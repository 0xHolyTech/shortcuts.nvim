local f_manager = require('shortcuts.utils.files')

local M = {
    shortcuts = {
        n = {
            keybind = 'p',
            command = 'echo "WORKS"',
        }
    },
    prefix = '<leader>a'
}

function M.is_invalid_shortcut(mode, shortcut)
    if shortcut == nil then
        return true
    end
    if type(shortcut.keybind) ~= 'string' then
        return true
    end
    return false
end

function M.get_project_shortcuts(project)
    -- create if not
    local fn = project .. '.json'
    f_manager.touch(fn)
    -- file_valid_json or empty file
    if f_manager.is_empty(fn) then
        f_manager.fill_template(fn, M.shortcuts)
    end
    if f_manager.is_invalid_json(fn) then
        return M.shortcuts
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

function M.add_shortcut(mode, shortcut)
    if M.is_invalid_shortcut(mode, shortcut) then
        vim.api.nvim_err_writeln('INVALID SHORTCUT: ' .. vim.inspect(shortcut))
    end
    vim.keymap.set(mode, M.prefix .. shortcut.keybind, '<Cmd>' .. shortcut.command .. '<CR>')
end

function M.setup()
    local project = M.get_current_project()
    M.shortcuts = M.get_project_shortcuts(project)
    for mode, shortcut in pairs(M.shortcuts) do
        M.add_shortcut(mode, shortcut)
    end
end

M.setup()

return M

