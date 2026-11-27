local servers = {
  clangd = {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
    root_markers = { 'compile_commands.json', 'compile_flags.txt', '.clangd', '.git' },
  },
  gopls = { cmd = { 'gopls' } },
  kotlin_lsp = { cmd = { 'intellij-server', '--stdio' }, single_file_support = false },
  lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
    settings = { Lua = { completion = { callSnippet = 'Replace' } } },
  },
  texlab = {
    cmd = { 'texlab' },
    filetypes = { 'tex', 'plaintex', 'bib' },
    root_markers = { '.texlabroot', 'texlabroot', '.latexmkrc', 'latexmkrc', 'Tectonic.toml', '.git' },
  },
}
for name, config in pairs(servers) do
  vim.lsp.config(name, config)
  local server_config = vim.lsp.config[name]
  local command = (config.cmd or server_config.cmd)[1]
  if vim.fn.executable(command) == 1 then vim.lsp.enable(name) end
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-keys', { clear = true }),
  callback = function(event)
    local function map(keys, action, desc) vim.keymap.set('n', keys, action, { buffer = event.buf, desc = desc }) end
    local buf = vim.lsp.buf
    map('gd', buf.definition, 'Go to definition')
    map('gD', buf.declaration, 'Go to declaration')
    map('gI', buf.implementation, 'Go to implementation')
    map('gr', buf.references, 'Find references')
    map('K', buf.hover, 'Show documentation')
    map('<leader>D', buf.type_definition, 'Go to type definition')
    map('<leader>ds', buf.document_symbol, 'Document symbols')
    map('<leader>ws', function() buf.workspace_symbol() end, 'Workspace symbols')
    map('<leader>rn', buf.rename, 'Rename symbol')
    map('<leader>ca', buf.code_action, 'Code action')
    vim.keymap.set('i', '<C-k>', buf.signature_help, { buffer = event.buf, desc = 'Show signature help' })

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/completion', event.buf) then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
      vim.keymap.set('i', '<C-Space>', vim.lsp.completion.get, { buffer = event.buf, desc = 'Complete symbol' })
    end

    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
      map(
        '<leader>th',
        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }, { bufnr = event.buf }) end,
        'Toggle inlay hints'
      )
    end
  end,
})
