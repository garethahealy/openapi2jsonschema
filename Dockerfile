FROM python:3-alpine@sha256:c6ead215bfd31f1e433d968853b7a769989117115b728874824e6c0a27cb96fc
MAINTAINER Yann Hamon "yann@mandragor.org"

COPY ./openapi2jsonschema/ /src/openapi2jsonschema
COPY ./requirements.txt /src/requirements.txt
COPY ./setup.py /src/setup.py
COPY ./LICENSE /src/LICENSE

RUN cd src && pip install -r requirements.txt .

WORKDIR /out

ENTRYPOINT ["/usr/local/bin/python", "/src/openapi2jsonschema/command.py"]
CMD ["--help"]
