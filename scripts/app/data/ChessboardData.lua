import("..data.Order")
local Order = _G.Order

local ChessboardData = class("ChessboardData")
local accp = class("accp")

ChessboardData.boardMap = nil

ChessboardData.NODE_IS_WHITE  = 1
ChessboardData.NODE_IS_BLACK  = -1
ChessboardData.NODE_IS_EMPTY  = 0

function ChessboardData:ctor()
    self.boardMap = {}
    self.boardMap[1] = {
    rows = 17,
    cols = 17,
    grid = {
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --1
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --2
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --3
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --4
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --5
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --6
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --7
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --8
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --9
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --10
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --11
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --12
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --13
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --14
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --15
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, --16
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}  --17
        }
    }
end


function ChessboardData:getSizeOfMap(map_number)
    return {rows = self.boardMap[map_number].rows, cols = self.boardMap[map_number].cols}
end

function ChessboardData:moveInChessOn(ui_row, ui_col, isWhite)
    local dataGridX = ui_col + 1
    local dataGridY = ui_row + 1
    local grid = self.boardMap[1].grid

    -- validate dataGridY or dataGridX check
    if (dataGridY > self.boardMap[1].rows) or (dataGridX > self.boardMap[1].cols) or (dataGridY < 1) or (dataGridX < 1) then
        echoInfo("Invalid dataGridY:%d or dataGridX:%d", dataGridY, dataGridX)
        return
    end

    -- check if there is a chess already
    if grid[dataGridX][dataGridY] ~= ChessboardData.NODE_IS_EMPTY then
        echoInfo("grid already has chess on , chess value is %d", grid[dataGridX][dataGridY])
        return
    end

    if Order.value == Order.whiteOrder then
        grid[dataGridX][dataGridY] = ChessboardData.NODE_IS_WHITE
        self:checkLogic(dataGridX, dataGridY)
    elseif Order.value == Order.blackOrder then
        grid[dataGridX][dataGridY] = ChessboardData.NODE_IS_BLACK
        self:checkLogic(dataGridX, dataGridY)
    end
end

function ChessboardData:checkLogic(dataGridX, dataGridY)

    local grid = self.boardMap[1].grid

    local chessVal = grid[dataGridX][dataGridY]

    -- 第一组从左到右检查
    local checkPointLeft = dataGridX - SERIAL_NUM_TO_WIN + 1
    local checkPointRight = dataGridX + SERIAL_NUM_TO_WIN  - 1

    -- 第二组从上到下检查
    local checkPointTop = dataGridY  - SERIAL_NUM_TO_WIN + 1
    local checkPointBottom = dataGridY  + SERIAL_NUM_TO_WIN - 1

    -- 第三组从左上到右下检查
    local checkPointLeftTop = accp:new(checkPointLeft, checkPointTop)
    local checkPointRightBottom = accp:new(checkPointRight, checkPointBottom)
    local checkIncrementLT2RB = accp:new(1, 1)

    -- 第四组从左下到右上检查
    local checkPointLeftBottom = accp:new(checkPointLeft, checkPointBottom)
    local checkPointRightTop = accp:new(checkPointRight, checkPointTop)
    local checkIncrementLB2RT = accp:new(1, -1) --从左下到右上的检查棋子位置增量


    local asd = accp:new(2,2)
    local sdf = accp:new(11,11)
    local step = accp:new(1,1)

    local qwe = asd
    repeat
        print("(" .. qwe.x .. "," .. qwe.y .. ")")
        qwe = qwe + step
    until qwe == sdf
    local dfg = asd + sdf
    print("(" .. dfg.x .. "," .. dfg.y .. ")")

    local formatter = ""
    for tmp_r=1,17 do
        local one_row = ""
        for tmp_col=1,17 do
            one_row = one_row..formatter.format(grid[tmp_r][tmp_col]) .." "
        end
        print(one_row)
    end

    -- 从上至下进行检查
    for i=checkPointLeft, dataGridX do
        if grid[i] ~= nil and grid[i][dataGridY] ~= nil then
            local sum = 0 
            for c=i,i + SERIAL_NUM_TO_WIN - 1 do
                if grid[c] == nil or grid[c][dataGridY] == nil then
                    break
                end
                sum = sum + grid[c][dataGridY]
            end
            echoInfo("sum == %d", sum)
            if math.abs(sum) == SERIAL_NUM_TO_WIN then
                self:win(chessVal) -- 游戏结束 Game end
                return
            end
        end
    end

    -- 从左至右进行检查
    for i=checkPointTop, dataGridY do
        if grid[dataGridX] ~= nil and grid[dataGridX][i] ~= nil then
            local sum = 0 
            for c=i,i + SERIAL_NUM_TO_WIN - 1 do
                if grid[c] == nil or grid[dataGridX][c] == nil then
                    break
                end
                sum = sum + grid[dataGridX][c]
            end
            echoInfo("sum == %d", sum)
            if math.abs(sum) == SERIAL_NUM_TO_WIN then
                self:win(chessVal) -- 游戏结束 Game end
                return
            end
        end
    end

    -- 从左上至右下进行检查
    local checkPointCur = clone(checkPointLeftTop)
    repeat
        if grid[checkPointCur.x] ~= nil and grid[checkPointCur.x][checkPointCur.y] ~= nil then
            local sum = 0
            local cpCurCur = clone(checkPointCur)
            repeat
                if grid[cpCurCur.x] ~= nil and grid[cpCurCur.x][cpCurCur.y] ~= nil then
                    echoInfo("grid[%d][%d] == %d", cpCurCur.x, cpCurCur.y, grid[cpCurCur.x][cpCurCur.y])
                    sum = sum + grid[cpCurCur.x][cpCurCur.y]
                end
                cpCurCur = cpCurCur + checkIncrementLT2RB
            until (cpCurCur.x > checkPointCur.x + SERIAL_NUM_TO_WIN - 1 )
                and 
                (cpCurCur.y > checkPointCur.y + SERIAL_NUM_TO_WIN - 1 )

            if math.abs(sum) == SERIAL_NUM_TO_WIN then
                self:win(chessVal) -- 游戏结束 Game end
                return
            end
        end
        checkPointCur = checkPointCur + checkIncrementLT2RB
    until checkPointCur.x > dataGridX and checkPointCur.y > dataGridY

    -- 从左下至右上进行检查
    checkPointCur = clone(checkPointLeftBottom)
    repeat
        if grid[checkPointCur.x] ~= nil and grid[checkPointCur.x][checkPointCur.y] ~= nil then
            local sum = 0
            local cpCurCur = clone(checkPointCur)
            repeat
                if grid[cpCurCur.x] ~= nil and grid[cpCurCur.x][cpCurCur.y] ~= nil then
                    echoInfo("grid[%d][%d] == %d", cpCurCur.x, cpCurCur.y, grid[cpCurCur.x][cpCurCur.y])
                    sum = sum + grid[cpCurCur.x][cpCurCur.y]
                end
                cpCurCur = cpCurCur + checkIncrementLB2RT
            until (cpCurCur.x > checkPointCur.x + SERIAL_NUM_TO_WIN - 1 )
                and 
                (cpCurCur.y < checkPointCur.y - SERIAL_NUM_TO_WIN + 1 )

            if math.abs(sum) == SERIAL_NUM_TO_WIN then
                self:win(chessVal) -- 游戏结束 Game end
                return
            end
        end
        checkPointCur = checkPointCur + checkIncrementLB2RT
    until checkPointCur.x > dataGridX and checkPointCur.y < dataGridY
end

-- 游戏胜利
function ChessboardData:win(chessVal)
    if (chessVal == self.NODE_IS_WHITE) then
        echoInfo("White win")
        CCMessageBox("White Win", "你淫了")
    else
        echoInfo("Black win")
        CCMessageBox("Black Win", "我淫了")
    end
end


accp.x = 0
accp.y = 0
-- 可以相加的坐标对
function accp:ctor(t, x, y)
    self.x = x
    self.y = y
end

function accp.__add(a, b)
    local nx = a.x + b.x
    local ny = a.y + b.y
    return accp:new(nx, ny)
end

function accp.__eq(a, b)
    return (a.x == b.x and a.y == b.y)
end

return ChessboardData