local TestScene = class("TestScene", function() 
	return display.newScene("TestScene")
end)

local tmxNodeTagInLayer = 12
local scaler = 1;

function TestScene:ctor()
	local layer = display.newLayer()
	local tmxNode = CCTMXTiledMap:create("testMap.tmx")
	local spriteHeight = tmxNode:getContentSize().height
    self.scaler = display.height / spriteHeight
    tmxNode:setScale(self.scaler)

    local function testButtonCallBack(sender)
    	local tileLayer = tmxNode:layerNamed("tmxLayer1")
    	local tileSet = tileLayer:getTileSet()
    	echoInfo("tileSet is %s", type(tileSet))
    	for i=0, 10000 do
    		local rect = tileSet:rectForGID(i)
    		echoInfo("tileSet[%d].(x, y) == (%d, %d)", i, rect.origin.x, rect.origin.y)
    	end
	end
    local testMenuItem = ui.newTTFLabelMenuItem({text="点我啊", 
    								listener=testButtonCallBack,
    								size=64})
						:pos(0, 0)

	ui.newMenu({testMenuItem}):pos(display.cx, display.cy):addTo(self, 2, 1212)

	layer:addChild(tmxNode, 0, tmxNodeTagInLayer)

	layer:addTo(self, 1 ,2323)
end

return TestScene