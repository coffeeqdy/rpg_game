local game_player = class("game_player", cc.Node)

function game_player:ctor()
    self.hp = 0
    self.is_alive = false
end

function game_player:set_id(id)
    if id == self.id then return end
end

return game_player