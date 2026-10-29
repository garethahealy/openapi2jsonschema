FROM registry.access.redhat.com/ubi9/python-312:9.8-1793278874@sha256:5b0c67feb3f2e5637c6301ea22e2839d402dd71d88c3cec8d1fd278ce0f9e69a

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
