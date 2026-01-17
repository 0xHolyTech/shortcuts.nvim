local directory_utils = require('shortcuts.utils.directory')
local M = {}

function M.is_python_directory()
    local python_indicators = {
        "pyproject.toml",
        "setup.py",
        "main.py",
        "src/main.py",
        "requirements.txt",
        "requirements-dev.txt",
        "Pipfile",
        "Pipfile.lock",
        "poetry.lock",
        "conda.yml",
        ".venv",
        "venv",
    }

    return directory_utils.is_directory_with_indicators(python_indicators)
end

return M
