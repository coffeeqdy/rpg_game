
local public_module = {}

function public_module.toast(msg, time)
    time = time or 2.0
    msg = msg or ""
    local sprite = ccui.Scale9Sprite:create("PublicRes/toastback.png")
    local parent = cc.Director:getInstance():getRunningScene()
    parent:addChild(sprite,100)
    sprite:setPosition(display.cx, display.cy)
    sprite:setOpacity(0)
    sprite:runAction(cc.Sequence:create(
        cc.FadeIn:create(0.5),
        cc.DelayTime:create(time),
        cc.FadeOut:create(0.5),
        cc.RemoveSelf:create()
    ))
    local _text = ccui.Text:create(msg, "fonts/FZZY.TTF", 30)
    _text:setTextColor(cc.WHITE)
    sprite:addChild(_text)
    sprite:setContentSize(cc.size(_text:getContentSize().width + 60, 74))
    _text:setPosition(cc.p(sprite:getContentSize().width/2,sprite:getContentSize().height/2))
end

function public_module.show_error_dlg(str)
end

function public_module.copy_string(str)
    if device.platform == "android" then
    elseif device.platform == "ios" then
    elseif device.platform == "windows" then
        local path = cc.FileUtils:getInstance():getWritablePath().."temp_copy.txt"
        local file = io.open(path, "w")
        file:write(str)
        file:close()
        --变更编码格式为65001再输出到粘贴板65001是utf-8
        os.execute("chcp 65001 | clip < " .. path .. "| chcp 936 > nul")
        os.remove(path)
    end
end

function public_module.append_table(p_table,str_path)
    if not str_path then return end
    if type(str_path) ~= "string" then return end

    local _append_table = require(str_path)
    if _append_table then
        for i, v in pairs(_append_table) do
            p_table[i] = v
        end
    end
end

function public_module.remove_spaces_from_string(str)
    local _str_acc = str
    local _num_len = string.len(_str_acc)
    --判断最后一个字符是否是空格
    for i=_num_len,1,-1 do
        local str1 = string.sub(_str_acc,i,i)
        if str1 == '\0' then
            _str_acc = string.sub(_str_acc, 1, i-1)
        elseif str1 == ' ' then
            _str_acc = string.sub(_str_acc, 1, i-1)
        else
            break
        end  
    end
    
    return _str_acc
end

----------------------------------按钮Q弹统一处理-----------------------------------
function public_module.playQAction(node, tag,_time)
    if node then
        local act = cc.RepeatForever:create(cc.Sequence:create(
            cc.ScaleTo:create(0.016*11,1.1,0.9),
            cc.ScaleTo:create(0.016*7,0.95,1.05),
            cc.ScaleTo:create(0.016*9,1.05,0.95),
            cc.ScaleTo:create(0.016*11,0.97,1.03),
            cc.ScaleTo:create(0.016*12,1,1),
            cc.DelayTime:create(_time or 2)
        ))
        if tag then
            node:stopActionByTag(tag)
            act:setTag(tag)
        end
        node:runAction(act)
    end
end

----------------------------------跳动动画统一处理-----------------------------------
function public_module.playJumpAction(node, tag, scale)
    if node then
        scale = scale or 1
        local act = cc.RepeatForever:create(cc.Sequence:create(
            cc.Spawn:create(cc.ScaleTo:create(0.016*9,1.05*scale,0.9*scale),cc.MoveBy:create(0.016*9,cc.p(0,1))),
            cc.Spawn:create(cc.ScaleTo:create(0.016*4,0.95*scale,1.1*scale),cc.MoveBy:create(0.016*4,cc.p(0,3))),
            cc.Spawn:create(cc.ScaleTo:create(0.016*13,1*scale,1*scale),cc.MoveBy:create(0.016*13,cc.p(0,9))),
            cc.Spawn:create(cc.ScaleTo:create(0.016*8,0.95*scale,1.1*scale),cc.MoveBy:create(0.016*8,cc.p(0,-10))),
            cc.Spawn:create(cc.ScaleTo:create(0.016*4,1.05*scale,0.9*scale),cc.MoveBy:create(0.016*4,cc.p(0,-1))),
            cc.Spawn:create(cc.ScaleTo:create(0.016*7,0.95*scale,1.02*scale),cc.MoveBy:create(0.016*7,cc.p(0,-1))),
            cc.Spawn:create(cc.ScaleTo:create(0.016*7,1*scale,1.02*scale),cc.MoveBy:create(0.016*7,cc.p(0,-1))),
            cc.DelayTime:create(0.5)
        ))
        if tag then
            node:stopActionByTag(tag)
            act:setTag(tag)
        end
        node:runAction(act)
    end
end

function public_module.create_area_line(size)
    local _node = cc.DrawNode:create()
    local _width = size.width
    local _height = size.height
    _node:drawSegment(cc.p(-_width / 2, _height / 2),cc.p(_width / 2, _height / 2), 2,cc.c4f(1,1,1,1))
    _node:drawSegment(cc.p(-_width / 2, _height / 2),cc.p(-_width / 2, -_height / 2), 2,cc.c4f(1,1,1,1))
    _node:drawSegment(cc.p(_width / 2, _height / 2),cc.p(_width / 2, -_height / 2), 2,cc.c4f(1,1,1,1))
    _node:drawSegment(cc.p(-_width / 2, -_height / 2),cc.p(_width / 2, -_height / 2), 2,cc.c4f(1,1,1,1))
    return _node
end


function public_module.create_direct(node_par, position, rotation, scale)
    local _sprite_direct = cc.Sprite:create("public_res/direct.png")
    node_par:addChild(_sprite_direct)
    if position then
        _sprite_direct:setPosition(position)
    end
    scale = scale or 0.5
    _sprite_direct:setScale(scale)
    node_par.sprite_direct = _sprite_direct
    _sprite_direct:setVisible(false)

    if rotation then
        _sprite_direct:setRotation(rotation)
    end
    if rotation == 90 then
        _sprite_direct:runAction(cc.RepeatForever:create(cc.Sequence:create(
            cc.MoveBy:create(0.5, cc.p(0, -20)),
            cc.MoveBy:create(0.5, cc.p(0, 20))
        )))
    elseif rotation == nil or rotation == 0 then
        _sprite_direct:runAction(cc.RepeatForever:create(cc.Sequence:create(
            cc.MoveBy:create(0.5, cc.p(20, 0)),
            cc.MoveBy:create(0.5, cc.p(-20, 0))
        )))
    elseif rotation == 270 then
        _sprite_direct:runAction(cc.RepeatForever:create(cc.Sequence:create(
            cc.MoveBy:create(0.5, cc.p(0, 20)),
            cc.MoveBy:create(0.5, cc.p(0, -20))
        )))
    elseif rotation == 180 then
        _sprite_direct:runAction(cc.RepeatForever:create(cc.Sequence:create(
            cc.MoveBy:create(0.5, cc.p(-20, 0)),
            cc.MoveBy:create(0.5, cc.p(20, 0))
        )))
    end
end

--[[
    @desc: 
    author:{author}
    time:2020-11-06 11:37:35
    --@_nodes:节点table顺序严格要求从左到右边 从上到下
	--@_direction:方向,"x"横向,"y"纵向 "x-left"左到右 "x-mid" 横向居中 "y-bottom" 纵向从下往上
	--@_node_bg:底图，_node_bg.table_size 初始尺寸
	--@pt_begin:初始点位，如果不传，则认为是整体居中
	--@num_space:节点单位间隔
	--@num_node_count: 节点数
    @return:
]]
function public_module.ui_node_sort(_nodes,_direction,_node_bg, pt_begin, num_space, num_node_count)
    if _nodes == nil or not next(_nodes) then return end
    if _direction == nil then return end
    
    num_node_count = num_node_count or table.nums(_nodes)
    if _direction =="y-top" or _direction == "y-bottom" or "y-mid"
    or _direction =="x-left" or _direction =="x-mid" or _direction =="x-right" then
        local _node_positions={}
        num_space = num_space or 100
        local _node_isVisible={}
        for j = 1, num_node_count do
            if _nodes[j] and not tolua.isnull(_nodes[j]) and _nodes[j]:isVisible() then
                _node_isVisible[#_node_isVisible + 1]=_nodes[j]
            end
        end
        pt_begin = pt_begin or cc.p(0,0)
        local _total_space = num_space * (#_node_isVisible - 1)
        for i = 1, #_node_isVisible do
            if _direction=="y-top" then
                _node_positions[i] = pt_begin.y - (i - 1) * num_space
            elseif _direction == "y-mid" then
                _node_positions[i] = pt_begin.y - (i - 1) * num_space + _total_space / 2
            elseif _direction=="y-bottom" then
                _node_positions[i] = pt_begin.y + (i - 1) * num_space
            elseif _direction=="x-left" then
                _node_positions[i] = pt_begin.x + (i - 1) * num_space
            elseif _direction=="x-mid" then
                _node_positions[i] = pt_begin.x + (i - 1) * num_space - _total_space / 2
            elseif _direction=="x-right" then
                _node_positions[i] = pt_begin.x - (i - 1) * num_space
            end
        end
        for m = 1, #_node_isVisible do
            if _direction=="y-top" or _direction=="y-bottom" or _direction=="y-mid" then
                _node_isVisible[m]:setPosition(pt_begin.x, _node_positions[m])
            else
                _node_isVisible[m]:setPosition(_node_positions[m], pt_begin.y)
            end
        end
        --临时处理，后续扩展
        if _node_bg and not tolua.isnull(_node_bg) then
            if not _node_bg.table_size then
                local _size = _node_bg:getContentSize()
                _node_bg.table_size = _size
            end
            if _direction =="y-top" or _direction=="y-bottom" or _direction=="y-mid" then
                _node_bg:setContentSize(cc.size(_node_bg.table_size.width,_node_bg.table_size.height + _total_space))
            else
                _node_bg:setContentSize(cc.size(_node_bg.table_size.width + _total_space,_node_bg.table_size.height))
            end
        end
    end
end

function public_module.delay_do(time, func)
    local _scene = cc.Director:getInstance():getRunningScene()
    if not _scene then return end
    if not _scene.node_delay then
        _scene.node_delay = cc.Node:create()
        _scene:addChild(_scene.node_delay)
    end
    _scene.node_delay:runAction(cc.Sequence:create(
        cc.DelayTime:create(time),
        cc.CallFunc:create(function()
            if func then func() end
        end)
    ))
end

return public_module