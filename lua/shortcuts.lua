local M = {
    shortcuts = {}
}

function M.get_project_shortcuts(projects)
end

function M.get_current_project()
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

return M

