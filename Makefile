#!/usr/bin/make -f

REPO_ORG ?= yannh

.PHONY: docker-image
docker-image:
	docker build -f Dockerfile -t $(REPO_ORG)/openapi2jsonschema .

publish: docker-image
	echo "$(GITHUB_TOKEN)" | docker login -u $(GITHUB_USER) --password-stdin ghcr.io
	docker tag $(REPO_ORG)/openapi2jsonschema ghcr.io/$(REPO_ORG)/openapi2jsonschema:latest
	docker push ghcr.io/$(REPO_ORG)/openapi2jsonschema:latest

venv:
	python3 -m venv venv/
	source venv/bin/activate

.PHONY: pip-install
pip-install: venv
	pip install -r requirements.txt .

.PHONY: pip-freeze
pip-freeze:
	pip freeze > requirements.txt

.PHONY: run
run: pip-install
	python openapi2jsonschema/command.py https://raw.githubusercontent.com/kubernetes/kubernetes/master/api/openapi-spec/swagger.json

.PHONY: run-container
run-container: docker-image
	docker run $(REPO_ORG)/openapi2jsonschema:latest https://raw.githubusercontent.com/kubernetes/kubernetes/master/api/openapi-spec/swagger.json