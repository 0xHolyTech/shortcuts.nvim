local json = require('shortcuts.utils.json')

local FileManager = {}

local plugin_path = vim.fn.expand('$HOME/.local/share/nvim/shortcuts/')

function FileManager.touch(file)
    vim.fn.system('mkdir -p ' .. plugin_path)
    vim.fn.system('touch '.. plugin_path .. file)
end

function FileManager.read_file(file)
    local lines = ''
    for line in io.lines(plugin_path .. file) do
      lines = lines .. '\n' .. line
    end
    return lines
end

function FileManager.is_empty(file)
    local content = FileManager.read_file(file)
    return content == ''
end

function FileManager.is_invalid_json(file)
    local content = FileManager.read_file(file)
    local should_be_json = json.decode(content)
    print(should_be_json)
    print(type(should_be_json))
    return true
end

return FileManager
