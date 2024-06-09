local WorkWIthList = {}
WorkWIthList.__index = WorkWIthList

function WorkWIthList:new()
    local self = setmetatable({}, WorkWIthList)
    return self
end

function WorkWIthList:find_by_value(list, x, y)
    local index = 0;
    for i = 1, #list do
        if list[i][1].x == x and list[i][1].y == y
        then
            index = i;
            break;
        end
    end
    return index;
end

function WorkWIthList:remove_by_value(list, index)
    table.remove(list, index)
end

function WorkWIthList:find_min_value(list)
    if #list == 0 then
        return nil
    end

    local min_class = list[1]
    for i = 2, #list do
        if list[i][1].f < min_class[1].f then
            min_class = list[i]
        end
    end

    return min_class
end

return WorkWIthList;
