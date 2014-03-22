
require("config")
require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")
require("framework.debug")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    display.addSpriteFramesWithFile(GAME_TEXTURE_DATA_FILENAME, GAME_TEXTURE_IMAGE_FILENAME)
    self:enterMenuScene()
end

function MyApp:enterMenuScene()
    self:enterScene("StartScene", nil, "fade", 1.5, display.COLOR_RED)
end

function MyApp:enterGameScene()
	self:enterScene("GameScene", nil, "fade", 1.0, display.COLOR_RED)
end

return MyApp
