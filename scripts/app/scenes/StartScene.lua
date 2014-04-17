
local GameScene = require("app.scenes.GameScene")
local TestScene = require("app.scenes.TestScene")

local StartScene = class("StartScene", function()
    return display.newScene("StartScene")
end)

function StartScene:ctor()
    local ttfLabelMenu = ui.newTTFLabel({text = "董旭的五子棋", size = 64, align = ui.TEXT_ALIGN_CENTER})
        :pos(display.cx, display.cy)
        :addTo(self)
    local ttfLabelMenuSize = ttfLabelMenu:getContentSize()

    local function titleMenuCallBack(sender)
        echoInfo("sender is %d", sender)
        -- 进入游戏主界面
        echoInfo("replcate scene with GameScene")
        app:enterGameScene()
    end
    local menuItem1 = ui.newImageMenuItem({image="#title.png", listener=titleMenuCallBack})
    local menuItem1Size = menuItem1:getContentSize()

    function menuCloseItemCallBack(sender)
        echoInfo("going to close")
        -- 关闭游戏
        app.exit()
    end
    local menuItemClose = ui.newImageMenuItem({image="#CloseNormal.png", 
                                            imageSelected="#CloseSelected.png", 
                                            listener=menuCloseItemCallBack})
    local closeItemSize = menuItemClose:getContentSize()
    menuItemClose:pos(0, 0 - closeItemSize.height - 10)

    local function testMenuCallBack(tag)
        local pDirector = CCDirector:sharedDirector()
        echoInfo("testMenu sender is %d", tag)
        pDirector:replaceScene(TestScene:new())
    end
    local testSceneItem = ui.newTTFLabelMenuItem({tag=1212, listener=testMenuCallBack, text="testScene"})
    testSceneItem:pos(0, 0 - closeItemSize.height - testSceneItem:getContentSize().height - 20)

    ui.newMenu({menuItem1, menuItemClose, testSceneItem})
        :pos(display.cx, display.cy - ttfLabelMenuSize.height - 5):addTo(self)

end

function StartScene:onEnter()
    if device.platform == "android" then
        -- avoid unmeant back
        self:performWithDelay(function()
            -- keypad layer, for android
            local layer = display.newLayer()
            layer:addKeypadEventListener(function(event)
                if event == "back" then 
                    audio.playSound(GAME_SFX.backButton)
                    app.exit() 
                end
            end)
            self:addChild(layer)

            layer:setKeypadEnabled(true)
        end, 0.5)
    end
end

function StartScene:onExit()
    echoInfo("StartScene onExit()")
end

return StartScene
