local public_module = require("app.public.util.public_module")

local game_bullet = class("game_bullet", cc.Node)

function game_bullet:ctor(param)
    local _node = public_module.create_area_line(cc.size(50,50))
    self:addChild(_node)
    self:init(param)
end

function game_bullet:init(param)
end

function game_bullet:kill_self()
    self:runAction()
end

return game_bullet