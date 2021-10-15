local public_module = require("app.public.util.public_module")
local equip_data = require("app.public.data.equip_data")
local global_define = require("app.public.global.global_define")

local body_data = class("body_data")

function body_data:ctor()
    public_module.append_table(self, "app.public.data.base_data")
    self:init_base_data()
    self:init_real_base_data()

    --特有属性
    self.title = ""--称号
    self.title_id = 0--称号id
    self.sex = 1--性别1男2女3其他

    --总属性
    self.total_att = 0
    self.total_def = 0
    self.total_hp = 0

    self.total_crit = 0--暴击率
    self.total_dmg = 0--暴击伤害倍数
    self.total_hit = 0--命中率
    self.total_evd = 0--躲闪率

    self.total_fire = 0--火
    self.total_ice = 0--冰
    self.total_electric = 0--电
    self.total_voice = 0 --音

    self.total_att_speed = 0 --攻击速度
    self.total_weapon_cd = 1


    self.equip = {}
    self.buff = {}
end

function body_data:init_real_base_data()
    self:set_meta_data("base_hit", 70)--基本命中
    self:set_meta_data("base_evd", 20)--基本闪避
    self:set_meta_data("base_crit", 10)--基本暴击率
    self:set_meta_data("base_dmg", 2)--基本暴击伤害倍数
    self:set_meta_data("base_hit_area", 10)--伤害浮动
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
    self.total_att_speed = self.base_att_speed
    self.total_hp = self.base_hp
    local _cur_weapon_cd = self.base_weapon_cd
    for equip_tag, equip_data in pairs(self.equip) do
        self.total_att = self.total_att + equip_data:get_meta_data("base_att")
        self.total_def = self.total_def + equip_data:get_meta_data("base_def")
        self.total_fire = self.total_fire + equip_data:get_meta_data("base_fire")
        self.total_ice = self.total_ice + equip_data:get_meta_data("base_ice")
        self.total_electric = self.total_electric + equip_data:get_meta_data("base_electric")
        self.total_voice = self.total_voice + equip_data:get_meta_data("base_voice")
        self.total_att_speed = self.total_att_speed + equip_data:get_meta_data("base_att_speed")
        self.total_crit = self.total_crit + equip_data:get_meta_data("base_crit")
        self.total_dmg = self.total_dmg + equip_data:get_meta_data("base_dmg")
        self.total_hit = self.total_hit + equip_data:get_meta_data("base_hit")
        self.total_evd = self.total_evd + equip_data:get_meta_data("base_evd")
        self.total_hp = self.total_hp + equip_data:get_meta_data("base_hp")
        if equip_data:is_weapon() then
            _cur_weapon_cd = equip_data:get_weapon_cd()
        end
    end
    self.total_weapon_cd = _cur_weapon_cd
end

--检测是否是无效的装备
function body_data:check_invalid_equip(equip_type, equip_id)
    local _temp_type = math.floor(equip_id % 1000000 / 10000)
    if _temp_type == equip_type then
        return false
    end
    return true
end

--攻击间隔不能低于阈值
function body_data:get_attack_cd()
    --武器的攻击间隔加成攻击速度的计算
    local _cd = self.total_weapon_cd * 1000 / self.total_att_speed
    if _cd < global_define.cd_min then
        _cd = global_define.cd_min
    end
    return _cd
end

function body_data:get_hp()
    return self.total_hp
end

return body_data