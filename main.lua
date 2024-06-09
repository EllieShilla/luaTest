local SymbolPositon = require("SymbolPositon")
local Node = require("Node")
local ReadFile = require("ReadFile")
local TransformData = require("TransformData")
local WorkWIthList = require("WorkWIthList")
local SaveResult = require("SaveResult")
local FindPath = require("FindPath")
local NodeCount = require("NodeCount")

local docPath = "D:\\luaTest\\Maze.txt"

local readFile = ReadFile:new()
local transformData = TransformData:new();
local findSymbol = SymbolPositon:new();
local workWIthList = WorkWIthList:new()
local saveResult = SaveResult:new()
local nodeCount = NodeCount:new()

local conteiner = {};
local fileContent = {};

table.insert(conteiner, readFile:read_file(docPath));
fileContent = transformData:fromStringToChar(conteiner)

local startPos = findSymbol:findSymbolPosition(fileContent, 'I');
local endPos = findSymbol:findSymbolPosition(fileContent, "E");

local function pathfinding(startPos, endPos, Maze)
    local isFinishReached = false;
    local closedList = {};
    local openList = {};

    local currentNode = Node:new(startPos[1][1], startPos[2][1], 0,
        nodeCount:countNode(startPos[1][1], startPos[2][1], endPos[1][1], endPos[2][1]));

    table.insert(openList, { currentNode })

    while #openList > 0 do
        if (Maze[currentNode.x][currentNode.y - 1] == " " or Maze[currentNode.x][currentNode.y - 1] == "E") then
            if (workWIthList:find_by_value(closedList, currentNode.x, currentNode.y - 1) == 0) then
                if (workWIthList:find_by_value(openList, currentNode.x, currentNode.y - 1) == 0) then
                    table.insert(openList,
                        { Node:new(currentNode.x, currentNode.y - 1,
                            nodeCount:countNode(startPos[1][1], startPos[2][1], currentNode.x, currentNode.y - 1),
                            nodeCount:countNode(currentNode.x, currentNode.y - 1, endPos[1][1], endPos[2][1]),
                            currentNode) });
                else
                    local updateNodeIndex = workWIthList:find_by_value(openList, currentNode.x, currentNode.y - 1);
                    local currentG = nodeCount:countNode(startPos[1][1], startPos[2][1], currentNode.x, currentNode.y - 1)
                    if (openList[updateNodeIndex][1].g > currentG) then
                        openList[updateNodeIndex][1].g = currentG
                        openList[updateNodeIndex][1].parent = currentNode
                        openList[updateNodeIndex][1]:updateF()
                    end
                end
            end
        end

        if (Maze[currentNode.x][currentNode.y + 1] == " " or Maze[currentNode.x][currentNode.y + 1] == "E") then
            if (workWIthList:find_by_value(closedList, currentNode.x, currentNode.y + 1) == 0) then
                if (workWIthList:find_by_value(openList, currentNode.x, currentNode.y + 1) == 0) then
                    table.insert(openList,
                        { Node:new(currentNode.x, currentNode.y + 1,
                            nodeCount:countNode(startPos[1][1], startPos[2][1], currentNode.x, currentNode.y + 1),
                            nodeCount:countNode(currentNode.x, currentNode.y + 1, endPos[1][1], endPos[2][1]),
                            currentNode) });
                else
                    local updateNodeIndex = workWIthList:find_by_value(openList, currentNode.x, currentNode.y + 1);
                    local currentG = nodeCount:countNode(startPos[1][1], startPos[2][1], currentNode.x,
                        currentNode.y - 1)
                    if (openList[updateNodeIndex][1].g > currentG) then
                        openList[updateNodeIndex][1].g = currentG
                        openList[updateNodeIndex][1].parent = currentNode
                        openList[updateNodeIndex][1]:updateF()
                    end
                end
            end
        end

        if (Maze[currentNode.x - 1][currentNode.y] == " " or Maze[currentNode.x - 1][currentNode.y] == "E") then
            if (workWIthList:find_by_value(closedList, currentNode.x - 1, currentNode.y) == 0) then
                if (workWIthList:find_by_value(openList, currentNode.x - 1, currentNode.y) == 0) then
                    table.insert(openList,
                        { Node:new(currentNode.x - 1, currentNode.y,
                            nodeCount:countNode(endPos[1][1], endPos[2][1], currentNode.x - 1, currentNode.y),
                            nodeCount:countNode(currentNode.x - 1, currentNode.y, endPos[1][1], endPos[2][1]),
                            currentNode) });
                else
                    local updateNodeIndex = workWIthList:find_by_value(openList, currentNode.x - 1, currentNode.y);
                    local currentG = nodeCount:countNode(startPos[1][1], startPos[2][1], currentNode.x,
                        currentNode.y - 1)
                    if (openList[updateNodeIndex][1].g > currentG) then
                        openList[updateNodeIndex][1].g = currentG
                        openList[updateNodeIndex][1].parent = currentNode
                        openList[updateNodeIndex][1]:updateF()
                    end
                end
            end
        end

        if (Maze[currentNode.x + 1][currentNode.y] == " " or Maze[currentNode.x + 1][currentNode.y] == "E") then
            if (workWIthList:find_by_value(closedList, currentNode.x + 1, currentNode.y) == 0) then
                if (workWIthList:find_by_value(openList, currentNode.x + 1, currentNode.y) == 0) then
                    table.insert(openList,
                        { Node:new(currentNode.x + 1, currentNode.y,
                            nodeCount:countNode(endPos[1][1], endPos[2][1], currentNode.x + 1, currentNode.y),
                            nodeCount:countNode(currentNode.x + 1, currentNode.y, endPos[1][1], endPos[2][1]),
                            currentNode) });
                else
                    local updateNodeIndex = workWIthList:find_by_value(openList, currentNode.x + 1, currentNode.y);
                    local currentG = nodeCount:countNode(startPos[1][1], startPos[2][1], currentNode.x, currentNode.y - 1)
                    if (openList[updateNodeIndex][1].g > currentG) then
                        openList[updateNodeIndex][1].g = currentG
                        openList[updateNodeIndex][1].parent = currentNode
                        openList[updateNodeIndex][1]:updateF()
                    end
                end
            end
        end


        workWIthList:remove_by_value(openList, workWIthList:find_by_value(openList, currentNode.x, currentNode.y));
        table.insert(closedList, { currentNode });

        currentNode = nil;

        if (#openList > 0) then
            currentNode = workWIthList:find_min_value(openList)[1];
        end

        if (currentNode ~= nil) then
            if (currentNode.x == endPos[1][1] and currentNode.y == endPos[2][1]) then -- if the coordinates of the currentNode equal with the endPos,
                table.insert(closedList, { currentNode });                            -- exit the loop
                isFinishReached = true;
                break;
            end
        end
    end

    if (isFinishReached == true) then
        return closedList;
    else
        return nil;
    end
end

local findPath = FindPath:new()

local result = pathfinding(startPos, endPos, fileContent);


if (result ~= nil) then -- save result
    saveResult:saveGoodResult(fileContent, findPath:findPathByParents(result));
else
    saveResult:saveBadResult()
end
