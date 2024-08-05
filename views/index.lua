---@type Widget
local Widget = require("lapis.html").Widget

return Widget:extend(function(self)
  div({ class = "flex-col-center gap-s width-max height-100" }, function()
    h1({ class = "padding-b-xs" }, "HTML to Lapis")
    div(function()
      p("Known Issues:")
      ul(function()
        li("Inline JS comments: workaround: remove all them or remove script from source and add to a .js file :)")
      end)
    end)
    div({ id = "loading", class = "htmx-indicator loading" })
    div({ class = "code-columns flex gap-m padding-i-m width-100 height-100" }, function()
      form(
        {
          action = self:url_for("convert"),
          method = "POST",
          ["hx-target"] = "#result",
          ["hx-swap"] = "innerHTML",
          ["hx-push-url"] = "false",
          ["hx-indicator"] = "#loading",
          class = "flex-col gap-s width-50 height-100"
        },
        function()
          element("select", {
            name = "type",
            class = "input btn",
            ["hx-post"] = self:url_for("convert"),
            ["hx-trigger"] = "change",
          }, function()
            option({ value = "lua" }, "lua")
            option({ value = "moon" }, "moon")
          end)
          textarea({
            type = "text",
            name = "content",
            ["hx-post"] = self:url_for("convert"),
            ["hx-trigger"] = "input",
            class = "code-input input width-100 height-100"
          })
        end)
      div({ class = "flex-col width-50 height-100" }, function()
        pre({ id = "code-output", class = "code-output height-100" }, function()
          code({ id = "result" })
        end)
        button({ class = "input btn", onClick = "toClipboard()" }, "Copy")
      end)
    end)
    p({ class = "padding-b-xs" }, function()
      text("Credit to ")
      a({ href = "https://github.com/olueiro/lapis_layout", target = "_blank" }, "oluerio")
      text(" for the original library")
    end)
  end)
end)
