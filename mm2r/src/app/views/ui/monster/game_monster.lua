local game_monster = class("game_monster", cc.Node)

function game_monster:ctor()
    self.hp = 0
    self.is_alive = false
end

function game_monster:set_id(id)
    if id == self.id then return end
end

return game_monster