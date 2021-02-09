local game_monster = require("app.views.ui.monster.game_monster")

local game_fight_layer = class("game_fight_layer", cc.Node)

function game_fight_layer:ctor()
    self.monster_list = {}
    self.body_list = {}

    self.node_monster_manager = cc.Node:create()
    self:addChild(self.node_monster_manager)
end

function game_fight_layer:show(monster_list)
    self:setVisible(true)
    self:render_player_list()
    self:render_monster_list(monster_list)
end

function game_fight_layer:render_monster_list(monster_list)
    if #monster_list > #self.monster_list then
        for i = 1, #self.monster_list do
            self:on_fresh_monster(self.monster_list[i], monster_list[i])
        end
        for i = #self.monster_list + 1, #monster_list do
            self:on_create_monster(monster_list[i])
        end
    else
        for i = #self.monster_list, #monster_list + 1, -1 do
            self:on_remove_monster(self.monster_list[i])
        end
        for i = 1, #self.monster_list do
            self:on_fresh_monster(self.monster_list[i], monster_list[i])
        end
    end
end

function game_fight_layer:on_create_monster(data)
    local _monster = game_monster.new()
    self.node_monster_manager:addChild(_monster)
    self.monster_list[#self.monster_list + 1] = _monster
    self:on_fresh_monster(_monster, data)
end

function game_fight_layer:on_fresh_monster(node, data)
    node:set_id(data)
end

function game_fight_layer:on_remove_monster(node)
    for i,v in pairs(self.monster_list) do
        if v == node then
            table.remove(self.monster_list, i)
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
end

return game_fight_layer