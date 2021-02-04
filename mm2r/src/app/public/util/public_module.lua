
local public_module = {}

function public_module.toast(msg,time,ptY,is_ignore)
    time = time or 2.0
    msg = msg or ""
    local sprite = cc.Scale9Sprite:create("PublicRes/toastback.png")
    local parent = cc.Director:getInstance():getRunningScene()
    parent:addChild(sprite,100);
    sprite:setPosition(display.cx, ptY or (display.cy - 200))
    sprite:setOpacity(0)
    sprite:runAction(transition.sequence({
        cc.FadeIn:create(0.5),
        cc.DelayTime:create(time),
        cc.FadeOut:create(0.5),
        cc.RemoveSelf:create()
    }))
    local pLabel = cc.Label:createWithTTF(msg, "fonts/FZZY.TTF", 30)
    pLabel:setColor(cc.WHITE)
    pLabel:setIgnoreAnchorPointForPosition(false)
    pLabel:setAnchorPoint(cc.p(0.5,0.5))
    sprite:addChild(pLabel)
    sprite:setContentSize(cc.size(pLabel:getContentSize().width + 60, 74))
    pLabel:setPosition(cc.p(sprite:getContentSize().width/2,sprite:getContentSize().height/2))
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

return public_module