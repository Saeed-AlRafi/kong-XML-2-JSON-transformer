# kong XML2JSON

XML to JSON custom plugin for Kong 3.3.0 on Docker.

run:
```
docker build    --build-arg KONG_BASE="kong:3.3"    --build-arg PLUGINS="bundled,xml-json-transformer"    --tag "ekong2" .  
```
to build the container using the dockerfile provided to install dependencies for the XML2JSON plugin.

run:
```
docker run --name kong-dbless-gatewaytest \
 --network=kong-net \
 -v "$(pwd):/kong/declarative/" \
 -e "KONG_DATABASE=off" \
 -e "KONG_DECLARATIVE_CONFIG=/kong/declarative/kong.yml" \
 -e "KONG_LUA_PACKAGE_PATH=/plugins/?.lua" \
 -e "KONG_PLUGINS=bundled,xml-json-transformer" \
 -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
 -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
 -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
 -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
 -e "KONG_ADMIN_LISTEN=0.0.0.0:8001" \
 -e "KONG_ADMIN_GUI_URL=http://localhost:8002" \
 -e "KONG_ADMIN_TOKEN=1234" \
 -e KONG_LICENSE_DATA \
 -v "$(pwd)/plugins:/plugins" \
 -p 8000:8000 \
 -p 8001:8001 \
ekong2
```

works alongside the plugins provided by Kong.

have plugin file similar to how it is here.
plugins>kong>plugins>xml-json-transformer