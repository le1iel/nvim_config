return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local builtin = require("telescope.builtin")
        local opts = { silent = true, noremap = true, buffer = true }

        vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)
        vim.keymap.set("n", "<leader>fg", builtin.git_files, opts)
        vim.keymap.set("n", "<leader>fs", builtin.live_grep, opts)

        vim.keymap.set("n", "<leader>lh", builtin.help_tags, opts)
        vim.keymap.set("n", "<leader>lm", builtin.marks, opts)
        vim.keymap.set("n", "<leader>lb", builtin.buffers, opts)
        vim.keymap.set("n", "<leader>ss", builtin.spell_suggest, opts)
    end,
}
