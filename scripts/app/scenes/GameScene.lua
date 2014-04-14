
local ChessboardLayer = import(".ChessboardLayer")

local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)

GameScene.chessboardLayer = nil

GameScene.chessboardLayerZorder = 100
GameScene.chessboardLayerTag = 3476723231

GameScene.outsideUILayerZorder = 200
GameScene.outsideUILayerTag = 464325645

GameScene.completeUIImageZorder = 300
GameScene.completeUIImageTag = 346543532

function GameScene:ctor()
    self.chessboardLayer = ChessboardLayer.new()
    self.chessboardLayer:addEventListener("GAME_COMPLETED", handler(self, self.onGameComplete))
    echoInfo("device.platform == %s", device.platform)
    if device.platform == "android" then
        -- avoid unmeant back
        self:performWithDelay(function()
            echoInfo("Perform add keypad event")
            self.chessboardLayer:addKeypadEventListener(
                function(event)
                    echoInfo("Click back info: %s", event)
                    if event == "back" then
                        -- 这些地方应该使用 pop 或 push场景
                        app:enterMenuScene()
                    end
                end
            )
            self.chessboardLayer:setKeypadEnabled(true)
        end, 0.5)
    end
    self.chessboardLayer:addTo(self, self.chessboardLayerZorder, self.chessboardLayerTag)
    echoInfo("GameScene ctor end")
end


function GameScene:onGameComplete()
    local overImage = display.newSprite("#title.png")
    overImage:setPosition(display.cx, display.top + overImage:getContentSize().height / 2 + 40)
    self:addChild(overImage, self.completeUIImageZorder, self.completeUIImageTag)
    transition.moveTo(overImage, {x=display.cx, y=display.cy, time=3.0, easing = "BOUNCEOUT"})
end


function GameScene:onEnter()
    
end


function GameScene:onExit()
	echoInfo("GameScene onExit")
end

return GameScene