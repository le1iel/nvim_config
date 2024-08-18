return {
    "mbbill/undotree",
    config = function()
        vim.keymap.set("n", "<F8>", vim.cmd.UndotreeToggle)
    end
}
