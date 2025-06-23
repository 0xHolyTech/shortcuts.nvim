local popup = require("plenary.popup")

M = {
    height = 20,
    width = 50,
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    bufnr = vim.api.nvim_create_buf(false, true),
    project = ''
}

function M.setup(project)
    M.project = project
    vim.api.nvim_create_autocmd('BufLeave', {
        buffer = M.bufnr,
        callback = function()
            -- This should save to file
            -- :write M.project
        end
    })
    vim.api.nvim_create_autocmd('BufEnter', {
        buffer = M.bufnr,
        callback = function()
            -- This should load from file
            -- :edit M.project
        end
    })
end

function M.ShowMenu()
    M.Win_id = popup.create(M.bufnr, {
        title = M.project,
        highlight = "MyProjectWindow",
        line = math.floor(((vim.o.lines - M.height) / 2) - 1),
        col = math.floor((vim.o.columns - M.width) / 2),
        minwidth = M.width,
        minheight = M.height,
        borderchars = M.borderchars,
        -- callback = cb,
    })
    vim.api.nvim_buf_set_keymap(M.bufnr, "n", "q", "<cmd>lua require('shortcuts').hide_ui()<CR>", { silent=false })
end

function M.HideMenu()
    vim.api.nvim_win_hide(M.Win_id)
end

return M
