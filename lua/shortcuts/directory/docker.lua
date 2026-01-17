local directory_utils = require('shortcuts.utils.directory')
local M = {}

function M.is_docker_directory()
    local docker_indicators = {
        "Dockerfile",
        "Dockerfile.*",
        "docker-compose.*",
    }

    return directory_utils.is_directory_with_indicators(docker_indicators)
end

return M
