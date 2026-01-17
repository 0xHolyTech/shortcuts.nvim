local directory_utils = require('shortcuts.utils.directory')
local M = {}

function M.is_javascript_directory()
    local js_indicators = {
        "package.json",
        "package-lock.json",
        "yarn.lock",
        "pnpm-lock.yaml",
        "main.js",
        "src/main.js",
        "index.js",
        "lib/index.js",
        "webpack.config.js",
        "babel.config.js",
        "eslintrc.js",
        ".eslintrc.json",
        "tsconfig.json",
        "jsconfig.json",
    }

    return directory_utils.is_directory_with_indicators(js_indicators)
end

return M