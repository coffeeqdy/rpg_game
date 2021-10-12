
local game_scene = class("game_scene", cc.Layer)
local public_module = require("app.public.util.public_module")
local ui_observer = require("app.public.util.ui_observer")

local layer_main = require("app.views.layer.layer_main")

function game_scene:ctor()
    self:setPosition(display.cx, display.cy)

    self.layer_main = layer_main.new()
    self:addChild(self.layer_main)
end

return game_scene
