local public_module = require("app.public.util.public_module")

local equip_data = class("equip_data")

function equip_data:ctor()
    public_module.append_table(self, "app.public.data.base_data")
end

function equip_data:set_equip_id(id)
end

return equip_data