local default_on_attach = function(_, _)
    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "K", vim.lsp.buf.hover)
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition)
    vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration)
    vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation)
    vim.keymap.set("n", "<leader>gr", builtin.lsp_references)
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.code_action)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
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

        -- Gutter sings
        local signs = {
            Error = " ",
            Warn = " ",
            Hint = " ",
            Info = " ",
        }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        -- Ensure some lsps are installed always
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "pylsp", "clangd", "rust_analyzer" },
        })

        local lspconfig = require("lspconfig")

        -- Language specific settings
        lspconfig.pylsp.setup({
            on_attach = default_on_attach,
            -- formatter options
            black = { enabled = true },
            autopep8 = { enabled = false },
            yapf = { enabled = false },
            -- linter options
            pylint = { enabled = true, executable = "pylint" },
            pyflakes = { enabled = false },
            pycodestyle = { enabled = false },
            -- type checker
            pylsp_mypy = { enabled = true },
            -- auto-completion options
            jedi_completion = { fuzzy = true },
            -- import sorting
            pyls_isort = { enabled = true },
        })
        lspconfig.rust_analyzer.setup({ on_attach = default_on_attach })
        lspconfig.clangd.setup({
            on_attach = function(client, buffernr)
                default_on_attach(client, buffernr)
                vim.keymap.set("n", "<leader>%", ":ClangdSwitchSourceHeader<CR>", { silent = true })
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
