return {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
        require("treesitter-context").setup({
            mode = "topline",
            max_lines = 3,
        })
        vim.keymap.set("n", "<F8>", ":TSContextToggle<CR>", {silent=true})
    end,
}
