return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                json = { "jq" },
                cpp = { "clang-format" },
                ["*"] = { "codespell" },
            },
        })
        conform.formatters.stylua = {
            prepend_args = function(self, ctx)
                return { "--indent-type", "Spaces" }
            end,
        }
        vim.keymap.set("n", "<leader>pf", function()
            conform.format()
        end)
    end,
    keys = {
        {
            "<leader>pf",
            function()
                require("conform").format()
            end,
            desc = "Pretty format.",
        },
    },
}
