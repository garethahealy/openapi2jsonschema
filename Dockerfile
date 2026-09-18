FROM python:3-alpine@sha256:016508ba505da24f7139765bc4bb669df4e88eb2f12eeadd571bf2f88d7533df
MAINTAINER Yann Hamon "yann@mandragor.org"

COPY ./openapi2jsonschema/ /src/openapi2jsonschema
COPY ./requirements.txt /src/requirements.txt
COPY ./setup.py /src/setup.py
COPY ./LICENSE /src/LICENSE

RUN cd src && pip install -r requirements.txt .

WORKDIR /out

ENTRYPOINT ["/usr/local/bin/python", "/src/openapi2jsonschema/command.py"]
CMD ["--help"]
