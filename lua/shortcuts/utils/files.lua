local json = require('shortcuts.utils.json')

local FileManager = {}

local plugin_path = vim.fn.expand('$HOME/.local/share/nvim/shortcuts/')

function FileManager.touch(fn)
    vim.fn.system('mkdir -p ' .. plugin_path)
    vim.fn.system('touch '.. plugin_path .. fn)
end

function FileManager.read_file(fn)
    local lines = ''
    for line in io.lines(plugin_path .. fn) do
      lines = lines .. '\n' .. line
    end
    return lines
end

function FileManager.write_file(fn, content)
    local file = io.open(plugin_path .. fn, 'w+')
    if file ~= nil then
        file:write(content)
        file:close()
    else
        vim.api.nvim_err_writeln('WHAAAT')
    end
end

function FileManager.is_empty(fn)
    local content = FileManager.read_file(fn)
    return content == ''
end

function FileManager.fill_template(fn)
    FileManager.write_file(fn, '{}')
end

function FileManager.is_invalid_json(fn)
    local content = FileManager.read_file(fn)
    local should_be_json = xpcall(json.decode(content), function(err) print(err); return false end )
    print(should_be_json)
    return true
end

return FileManager
