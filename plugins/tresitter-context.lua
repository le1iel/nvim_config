return {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
        require("treesitter-context").setup({
            mode = "topline",
        })
        vim.keymap.set("n", "<F8>", ":TSContextToggle<CR>", {silent=true})
    end,
}
