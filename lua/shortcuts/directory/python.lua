local M = {}

function M.is_python_directory()
    local uv = vim.uv or require('vim.uv')

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

    local cwd = uv.cwd()
    for _, indicator in ipairs(python_indicators) do
        local path = cwd .. "/" .. indicator
        local stat = uv.fs_stat(path)

        if stat then
            return true
        end
    end

    return false
end

return M
