local go = require('shortcuts.directory.go')
local javascript = require('shortcuts.directory.javascript')
local lua = require('shortcuts.directory.lua')
local python = require('shortcuts.directory.python')
local rust = require('shortcuts.directory.rust')

local M = {}

function M.get_project_languages()
    local languages = {}
    if go.is_go_directory() then
        languages.insert('go')
    end
    if javascript.is_javascript_directory() then
        languages.insert('js')
    end
    if lua.is_lua_directory() then
        languages.insert('lua')
    end
    if python.is_python_directory() then
        languages.insert('python')
    end
    if rust.is_rust_directory() then
        languages.insert('rust')
    end
    return languages
end

return M
