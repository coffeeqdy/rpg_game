local game_player = require("app.views.ui.fight.player.game_player")

local body_position = {
    cc.p(440, 300),cc.p(440,150),cc.p(440,0),cc.p(440,-150)
}

local game_fight_layer = {}

function game_fight_layer:init_body_manager()
    self.body_list = {}

    self.node_body_manager = cc.Node:create()
    self:addChild(self.node_body_manager)
end


function game_fight_layer:on_remove_monster(node)
    for i,v in pairs(self.body_list) do
        if v == node then
            table.remove(self.body_list, i)
            break
        end
    end
    if tolua.isnull(node) then
        node = nil
        return
    end
    node:removeFromParent()
    node = nil
end

function game_fight_layer:render_player_list()
    if #g_data.player > #self.body_list then
        for i = 1, #self.body_list do
            self:on_fresh_body(self.body_list[i], g_data.player[i], i)
        end
        for i = #self.body_list + 1, #g_data.player do
            self:on_create_body(g_data.player[i], i)
        end
    else
        for i = #self.body_list, #g_data.player + 1, -1 do
            self:on_remove_body(self.body_list[i])
        end
        for i = 1, #self.body_list do
            self:on_fresh_body(self.body_list[i], g_data.player[i], i)
        end
    end
end

function game_fight_layer:on_create_body(data, index)
    local _body = game_player.new()
    self.node_body_manager:addChild(_body)
    self.body_list[#self.body_list + 1] = _body
    self:on_fresh_body(_body, data, index)
end

function game_fight_layer:on_fresh_body(node, data, index)
    node:set_data(data)
    if body_position[index] then
        node:setPosition(body_position[index])
    end
end

function game_fight_layer:on_remove_body(node)
    for i,v in pairs(self.body_list) do
        if v == node then
            table.remove(self.body_list, i)
            break
        end
    end
    if tolua.isnull(node) then
        node = nil
        return
    end
    node:removeFromParent()
    node = nil
end

return game_fight_layer