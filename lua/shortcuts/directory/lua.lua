local directory_utils = require('shortcuts.utils.directory')
local M = {}

function M.is_lua_directory()
    local lua_indicators = {
        "init.lua",
        "main.lua",
        "rockspec",
        "lua",
        ".luarc.json",
        "selene.toml",
        "stylua.toml",
    }

    return directory_utils.is_directory_with_indicators(lua_indicators)
end

return M
