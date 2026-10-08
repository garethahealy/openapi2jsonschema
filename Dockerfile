FROM registry.access.redhat.com/ubi9/python-312@sha256:57731b9fb128bfa9be6c00d3ae0b0f6dd8f4f23c7e2572bde1cae15c8fb16c90

USER 0
COPY ./openapi2jsonschema/ /src/openapi2jsonschema
COPY ./requirements.txt /src/requirements.txt
COPY ./setup.py /src/setup.py
COPY ./LICENSE /src/LICENSE

RUN chown -R 1001:0 /src \
    && mkdir -p /out \
    && chown 1001:0 /out

USER 1001
RUN cd /src && pip install --no-cache-dir -r requirements.txt .

WORKDIR /out

ENTRYPOINT ["python", "/src/openapi2jsonschema/command.py"]
CMD ["--help"]
