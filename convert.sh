#!/bin/bash

swagger2markup=/home/swagger2markup.jar
fyamls=/opt/src
linkcss=false
out=/opt/docs_output

while getopts ":i:t" arg; do
  case ${arg} in
    i) fyamls=/opt/${OPTARG};;
    t) linkcss=true;;
  esac
done

function _images_dir {
  local _opt=${1#/opt/src/}
  local _opt=${_opt#/opt/}
  echo $(dirname ${out}/${_opt})
}

function _copy_images {
  local odir=$(_images_dir ${1})
  mkdir -p ${odir} || true
  echo "images ${1} exist, copy to ${odir}"
  cp -fr ${1} ${odir} || true
}

function convert {
  local fyaml=${1}
  local _opt=${fyaml#/opt/src/}
  local _opt=${_opt#/opt/}
  local obj=${out}/${_opt%.*}
  local fadoc=${obj}.adoc
  local fhtml=${obj}.html
  local fcss=${obj##*/}.css

  [[ ! -f ${fyaml} ]] && {
    echo "${fyaml} not exist"
    exit 1
  }

  echo "begin to convert to ${fadoc} ......"
  adoccmd="convert -i ${fyaml} -f ${obj}"
  [[ -f /opt/config.properties ]] && adoccmd="${adoccmd} -c config.properties"
  java -jar ${swagger2markup} ${adoccmd}

  echo "begin to convert to ${fhtml} ......"
  htmlcmd="-b html5 -o ${obj}.html ${obj}.adoc"
  [[ ${linkcss} == true ]] && htmlcmd="-a linkcss ${htmlcmd}"
  asciidoctor ${htmlcmd}

  [[ ${linkcss} == true ]] && {
    mv "${obj%/*}/asciidoctor.css" ${obj}.css
    sed -i "s/asciidoctor.css/${fcss}/g" ${fhtml}
  }
}

function iterate_over_dir {
  [[ -f ${1} ]] && {
    [[ ${1} =~ yaml$|yml$ ]] && {
      convert ${1}
      images=$(dirname ${1})/images
      [[ -d ${images} ]] && {
        echo "images ${images} exist, copy to ${out}"
        cp -fr ${images} ${out}
      }
    }
    return
  }

  for file in ${1%/}/*; do
    [[ -d ${file} ]] && {
      [[ ${file} =~ images$ ]] && {
        _copy_images ${file}
      } || {
        iterate_over_dir ${file} || true
      }
    } || {
      [[ ${file} =~ .yaml$|.yml$ ]] && convert ${file}
    }

  done

}

iterate_over_dir ${fyamls}
