local public_module = require("app.public.util.public_module")

local equip_data = class("equip_data")

function equip_data:ctor()
    public_module.append_table(self, "app.public.data.base_data")
    self:init_base_data()
end

--id的万位和十万位表示装备类型
--例如130001其中13表示装备类型
--1=武器；2=副手；3=头盔；4=项链；5=手套；6=护腕；7=戒指；8=胸甲；9=腰带；10=护腿；11=鞋子；12=饰品
function equip_data:set_equip_id(id)
    self.equip_id = id
end

function equip_data:get_equip_id()
    return self.equip_id
end

function equip_data:is_weapon()
    return math.floor(self.equip_id % 1000000 / 10000) == 1
end

function equip_data:get_weapon_cd()
    return self.weapon_cd or self.base_weapon_cd
end

return equip_data