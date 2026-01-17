local go = require('shortcuts.directory.go')
local javascript = require('shortcuts.directory.javascript')
local lua = require('shortcuts.directory.lua')
local python = require('shortcuts.directory.python')
local rust = require('shortcuts.directory.rust')

local M = {}

function M.get_project_languages()
    local languages = {}
    if go.is_go_directory() then
        table.insert(languages, 'go')
    end
    if javascript.is_javascript_directory() then
        table.insert(languages, 'js')
    end
    if lua.is_lua_directory() then
        table.insert(languages, 'lua')
    end
    if python.is_python_directory() then
        table.insert(languages, 'python')
    end
    if rust.is_rust_directory() then
        table.insert(languages, 'rust')
    end
    return languages
end

return M
