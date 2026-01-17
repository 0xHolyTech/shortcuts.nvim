local go = require('shortcuts.directory.go')
local javascript = require('shortcuts.directory.javascript')
local lua = require('shortcuts.directory.lua')
local python = require('shortcuts.directory.python')
local rust = require('shortcuts.directory.rust')
local docker = require('shortcuts.directory.docker')
local kubernetes = require('shortcuts.directory.kubernetes')
local terraform = require('shortcuts.directory.terraform')

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
    if docker.is_docker_directory() then
        table.insert(languages, 'docker')
    end
    if kubernetes.is_kubernetes_directory() then
        table.insert(languages, 'kubernetes')
    end
    if terraform.is_terraform_directory() then
        table.insert(languages, 'terraform')
    end
    return languages
end

return M
