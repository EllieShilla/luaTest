local Node = {};
Node.__index = Node

function Node:new(x, y, g, h, parent)
    local self = setmetatable({}, Node)
    self.x = x
    self.y = y
    self.g = g
    self.h = h
    self.f = g + h
    self.parent = parent
    return self
end

function Node:updateF()
    self.f = self.g + self.h
end

return Node;
