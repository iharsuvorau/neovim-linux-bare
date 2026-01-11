vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

vim.lsp.config("html", {
  filetypes = { "html", "templ", "eruby" }
})

------------------------
-- Java Configuration --
------------------------

-- A good JDTLS config example is in this blog post,
-- https://sookocheff.com/post/vim/neovim-java-ide/

local home = os.getenv('HOME')

-- File types that signify a Java project's root directory. This will be
-- used by eclipse to determine what constitutes a workspace
local root_markers = {'gradlew', 'mvnw', '.git'}
local root_dir = require('jdtls.setup').find_root(root_markers)

-- eclipse.jdt.ls stores project specific data within a folder. If you are working with multiple different projects, each project must use a dedicated data directory. This variable is used to configure eclipse to use the directory name of the current project found using the root_marker as the folder for project specific data.
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
local lombok_path_mac = home .. '/.local/share/eclipse/lombok.jar'
local lombok_path_linux = home .. '/.local/share/nvim-dev/mason/packages/jdtls/lombok.jar'

vim.lsp.config("jdtls", {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    -- Mac
    -- '-javaagent:' .. lombok_path_mac,
    -- '-Xbootclasspath/a:' .. lombok_path_mac,
    -- '-jar', vim.fn.glob('/opt/homebrew/opt/jdtls/libexec/plugins/org.eclipse.equinox.launcher_*.jar'),
    -- '-configuration', '/opt/homebrew/opt/jdtls/libexec/config_mac_arm',

    -- Linux
    '-javaagent:' .. lombok_path_linux,
    '-Xbootclasspath/a:' .. lombok_path_linux,
    '-jar', vim.fn.glob(home .. '/.local/share/nvim-dev/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration', home .. '/.local/share/nvim-dev/mason/share/jdtls/config',

    -- Use the workspace_folder defined above to store data for this project
    '-data', workspace_folder,
  }
})

-------------------------------
-- end of Java Configuration --
-------------------------------

vim.lsp.enable({ "lua_ls", "ruby_lsp", "herb_ls", "gopls", "emmet_language_server", "html", "ts_ls", "clangd", "jdtls", "pylsp" })

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
