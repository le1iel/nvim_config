return {
    "echasnovski/mini.nvim",
    version = false,

    config = function()
        local mini = require("mini.files")
        mini.setup({
            options = {
                use_as_default_explorer = true,
            },
        })

        vim.keymap.set("n", "<leader>fe", mini.open)
    end,
}
