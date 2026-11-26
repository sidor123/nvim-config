local git = require 'gitsigns'
git.setup {
  on_attach = function(buf)
    local function map(keys, action, desc) vim.keymap.set('n', keys, action, { buffer = buf, desc = desc }) end
    for keys, direction in pairs { [']c'] = 'next', ['[c'] = 'prev' } do
      map(keys, function()
        if vim.wo.diff then
          vim.cmd.normal { keys, bang = true }
        else
          git.nav_hunk(direction)
        end
      end, 'Go to ' .. direction .. ' change')
    end
    map('<leader>hs', git.stage_hunk, 'Stage or unstage hunk')
    map('<leader>hr', git.reset_hunk, 'Reset hunk')
    map('<leader>hS', git.stage_buffer, 'Stage buffer')
    map('<leader>hR', git.reset_buffer, 'Reset buffer')
    map('<leader>hp', git.preview_hunk, 'Preview hunk')
    map('<leader>hb', git.blame_line, 'Blame line')
    map('<leader>hd', git.diffthis, 'Diff against index')
    map('<leader>hD', function() git.diffthis 'HEAD' end, 'Diff against HEAD')
    map('<leader>tb', git.toggle_current_line_blame, 'Toggle line blame')
    for keys, action in pairs { ['<leader>hs'] = git.stage_hunk, ['<leader>hr'] = git.reset_hunk } do
      vim.keymap.set('x', keys, function() action { vim.fn.line 'v', vim.fn.line '.' } end, { buffer = buf, desc = 'Apply hunk action to selection' })
    end
  end,
}
