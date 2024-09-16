return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        })
        vim.keymap.set('n', '<F5>', function()require('lualine').refresh() end, {silent=true})
    end,
}
