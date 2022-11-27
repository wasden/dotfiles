local M = {}

M.highlight = function(group, options)
  local guifg = options.fg or "NONE"
  local guibg = options.bg or "NONE"
  local guisp = options.sp or "NONE"
  local gui = options.gui or "NONE"
  local blend = options.blend or 0
  local ctermfg = options.ctermfg or "NONE"

  vim.cmd(
    string.format(
      "highlight %s guifg=%s ctermfg=%s guibg=%s guisp=%s gui=%s blend=%d",
      group,
      guifg,
      ctermfg,
      guibg,
      guisp,
      gui,
      blend
    )
  )
end

M.colors = {
  red = "#E06C75",
  dark_red = "#BE5046",
  diff_red = "#2c1517",
  green = "#98C379",
  dark_green = "#59843b",
  dimm_green = "#41602b",
  diff_green = "#1e2718",
  yellow = "#E5C07B",
  diff_yellow = "#3e2e1e",
  dark_yellow = "#D19A66",
  blue = "#61AFEF",
  dimm_blue = "#0d4c7f",
  purple = "#C678DD",
  dimm_purple = "#633c6e",
  diff_purple = "#27182C",
  cyan = "#56B6C2",
  white = "#ABB2BF",
  black = "#1f1f1f",
  dimm_black = "#1c1c1c",
  dark_black = "#1a1a1a",
  comment_grey = "#5C6370",
  gutter_fg_grey = "#4B5263",
  cursor_grey = "#2C323C",
  dimm_cursor_grey = "#21262d",
  dark_cursor_grey = "#1d2228",
  visual_grey = "#3E4452",
  special_grey = "#3B4048",
  bracket_grey = "#7C828C",
}

M.setup = function()
  -- Markdown
  M.highlight("markdownCode", { fg = M.colors.yellow })
  M.highlight("markdownCodeBlockBGBorder", { bg = M.colors.dark_black })
  M.highlight("markdownCodeBlockBGBorderSign", { fg = M.colors.gutter_fg_grey })
  M.highlight("markdownCodeBlock", { fg = M.colors.yellow })
  M.highlight("markdownCodeDelimiter", { fg = M.colors.cursor_grey })
  M.highlight("markdownHeadingDelimiter", { fg = M.colors.gutter_fg_grey })
  M.highlight("markdownRule", { fg = M.colors.comment_grey })
  M.highlight("markdownHeadingRule", { fg = M.colors.comment_grey })
  M.highlight("markdownH1", { fg = M.colors.green, gui = "bold,italic" })
  M.highlight("markdownH2", { fg = M.colors.yellow, gui = "bold,italic" })
  M.highlight("markdownH3", { fg = M.colors.green, gui = "bold,italic" })
  M.highlight("markdownH4", { fg = M.colors.green, gui = "bold,italic" })
  M.highlight("markdownH5", { fg = M.colors.green, gui = "bold,italic" })
  M.highlight("markdownH6", { fg = M.colors.green, gui = "bold,italic" })
  M.highlight("markdownIdDelimiter", { fg = M.colors.purple })
  M.highlight("markdownId", { fg = M.colors.purple })
  M.highlight("markdownBlockquote", { fg = M.colors.comment_grey })
  M.highlight("markdownItalic", { gui = "italic" })
  M.highlight("markdownBold", { fg = M.colors.dark_yellow, gui = "bold" })
  M.highlight("markdownListMarker", { fg = M.colors.red })
  M.highlight("markdownOrderedListMarker", { fg = M.colors.red })
  M.highlight("markdownIdDeclaration", { fg = M.colors.blue })
  M.highlight("markdownLinkText", { fg = M.colors.blue })
  M.highlight("markdownLinkDelimiter", { fg = M.colors.white })
  M.highlight("markdownUrl", { fg = M.colors.purple })
end
return M
