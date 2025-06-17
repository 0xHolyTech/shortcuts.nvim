local f_manager = require('shortcuts.utils.files')

local M = {
    shortcuts = {
        n = {
            p = {
                command = 'echo "WORKS"',
                is_bash = true,
            },
        }
    },
    prefix = '<leader>a'
}

function M.is_invalid_shortcut(mode, keybind, shortcut)
    local exists = vim.cmd('silent ' .. mode .. 'map ' .. M.prefix .. keybind)
    if exists ~= '' then
        return true
    end
    if shortcut == nil then
        return true
    end
    if type(keybind) ~= 'string' then
        return true
    end
    return false
end

function M.get_project_shortcuts(project)
    local fn = project .. '.json'
    f_manager.touch(fn)
    if f_manager.is_empty(fn) then
        f_manager.fill_template(fn, M.shortcuts)
    end
    if f_manager.is_invalid_json(fn) then
        return M.shortcuts
    end
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

function M.add_shortcut(mode, keybind, shortcut)
    if M.is_invalid_shortcut(mode, keybind, shortcut) then
        vim.api.nvim_err_writeln('INVALID SHORTCUT: ' .. vim.inspect(shortcut))
    end
    if shortcut.is_bash then
        vim.keymap.set(mode, M.prefix .. keybind, '<Cmd>' .. shortcut.command .. '<CR>')
    else
        vim.keymap.set(mode, M.prefix .. keybind, shortcut.command)
    end
end

function M.setup()
    local project = M.get_current_project()
    M.shortcuts = M.get_project_shortcuts(project)
    for mode, shortcut in pairs(M.shortcuts) do
        for keybind, command in pairs(shortcut) do
            M.add_shortcut(mode, keybind, command)
        end
    end
end

M.setup()

return M

