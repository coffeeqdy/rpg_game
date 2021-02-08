local game_fight_layer = class("game_fight_layer", cc.Node)

function game_fight_layer:ctor()
end

function game_fight_layer:show(monster_list)
    self:setVisible(true)
end

return game_fight_layer