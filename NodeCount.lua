local NodeCount = {}
NodeCount.__index = NodeCount


function NodeCount:new()
    local self = setmetatable({}, NodeCount)
    return self
end

function NodeCount:countNode(startX, startY, finX, finY) --findGandH
    return math.abs(finX - startX) + math.abs(finY - startY);
end

return NodeCount