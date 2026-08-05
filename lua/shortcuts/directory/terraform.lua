local directory_utils = require('shortcuts.utils.directory')
local M = {}

function M.is_terraform_directory()
    local terraform_indicators = {
        "*.tf",
        "*.tfvars",
        "terraform",
    }

    return directory_utils.is_directory_with_indicators(terraform_indicators)
end

return M
