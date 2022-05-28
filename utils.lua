local M = {}

M.execute_with_notify = function (cmd)
  vim.cmd(cmd)
  require("notify")(string.format("execute: %s!", cmd), vim.log.levels.INFO)
end

-- M.impatient_log = function (num)
--   local log = require("impatient").log
--   local begin_num = #log - num
--   for i, info in ipairs(log) do
--     if i >= begin_num then
--       print(info)
--     end
--   end
-- end
-- M.impatient_log(20)
return M
