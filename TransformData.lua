local TransformData = {};
TransformData.__index = TransformData

function TransformData:new()
    local self = setmetatable({}, TransformData)
    return self
end

function TransformData:fromStringToChar(conteiner)
    local fileContent = {}
    for key, value in next, conteiner do -- transformation string to char[]
        for key2, value2 in next, value do
            local buffTable = {};
            for index = 1, #value2 do
                local char = string.sub(value2, index, index)
                table.insert(buffTable, char)
            end
            table.insert(fileContent, buffTable)
            buffTable = nil;
        end
    end
    return fileContent;
end

return TransformData;
