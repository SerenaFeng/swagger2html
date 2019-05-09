# swagger2html

Convert swagger Spec files to html files, ${srcpath}, where the swagger spec
file(s) is/are located, the outout is under ${srcpath}/_out

To build docker image:

```shell
docker build -t <image:tag> .
```

A built image is stored as serenafeng/swagger2html:latest, the usage:

```shell
docker run --rm -ti -v ${srcpath}:/opt serenafeng/swagger2html:latest -i <objs> -t
```

`-i`: swagger spec file or directory of swagger spec files to be converted,
      must ends with "yaml" or "yml", if not given, all yaml/yml files under
      /opt will be converted.

`-t`: whether to link the stylesheet to the html file or embed it in the
      html file. if not given, embed-style is selected.
