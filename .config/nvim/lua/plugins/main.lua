-- Memory

local theme_file = vim.fn.stdpath("state") .. "/colorscheme"
local fallback = "catppuccin-frappe"

local function saved_theme()
  -- Whatever survived the last session, frappe if nothing did
  local f = io.open(theme_file, "r")
  if not f then
    return fallback
  end
  local name = f:read("*l")
  f:close()
  if name and name ~= "" then
    return name
  end
  return fallback
end

local function keep_theme(name)
  -- Tiny file, big convenience
  local f = io.open(theme_file, "w")
  if f then
    f:write(name)
    f:close()
  end
end

-- Every colorscheme call leaves a trace, picker previews included
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function(event)
    keep_theme(event.match)
  end,
})

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "frappe",
      styles = {
        comments = {},
      },
    },
  },
  {
    "mellow-theme/mellow.nvim",
    name = "mellow",
    lazy = false,
    priority = 1000,
    init = function()
      -- Matching taste: no italics here either
      vim.g.mellow_italic_comments = false
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- Boots into whatever was picked last, zero drama
      colorscheme = saved_theme(),
    },
  },
}
