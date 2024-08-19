return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim"},

    config = function()
       vim.keymap.set("n", "<leader>fe", ":Neotree position=current<CR>", {silent=true})
    end
}
