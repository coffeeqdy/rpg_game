local base_observer = require("app.public.base_observer")
local layer_main = class("layer_main", base_observer)

local layer_auto_fight = require("app.views.layer.layer_auto_fight")

function layer_main:init()
end

function layer_main:get_listen_list()
end

function layer_main:on_deal_event(id, data)
end

function layer_main:show_auto_fight()
    if not self.layer_auto_fight then
        self.layer_auto_fight = layer_auto_fight.new()
        self:addChild(self.layer_auto_fight)
    end
    self.layer_auto_fight:show()
end

return layer_main