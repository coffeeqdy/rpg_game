local game_monster = require("app.views.ui.fight.monster.game_monster")

local game_fight_layer = {}

local boss_position = cc.p(-320, 100)

local normal_position = {
    x_area = {-440,0},
    y_area = {-100,300}
}

function game_fight_layer:init_monster_manager()
    self.monster_list = {}
    self.node_monster_manager = cc.Node:create()
    self:addChild(self.node_monster_manager)
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
    if node:is_boss() then
        node:setPosition(boss_position)
    else
        local _x = math.random(normal_position.x_area[1], normal_position.x_area[2])
        local _y = math.random(normal_position.y_area[1], normal_position.y_area[2])
        node:setPosition(_x, _y)
    end
end

return game_fight_layer