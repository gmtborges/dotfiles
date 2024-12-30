local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local function get_date()
  return os.date("%Y-%m-%d")
end

ls.add_snippets("markdown", {
  s("tsemana", fmt([[
# Tarefas

1.
2.
3.

# Revisão

]], {}))
})

ls.add_snippets("markdown", {
  s("tanotacao", fmt([[
---
titulo: {}
data: {}
---

# Veja Também

# Referências

]], {
    i(1, ""),
    f(get_date, {}),
  })),
})
