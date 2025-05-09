#!/usr/bin/make -f

.PHONY: docker-image
docker-image:
	docker build -f Dockerfile -t yannh/openapi2jsonschema .

publish: docker-image
	docker tag yannh/openapi2jsonschema docker.pkg.github.com/yannh/openapi2jsonschema/openapi2jsonschema:latest
	docker push docker.pkg.github.com/yannh/openapi2jsonschema/openapi2jsonschema:latest

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
	docker run yannh/openapi2jsonschema:latest https://raw.githubusercontent.com/kubernetes/kubernetes/master/api/openapi-spec/swagger.json