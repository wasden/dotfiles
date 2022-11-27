
local lua_snip = require("luasnip")
-- some shorthands...
local snip = lua_snip.snippet
local node = lua_snip.snippet_node
local text = lua_snip.text_node
local i = lua_snip.insert_node
local f = lua_snip.function_node
local c = lua_snip.choice_node
local d = lua_snip.dynamic_node
local r = lua_snip.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

lua_snip.snippets = {
	c = {
		-- rec_ls is self-referencing. That makes this snippet 'infinite' eg. have as many
		-- \item as necessary by utilizing a choiceNode.
    snip(
			{
        trig="go",
        name="goto EXIT_LABEL;"
      },
      text("goto EXIT_LABEL;")
		),
	},
}

