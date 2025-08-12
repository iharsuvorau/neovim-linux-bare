vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

vim.lsp.config("html", {
  filetypes = { "html", "templ", "eruby" }
})

vim.lsp.enable({ "lua_ls", "ruby_lsp", "herb_ls", "gopls", "emmet_language_server", "html", "ts_ls" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end
  end
})

vim.cmd("set completeopt+=noselect")

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, { desc = "Format buffer with LSP" })
vim.keymap.set("n", "<leader>ef", ":w<cr>:!herb-format %<cr>", { desc = "Format ERB with Herb" })
