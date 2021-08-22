project('integrate_f6', 'cpp')

# For documentation, see:
# https://mesonbuild.com/Python-module.html

py = import('python').find_installation()

pythran = find_program('pythran')
pythran_config = find_program('pythran-config')

pythran_cflags = run_command(pythran_config, '--cflags').stdout().split()
pythran_libs = run_command(pythran_config, '--libs').stdout().split()

silence_warnings = ['-Wno-unused-function',
                    '-Wno-unused-variable']

integrate_f6_cc = custom_target(
  'integrate_f6.cc',
  input : 'integrate_f6.py',
  output : 'integrate_f6.cc',
  command : [pythran,
             '@INPUT@',
             '-E',
             '-o', '@OUTPUT0@'])

py.extension_module(
  'integrate_f6',
  integrate_f6_cc,
  dependencies : py.dependency(),
  cpp_args : [pythran_cflags,
              silence_warnings],
  link_args : pythran_libs,
)
