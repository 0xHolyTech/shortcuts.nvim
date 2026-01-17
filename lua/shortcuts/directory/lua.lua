local M = {}

function M.is_lua_directory()
    local uv = vim.uv or require('vim.uv')

    local lua_indicators = {
        "init.lua",
        "main.lua",
        "src/main.lua",
        "rockspec",
        "lua",
        ".luarc.json",
        "selene.toml",
        "stylua.toml",
    }

    local cwd = uv.cwd()
    for _, indicator in ipairs(lua_indicators) do
        local path = cwd .. "/" .. indicator
        local stat = uv.fs_stat(path)

        if stat then
            return true
        end
    end

    return false
end

return M