FROM kong:3.3

USER root
RUN luarocks install xml2lua