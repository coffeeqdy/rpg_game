
local game_scene = class("game_scene", cc.Layer)
local public_module = require("app.public.util.public_module")
local game_fight_layer = require("app.views.ui.fight.game_fight_layer")
local global_define = require("app.public.global.global_define")
local ui_observer = require("app.public.util.ui_observer")

function game_scene:ctor()
    self:setPosition(display.cx, display.cy)
    public_module.append_table(self, "app.views.ui.map.layer_game.lua")
    public_module.append_table(self, "app.views.ui.map.layer_max_map.lua")
    public_module.append_table(self, "app.views.ui.menu.layer_operate.lua")

    self:init_layer_game()--游戏界面处理
    self:init_layer_max_map()--大地图
    self:init_layer_operate()--基本操作处理
    self:init_fight_layer()
end

function game_scene:init_fight_layer()
    --战斗场景
    self.game_fight_layer = game_fight_layer.new()
    self:addChild(self.game_fight_layer, 3)
    self.game_fight_layer:setVisible(false)

    ui_observer.get_instance():register_listener(global_define.observer_type.fight,global_define.observer_name.start_fight,function(data)
        self.game_fight_layer:show(data)
    end)
end

return game_scene
