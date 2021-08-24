from setuptools import setup
from pythran.dist import PythranExtension, PythranBuildExt

setup(
    name = 'hello',
    version = '1.0',
    description = 'Pythran version of integrate_f6',

    cmdclass = { "build_ext": PythranBuildExt },
    ext_modules = [
        PythranExtension('integrate_f6',
                         sources = ['python/integrate_f6.py']),
    ],
)
