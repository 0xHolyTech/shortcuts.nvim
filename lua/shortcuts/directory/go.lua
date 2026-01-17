local M = {}

function M.is_go_directory()
    local uv = vim.uv or require('vim.uv')

    local go_indicators = {
        "go.mod",
        "go.sum",
        "go.work",
        "main.go",
        "go.mod",
        "go.{version}",
        "Gopkg.toml",
        "Gopkg.lock",
    }

    local cwd = uv.cwd()
    for _, indicator in ipairs(go_indicators) do
        local path = cwd .. "/" .. indicator
        local stat = uv.fs_stat(path)

        if stat then
            return true
        end
    end

    return false
end

return M