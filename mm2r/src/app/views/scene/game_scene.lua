
local game_scene = class("game_scene", cc.Layer)
local public_module = require("app.public.util.public_module")

function game_scene:ctor()
    self:setPosition(display.cx, display.cy)
    public_module.append_table(self, "app.views.scene.layer_game.lua")
    public_module.append_table(self, "app.views.scene.layer_operate.lua")

    self:init_layer_game()--游戏界面处理
    self:init_layer_operate()--基本操作处理
end

return game_scene
