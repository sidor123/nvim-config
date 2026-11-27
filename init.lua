vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.mouse = 'a'
opt.clipboard:append 'unnamedplus'
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = 'yes'
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.inccommand = 'split'
opt.cursorline = true
opt.scrolloff = 10
opt.completeopt = { 'menuone', 'noselect', 'popup' }

local map = vim.keymap.set
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>e', '<cmd>Neotree toggle left<CR>', { desc = 'Toggle Neo-tree sidebar' })
map('n', '<leader>E', '<cmd>Neotree toggle current<CR>', { desc = 'Toggle Neo-tree in current window' })
map('n', '<leader>C', '<cmd>quit<CR>', { desc = 'Close window' })
map('n', '<leader>q', '<cmd>qa<CR>', { desc = 'Quit Neovim' })
map('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
for _, key in ipairs { 'h', 'j', 'k', 'l' } do
  map('n', '<C-' .. key .. '>', '<C-w>' .. key, { desc = 'Focus adjacent window' })
end

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('close-empty-buffer', { clear = true }),
  callback = function(event)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if buf ~= event.buf
        and vim.api.nvim_buf_is_valid(buf)
        and vim.api.nvim_buf_get_name(buf) == ''
        and vim.bo[buf].buftype == ''
        and not vim.bo[buf].modified
        and vim.api.nvim_buf_line_count(buf) == 1
        and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ''
      then
        vim.api.nvim_buf_delete(buf, {})
      end
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('syntax-highlight', { clear = true }),
  pattern = { 'c', 'cpp', 'go', 'kotlin', 'sh', 'diff', 'html' },
  callback = function(event)
    local lang = vim.treesitter.language.get_lang(event.match)
    if lang and vim.treesitter.language.add(lang) and vim.treesitter.query.get(lang, 'highlights') then vim.treesitter.start(event.buf, lang) end
  end,
})

-- Reuse tools already installed by Mason, after executables on the system PATH.
local mason_bin = vim.fn.stdpath 'data' .. '/mason/bin'
if vim.fn.isdirectory(mason_bin) == 1 then vim.env.PATH = vim.env.PATH .. ':' .. mason_bin end

vim.pack.add {
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/tiagovla/tokyodark.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = 'v3.x' },
  'https://github.com/goolord/alpha-nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/folke/snacks.nvim',
  'https://github.com/leejh903/codex.nvim',
  'https://github.com/akinsho/bufferline.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-treesitter/nvim-treesitter',
}

vim.cmd.colorscheme 'tokyodark'
require('nvim-treesitter').setup { install_dir = vim.fn.stdpath 'data' .. '/site' }
require('nvim-treesitter').install { 'c', 'cpp', 'go', 'kotlin' }
vim.cmd.highlight 'Comment gui=none'
require('mini.ai').setup { n_lines = 500 }
require('mini.surround').setup()
local pairs_plugin = require 'mini.pairs'
pairs_plugin.setup()
map('i', '<Tab>', function() return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>' end, { expr = true })
map('i', '<S-Tab>', function() return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>' end, { expr = true })
map('i', '<CR>', function()
  if vim.fn.pumvisible() == 0 then return pairs_plugin.cr() end
  local selected = vim.fn.complete_info({ 'selected' }).selected
  return vim.keycode(selected == -1 and '<C-n><C-y>' or '<C-y>')
end, { expr = true, replace_keycodes = false })
require('lualine').setup {
  options = {
    theme = 'auto',
    globalstatus = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { statusline = { 'alpha', 'neo-tree' } },
  },
  sections = {
    lualine_a = { { 'mode', fmt = function(mode) return ' ' .. mode .. ' ' end } },
    lualine_b = {
      { 'branch', icon = '', separator = { right = '' } },
      { 'filetype', icon_only = true, colored = true, padding = { left = 1, right = 0 } },
      { 'filename', path = 0, symbols = { modified = ' ●', readonly = ' ', unnamed = '[No Name]' } },
    },
    lualine_c = {
      { 'diagnostics', sources = { 'nvim_diagnostic' }, symbols = { error = ' ', warn = ' ', info = ' ' } },
    },
    lualine_x = {},
    lualine_y = {
      { 'progress', separator = { left = '' } },
      { function() return ('%d'):format(vim.fn.line '.') end, icon = '', padding = { left = 1, right = 0 } },
      { function() return ('%d'):format(vim.fn.col '.') end, icon = '', padding = { left = 0, right = 1 } },
    },
    lualine_z = { { function() return ' ' .. os.date '%H:%M' end, separator = { left = '' } } },
  },
  extensions = { 'neo-tree', 'quickfix' },
}
require('bufferline').setup {
  options = {
    mode = 'buffers',
    separator_style = 'slant',
    show_buffer_close_icons = false,
    show_close_icon = false,
    diagnostics = 'nvim_lsp',
    offsets = { { filetype = 'neo-tree', text = 'Files', text_align = 'left' } },
  },
}
map('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
map('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
map('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Close buffer' })
require('snacks').setup { terminal = { enabled = true } }
local codex_home = vim.env.CODEX_HOME or vim.fn.expand '~/.codex'
require('codex').setup { socket_paths = { codex_home .. '/ipc/ipc.sock' } }
require('codex').start()
require('codex.terminal').setup {
  split_side = 'right',
  split_width_percentage = 0.35,
}
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('codex-terminal-navigation', { clear = true }),
  callback = function(event)
    if vim.bo[event.buf].filetype ~= 'snacks_terminal' then return end
    for key, direction in pairs { h = 'h', j = 'j', k = 'k', l = 'l' } do
      vim.keymap.set('t', '<C-' .. key .. '>', '<C-\\><C-n><C-w>' .. direction, {
        buffer = event.buf,
        desc = 'Move focus ' .. direction,
      })
    end
    vim.keymap.set('t', '<C-q>', '<C-\\><C-n>:q<CR>', {
      buffer = event.buf,
      desc = 'Close Codex window',
    })
  end,
})
map('n', '<leader>cc', '<cmd>Codex<CR>', { desc = 'Toggle Codex terminal' })
map('n', '<leader>cf', '<cmd>CodexFocus<CR>', { desc = 'Focus Codex terminal' })
map('x', '<leader>cs', '<cmd>CodexSend<CR>', { desc = 'Send selection to Codex' })
opt.showmode = false

require 'config.search'
require('neo-tree').setup {}
require('fidget').setup {}
require('todo-comments').setup { signs = false }
require('ibl').setup {}
local which_key = require 'which-key'
which_key.setup {}
which_key.add {
  { '<leader>s', group = 'Search' },
  { '<leader>h', group = 'Git hunks', mode = { 'n', 'x' } },
}
require 'config.dashboard'
require 'config.git'
require 'config.lsp'

local conform = require 'conform'
conform.setup {
  formatters_by_ft = { lua = { 'stylua' } },
  format_on_save = function(buf)
    local ft = vim.bo[buf].filetype
    if ft ~= 'c' and ft ~= 'cpp' then return { timeout_ms = 500, lsp_format = 'fallback' } end
  end,
}
map({ 'n', 'x' }, '<leader>f', function() conform.format { async = true, lsp_format = 'fallback' } end, { desc = 'Format code' })
