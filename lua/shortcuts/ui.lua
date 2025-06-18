local popup = require("plenary.popup")

M = {
    height = 20,
    width = 30,
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
}

local Win_id

function M.ShowMenu(opts, cb)
  Win_id = popup.create(opts, {
        title = "MyProjects",
        highlight = "MyProjectWindow",
        line = math.floor(((vim.o.lines - M.height) / 2) - 1),
        col = math.floor((vim.o.columns - M.width) / 2),
        minwidth = M.width,
        minheight = M.height,
        borderchars = M.borderchars,
        -- callback = cb,
  })
  local bufnr = vim.api.nvim_win_get_buf(Win_id)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>lua CloseMenu()<CR>", { silent=false })
end

return M
