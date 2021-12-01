# {{cookiecutter.project_name}}

[![pre-commit](https://github.com/anoru/data-ci-cd-template/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/anoru/data-ci-cd-template/actions/workflows/pre-commit.yaml)
[![test-coverage](https://github.com/anoru/data-ci-cd-template/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/anoru/data-ci-cd-template/actions/workflows/test-coverage.yaml)
[![type-checks](https://github.com/anoru/data-ci-cd-template/actions/workflows/type-checks.yaml/badge.svg)](https://github.com/anoru/data-ci-cd-template/actions/workflows/type-checks.yaml)
[![unit-tests](https://github.com/anoru/data-ci-cd-template/actions/workflows/unit-tests.yaml/badge.svg)](https://github.com/anoru/data-ci-cd-template/actions/workflows/unit-tests.yaml)


{{cookiecutter.project_description}}

# Project Organization

    ├── LICENSE
    ├── .github/workflows      <- Github actions to automate, customize, and execute the project workflows
    ├── Makefile               <- Makefile with commands like `make virtual` or `make install`
    ├── README.md              <- The top-level README for developers using this project.
    ├── data                   <- This folder is only for unit test data, delete .gitkeep to not include
    │   ├── processed          <- The final, canonical data sets for modeling.
    │   └── raw                <- The original, immutable data dump.
    │
    ├── docs                   <- A default Sphinx project; see sphinx-doc.org for details
    │   ├── references         <- Data dictionaries, manuals, and all other explanatory materials.
    │   └── reports            <- Generated analysis as HTML, PDF, LaTeX, etc.
    │      └── figures         <- Generated graphics and figures to be used in reporting
    │
    ├── notebooks              <- Jupyter notebooks. Naming convention is a number (for ordering),
    │                             the creator's initials, and a short `-` delimited description, e.g.
    │                             `1.0-az-initial-data-exploration`.
    │
    ├── requirements.txt       <- The requirements file for reproducing the analysis environment, e.g.
    │                             generated with `pip freeze > requirements.txt`
    │
    ├── requirements-dev.txt   <- The requirements file for dev and test.
    │
    ├── setup.py               <- makes project pip installable (pip install -e .) so project can be imported
    │
    |── pipelines              <- job and pipelines to run
    |   └── benchmark          <- benchmark job
    |
    ├── src
    │   └── {{cookiecutter.project_slug_under}}  <- Source code for use in the project.
    │      └── __init__.py     <- Makes src a Python package
    │
    ├── deployment             <- Scripts to test and deploy
    │   │
    │   ├── models             <- store the ml models.
    │   │
    │   ├── integration_tests  <- Here goes the integration pipelines test. Executed when merging to main
    │   │   └── pipeline1
    │   │       └── test_example.py
    │   │
    │   └── unit_tests         <- Here goes the unit tests. Executed for every push
    │       └── test_example.py
    └──

# Usage

## As Flask API

### Local run

Run Flask application in debug mode

```bash
make local-run-endpoint
```

### Docker run

Build the docker image

```bash
make docker-build-endpoint
```

And finally run it

```bash
make docker-run-endpoint
```

### Test local

With `make local-run-endpoint`, we launch a local Flask server from our virtual environment. The default base url is 127.0.0.1:8080.
With `make docker-run-endpoint`, we launch a local Flask server from the Docker image. The default base url is 172.17.0.2:8080. Docker uses the default 172.17.0.0/16 subnet for container networking.

```bash
curl -X POST http://127.0.0.1:8080/invocations -d '{"body": "test"}' -H "content-type: application/json"
```

## As a package

Here an example on how to use the schema mapping as a package

```bash
pip install .
```

```python
from {{cookiecutter.project_slug}} import *

```

# Deployment

## Github Action

    ├── On push:
    │   └── unit-tests                <- Run tests against the installed package and make sure they all pass.
    │
    ├── On pull_request:
    │   ├── unit-tests                <- Run tests against the installed package and make sure they all pass.
    │   ├── integration-tests         <- Run integration tests against the docker image and make sure they all pass.
    │   ├── test-coverage             <- Install dependencies, create coverage tests and run Pytest Coverage Commentator.
    │   ├── type-checks               <- Use Mypy and pyright to perform static type checking, and make sure no type error was introduced.
    │   ├── pre-commit                <- Run `pre-commit` on all files. run `pre-commit install` in order to perform the checks on each commit automatically.
    │   └── check-version-increase    <- Check if the version is increased when modifying python files.
    │
    └── On push to main:
        ├── unit-tests                <- Run tests against the installed package and make sure they all pass.
        ├── integration-tests         <- Run integration tests against the docker image and make sure they all pass.
        └── save-artifacts            <- Save the docker image as a tarball & the model file in github artifacts.
