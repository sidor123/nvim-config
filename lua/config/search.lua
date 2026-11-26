local pick = require 'mini.pick'
pick.setup()
local extra = require 'mini.extra'
extra.setup()

local function map(keys, action, desc) vim.keymap.set('n', keys, action, { desc = desc }) end

map('<leader>sf', pick.builtin.files, 'Find file')
map('<leader>sg', pick.builtin.grep_live, 'Search project text')
map('<leader>sw', function() pick.builtin.grep { pattern = vim.fn.expand '<cword>' } end, 'Search word under cursor')
map('<leader><leader>', pick.builtin.buffers, 'Find buffer')
map('<leader>sh', pick.builtin.help, 'Find help')
map('<leader>sk', extra.pickers.keymaps, 'Find keymap')
map('<leader>sd', extra.pickers.diagnostic, 'Find diagnostic')
map('<leader>s.', extra.pickers.oldfiles, 'Recent files')
map('<leader>sr', pick.builtin.resume, 'Resume search')
map('<leader>/', function() extra.pickers.buf_lines { scope = 'current' } end, 'Search buffer')
map('<leader>sn', function() pick.builtin.files(nil, { source = { cwd = vim.fn.stdpath 'config' } }) end, 'Find Neovim config file')
