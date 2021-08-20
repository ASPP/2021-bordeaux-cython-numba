project('wrap_zstd', 'cython')

py = import('python').find_installation()
libzstd = dependency('libzstd')

py.extension_module(
    'wrap_zstd',
    'wrap_zstd.pyx',
    dependencies : [py.dependency(),
                    libzstd]
)
