local base_observer = class("base_observer")
local event_manager = require("app.public.util.event_manager")

function base_observer:get_listen_list()
    return {}
end

function base_observer:event_callback(main_id, sub_id, data)
    self:on_deal_event(main_id, sub_id, data)
end

function base_observer:on_deal_event(id, data)
end

function base_observer:register_observer()
    local _list = self:get_listen_list() or {}
    if type(_list) ~= "table" then return end
    for i, v in pairs(_list) do
        event_manager.get_instance():register_listener(v[1], v[2], self.__cname, handler(self,self.event_callback))
    end
end

function base_observer:send_event(main_id, sub_id, data)
    event_manager.get_instance():send_event(main_id, sub_id, data)
end

return base_observer