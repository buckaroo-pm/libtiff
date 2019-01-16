load('//:buckaroo_macros.bzl', 'buckaroo_deps')
load('//:subdir_glob.bzl', 'subdir_glob')
load('//:configure.bzl', 'configure')

acorn_srcs = [
  'libtiff/tif_acorn.c',
]

atari_srcs = [
  'libtiff/tif_atari.c',
]

apple_srcs = [
  'libtiff/tif_apple.c',
]

macos_srcs = [
  'libtiff/tif_unix.c',
]

linux_srcs = [
  'libtiff/tif_unix.c',
]

windows_srcs = [
  'libtiff/tif_win3.c',
  'libtiff/tif_win32.c',
]

msdos_srcs = [
  'libtiff/tif_msdos.c',
]

platform_srcs = acorn_srcs + atari_srcs + macos_srcs + linux_srcs + \
                   windows_srcs + msdos_srcs + apple_srcs

cxx_library(
  name = 'tiff',
  header_namespace = '',
  exported_headers = subdir_glob([
    ('libtiff', '*.h'),
  ]),
  srcs = glob([
    'libtiff/*.c',
  ],
  exclude = platform_srcs),
  exported_platform_headers = [
    ('macos.*', configure('x86_64-apple-darwin')),
    ('linux.*', configure('x86_64-linux-gnu')),
  ],
  platform_srcs = [
    ('default', macos_srcs),
    ('macos.*', macos_srcs),
    ('linux.*', linux_srcs),
    ('windows.*', windows_srcs),
  ],
  compiler_flags = [
    '-DHAVE_CONFIG_H',
    '-Dtiffxx_EXPORTS',
  ],
  deps = buckaroo_deps(),
  reexport_all_header_dependencies = False,
  visibility = [
    'PUBLIC',
  ],
)
