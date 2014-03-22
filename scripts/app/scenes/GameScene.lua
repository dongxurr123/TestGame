
local ChessboardLayer = import(".ChessboardLayer")

local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)

GameScene.chessboardLayer = nil

GameScene.chessboardLayerZorder = 100
GameScene.chessboardLayerTag = 3476723231

GameScene.outsideUILayerZorder = 200
GameScene.outsideUILayerTag = 464325645


function GameScene:ctor()
    self.chessboardLayer = ChessboardLayer:new()
    self.chessboardLayer:addTo(self, self.chessboardLayerZorder, self.chessboardLayerTag)
    echoInfo("GameScene ctor end")
end


function GameScene:onEnter()
    if device.platform == "android" then
        -- avoid unmeant back
        self:performWithDelay(function()
            -- keypad layer, for android
            local layer = display.newLayer()
            layer:addKeypadEventListener(
	            function(event)
	                if event == "back" then
	                	-- 这些地方应该使用 pop 或 push场景
	                	CCDirector:sharedDirector():replaceScene(StartScene:new())
	                end
	            end
	        )
            self:addChild(layer)

            layer:setKeypadEnabled(true)
        end, 0.5)
    end
end


function GameScene:onExit()
	echoInfo("GameScene onExit")
end

return GameScene