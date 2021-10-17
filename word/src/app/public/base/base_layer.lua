local base_observer = require("app.public.base.base_observer")
local base_layer = class("base_layer", cc.Node, base_observer)

function base_layer:ctor()
    self:init()
    self:register_observer()
end

function base_layer:init()
end

function base_layer:show()
    self:setVisible(true)
end

function base_layer:hide()
    self:setVisible(false)
end

return base_layer