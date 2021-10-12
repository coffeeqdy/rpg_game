local base_observer = class("base_observer",cc.Node)
local ui_observer = require("app.public.util.ui_observer")

function base_observer:get_listen_list()
    return {}
end

function base_observer:init()
end

function base_observer:event_callback(name, id, data)
    if self.name == self.__cname then
        self:on_deal_event(id, data)
    end
end

function base_observer:on_deal_event(id, data)
end

function base_observer:register_observer()
    local _list = self:get_listen_list() or {}
    if type(_list) ~= "table" then return end
    for i, v in pairs(_list) do
        ui_observer.get_instance():register_listener(self.__cname, v, self.event_callback)
    end
end

function base_observer:ctor()
    self:init()
    self:register_observer()
end

function base_observer:show()
    self:setVisible(true)
end

function base_observer:hide()
    self:setVisible(false)
end

return base_observer