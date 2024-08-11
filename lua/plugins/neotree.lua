return {

  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    vim.cmd [[nnoremap <leader>e :Neotree toggle<cr>]]
    vim.cmd [[nnoremap <leader>E :Neotree toggle position=current<cr>]]
  end,
}
