local square = class("square",cc.Node)

function square:ctor(size)
    local _square = cc.CSLoader:createNode("game/map_square.csb")
    _square.sprite_square = _square:getChildByName("sprite_square")
    _square.sprite_surprise = _square:getChildByName("sprite_surprise")
    self:addChild(_square)
    self:setContentSize(cc.size(size,size))
end

function square:get_meet_percent()
    return 100
end

function square:conntain_point(pt)
    local _pt = self:convertToWorldSpace(cc.p(0,0))
    local _x, _y = _pt.x, _pt.y
    local _size = self:getContentSize()
    if pt.x > _x - _size.width / 2 and pt.x <= _x + _size.width / 2 and pt.y > _y - _size.height / 2 and pt.y <= _y + _size.height / 2 then
        return true
    end
    return false
end

function square:get_monster_list()
    return {1}
end

return square