def configure(target):
  name = 'configure-' + target.lower()

  native.genrule(
    name = name,
    out = 'out',
    srcs = native.glob([
      'config/*',
      'contrib/**/*.in',
      'html/**/*.in',
      'libtiff/**/*.in',
      'man/**/*.in',
      'm4/*.m4',
      'port/**/*.in',
      # 'test/**/*.in',
      'tools/**/*.in',
      'configure',
      'configure.ac',
      'install-sh',
      'missing',
      'ltmain.sh',
      'jpeglib.h',
      '*.m4',
      '*.in',
      '*.cfg',
    ]),
    cmd = ' && '.join([
      'cp -r $SRCDIR/. $TMP',
      'cd $TMP',
      'mkdir -p $TMP/test',
      'cp $(location //test:in)/Makefile.in $TMP/test/Makefile.in',
      './configure --target=' + target,
      'mkdir -p $OUT',
      'cp $TMP/libtiff/tif_config.h $OUT/tif_config.h',
      'cp $TMP/libtiff/tiffconf.h $OUT/tiffconf.h',
    ]),
  )

  tif_config_h_name = 'tif-config-h-' + target.lower()

  native.genrule(
    name = tif_config_h_name,
    out = 'tif_config.h',
    cmd = 'cp $(location :' + name + ')/tif_config.h $OUT',
  )

  tiffconf_h_name = 'tiffconf-h-' + target.lower()

  native.genrule(
    name = tiffconf_h_name,
    out = 'tiffconf.h',
    cmd = 'cp $(location :' + name + ')/tiffconf.h $OUT',
  )

  return [ ':' + tif_config_h_name, ':' + tiffconf_h_name ]
