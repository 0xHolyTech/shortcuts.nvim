local directory_utils = require('shortcuts.utils.directory')
local M = {}

function M.is_go_directory()
    local go_indicators = {
        "go.mod",
        "go.sum",
        "go.work",
        "main.go",
        "go.{version}",
        "Gopkg.toml",
        "Gopkg.lock",
    }

    return directory_utils.is_directory_with_indicators(go_indicators)
end

return M