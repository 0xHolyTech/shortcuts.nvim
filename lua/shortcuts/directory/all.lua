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
    local language_detector_map = {
        docker = docker.is_docker_directory,
        golang = go.is_go_directory,
        javascript = javascript.is_javascript_directory,
        kubernetes = kubernetes.is_kubernetes_directory,
        lua = lua.is_lua_directory,
        python = python.is_python_directory,
        rust = rust.is_rust_directory,
        terraform = terraform.is_terraform_directory
    }

    for lang_name, detector_func in pairs(language_detector_map) do
        if detector_func() then
            table.insert(languages, lang_name)
        end
    end

    return languages
end

return M
