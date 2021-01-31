
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

return public_module