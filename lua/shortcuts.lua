local f_manager = require('shortcuts.file_utils')

local M = {
    shortcuts = {}
}

function M.get_project_shortcuts(projects)
    -- create if not
    f_manager.touch('1.json')
    -- file_valid_json or empty file
    f_manager.read_file('1.json')
    if f_manager.is_empty() then
        f_manager.fill_template()
    elseif f_manager.invalid_json() then
        vim.api.nvim_err_writeln('ERRORED')
    end
    -- read_file
end

function M.get_current_project()
    local cwd = vim.loop.cwd()
    local root = vim.fn.system('git rev-parse --show-toplevel')
    if vim.v.shell_error == 0 and root ~= nil then
        return string.gsub(root, "\n", "")
    end
    return cwd
end

function M.add_shortcut(shortcut)
end

function M.setup()
    local project = M.get_current_project()
    M.shortcuts = M.get_project_shortcuts(project)
    for shortcut in M.shortcuts do
        M.add_shortcut(shortcut)
    end
end

print(M.get_project_shortcuts("a"))

return M

