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

                local builtin = require("telescope.builtin")
                -- Actions
                map("n", "<leader>fr", gitsigns.reset_hunk)
                map("n", "<leader>fp", gitsigns.preview_hunk)
                map("n", "<leader>fb", gitsigns.blame_line)
                map("n", "<leader>fB", builtin.git_branches)
            end,
        })
    end,
    priority = 0,
}
