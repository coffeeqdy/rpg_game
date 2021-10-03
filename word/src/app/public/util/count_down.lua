---------------------------------------------------------
---倒计时控件
---
---
---
---------------------------------------------------------

local type_label = {
    text_normal = 1,
    text_bmfnt = 2,
    text_atlas = 3,
    text_ttf = 4,
}

local E_H_02M_02S = 0 --时分秒
local E_H_02M = 1 --时分
local E_M_02S = 2 --分秒
local E_S = 3 --秒
local E_02H_02M_02S = 4 --时分秒02
local E_02H_02M = 5 --时分02
local E_02M_02S = 6 --分秒02
local E_02S = 7 --秒02
local E_S_UNITs = 8 --秒，带单位s
local E_D_02H_02M_02S = 9 --天时分秒

local count_down = class("count_down",function() return cc.Node:create() end)

function count_down:create(fontName, fontColor, fontSize, param)
    local count_down = count_down.new()
    count_down:init(fontName, fontColor, fontSize, param)
    return count_down
end

function count_down:init(fontName, fontColor, fontSize, param)
    fontName = fontName or ""
    fontColor = fontColor or cc.c4b(255,255,255,255)
    fontSize = fontSize or 24
    local lenth = string.len(fontName)
    self.m_labelType = type_label.text_normal
    self.m_nShowFormat = E_02H_02M_02S
    if lenth > 0 then
        local tail = string.sub( fontName, lenth - 2, lenth )
        if tail == "fnt" then
            self.m_label = ccui.TextBMFont:create("",fontName)
            self:addChild(self.m_label)
            self.m_labelType = type_label.text_bmfnt
        elseif tail == "png" then
            self.m_label = ccui.TextAtlas:create("",fontName,param[1],param[2],"0")
            self:addChild(self.m_label)
            self.m_labelType = type_label.text_atlas
        elseif tail == "TTF" then
            -- self.m_label = cc.Label:createWithSystemFont("", fontName,fontSize);
            self.m_label = ccui.Text:create("",fontName,fontSize)
            self:addChild(self.m_label)
            self.m_labelType = type_label.text_ttf
            self.m_label:setTextColor(fontColor)
        end
    else
        self.m_label = cc.Label:create()
        self.m_label:setSystemFontSize(fontSize)
        self.m_label:setTextColor(fontColor)
        self:addChild(self.m_label)
        self.m_labelType = type_label.text_normal
    end

    local _callback = function(eventType)
        if eventType == "cleanup" then
            self:releaseSchedule()
        end
    end
    self.m_timePointFunc = {}
    self:registerScriptHandler(_callback)
    self:setCascadeOpacityEnabled(true)
end

function count_down:setLabel(label)
    if self.m_label then
        self.m_label:removeFromParent()
    end
    self.m_label = label
end

function count_down:setTimeTotal(num)
    self.m_timeTotal = num
end

function count_down:start()
    self:stop()
    self.m_timeCurrent = self.m_timeTotal
    self:showLabel(self.m_timeCurrent)
    self.m_scheduleID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,self.updateLabel),1,false)
end

function count_down:updateLabel()
    if self.m_timeCurrent then
        if self.m_timeCurrent >= 0 then
            self.m_timeCurrent = self.m_timeCurrent - 1
            if self.m_timePointFunc and next(self.m_timePointFunc) then
                for i = 1, #self.m_timePointFunc do
                    if self.m_timePointFunc[i].time == self.m_timeCurrent then
                        self.m_timePointFunc[i].func()
                        table.remove( self.m_timePointFunc, i )
                        break
                    end
                end
            end
            self:showLabel(self.m_timeCurrent)
        else
            self:showLabel(0)
            self:stop()
            if self.m_callFunc then
                self.m_callFunc()
            end
        end
    end
end

function count_down:releaseSchedule()
    if self.m_scheduleID then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.m_scheduleID)
        self.m_scheduleID = nil
    end
end

function count_down:stop()
    self:releaseSchedule()
    self.m_timeCurrent = 0
end

function count_down:setFontSize(size)
    if self.m_labelType == type_label.text_normal then
        self.m_label:setSystemFontSize(size)
    elseif self.m_labelType == type_label.text_ttf then
        self.m_label:setFontSize(size)
    end
end

function count_down:setFontColor(color)
    if self.m_labelType == type_label.text_normal or self.m_labelType == type_label.text_ttf then
        self.m_label:setTextColor(color)
    end
end

function count_down:showLabel(_time)
    if _time < 0 then
        _time = 0
    end
    local str_
	if self.m_nShowFormat == E_H_02M_02S then --时分秒
		local nHour = _time / 3600
		local nMinute = (_time % 3600) / 60
		local nSeconds = (_time % 3600) % 60
		str_ = string.format("%d:%02d:%02d", nHour, nMinute, nSeconds)
	elseif self.m_nShowFormat == E_H_02M then --时分
		local nHour = _time / 3600
		local nMinute = (_time % 3600) / 60
		str_ = string.format("%d:%02d", nHour, nMinute)
	elseif self.m_nShowFormat == E_M_02S then --分秒
		local nMinute = _time / 60
		local nSeconds = _time % 60
		str_ = string.format("%d:%02d", nMinute, nSeconds)
	elseif self.m_nShowFormat == E_02M_02S then --分秒
		local nMinute = _time / 60
		local nSeconds = _time % 60
		str_ = string.format("%02d:%02d", nMinute, nSeconds)
	elseif self.m_nShowFormat == E_S then --秒
		str_ = string.format("%d", _time)
	elseif self.m_nShowFormat == E_S_UNITs then
		str_ = string.format("%ds", _time)
	elseif self.m_nShowFormat == E_02H_02M_02S then
		local nHour = _time / 3600
		local nMinute = (_time % 3600) / 60
		local nSeconds = (_time % 3600) % 60
		str_ = string.format("%02d:%02d:%02d", nHour, nMinute, nSeconds)
	elseif self.m_nShowFormat == E_D_02H_02M_02S then
		local nDay = math.floor(_time / 86400)
		local nHour = math.floor((_time % 86400) / 3600)
		local nMinute = math.floor((_time % 3600) / 60)
		local nSeconds = (_time % 3600) % 60
		if nDay > 0 then
			str_ = string.format("%d天", nDay)
		else
			str_ = string.format("%02d:%02d:%02d", nHour, nMinute, nSeconds)
        end
    end
    if self.table_label then
        for i,v in ipairs(self.table_label) do
            if not tolua.isnull(v) then
                v:setString(str_)
            end
        end
    end
	if self.m_strLeft then
		str_ = self.m_strLeft .. str_
    end
	if self.m_strRight then
		str_ = str_ .. self.m_strRight
    end
    if self.m_label and not tolua.isnull(self.m_label) then
        self.m_label:setString(str_)
    end
end

function count_down:setFormat(name)
    self.m_nShowFormat = name
end

function count_down:setTimeDownCallFunc(func)
    self.m_callFunc = func
end

function count_down:setLabelLeft(str)
    self.m_strLeft = str
end

function count_down:setLabelRight(str)
    self.m_strRight = str
end

function count_down:getCurrentTime()
    return self.m_timeCurrent
end

function count_down:clearTimePointCallFunc()
    self.m_timePointFunc = {}
end

function count_down:addTimePointCallFunc(num,func)
    self.m_timePointFunc = self.m_timePointFunc or {}
    self.m_timePointFunc[#self.m_timePointFunc + 1] = {time = num,func = func}
end

function count_down:enableOutline(_color,_size)
    if self.m_labelType == type_label.text_ttf then
        self.m_label:enableOutline(_color,_size)
    end
end

function count_down:add_update_label(label, index)
    self.table_label = self.table_label or {}
    if index then
        self.table_label[index] = label
    else
        self.table_label[#self.table_label + 1] = label
    end
end

return count_down
