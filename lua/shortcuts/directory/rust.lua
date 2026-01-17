local M = {}

function M.is_rust_directory()
    local uv = vim.uv or require('vim.uv')

    local rust_indicators = {
        "Cargo.toml",
        "Cargo.lock",
        "main.rs",
        "src/main.rs",
        "lib.rs",
        "src/lib.rs",
    }

    local cwd = uv.cwd()
    for _, indicator in ipairs(rust_indicators) do
        local path = cwd .. "/" .. indicator
        local stat = uv.fs_stat(path)

        if stat then
            return true
        end
    end

    return false
end

return M