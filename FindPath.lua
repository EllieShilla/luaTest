local FindPath = {}
FindPath.__index = FindPath


function FindPath:new()
    local self = setmetatable({}, FindPath)
    return self
end

function FindPath:findPathByParents(list) -- finds the path from the end point to the start point based on the parents of the cells
    local Nodes = {};
    local parent = list[#list][1].parent

    for index = #list, 2, -1 do
        if (list[index][1].x == parent.x and list[index][1].y == parent.y) then
            table.insert(Nodes, { list[index][1] })
            parent = list[index][1].parent
        end
    end
    return Nodes;
end

return FindPath;
