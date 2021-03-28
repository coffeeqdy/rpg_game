local game_bullet = require("app.views.ui.fight.bullet.game_bullet")

local game_fight_layer = {}

function game_fight_layer:init_bullet_manager()
    self.bullet_cache_list = {}
    self.node_bullet_manager = cc.Node:create()
    self:addChild(self.node_bullet_manager, 2)
end

function game_fight_layer:get_bullet(param)
    local _bullet = nil
    if next(self.bullet_cache_list) then
        _bullet = table.remove(self.bullet_cache_list, 1)
    end
    if not _bullet then
        _bullet = game_bullet.new()
    end
    _bullet:init(param)
    self.node_bullet_manager:addChild(_bullet)
    return _bullet
end

function game_fight_layer:remove_bullet(bullet)
    bullet:retain()
    bullet:removeFromParent()
    table.insert(self.bullet_cache_list,bullet)
end

return game_fight_layer