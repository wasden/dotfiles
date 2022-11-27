local M = {}

M.execute_with_notify = function (cmd)
  vim.cmd(cmd)
  vim.notify(string.format("execute: %s!", cmd), vim.log.levels.INFO, {})
end

M.get_cur_func_name = function ()
  local ts_utils = require 'nvim-treesitter.ts_utils'
  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then
    return ""
  end
  local expr = current_node

  while expr do
    if expr:type() == 'function_definition' then
      break
    end
    expr = expr:parent()
  end

  if not expr then return "" end

  return (ts_utils.get_node_text(expr:child(1)))
  -- return expr
end

return M
