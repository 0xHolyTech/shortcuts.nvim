local Popup = require("nui.popup")
local Layout = require("nui.layout")

local event = require("nui.utils.autocmd").event

M = {
    layout_params = {
        position = "50%",
        size = {
            width = 80,
            height = "60%",
        },
    },
    popup = Popup({ enter = true, border = "single" }),
    project = '',
}


function M.setup(project)
    M.project = project
    M.popup:on(event.BufLeave, function()
        vim.cmd(':silent write! ' .. M.project)
        vim.cmd(':ShortcutsReset')
        M.popup:unmount()
    end)
    M.popup:on(event.BufWinEnter, function()
        vim.cmd(':silent 0read ' .. M.project)
    end, { once = true })
    M.layout = Layout(
        M.layout_params,
        Layout.Box({
            Layout.Box( M.popup, { size = "100%" } ),
        }, { dir = "row" })
    )
    M.popup:map("n", "q", function()
        M.layout:hide()
    end, {})
end

function M.ShowMenu()
    M.layout:show()
end

return M
