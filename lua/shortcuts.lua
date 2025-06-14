local f_manager = require('shortcuts.utils.files')

local M = {
    shortcuts = {}
}

function M.get_project_shortcuts(project)
    -- create if not
    local fn = project .. '.json'
    f_manager.touch(fn)
    -- file_valid_json or empty file
    if f_manager.is_empty(fn) then
        f_manager.fill_template(fn, M.shortcuts)
    end
    if f_manager.is_invalid_json(fn) then
        vim.api.nvim_err_writeln('ERRORED')
    end
    -- read_file
    return f_manager.get_json(fn)
end

function M.get_current_project()
    local cwd = vim.loop.cwd()
    local root = vim.fn.system('git rev-parse --show-toplevel')
    if vim.v.shell_error == 0 and root ~= nil then
        local project, _ = string.gsub(root, "\n", "")
        project, _ = string.gsub(project, '/', '.')
        return project
    end
    return string.gsub(cwd, '/', '.')
end

function M.add_shortcut(shortcut)
end

function M.setup()
    local project = M.get_current_project()
    M.shortcuts = M.get_project_shortcuts(project)
    print(type(M.shortcuts))
    print(vim.inspect(M.shortcuts))
    for shortcut in M.shortcuts do
        M.add_shortcut(shortcut)
    end
end

M.setup()

return M

