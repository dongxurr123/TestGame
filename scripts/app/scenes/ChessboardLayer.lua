import("..data.Order")
local Order = _G.Order
local ChessboardData = import("..data.ChessboardData")

local ChessboardLayer = class("ChessboardLayer", function()
	return display.newLayer("ChessboardLayer") 
end)

local tmxChessBoardTag = 1

ChessboardLayer.tmxNode = nil
ChessboardLayer.scaler = 1.0
ChessboardLayer.offset = { x=0, y=0 }

ChessboardLayer.whiteChessGID = 0
ChessboardLayer.blackChessGID = 0

ChessboardLayer.logicData = nil

function ChessboardLayer:ctor()
    self.tmxNode = CCTMXTiledMap:create(CHESSBOARD_TMX_FILENAME)
    local tmxSize = self.tmxNode:getContentSize()
    local tmxHeight = tmxSize.height
    local tmxWidth = tmxSize.width

    local pieceTMXLayer = self.tmxNode:layerNamed("tmxLayer2")
    self.whiteChessGID = pieceTMXLayer:tileGIDAt(WHITE_CHESS_TMX_POINT)
    self.blackChessGID = pieceTMXLayer:tileGIDAt(BLACK_CHESS_TMX_POINT)

    self.logicData = ChessboardData:new()

    self.scaler = display.height / tmxHeight
    self.tmxNode:setScale(self.scaler)

    self.offset.x = display.left + ((display.width - tmxWidth * self.scaler)/2)
    self.offset.y = 0
    self.tmxNode:setPosition(ccp(self.offset.x, self.offset.y))

    self:addChild(self.tmxNode, 0, tmxChessBoardTag)

	local prev = {x = 0, y = 0}
    local count = 1
    local isMoved = false
    local canMove = false
    local shor_move_power_2 = SHORT_MOVE_AS_CLICK_LEN^2

	local function onTouchEvent(eventType, points)
        if #points/3 == 1 then
            local x = points[1]
            local y = points[2]
            local touchId = points[3]
            if eventType == "began" then
                prev.x = x
                prev.y = y
                isMoved = false
                return true
            elseif  eventType == "moved" then
                local diffX = x - prev.x
                local diffY = y - prev.y
                local diffLen = diffX^2 + diffY^2
                --当移动大于SHORT_MOVE_AS_CLICK_LEN值时才当做移动处理
                if canMove or diffLen > shor_move_power_2 then
                    canMove = true
                    local node  = self:getChildByTag(tmxChessBoardTag)
                    local nodeX  = node:getPositionX()
                    local nodeY  = node:getPositionY()

                    node:setPosition( ccpAdd(ccp(nodeX, nodeY), ccp(diffX, diffY)) )
                    prev.x = x
                    prev.y = y
                    self.offset.x = self.offset.x + diffX
                    self.offset.y = self.offset.y + diffY
                    isMoved = true --设置标志位,本次是滑动屏幕
                end
            elseif eventType == "ended" then
                canMove = false
                if not isMoved then
    				local tmxLayerPoint = self:tilePosFromLocation(x, y)
    				self:moveInChessOnPoint(tmxLayerPoint, Order.value)
                    echoInfo("not moved")
                end
            end
        end
    end
    self:setTouchEnabled(true)
    self:setTouchMode(kCCTouchesAllAtOnce)
    self:addTouchEventListener(onTouchEvent, true) -- Multi touch
    --self:registerScriptTouchHandler(onTouchEvent) -- Single touch
end


function ChessboardLayer:moveInChessOnPoint(tmxPoint, isWhite)
    local pieceTMXLayer = self.tmxNode:layerNamed("tmxLayer2")

    local chessboardSize = self.logicData:getSizeOfMap(1)
    if (tmxPoint.x > chessboardSize.rows - 1) or (tmxPoint.x < 0) 
        or (tmxPoint.y > chessboardSize.cols - 1) or (tmxPoint.y < 0) then
        return
    end
    if Order.value == Order.whiteOrder then
        pieceTMXLayer:setTileGID(self.whiteChessGID, tmxPoint)
    elseif Order.value == Order.blackOrder then
        pieceTMXLayer:setTileGID(self.blackChessGID, tmxPoint)
    else
        echoError("Unkown piece: %d", Order.value)
    end
    self.logicData:moveInChessOn(tmxPoint.x, tmxPoint.y)
    Order:switchOrder()
end


function ChessboardLayer:tilePosFromLocation(pointX, pointY)
    local tmxTileWidth = self.tmxNode:getTileSize().width * self.scaler
    local tmxTileHeight = self.tmxNode:getTileSize().height * self.scaler
    local rx = toint((pointX - self.offset.x) / tmxTileWidth - 0.5)
    local ry = toint((pointY - self.offset.y) / tmxTileHeight + 0.5)
    ry = self.tmxNode:getMapSize().height - ry
    return ccp(rx, ry)
end

function ChessboardLayer:zoomByScaler(scaler)
    self.scaler = scaler
    self.tmxNode:setScale(self.scaler)
end

return ChessboardLayer