from setuptools import find_packages, setup

with open("requirements.txt") as f:
    install_requires = f.read().strip().split("\n")

setup(
    name="{{cookiecutter.project_slug}}",
    version="{{cookiecutter.version}}",
    description="{{cookiecutter.project_description}}",
    author="{{cookiecutter.author}}",
    install_requires=install_requires,
    # https://www.python.org/dev/peps/pep-0561/
    package_data={"{{cookiecutter.project_slug.replace('-', '_')}}": ["py.typed"]},
    # prevent some edge case were py.typed isn't taken into account
    # https://github.com/python/mypy/issues/8802
    zip_safe=False,
    packages=find_packages("src", exclude=["*data_science*"]),
    package_dir={"": "src"},
)
