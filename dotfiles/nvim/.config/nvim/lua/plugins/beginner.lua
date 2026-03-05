-- Beginner-friendly plugin customizations
-- Makes LazyVim more approachable

return {
  {
    "folke/which-key.nvim",
    opts = {
      delay = 200, -- show keybinding hints faster
    },
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  },
}
