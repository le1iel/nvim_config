-- Configs for window
vim.diagnostic.config({
    virtual_text = true,
    virtual_line = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
        },
    },
    underline = true,
    update_in_insert = false,
})

vim.lsp.config["neocmakelsp"] = {
    cmd = { "neocmakelsp", "--stdio" },
    filetypes = { "cmake" },
    root_markers = { ".git" },
}

vim.lsp.enable({ "clangd", "luals", "neocmakelsp" })
