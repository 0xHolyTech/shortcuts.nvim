local f_manager = require('shortcuts.utils.files')
local ui = require('shortcuts.ui')

local Shortcuts = {
    default_shortcuts = {
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
    shortcuts = {},
    plugin_path = vim.fn.expand('$HOME/.local/share/nvim/shortcuts/'),
    prefix = '<leader>a'
}

function Shortcuts.is_invalid_shortcut(mode, keybind, shortcut)
    local exists = vim.cmd('silent ' .. mode .. 'map ' .. Shortcuts.prefix .. keybind)
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

function Shortcuts.get_project_shortcuts(project)
    local fn = project .. '.json'
    f_manager.touch(fn)
    if f_manager.is_empty(fn) then
        f_manager.fill_template(fn, Shortcuts.default_shortcuts)
    end
    if f_manager.is_invalid_json(fn) then
        return Shortcuts.default_shortcuts
    end
    return f_manager.get_json(fn)
end

function Shortcuts.reset_project_shortcuts()
    local project = Shortcuts.get_current_project()
    local fn = project .. '.json'
    f_manager.delete(fn)
    return Shortcuts.get_project_shortcuts(project)
end

function Shortcuts.get_current_project()
    local cwd = vim.loop.cwd()
    local root = vim.fn.system('git rev-parse --show-toplevel')
    if vim.v.shell_error == 0 and root ~= nil then
        local project, _ = string.gsub(root, "\n", "")
        project, _ = string.gsub(project, '/', '.')
        return project
    end
    return string.gsub(cwd, '/', '.')
end

function Shortcuts.add_shortcut(mode, keybind, shortcut)
    if Shortcuts.is_invalid_shortcut(mode, keybind, shortcut) then
        vim.api.nvim_err_writeln('INVALID SHORTCUT: ' .. vim.inspect(shortcut))
    end
    if shortcut.command_type == 'lua' then
        vim.keymap.set(mode, Shortcuts.prefix .. keybind, ':lua ' .. shortcut.command .. '<CR>')
    elseif shortcut.command_type == 'nvim' or shortcut.command_type == 'vim' then
        vim.keymap.set(mode, Shortcuts.prefix .. keybind, ':' .. shortcut.command .. '<CR>')
    elseif shortcut.command_type == 'bash' then
        vim.keymap.set(mode, Shortcuts.prefix .. keybind, '<Cmd>' .. shortcut.command .. '<CR>')
    else
        vim.keymap.set(mode, Shortcuts.prefix .. keybind, '<Cmd>' .. shortcut.command .. '<CR>')
        vim.api.nvim_err_writeln(shortcut.command_type .. ' is not a valid command type, defaulting to bash')
    end
end

function Shortcuts.show_ui()
    ui.ShowMenu()
end

function Shortcuts.hide_ui()
    ui.HideMenu()
end

function Shortcuts.setup()
    local project = Shortcuts.get_current_project()
    f_manager.setup(Shortcuts.plugin_path)
    ui.setup(Shortcuts.plugin_path .. project .. '.json')
    Shortcuts.shortcuts = Shortcuts.get_project_shortcuts(project)
    for mode, shortcut in pairs(Shortcuts.shortcuts) do
        for keybind, command in pairs(shortcut) do
            Shortcuts.add_shortcut(mode, keybind, command)
        end
    end
end

vim.api.nvim_create_user_command('ShortcutsToggle', 'lua require"shortcuts".toggle()', {})
vim.api.nvim_create_user_command('ShortcutsReset', 'lua require"shortcuts".reset_project_shortcuts()', {})

