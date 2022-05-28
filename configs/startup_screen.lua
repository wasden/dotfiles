local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local leader = "SPC"

local path_ok, path = pcall(require, "plenary.path")
if not path_ok then
  return
end

local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

    local opts = {
        position = "center",
        shortcut = sc,
        cursor = 5,
        width = 70,
        align_shortcut = "right",
        hl_shortcut = { { "Operator", 0, 1 }, { "Number", 1, #sc + 1 }, { "Operator", #sc + 1, #sc + 2 } },
    }
    if keybind then
        keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_, keybind, { noremap = false, silent = true, nowait = true } }
    end

    local function on_press()
        -- local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
        local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "t", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end


local function get_extension(fn)
    local match = fn:match("^.+(%..+)$")
    local ext = ""
    if match ~= nil then
        ext = match:sub(2)
    end
    return ext
end

local function icon(fn)
    local nwd = require("nvim-web-devicons")
    local ext = get_extension(fn)
    return nwd.get_icon(fn, ext, { default = true })
end

local function file_button(icon_name, sc, cmd, short_name)
    short_name = short_name or icon_name
    local ico_txt
    local fb_hl = {}

    local ico, hl = icon(icon_name)
    table.insert(fb_hl, {hl, 1, 3})
    ico_txt = ico .. "  "

    local file_button_el = button(sc, ico_txt .. short_name, cmd)
    local fn_start = short_name:match(".*/")
    if fn_start ~= nil then
        table.insert(fb_hl, { "Comment", #ico_txt - 2, #fn_start + #ico_txt })
    end
    file_button_el.opts.hl = fb_hl
    return file_button_el
end

local cool = {
  [[    ███╗   ███╗ █████╗ ██╗  ██╗███████╗   ]],
  [[    ████╗ ████║██╔══██╗██║ ██╔╝██╔════╝   ]],
  [[    ██╔████╔██║███████║█████╔╝ █████╗     ]],
  [[    ██║╚██╔╝██║██╔══██║██╔═██╗ ██╔══╝     ]],
  [[    ██║ ╚═╝ ██║██║  ██║██║  ██╗███████╗   ]],
  [[    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ]],
  [[      ██████╗ ██████╗  ██████╗ ██╗        ]],
  [[     ██╔════╝██╔═══██╗██╔═══██╗██║        ]],
  [[     ██║     ██║   ██║██║   ██║██║        ]],
  [[     ██║     ██║   ██║██║   ██║██║        ]],
  [[     ╚██████╗╚██████╔╝╚██████╔╝███████╗   ]],
  [[      ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝   ]],
  [[███████╗████████╗██╗   ██╗███████╗███████╗]],
  [[██╔════╝╚══██╔══╝██║   ██║██╔════╝██╔════╝]],
  [[███████╗   ██║   ██║   ██║█████╗  █████╗  ]],
  [[╚════██║   ██║   ██║   ██║██╔══╝  ██╔══╝  ]],
  [[███████║   ██║   ╚██████╔╝██║     ██║     ]],
  [[╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝     ]],
}

local headers = {cool}

local function header_chars()
  return headers[ math.random(#headers) ]
end


local function padding(height)
  return { type = "padding", val = height}
end

local function make_tvo(type)
  return function (val, opts)
    return {
      type = type,
      val = val,
      opts = opts,
    }
  end
end

local group_tvo = make_tvo("group")
local text_tvo = make_tvo("text")

local function header_color()
  local lines = {}
  for _, line_chars in pairs(header_chars()) do
    local line = text_tvo(line_chars, {
      hl = "Type",
      shrink_margin = false,
      position = "center",
    })
    table.insert(lines, line)
  end

  -- return group_tvo(lines, {
  --   position = "center",
  -- })
  return group_tvo(lines)
end

local function make_section(section_name, display_fn)
  local val = {
    text_tvo(section_name, {
      hl = "SpecialComment",
      shrink_margin = false,
      position = "center",
    }),
    padding(1),
    group_tvo(display_fn, {
      shrink_margin = false
    }),
  }
  return group_tvo(val)
end

local command_buttons = make_section("Quick links", function ()
  local val = {
    -- dashboard.button("m", "  MRU", ":Telescope oldfiles initial=normal <CR>"),
    button(" n", "  New file", ":ene <BAR> startinsert <CR>"),
    button(" f", "  Find file", ":Telescope find_files <CR>"),
    button(" F", "  Find text", ":Telescope live_grep <CR>"),
    button(" u", "  Update plugins" , ":PackerSync<CR>"),
    button(" c", "  Compile plugins" , ":lua require('custom.utils').execute_with_notify('PackerCompile')<CR>"),
    button(" q", "  Quit" , ":qa<CR>"),
  }

  for _, b in ipairs(val) do
    b.opts.hl = {{"DevIconVim", 1, 3}}
  end
  return {group_tvo(val)}
end)

local sessions = make_section("Sessions", function ()
  local query = require('possession.query')
  local session_list = query.as_list()
  table.sort(session_list, function (tbl1, tbl2)
    return tbl1.name < tbl2.name
  end)
  local tbl = {}
  for _, session in pairs(session_list) do
    if #tbl >= 9 then
      break
    end

    local shortcut = " " .. "s" .. tostring(#tbl + 1)
    local cmd = string.format(':SLoad %s<cr>', session.name)
    local file_button_el = file_button("favicon.ico", shortcut, cmd, session.name)
    table.insert(tbl, file_button_el)
  end
  return {group_tvo(tbl, {})}
end)

local function make_mru(cwd)
  return function ()
    local oldfiles = {}
    local tbl = {}
    for _, v in pairs(vim.v.oldfiles) do
      if #oldfiles >= 9 then
        break
      end
      local cwd_cond
      if not cwd then
        cwd_cond = true
      else
        cwd_cond = vim.startswith(v, cwd)
      end
      if (vim.fn.filereadable(v) == 1) and cwd_cond then
        oldfiles[#oldfiles + 1] = v
      end
    end

    local target_width = 35

    for i, fn in ipairs(oldfiles) do
      local short_fn = vim.fn.fnamemodify(fn, ":~")

      if(#short_fn > target_width) then
        short_fn = path.new(short_fn):shorten(1, {-2, -1})
        if(#short_fn > target_width) then
          short_fn = path.new(short_fn):shorten(1, {-1})
        end
      end

      local shortcut = " m" .. tostring(i)
      local cmd = string.format("<cmd>e %s <CR>", fn)
      local file_button_el = file_button(fn, shortcut, cmd, short_fn)
      tbl[i] = file_button_el
    end
    return {group_tvo(tbl)}
  end
end

local function make_mru_cwd_title()
  local cwd = vim.fn.getcwd()
  cwd = path.new(cwd):shorten(1, {-1})
  return "MRU " .. cwd
end

local mru = make_section("MRU", make_mru(nil))
local mru_cwd = make_section(make_mru_cwd_title(), make_mru(vim.fn.getcwd()))

alpha.setup({
    layout = {
      padding(2),
      header_color(),
      padding(2),
      sessions,
      padding(2),
      command_buttons,
      padding(2),
      mru,
      padding(2),
      mru_cwd,
    },
    opts = {
        margin = 5,
        -- redraw_on_resize = false,
        -- setup = function()
        --     vim.cmd([[
        --     autocmd alpha_temp DirChanged * lua require('alpha').redraw()
        --     ]])
        -- end,
    },
})
