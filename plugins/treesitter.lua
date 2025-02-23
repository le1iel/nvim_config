return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "python", "c", "lua", "vim", "vimdoc", "query" },
            sync_install = true,
            auto_install = true,
        })
    end,
}
