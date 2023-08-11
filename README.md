# kong XML 2 JSON transformer

updated XML to JSON custom plugin for Kong 3.3.0 on Docker.
Original plugin: https://github.com/svenwal/kong-plugin-xml-json-transformer

## What:
This plugin will convert XML objects from upstream and convert them to JSON before sending them downstream.

## Why:
Some people are just lazy and can't be bothered to change their XML endpoints to JSON

## How:
The plugin starts by checking the "Content-Type" header. if it is "application/xml" then it will change it to "application/json" and proceed with converting the body.




## Setup:
```
docker build    --build-arg KONG_BASE="kong:3.3"    --build-arg PLUGINS="bundled,xml-2-json-transformer"    --tag "image_name" .  
```
to build the container image using the dockerfile provided to install dependencies for the XML2JSON plugin.

run:
```
docker run --name kong-dbless-gatewaytest \
 --network=kong-net \
 -v "$(pwd):/kong/declarative/" \
 -e "KONG_DATABASE=off" \
 -e "KONG_DECLARATIVE_CONFIG=/kong/declarative/kong.yml" \
 -e "KONG_LUA_PACKAGE_PATH=/plugins/?.lua" \
 -e "KONG_PLUGINS=bundled,xml-2-json-transformer" \
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
image_name
```

works alongside the plugins provided by Kong.

have plugin file similar to how it is here.
plugins>kong>plugins>xml-json-transformer

### disclaimer:
I am a beginer and this code is probably not the greatest.