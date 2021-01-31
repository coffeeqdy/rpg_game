local global_define = require("app.public.global.global_define")
local ui_observer = require("app.public.util.ui_observer")

local game_map = require("app.views.ui.game_map")
local game_body = require("app.views.ui.game_body")
local game_menu = require("app.views.ui.game_menu")

local _M = {}

function _M:init_layer_game()
    self.layer_game = cc.CSLoader:createNode('game/layer_game.csb')
    self:addChild(self.layer_game)

    --地图在下
    self.game_map = game_map.new()
    self.layer_game:addChild(self.game_map, 1)

    --游戏角色
    self.game_body = game_body.new()
    self.layer_game:addChild(self.game_body, 2)
    
    --操作菜单（背包、装备等等）
    self.game_menu = game_menu.new()
    self.layer_game:addChild(self.game_menu, 3)

    self:register_game_listener()
end

function _M:register_game_listener()
    ui_observer.get_instance():register_listener(global_define.observer_type.operate, global_define.observer_name.move_left, function()
    end)
    ui_observer.get_instance():register_listener(global_define.observer_type.operate, global_define.observer_name.move_right, function()
    end)
    ui_observer.get_instance():register_listener(global_define.observer_type.operate, global_define.observer_name.move_up, function()
    end)
    ui_observer.get_instance():register_listener(global_define.observer_type.operate, global_define.observer_name.move_down, function()
    end)
end

return _M