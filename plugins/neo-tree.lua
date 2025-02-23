return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim"},

    config = function()
        require("neo-tree").setup({
            filesystem= {
                hijack_netrw_behavior = "open_current"
            }
        })
       vim.keymap.set("n", "<leader>fe", function()
           require("neo-tree.command").execute({
               action = "focus",
               position = "float",
               reveal_force_cwd=true,
               source = "filesystem",
               })
           end
       )
    end
}
