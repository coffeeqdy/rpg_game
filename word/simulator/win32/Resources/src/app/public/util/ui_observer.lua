--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:{author}
    time:2020-01-17 11:58:59
]]

local print = print
local ui_observer = class("ui_observer")

local _instance = nil

function ui_observer:get_instance()
    if not _instance then
        _instance = ui_observer.new()
    end
    return _instance
end

function ui_observer:ctor()
    self.listener_event = {}
end

function ui_observer:register_listener(_type, _name, _func)
    if not _type or not _name then
        return
    end
    self.listener_event[_type] = self.listener_event[_type] or {}
    self.listener_event[_type][_name] = _func
end

function ui_observer:clear_listener()
    self.listener_event = {}
    _instance = nil
end

function ui_observer:send_event(_type, _name, data)
    if _type then
        if self.listener_event[_type] then
            if _name then
                if self.listener_event[_type][_name] and type(self.listener_event[_type][_name]) == "function" then
                    self.listener_event[_type][_name](data)
                end
            else
                for i, v in pairs(self.listener_event[_type]) do
                    if v and type(v) == "function" then
                        v(data)
                    end
                end
            end
        end
    end
end

function ui_observer:remove_listener(_type, _name)
    if _type then
        if self.listener_event[_type] then
            if _name then
                self.listener_event[_type][_name] = nil
            else
                self.listener_event[_type] = nil
            end
        end
    end
end

return ui_observer