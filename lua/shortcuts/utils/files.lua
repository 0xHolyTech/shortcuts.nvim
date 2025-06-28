local json = require('shortcuts.utils.json')

local FileManager = {
    plugin_path = ''
}

function FileManager.setup(path)
    FileManager.plugin_path = path
end

function FileManager.touch(fn)
    vim.fn.system('mkdir -p ' .. FileManager.plugin_path)
    vim.fn.system('touch '.. FileManager.plugin_path .. fn)
end

function FileManager.delete(fn)
    vim.fn.system('rm ' .. FileManager.plugin_path .. fn)
end

function FileManager.read_file(fn)
    local lines = ''
    for line in io.lines(FileManager.plugin_path .. fn) do
      lines = lines .. '\n' .. line
    end
    return lines
end

function FileManager.write_file(fn, content)
    local file = io.open(FileManager.plugin_path .. fn, 'w+')
    if file ~= nil then
        file:write(content)
        file:close()
    else
        vim.api.nvim_err_writeln('Unable to write to file')
    end
end

function FileManager.is_empty(fn)
    local content = FileManager.read_file(fn)
    return content == ''
end

function FileManager.fill_template(fn, content)
    FileManager.write_file(fn, json.encode(content))
    FileManager.format_json(fn)
end

function FileManager.is_invalid_json(fn)
    local content = FileManager.read_file(fn)
    return not xpcall(
        function()
            json.decode(content)
        end,
        function(err)
            vim.api.nvim_err_writeln('File ' .. FileManager.plugin_path .. fn .. 'is invalid: ' .. err)
        end
    )
end

function FileManager.format_json(fn)
    local full_fn = FileManager.plugin_path .. fn
    vim.fn.system('jq . ' .. full_fn .. ' > ' .. full_fn .. '.temp')
    vim.fn.system('jq . ' .. full_fn .. '.temp > ' .. full_fn)
    FileManager.delete(fn)
end

function FileManager.get_json(fn)
    local content = FileManager.read_file(fn)
    return json.decode(content)
end

return FileManager

