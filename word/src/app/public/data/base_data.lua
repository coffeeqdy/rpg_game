local base_data = {}

function base_data:init_base_data()
    -----基本属性参数
    self.name = ""--名称
    self.base_att = 0
    self.base_def = 0
    self.base_hp = 0
    self.base_crit = 0--暴击率0~100
    self.base_crit_hit = 2--暴击伤害率
    self.base_hit_area = 10--造成伤害浮动百分比
    self.base_miss = 0--闪避率
    
    self.base_fire = 0--火
    self.base_ice = 0--冰
    self.base_electric = 0--电
    self.base_voice = 0 --音
end

function base_data:get_meta_data(key_name)
    if self[key_name] then
        return self[key_name]
    else
        print("参数名不存在",key_name)
    end
end

function base_data:set_meta_data(key_name, value)
    if self[key_name] then
        self[key_name] = value
    else
        print("参数名不存在",key_name)
    end
end

return base_data