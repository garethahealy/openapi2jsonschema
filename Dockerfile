FROM python:3-alpine@sha256:2e740b2c28a426e74f11396c05e38afb3191acced75045b8d62df573c1dc8ce8
MAINTAINER Yann Hamon "yann@mandragor.org"

COPY ./openapi2jsonschema/ /src/openapi2jsonschema
COPY ./requirements.txt /src/requirements.txt
COPY ./setup.py /src/setup.py
COPY ./LICENSE /src/LICENSE

RUN cd src && pip install -r requirements.txt .

WORKDIR /out

ENTRYPOINT ["/usr/local/bin/python", "/src/openapi2jsonschema/command.py"]
CMD ["--help"]
