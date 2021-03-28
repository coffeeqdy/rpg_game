local public_module = require("app.public.util.public_module")

local game_monster = class("game_monster", cc.Node)

function game_monster:ctor()
    self.hp = 0
    self.is_alive = false
    local _node = public_module.create_area_line(cc.size(100,100))
    self:addChild(_node)
end

function game_monster:set_id(id)
    if id == self.id then return end
end

function game_monster:on_hit(param)
end

function game_monster:is_boss()
    return false
end

return game_monster