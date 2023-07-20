local kong_meta = require "kong.meta"
local cjson = require("cjson.safe").new()

local xml2lua = require("xml2lua")
local handler = require("xmlhandler.tree")

local check = false


local XMLJsonTransformerHandler = {
  PRIORITY = 801,
  VERSION = kong_meta.version,
}

function XMLJsonTransformerHandler:header_filter(conf)
  if kong.response.get_header("Content-Type") == "application/xml" then 
    check = true
    kong.response.clear_header("Content-Type")
    kong.response.set_header("Content-Type", "application/json", string)
  end
end

function XMLJsonTransformerHandler:body_filter(conf) 
  if check then
    local body = kong.response.get_raw_body()
    if body then
      body = Transform(body) --must use function when transforming body. doing it here would cause error. (idk why, lua stuff.)
      kong.response.set_raw_body(body)
    end
  end
end

function Transform(body)
  local myhandler = handler:new() --must start fresh handler or your parse will keep adding every subsecquent call.
  local parser = xml2lua.parser(myhandler)
  parser:parse(body)
  local xml = myhandler.root
  local json_text = cjson.encode(xml)
  return json_text
end

return XMLJsonTransformerHandler