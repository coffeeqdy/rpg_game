local public_module = require("app.public.util.public_module")

local game_player = class("game_player", cc.Node)

function game_player:ctor()
    self.hp = 0
    self.is_alive = false
    local _node = public_module.create_area_line(cc.size(100,100))
    self:addChild(_node)
end

function game_player:set_data(data)
    
end

function game_player:on_hit(param)
end

return game_player