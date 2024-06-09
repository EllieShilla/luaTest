local WorkWIthList = require("WorkWIthList")
local workWIthList = WorkWIthList:new()


local SaveResult = {}
SaveResult.__index = SaveResult

function SaveResult:new()
    local self = setmetatable({}, SaveResult)
    return self
end

function SaveResult:saveGoodResult(data, list)
    local file = io.open("output.txt", "w")

    if not file then
        print("Failed to open file for writing")
        return
    end

    for i, v in next, data do
        for n, k in next, v do
            local path = workWIthList:find_by_value(list, i, n)
            if (path ~= 0) then
                file:write('@')
            else
                file:write(k)
            end
        end
        file:write('\n');
    end

    file:close()
end

function SaveResult:saveBadResult()
    local file = io.open("output.txt", "w")

    if not file then
        print("Failed to open file for writing")
        return
    end

    file:write('Path not found');

    file:close()
end

return SaveResult
