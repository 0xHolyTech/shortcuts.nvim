local directory = require("shortcuts.directory.all")

local M = {}

local defaults = {
    empty = {
        n = {
            p = {
                command = "echo 'Example bash commands'",
                command_type = "bash",
            },
            o = {
                command = "print('Example lua command')",
                command_type = "lua",
            },
            i = {
                command = "lua print('example vim command')",
                command_type = "nvim",
            },
            u = {
                command = "echo 'hi'; sleep 3; echo 'bye'",
                command_type = "async",
                async_type = "run",
            },
            y = {
                command = "echo 'hi'; sleep 3; echo 'bye'",
                command_type = "async",
                async_type = "term",
                notify = true,
            },
            t = {
                command = "ihello world<ESC>",
                command_type = "keyinject",
            },
        },
    },
    default = {
    },
    python = {
        n = {
            l = {
              command_type = "async",
              async_type = "run",
              command = "uv run black ."
            }
        }
    },
    docker = {
        n = {
            b = {
              command_type = "async",
              async_type = "term",
              command = "docker compose build"
            },
            u = {
              command_type = "async",
              async_type = "run",
              command = "docker compose up -d",
              notify = true
            },
            d = {
              command_type = "async",
              async_type = "run",
              command = "docker compose down",
              notify = true
            },
        },
    },
    golang = {
        n = {
            u = {
                command_type = "async",
                async_type = "term",
                command = "go run main.go",
            },
            b = {
                command_type = "async",
                async_type = "term",
                command = "go build main.go",
            },
        },
    }
}

function M.generate_defaults()
    local language_list = directory.get_project_languages()
    local shortcuts = {}
    if next(language_list) == nil then
        table.insert(language_list, "empty")
    end
    table.insert(language_list, "default")
    for _, lang in pairs(language_list) do
        shortcuts = vim.tbl_deep_extend('keep', shortcuts, defaults[lang])
    end
    return shortcuts
end

return M
