# This file is used to make the dev & local testing easy

.PHONY: virtual install build-requirements black isort flake8

PROJECT_NAME = {{cookiecutter.project_slug}}
PROJECT_NAME_UNDER = {{cookiecutter.project_slug.replace('-', '_')}}
DOCKER_IMAGE = {{cookiecutter.project_slug}}
DOCKER_IMAGE_SAGEMAKER = ${DOCKER_IMAGE}-sagemaker
DOCKER_IMAGE_SAGEMAKER_ENDPOINT = ${DOCKER_IMAGE_SAGEMAKER}-endpoint
CURRENT_TIMESTAMP != date -u +'%Y-%m-%d-%H-%M-%S'
# AWS Account ID
REGION = {{cookiecutter.aws_region}}
ACCOUNT_ID = {{cookiecutter.aws_account_id}}
REPOSITORY = {{cookiecutter.ecr_repo_name}}

clean-pyc:
	find . -name '*.pyc' -exec rm --force {} +
	find . -name '*.pyo' -exec rm --force {} +
	name '*~' -exec rm --force  {}

clean-build:
	rm -f -r build/
	rm -f -r dist/
	rm -f -r *.egg-info

virtual: # Creates an isolated python 3 environment
	virtualenv -p /usr/bin/python3 .venv

python-install: virtual # --editable is used to allow debugging while running the tests
	.venv/bin/pip install --editable .

python-run: virtual clean-build
	.venv/bin/pip install -r requirements.txt

python-test: python-install
	.venv/bin/pip install -r requirements-dev.txt
	.venv/bin/pytest -vv

update-requirements: install
	.venv/bin/pip freeze > requirements.txt

# black
.venv/bin/black: # Installs black code formatter
	.venv/bin/pip install -U black

black: .venv/bin/black # Formats code with black
	.venv/bin/black *.py

# isort
.venv/bin/isort: # Installs isort to sort imports
	.venv/bin/pip install -U isort

isort: .venv/bin/isort # Sorts imports using isort
	.venv/bin/isort *.py

# flake8
.venv/bin/flake8: # Installs flake8 code linter
	.venv/bin/pip install -U flake8

flake8: .venv/bin/flake8 # Lints code using flake8
	.venv/bin/flake8 *.py

jupyter: .venv/bin/ipython
	.venv/bin/jupyter notebook

.venv/bin/ipython:
	.venv/bin/pip install -U ipykernel jupyter
	.venv/bin/ipython kernel install --user --name=$(PROJECT_NAME)

local-run-endpoint:
	FLASK_ENV=development FLASK_APP=src/${PROJECT_NAME_UNDER}.server_api flask run --port 8080

docker-build-endpoint:
	docker build  -f src/${PROJECT_NAME_UNDER}/Dockerfile.endpoint . -t ${DOCKER_IMAGE_SAGEMAKER_ENDPOINT}

docker-run-endpoint:
	docker run -p 8080:8080 -t ${DOCKER_IMAGE_SAGEMAKER_ENDPOINT}

run-mypy: virtual
	.venv/bin/pip install -r requirements-dev.txt
	rm -fR ./build
	.venv/bin/python -m mypy .

python-test-coverage: python-install
	.venv/bin/pip install -r requirements-dev.txt
	.venv/bin/pytest --cov=${PROJECT_NAME_UNDER} --cov-report xml:cov.xml --cov-report html

docker-sagemaker-build-and-push:
	aws --region ${REGION} ecr get-login-password | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPOSITORY}
	docker build  -f Dockerfile.sagemaker . -t ${DOCKER_IMAGE_SAGEMAKER} -t ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPOSITORY}:${DOCKER_IMAGE_SAGEMAKER}
	docker push ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPOSITORY}:${DOCKER_IMAGE_SAGEMAKER}

docker-sagemaker-endpoint-build-and-push:
	aws --region ${REGION} ecr get-login-password | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPOSITORY}
	docker build  -f src/${PROJECT_NAME_UNDER}/Dockerfile.endpoint . -t ${DOCKER_IMAGE_SAGEMAKER_ENDPOINT} -t ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPOSITORY}:${DOCKER_IMAGE_SAGEMAKER_ENDPOINT}
	docker push ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPOSITORY}:${DOCKER_IMAGE_SAGEMAKER_ENDPOINT}

deployment-endpoint:
	aws sagemaker update-endpoint --endpoint-name ${PROJECT_NAME}-manual --endpoint-config-name ${PROJECT_NAME}-manual

check-deployment-endpoint:
	aws sagemaker describe-endpoint --endpoint-name ${PROJECT_NAME}-manual
