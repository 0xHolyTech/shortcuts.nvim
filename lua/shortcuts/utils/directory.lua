local M = {}

function M.is_directory_with_indicators(indicators)
    local uv = vim.uv or require('vim.uv')
    local cwd = uv.cwd()

    for _, indicator in ipairs(indicators) do
        local path = cwd .. "/" .. indicator
        local stat = uv.fs_stat(path)
        if stat then
            return true
        end
    end

    return false
end

return M
