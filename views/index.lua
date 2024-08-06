---@type Widget
local Widget = require("lapis.html").Widget

return Widget:extend(function(self)
  div({ id = "loading", class = "htmx-indicator loading" })
  div({ class = "flex-col-center gap-s width-max height-100" }, function()
    div({ class = "padding-b-xs flex-col-center gap-xs" }, function()
      h1("HTML to Lapis")
      div({ class = "padding-i-s" }, function()
        p("Note:")
        ul(function()
          li(function()
            raw("Text inside the <code>title</code>, <code>script</code> and <code>styles</code> tags get discarded")
          end)
        end)
      end)
    end)
    div({ class = "code-columns flex gap-m padding-i-s width-100 height-100" }, function()
      form(
        {
          action = self:url_for("convert"),
          method = "POST",
          ["hx-target"] = "#result",
          ["hx-swap"] = "innerHTML ignoreTitle:true",
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
            placeholder = "Paste your HTML here and I'll convert it",
            name = "content",
            ["hx-post"] = self:url_for("convert"),
            ["hx-trigger"] = "input",
            class = "code input width-100 height-100"
          })
        end)
      div({ class = "flex-col gap-s width-50 height-100" }, function()
        textarea({ id = "result", class = "code input bold height-100", disabled = true })
        button({
          id = "copy-btn",
          class = "input btn",
          ["_"] = [[
            on click writeText(#result.innerText) into navigator.clipboard
            set my innerHTML to 'Copied'
            wait 1s
            set my innerHTML to 'Copy'
          ]]
        }, "Copy")
      end)
    end)
    p({ class = "padding-b-xs" }, function()
      text("Credit to ")
      a({ href = "https://github.com/olueiro/lapis_layout", target = "_blank" }, "oluerio")
      text(" for the original library")
    end)
  end)
end)
