local M = {}

local function find_files_single_depth(pattern)
    local cmd = "find . -maxdepth 1 -name '" .. pattern .. "' -type f"
    return vim.fn.system(cmd)
end

function M.is_directory_with_indicators(indicators)
    for _, indicator in ipairs(indicators) do
        local path = indicator
        local stat = find_files_single_depth(path)
        if string.len(stat) > 0 then
            return true
        end
    end

    return false
end

return M
