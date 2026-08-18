return {
    "bradcush/nvim-base16",
    config = function()
        vim.cmd("colorscheme base16-google-dark")

        local transparent = {
            "Normal",
            "NormalNC",
            "NormalFloat",
            "FloatBorder",
            "FloatTitle",
            "TabLine",
            "TabLineFill",
            "WinBar",
            "WinBarNC",
            "VertSplit",
            "WinSeparator",
        }

        for _, group in ipairs(transparent) do
            vim.api.nvim_set_hl(0, group, { bg = "NONE" })
        end

        -- Keep active tab highlighted
        vim.api.nvim_set_hl(0, "TabLineSel", {
            bg = "#303030",
            fg = "#ffffff",
            bold = true,
        })

        -- Bold functions and keywords
        vim.api.nvim_set_hl(0, "Function", {
            bold = true,
        })

        vim.api.nvim_set_hl(0, "Keyword", {
            bold = true,
        })
    end,
}
