local M = {
    shortcuts = {}
}

function M.get_project_shortcuts(projects)
    local resp vim.system({'bash', '-c [ ! -e ~/.local/share/nvim/shortcuts/1.json]'})
    if resp.code ~= 0 then
        vim.system('touch', '~/.local/share/nvim/shortcuts/1.json')
    end
    return resp.code
    -- file_exists
    -- create if not
    -- read_file
end

function M.get_current_project()
    local cwd = vim.loop.cwd()
    local root = vim.fn.system("git rev-parse --show-toplevel")
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

print(M.get_current_project())

return M

