return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
        "moyiz/blink-emoji.nvim",
    },

    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "default",
            ["<C-y>"] = { "accept", "fallback" },
        },

        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        },
        completion = { documentation = { auto_show = true } },
        signature = { enabled = true },
        snippets = { preset = "luasnip" },

        sources = {
            default = { "lsp", "path", "snippets", "buffer", "emoji" },
            providers = {
                emoji = {
                    module = "blink-emoji",
                    name = "Emoji",
                    score_offset = 15,        -- Tune by preference
                    opts = { insert = true }, -- Insert emoji (default) or complete its name
                    should_show_items = function()
                        return vim.tbl_contains(
                        -- Enable emoji completion only for git commits and markdown.
                        -- By default, enabled for all file-types.
                            { "gitcommit", "markdown" },
                            vim.o.filetype
                        )
                    end,
                },
            },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
