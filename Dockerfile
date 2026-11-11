FROM registry.access.redhat.com/ubi9/python-312:9.9-1793872299@sha256:5b184c2acfe9e2eb9df1a243da8e4a82fedd96e5e7f6648ec5512656177fa326

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
