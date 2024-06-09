local open = io.open

local ReadFile = {}

ReadFile.__index = ReadFile

function ReadFile:new()
    local self = setmetatable({}, ReadFile)
    return self
end

function ReadFile:read_file(path)
    local file = open(path, "r")
    if not file then return nil end

    local arr = {}
    for line in file:lines() do
        table.insert(arr, line);
    end

    file:close()
    return arr
end

return ReadFile;