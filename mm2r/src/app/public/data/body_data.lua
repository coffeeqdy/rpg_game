local public_module = require("app.public.util.public_module")
local equip_data = require("app.public.data.equip_data")

local body_data = class("body_data")

function body_data:ctor()
    public_module.append_table(self, "app.public.data.base_data")

    --特有属性
    self.title = ""--称号
    self.title_id = 0--称号id
    self.sex = 1--性别1男2女3其他

    --总属性
    self.total_att = 0
    self.total_def = 0

    self.total_fire = 0--火
    self.total_ice = 0--冰
    self.total_electric = 0--电
    self.total_voice = 0 --音

    self.equip = {}
    self.buff = {}
end

--equip_tag：装备标记
--equip_id：装备id，取消装备传nil即可
function body_data:set_equip(equip_type, equip_id)
    if self.equip[equip_type] == equip_id then return end
    if self:check_invalid_equip(equip_type, equip_id) then return end
    if not self.equip[equip_type] then
        self.equip[equip_type] = equip_data.new()
    end
    self:on_calculate_total_data()
end

function body_data:set_buff(buff_tag, is_on)
    self.buff[buff_tag] = is_on
end

function body_data:on_calculate_total_data()
    self.total_att = self.base_att
    self.total_def = self.base_def
    self.total_fire = self.base_fire
    self.total_ice = self.base_ice
    self.total_electric = self.base_electric
    self.total_voice = self.base_voice
    for equip_tag, equip_data in pairs(self.equip) do
        self.total_att = self.total_att + equip_data:get_meta_data("base_att")
        self.total_def = self.total_def + equip_data:get_meta_data("base_def")
        self.total_fire = self.total_fire + equip_data:get_meta_data("base_fire")
        self.total_ice = self.total_ice + equip_data:get_meta_data("base_ice")
        self.total_electric = self.total_electric + equip_data:get_meta_data("base_electric")
        self.total_voice = self.total_voice + equip_data:get_meta_data("base_voice")
    end
end

--检测是否是无效的装备
function body_data:check_invalid_equip(equip_type, equip_id)
    local _temp_type = math.floor(equip_id % 100000 / 10000)
    if _temp_type == equip_type then
        return false
    end
    return true
end

return body_data