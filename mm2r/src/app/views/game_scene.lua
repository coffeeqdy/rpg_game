
local game_scene = class("game_scene", cc.load("mvc").ViewBase)

function game_scene:ctor()
    self.game_layer = cc.Layer:create()
    self:addChild(self.game_layer)
    self.menu_layer = cc.Layer:create()
    self:addChild(self.menu_layer)
end

return game_scene
