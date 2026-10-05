FROM python:3-alpine@sha256:f6a589d43c42b9e7f7dc67a12d37132491f362859a5d750607710cc56da3bc72
MAINTAINER Yann Hamon "yann@mandragor.org"

COPY ./openapi2jsonschema/ /src/openapi2jsonschema
COPY ./requirements.txt /src/requirements.txt
COPY ./setup.py /src/setup.py
COPY ./LICENSE /src/LICENSE

RUN cd src && pip install -r requirements.txt .

WORKDIR /out

ENTRYPOINT ["/usr/local/bin/python", "/src/openapi2jsonschema/command.py"]
CMD ["--help"]
