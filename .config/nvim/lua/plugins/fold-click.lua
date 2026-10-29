-- No Fold Clicks

-- It’s uncomfortable for me on my phone.

return {
  {
    "folke/snacks.nvim",
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local ok, sc = pcall(require, "snacks.statuscolumn")
          if ok then
            sc.click_fold = function() end
          end
        end,
      })
    end,
  },
}
