local SymbolPositon = {}
SymbolPositon.__index = SymbolPositon


function SymbolPositon:new()
    local self = setmetatable({}, SymbolPositon)
    return self
end

function SymbolPositon:findSymbolPosition(maze, symbol)  --find (x,y) of element
    local startPosition = {};
    for key, value in next, maze do
        for key2, valu2 in next, value do
            if valu2 == symbol then
                table.insert(startPosition, { key });
                table.insert(startPosition, { key2 });
                return startPosition;
            end
        end
    end
end

return SymbolPositon;
