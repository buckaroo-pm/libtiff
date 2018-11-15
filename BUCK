def configure(target):
  name = 'configure-' + target.lower()
  genrule(
    name = name, 
    out = 'out', 
    srcs = glob([
      'config/*', 
      'contrib/**/*.in', 
      'html/**/*.in', 
      'libtiff/**/*.in', 
      'man/**/*.in', 
      'm4/*.m4', 
      'port/**/*.in', 
      'test/**/*.in', 
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
      './configure --target=' + target, 
      'mkdir -p $OUT', 
      'cp $TMP/libtiff/tif_config.h $OUT/tif_config.h', 
      'cp $TMP/libtiff/tiffconf.h $OUT/tiffconf.h', 
    ]), 
  )
  tif_config_h_name = 'tif-config-h-' + target.lower()
  genrule(
    name = tif_config_h_name,
    out = 'tif_config.h', 
    cmd = 'cp $(location :' + name + ')/tif_config.h $OUT', 
  )
  tiffconf_h_name = 'tiffconf-h-' + target.lower()
  genrule(
    name = tiffconf_h_name,
    out = 'tiffconf.h', 
    cmd = 'cp $(location :' + name + ')/tiffconf.h $OUT', 
  )
  return [ ':' + tif_config_h_name, ':' + tiffconf_h_name ]

acorn_sources = [
  'libtiff/tif_acorn.c',
]

atari_sources = [
  'libtiff/tif_atari.c',
]

apple_sources = [
  'libtiff/tif_apple.c',
]

macos_sources = [
  'libtiff/tif_unix.c',
]

linux_sources = [
  'libtiff/tif_unix.c',
]

windows_sources = [
  'libtiff/tif_win3.c',
  'libtiff/tif_win32.c',
]

msdos_sources = [
  'libtiff/tif_msdos.c',
]

platform_sources = acorn_sources + atari_sources + macos_sources + linux_sources + \
                   windows_sources + msdos_sources + apple_sources

cxx_library(
  name = 'tiff',
  header_namespace = '',
  exported_headers = subdir_glob([
    ('libtiff', '*.h'),
  ]), 
  srcs = glob([
    'libtiff/*.c',
  ],
  excludes = platform_sources),
  exported_platform_headers = [
    ('macos.*', configure('x86_64-apple-darwin')), 
    ('linux.*', configure('x86_64-linux-gnu')), 
  ], 
  platform_srcs = [
    ('default', macos_sources),
    ('macos.*', macos_sources),
    ('linux.*', linux_sources),
    ('windows.*', windows_sources),
  ],
  compiler_flags = [
    '-DHAVE_CONFIG_H',
    '-Dtiffxx_EXPORTS',
  ],
  deps = [
    'buckaroo.github.buckaroo-pm.luadist-libjpeg//:jpeg', 
  ], 
  visibility = [
    'PUBLIC',
  ],
)
