local M = {}

function M.is_javascript_directory()
    local uv = vim.uv or require('vim.uv')

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

    local cwd = uv.cwd()
    for _, indicator in ipairs(js_indicators) do
        local path = cwd .. "/" .. indicator
        local stat = uv.fs_stat(path)

        if stat then
            return true
        end
    end

    return false
end

return M