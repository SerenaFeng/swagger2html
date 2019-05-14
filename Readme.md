# swagger2html

Convert swagger Spec files to html files, ${srcpath}, where the swagger spec
file(s) is/are located, the out is under ${srcpath}/docs_output. Reference
images is/are required to be put under '.*/images$' directory.

To build docker image:

```shell
docker build -t <image:tag> .
```

A built image is stored as serenafeng/swagger2html:latest, the usage:

```shell
docker run --rm -ti -v ${srcpath}:/opt <image:tag> /home/convert.sh -i <objs> -t
```

`-i`: swagger spec file or directory of swagger spec files to be converted,
      must ends with "yaml" or "yml", if not given, all yaml/yml files under
      /opt/src will be converted.

`-t`: whether to link the stylesheet to the html file or embed it in the
      html file. if not given, embed-style is selected.
