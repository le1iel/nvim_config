return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end
                -- Navigation
                map("n", "]f", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]f", bang = true })
                    else
                        gitsigns.next_hunk()
                    end
                end)

                map("n", "[f", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[f", bang = true })
                    else
                        gitsigns.prev_hunk()
                    end
                end)

                -- Actions
                vim.keymap.set("n", "<leader>fp", gitsigns.preview_hunk)
                vim.keymap.set("n", "<leader>fr", gitsigns.reset_hunk)
                vim.keymap.set("n", "<leader>fb", function()
                    gitsigns.blame_line()
                end)
            end,
        })
    end,
    priority = 0,
}
