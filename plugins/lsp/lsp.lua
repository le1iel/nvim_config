local default_on_attach = function(client, buffnr)
    local opts = {
        noremap = true,
        buffer = true,
        silent = true,
    }

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>dd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>dr", builtin.lsp_references, opts)
    vim.keymap.set("n", "<leader>df", builtin.quickfix, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "williamboman/mason-lspconfig.nvim",
        "williamboman/mason.nvim",
    },
    config = function()
        --- Lsp Manager
        require("mason").setup()

        -- Configs for window
        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = false,
        })

        local signs = {
            Error = "󰅚 ",
            Warn = "󰀪 ",
            Hint = "󰌶 ",
            Info = " ",
        }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        -- Ensure some lsps are installed always
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "pyright", "clangd" },
        })

        local lspconfig = require("lspconfig")

        -- Language specific settings
        lspconfig.pyright.setup({ on_attach = default_on_attach })
        lspconfig.clangd.setup({
            on_attach = function(client, buffernr)
                default_on_attach(client, buffernr)
                vim.keymap.set("n", "<leader>%", ":ClangdSwitchSourceHeader<CR>", { silent = true, buffer = true })
            end,
        })

        lspconfig.lua_ls.setup({
            on_attach = default_on_attach,
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = {
                            "vim",
                            "require",
                        },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })
    end,
}
