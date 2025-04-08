return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind.nvim",
    },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-y>"] = cmp.mapping.confirm({
                    behaviour = cmp.ConfirmBehavior.Insert,
                    select = true,
                }),
                -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path", keyword_length = 5},
            }, {
                { name = "buffer", keyword_length = 5},
            }),
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol", -- show only symbol annotations
                    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    -- can also be a function to dynamically calculate max width such as
                    -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                    ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    show_labelDetails = true, -- show labelDetails in menu. Disabled by default
                    menu = {
                        buffer = "buf",
                        nvim_lsp = "lsp",
                        luasnip = "snp",
                    }
                }),
            },
        })

        -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
        -- Set configuration for specific filetype.
        -- cmp.setup.filetype("gitcommit", {
        --     sources = cmp.config.sources({
        --         { name = "git" },
        --     }, {
        --         { name = "buffer" },
        --     }),
        -- })
        -- require("cmp_git").setup()

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        -- cmp.setup.cmdline({ "/", "?" }, {
        --     mapping = cmp.mapping.preset.cmdline(),
        --     sources = {
        --         { name = "buffer" },
        --     },
        -- })
    end,
}
