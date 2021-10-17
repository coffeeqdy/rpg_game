local base_layer = require("app.public.base.base_layer")
local layer_auto_fight = class("layer_auto_fight", base_layer)
local ui_fight_user = require("app.views.ui.ui_fight_user")
local gate_manager = require("app.public.config.gate_manager")
local enemy_manager = require("app.public.config.enemy_manager")
local public_module = require("app.public.util.public_module")
local string_config = require("app.public.string_config.string")
local body_data = require("app.public.data.body_data")

local cmd_define = require("app.public.global.cmd_define")

local log_type = {
    miss = 1,
    hurt = 2,
    crit_hurt = 3,
    lose = 4,
    win = 5,
    wait = 6,
}

local max_count = 50

function layer_auto_fight:init()
    self.node_root = cc.CSLoader:createNode("scene/layer_auto_fight.csb")
    self:addChild(self.node_root)
    self.btn_close = self.node_root:getChildByName("btn_close")
    self.btn_close:addClickEventListener(function()
        self:hide()
    end)
    self.node_player = self.node_root:getChildByName("node_player")
    self.node_enemy = self.node_root:getChildByName("node_enemy")
    --还需要一个关卡选择控件TODO
    --战斗数据展示
    self.list_view = self.node_root:getChildByName("list_view")

    --管理动作
    self.node_action = cc.Node:create()
    self:addChild(self.node_action)
end

function layer_auto_fight:get_listen_list()
    return {
        {cmd_define.main_game, cmd_define.sub_stop_auto_fight_rsp},
        {cmd_define.main_game, cmd_define.sub_find_fight_rsp},
        {cmd_define.main_game, cmd_define.sub_fight_result_rsp},
    }
end

function layer_auto_fight:on_deal_event(main_id, sub_id, data)
    if main_id == cmd_define.main_game then
        if sub_id == cmd_define.sub_stop_auto_fight_rsp then
            self:wait_to_fight()
        elseif sub_id == cmd_define.sub_find_fight_rsp then
            self:reset_enemy_list(data)
            self:start_fight()
        elseif sub_id == cmd_define.sub_fight_result_rsp then
        end
    end
end

function layer_auto_fight:show()
    base_layer.show(self)
    self:send_event(cmd_define.main_game, cmd_define.sub_stop_auto_fight_req)
end

function layer_auto_fight:reset_player_list()
    self.node_player:removeAllChildren()
    local _data = g_data.player
    for i = 1, #_data do
        self:create_player(_data[i])
    end
    public_module.ui_node_sort(self.node_player:getChildren(),"y-top",nil,nil,100)
end

function layer_auto_fight:create_player(player)
    local _node = cc.CSLoader:createNode("scene/ui_fight_user.csb")
    self.node_player:addChild(_node)
    _node.data = player
    _node.hp = player:get_hp()
    _node.loading_bar = _node:getChildByName("loading_bar")
    _node.text_info = _node:getChildByName("text_info")
end

function layer_auto_fight:reset_enemy_list(data)
    self.node_enemy:removeAllChildren()
    for i = 1, #data.enemy do
        local _enemy_info = enemy_manager.get_instance():get_enemy_info(data.enemy[i])
        local _enemy_data = body_data.new()
        _enemy_data:set_enemy_data(_enemy_info)
        self:create_enemy(_enemy_data)
    end
    public_module.ui_node_sort(self.node_enemy:getChildren(),"y-top",nil,nil,100)
end

function layer_auto_fight:create_enemy(enemy)
    local _node = cc.CSLoader:createNode("scene/ui_fight_user.csb")
    self.node_enemy:addChild(_node)
    _node.data = enemy
    _node.hp = enemy:get_hp()
    _node.loading_bar = _node:getChildByName("loading_bar")
    _node.text_info = _node:getChildByName("text_info")
end

function layer_auto_fight:start_fight()
    local _players = self.node_player:getChildren()
    for i, v in pairs(_players) do
        v:stopAllActions()
        v:runAction(cc.RepeatForever:create(cc.Sequence:create(
            cc.DelayTime:create(v.data:get_attack_cd()),
            cc.CallFunc:create(function()
                self:player_attack(v)
            end)
        )))
    end
    local _enemys = self.node_enemy:getChildren()
    for i, v in pairs(_enemys) do
        v:stopAllActions()
        v:runAction(cc.RepeatForever:create(cc.Sequence:create(
            cc.DelayTime:create(v.data:get_attack_cd()),
            cc.CallFunc:create(function()
                self:enemy_attack(v)
            end)
        )))
    end
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
        self:do_print_log(_first_data, _second_data, log_type.miss)
        return
    end
    --打印类型
    local _type = log_type.hurt
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
        _type = log_type.crit_hurt
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
    self:do_hurt(node_def, _hurt, _type == log_type.crit_hurt)
    self:do_print_log(_first_data, _second_data, _type, _hurt)
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
    --飘字
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
    --伤害逻辑
    local _data = node.data
    node.hp = node.hp - hurt
    if node.hp <= 0 then
        node.hp = 0
        self:do_body_dead(node)
    end
    self:render_hp(node)
end

function layer_auto_fight:render_hp(node)
    node.loading_bar:setPencent(node.hp / node.data:get_hp() * 100)
end

function layer_auto_fight:do_body_dead(node)
    node.is_dead = true
    node:runAction(cc.Sequence:create(
        cc.Blink:create(0.5, 5),
        cc.Show:create(),
        cc.FadeIn:create(0.5),
        cc.RemoveSelf:create()
    ))
    public_module.delay_do(1.2,function()
        self:sort_body()
    end)
    --检测是否战斗结束
    --玩家是否还有存活
    local _is_player_alive = false
    local _players = self.node_player:getChildren()
    for i, v in pairs(_players) do
        if not v.is_dead then
            _is_player_alive = true
            break
        end
    end
    if not _is_player_alive then
        self:do_print_log(log_type.lose)
        self:wait_to_fight()
        return
    end
    --敌方是否还有存活
    local _is_enemy_alive = false
    local _enemys = self.node_enemy:getChildren()
    for i, v in pairs(_enemys) do
        if not v.is_dead then
            _is_enemy_alive = true
            break
        end
    end
    if not _is_enemy_alive then
        self:send_event(cmd_define.main_game, cmd_define.sub)
    end
end

--打印输出
--in_type  1=闪避；2=普通伤害；3=暴击伤害
function layer_auto_fight:do_print_log(first_data, second_data, in_type, value)
    local _items = self.list_view:getItems()
    if #_items == max_count then
        self.list_view:removeChild(_items[1])
    end
    local _rich_text = ccui.RichText:create()
    if in_type == log_type.miss then--躲闪
        local _element_text_1 = ccui.RichElementText:create(0,cc.c3b(172,95,31),255,first_data.name,"fonts/FZZY.TTF",16)
        local _element_text_2 = ccui.RichElementText:create(1,cc.c3b(244,5,0),255,string_config.attack .. ",","fonts/FZZY.TTF",16)
        local _element_text_3 = ccui.RichElementText:create(2,cc.c3b(172,95,31),255,second_data.name,"fonts/FZZY.TTF",16)
        local _element_text_4 = ccui.RichElementText:create(3,cc.c3b(172,95,31),255,string_config.miss,"fonts/FZZY.TTF",16)
        _rich_text:pushBackElement(_element_text_1)
        _rich_text:pushBackElement(_element_text_2)
        _rich_text:pushBackElement(_element_text_3)
        _rich_text:pushBackElement(_element_text_4)
    elseif in_type == log_type.hurt then--造成伤害
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
    elseif in_type == log_type.crit_hurt then--暴击伤害
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
    elseif in_type == log_type.lose then--战斗失败
    elseif in_type == log_type.win then--战斗胜利
    elseif in_type == log_type.wait then--战斗等待
    end
    _rich_text:setAnchorPoint(cc.p(0, 0))
    self.list_view:pushBackCustomItem(_rich_text)
    self.list_view:jumpToBottom()
end

function layer_auto_fight:sort_body()
    public_module.ui_node_sort(self.node_player:getChildren(),"y-top",nil,nil,100)
    public_module.ui_node_sort(self.node_enemy:getChildren(),"y-top",nil,nil,100)
end

function layer_auto_fight:wait_to_fight()
    self:do_print_log(log_type.wait, "正在探索中...")
    local _cur_time = g_data.wait_time
    self.node_action:runAction(cc.Sequence:create(
        cc.Repeat:create(cc.Sequence:create(
                cc.CallFunc:create(function()
                    self:do_print_log(log_type.wait, _cur_time .. "...")
                    _cur_time = _cur_time - 1
                end),
                cc.DelayTime:create(1)
        ), g_data.wait_time),
        cc.CallFunc:create(function()
            self:send_event(cmd_define.main_game, cmd_define.sub_find_fight_req, {gate_id=g_data.gate_id})
        end)
    ))
    self:reset_player_list()
end

return layer_auto_fight