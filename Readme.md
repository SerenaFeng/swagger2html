# swagger2html

usage:

```shell
docker run --rm -ti -v ${srcpath}:/opt serenafeng/swagger2html -i <objs> -t
```

Convert swagger Spec files to html files, ${srcpath} is the swagger spec
directory to be converted, the outout is under ${srcpath}/_out


`-i`: swagger spec file or directory of swagger spec files to be converted,
      must ends with "yaml" or "yml", if not given, all yaml/yml files under
      /opt will be converted.

`-t`: whether to link the stylesheet to the html file or embed it in the
      html file. if not given, embed-style is selected.
