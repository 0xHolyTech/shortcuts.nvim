local f_manager = require('shortcuts.utils.files')
local ui = require('shortcuts.ui')

local M = {
    shortcuts = {
        n = {
            p = {
                command = 'echo "Example bash commands"',
                command_type = 'bash',
            },
            o = {
                command = 'print("Example lua command")',
                command_type = 'lua',
            },
            i = {
                command = 'lua print("example vim command")',
                command_type = 'nvim',
            },
        }
    },
    plugin_path = vim.fn.expand('$HOME/.local/share/nvim/shortcuts/'),
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
    if shortcut.command_type == 'lua' then
        vim.keymap.set(mode, M.prefix .. keybind, ':lua ' .. shortcut.command .. '<CR>')
    elseif shortcut.command_type == 'nvim' or shortcut.command_type == 'vim' then
        vim.keymap.set(mode, M.prefix .. keybind, ':' .. shortcut.command .. '<CR>')
    elseif shortcut.command_type == 'bash' then
        vim.keymap.set(mode, M.prefix .. keybind, '<Cmd>' .. shortcut.command .. '<CR>')
    else
        vim.keymap.set(mode, M.prefix .. keybind, '<Cmd>' .. shortcut.command .. '<CR>')
        vim.api.nvim_err_writeln(shortcut.command_type .. ' is not a valid command type, defaulting to bash')
    end
end

function M.show_ui()
    ui.ShowMenu()
end

function M.hide_ui()
    ui.HideMenu()
end

function M.setup()
    local project = M.get_current_project()
    f_manager.setup(M.plugin_path)
    ui.setup(M.plugin_path .. project .. '.json')
    M.shortcuts = M.get_project_shortcuts(project)
    for mode, shortcut in pairs(M.shortcuts) do
        for keybind, command in pairs(shortcut) do
            M.add_shortcut(mode, keybind, command)
        end
    end
end

M.setup()
-- M.show_ui()

return M

