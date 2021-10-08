local base_observer = require("app.public.base_observer")
local layer_auto_fight = class("layer_auto_fight", base_observer)
local ui_fight_user = require("app.views.ui.ui_fight_user")
local gate_manager = require("app.public.data.gate_manager")
local enemy_manager = require("app.public.data.enemy_manager")
local public_module = require("app.public.util.public_module")

function layer_auto_fight:init()
    self.node_root = cc.CSLoader:createNode("")
    self.node_player = self.node_root:getChildByName("node_player")
    self.node_enemy = self.node_root:getChildByName("node_enemy")
    --还需要一个关卡选择控件TODO
end

function layer_auto_fight:get_listen_list()
end

function layer_auto_fight:on_deal_event(id, data)
end

function layer_auto_fight:show()
    base_observer.show(self)
    self:reset_user()
end

function layer_auto_fight:reset_user()
    self:reset_player_list()
    self:reset_enemy_list()
end

function layer_auto_fight:reset_player_list()
    self.node_player:removeAllChildren()
    local _data = g_data.player
end

function layer_auto_fight:reset_enemy_list()
    self.node_enemy:removeAllChildren()
    local _gate_info = gate_manager.get_instance():get_gate_info(g_data.gate_id)
    if _gate_info.enemy then
        local _index = math.random(1, #_gate_info.enemy)
        local _res = _gate_info.enemy[_index]
        for i = 1, #_res do
            local _enemy_info = enemy_manager.get_instance():get_enemy_info(_res[i])
            self:create_enemy(_enemy_info)
        end
    end
    public_module.ui_node_sort(self.node_enemy:getChildren(),"y-top",nil,nil,100)
end

function layer_auto_fight:create_enemy(enemy)
    local _node = cc.CSLoader:createNode("scene/ui_fight_user.csb")
    self.node_enemy:addChild(_node)
end

return layer_auto_fight