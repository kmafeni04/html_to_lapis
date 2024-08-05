local lapis = require("lapis")
---@type App
local app = lapis.Application()
app:enable("etlua")
-- app.layout = require "views.layout"

app:get("/", function(self)
  self.page_title = "HTML to Lapis"
  return { render = "index", layout = "layout" }
end)

app:post("convert", "/convert", function(self)
  local content = self.params.content
  local lapis_layout = require("lib.lapis_layout")
  local moon_output, lua_output = lapis_layout({
    input = content,
    tab   = "  "
  })
  if self.params.type == "moon" then
    return moon_output
  elseif self.params.type == "lua" then
    return lua_output
  else
    return "error, invalid type"
  end
end)

return app
