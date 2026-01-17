local directory_utils = require('shortcuts.utils.directory')
local M = {}

function M.is_rust_directory()
    local rust_indicators = {
        "Cargo.toml",
        "Cargo.lock",
        "main.rs",
        "src/main.rs",
        "lib.rs",
        "src/lib.rs",
    }

    return directory_utils.is_directory_with_indicators(rust_indicators)
end

return M