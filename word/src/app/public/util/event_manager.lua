--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:{author}
    time:2020-01-17 11:58:59
]]

local print = print
local event_manager = class("event_manager")

local _instance = nil

function event_manager:get_instance()
    if not _instance then
        _instance = event_manager.new()
    end
    return _instance
end

function event_manager:ctor()
    self.listener_event = {}
end

function event_manager:register_listener(main_id, sub_id, c_name, func)
    if not main_id or not sub_id or not c_name then return end
    self.listener_event[main_id] = self.listener_event[main_id] or {}
    self.listener_event[main_id][sub_id] = self.listener_event[main_id][sub_id] or {}
    self.listener_event[main_id][sub_id][c_name] = func
end

function event_manager:clear_listener()
    self.listener_event = {}
    _instance = nil
end

function event_manager:send_event(main_id, sub_id, data)
    if main_id then
        if self.listener_event[main_id] then
            if sub_id then
                if self.listener_event[main_id][sub_id] and next(self.listener_event[main_id][sub_id]) then
                    for i, v in pairs(self.listener_event[main_id][sub_id]) do
                        if type(v) == "function" then
                            v(main_id, sub_id, data)
                        end
                    end
                end
            end
        end
    end
end

function event_manager:remove_listener(main_id, sub_id, c_name)
    if main_id then
        if self.listener_event[main_id] then
            if sub_id then
                if c_name then
                    self.listener_event[main_id][sub_id][c_name] = nil
                else
                    self.listener_event[main_id][sub_id] = nil
                end
            else
                self.listener_event[main_id] = nil
            end
        end
    end
end

return event_manager