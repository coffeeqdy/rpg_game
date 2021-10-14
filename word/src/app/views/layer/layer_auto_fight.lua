local base_observer = require("app.public.base_observer")
local layer_auto_fight = class("layer_auto_fight", base_observer)
local ui_fight_user = require("app.views.ui.ui_fight_user")
local gate_manager = require("app.public.data.gate_manager")
local enemy_manager = require("app.public.data.enemy_manager")
local public_module = require("app.public.util.public_module")
local string_config = require("app.public.string_config.string")

local hurt_type = {
    miss = 1,
    hurt = 2,
    crit_hurt = 3
}

local max_count = 50

function layer_auto_fight:init()
    self.node_root = cc.CSLoader:createNode("scene/layer_auto_fight.csb")
    self.node_player = self.node_root:getChildByName("node_player")
    self.node_enemy = self.node_root:getChildByName("node_enemy")
    --还需要一个关卡选择控件TODO
    --战斗数据展示
    self.list_view = self.node_root:getChildByName("list_view")
end

function layer_auto_fight:get_listen_list()
end

function layer_auto_fight:on_deal_event(id, data)
end

function layer_auto_fight:show()
    base_observer.show(self)
    self:reset_user()
end

function layer_auto_fight:reset_user()
    self:reset_player_list()
    self:reset_enemy_list()
end

function layer_auto_fight:reset_player_list()
    self.node_player:removeAllChildren()
    local _data = g_data.player
    for i = 1, #_data do
        self:create_player(_data[i])
    end
end

function layer_auto_fight:create_player(player)
    local _node = cc.CSLoader:createNode("scene/ui_fight_user.csb")
    self.node_player:addChild(_node)
    _node.data = player
    _node:runAction(cc.RepeatForever:create(cc.Sequence:create(
        cc.DelayTime:create(player:get_attack_cd()),
        cc.CallFunc:create(function()
            self:player_attack(_node)
        end)
    )))
end

function layer_auto_fight:reset_enemy_list()
    self.node_enemy:removeAllChildren()
    local _gate_info = gate_manager.get_instance():get_gate_info(g_data.gate_id)
    if _gate_info.enemy then
        local _index = math.random(1, #_gate_info.enemy)
        local _res = _gate_info.enemy[_index]
        for i = 1, #_res do
            local _enemy_info = enemy_manager.get_instance():get_enemy_info(_res[i])
            self:create_enemy(_enemy_info)
        end
    end
    public_module.ui_node_sort(self.node_enemy:getChildren(),"y-top",nil,nil,100)
end

function layer_auto_fight:create_enemy(enemy)
    local _node = cc.CSLoader:createNode("scene/ui_fight_user.csb")
    self.node_enemy:addChild(_node)
    _node.data = enemy
    _node:runAction(cc.RepeatForever:create(cc.Sequence:create(
        cc.DelayTime:create(enemy:get_attack_cd()),
        cc.CallFunc:create(function()
            self:enemy_attack(_node)
        end)
    )))
end

--敌方发起攻击
function layer_auto_fight:enemy_attack(enemy)
    local _players = self.node_player:getChildren()
    local _target = _players[math.random(1, #_players)]
    self:do_attack(enemy, _target)
end

--我方发起攻击
function layer_auto_fight:player_attack(player)
    local _enemys = self.node_enemy:getChildren()
    local _target = _enemys[math.random(1, #_enemys)]
    self:do_attack(player, _target)
end

--战斗计算模拟
--node_att=攻击方
--node_def=防御方
function layer_auto_fight:do_attack(node_att, node_def)
    local _first_data = node_att.data
    local _second_data = node_def.data
    --是否命中
    local _hit = _first_data:get_meta_data("total_hit")
    local _evd = _second_data:get_meta_data("total_evd")
    local _real_hit = _hit - _evd
    local _random_hit = math.random(1, 100)
    if _random_hit > _real_hit then
        --未命中
        self:do_miss(node_def)
        self:do_print_fight(_first_data, _second_data, hurt_type.miss)
        return
    end
    --打印类型
    local _type = hurt_type.hurt
    --基本伤害计算
    local _att = _first_data:get_meta_data("total_att")
    local _def = _second_data:get_meta_data("total_def")
    local _hurt = _att - _def
    --是否暴击
    local _crit = _first_data:get_meta_data("total_crit")
    local _dmg = _first_data:get_meta_data("total_dmg")
    local _random_crit = math.random(1, 100)
    if _random_crit <= _crit then
        _hurt = _hurt * _dmg
        _type = hurt_type.crit_hurt
    end
    --随机浮动伤害
    local _hit_area = _first_data:get_meta_data("base_hit_area")
    local _random_percent = math.random(100 - _hit_area, 100)
    _hurt = math.ceil(_hurt * _random_percent / 100)
    --是否元素伤害

    --造成伤害
    if _hurt < 1 then
        _hurt = 1
    end
    self:do_hurt(node_def, _hurt, _type == hurt_type.crit_hurt)
    self:do_print_fight(_first_data, _second_data, _type, _hurt)
end

--闪避
function layer_auto_fight:do_miss(node)
    local _text = ccui.Text:create("躲闪","fonts/FZZY.TTF",30)
    _text:setTextColor(cc.c3b(255,255,255))
    node:addChild(_text)
    _text:runAction(cc.Sequence:create(
        cc.MoveBy:create(1, cc.p(0, 50)),
        cc.Spawn:create(
            cc.MoveBy:create(1, cc.p(0, 50)),
            cc.FadeIn:create(1)
        ),
        cc.RemoveSelf:create()
    ))
end

--造成伤害
function layer_auto_fight:do_hurt(node, hurt, is_crit)
    local _text = ccui.Text:create("-"..hurt,"fonts/FZZY.TTF",30)
    _text:setTextColor(cc.c3b(255,88,88))
    node:addChild(_text)
    _text:runAction(cc.Sequence:create(
        cc.MoveBy:create(1, cc.p(0, 50)),
        cc.Spawn:create(
            cc.MoveBy:create(1, cc.p(0, 50)),
            cc.FadeIn:create(1)
        ),
        cc.RemoveSelf:create()
    ))
    if is_crit then
        _text:runAction(cc.Sequence:create(
            cc.ScaleTo:create(0.5, 1.5),
            cc.ScaleTo:create(0.5, 1)
        ))
    end
end

--打印输出
--in_type  1=闪避；2=普通伤害；3=暴击伤害
function layer_auto_fight:do_print_fight(first_data, second_data, in_type, value)
    local _items = self.list_view:getItems()
    if #_items == max_count then
        self.list_view:removeChild(_items[1])
    end
    local _rich_text = ccui.RichText:create()
    if in_type == hurt_type.miss then
        local _element_text_1 = ccui.RichElementText:create(0,cc.c3b(172,95,31),255,first_data.name,"fonts/FZZY.TTF",16)
        local _element_text_2 = ccui.RichElementText:create(1,cc.c3b(244,5,0),255,string_config.attack .. ",","fonts/FZZY.TTF",16)
        local _element_text_3 = ccui.RichElementText:create(2,cc.c3b(172,95,31),255,second_data.name,"fonts/FZZY.TTF",16)
        local _element_text_4 = ccui.RichElementText:create(3,cc.c3b(172,95,31),255,string_config.miss,"fonts/FZZY.TTF",16)
        _rich_text:pushBackElement(_element_text_1)
        _rich_text:pushBackElement(_element_text_2)
        _rich_text:pushBackElement(_element_text_3)
        _rich_text:pushBackElement(_element_text_4)
    elseif in_type == hurt_type.hurt then
        local _element_text_1 = ccui.RichElementText:create(0,cc.c3b(172,95,31),255,first_data.name,"fonts/FZZY.TTF",16)
        local _element_text_2 = ccui.RichElementText:create(1,cc.c3b(244,5,0),255,string_config.attack .. ",","fonts/FZZY.TTF",16)
        local _element_text_3 = ccui.RichElementText:create(2,cc.c3b(172,95,31),255,second_data.name,"fonts/FZZY.TTF",16)
        local _element_text_4 = ccui.RichElementText:create(3,cc.c3b(172,95,31),255,string_config.hurt,"fonts/FZZY.TTF",16)
        local _element_text_5 = ccui.RichElementText:create(4,cc.c3b(172,95,31),255,value,"fonts/FZZY.TTF",16)
        _rich_text:pushBackElement(_element_text_1)
        _rich_text:pushBackElement(_element_text_2)
        _rich_text:pushBackElement(_element_text_3)
        _rich_text:pushBackElement(_element_text_4)
        _rich_text:pushBackElement(_element_text_5)
    elseif in_type == hurt_type.crit_hurt then
        local _element_text_1 = ccui.RichElementText:create(0,cc.c3b(172,95,31),255,first_data.name,"fonts/FZZY.TTF",16)
        local _element_text_2 = ccui.RichElementText:create(1,cc.c3b(244,5,0),255,string_config.attack .. string_config.crit .. ",","fonts/FZZY.TTF",16)
        local _element_text_3 = ccui.RichElementText:create(2,cc.c3b(172,95,31),255,second_data.name,"fonts/FZZY.TTF",16)
        local _element_text_4 = ccui.RichElementText:create(3,cc.c3b(172,95,31),255,string_config.hurt,"fonts/FZZY.TTF",16)
        local _element_text_5 = ccui.RichElementText:create(4,cc.c3b(172,95,31),255,value,"fonts/FZZY.TTF",16)
        _rich_text:pushBackElement(_element_text_1)
        _rich_text:pushBackElement(_element_text_2)
        _rich_text:pushBackElement(_element_text_3)
        _rich_text:pushBackElement(_element_text_4)
        _rich_text:pushBackElement(_element_text_5)
    end
    _rich_text:setAnchorPoint(cc.p(0, 0))
    self.list_view:pushBackCustomItem(_rich_text)
    self.list_view:jumpToBottom()
end

return layer_auto_fight