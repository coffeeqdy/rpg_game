local public_module = require("app.public.util.public_module")

local game_fight_layer = class("game_fight_layer", cc.Node)

function game_fight_layer:ctor()
    public_module.append_table(self,"app.views.ui.fight.game_fight_layer_ui")
    public_module.append_table(self,"app.views.ui.fight.game_fight_operate")
    public_module.append_table(self,"app.views.ui.fight.monster.fight_layer_monster_manager")
    public_module.append_table(self,"app.views.ui.fight.player.fight_layer_body_manager")
    public_module.append_table(self,"app.views.ui.fight.bullet.fight_layer_bullet_manager")

    self.attack_queue = {}

    self:init_ui()
    self:init_body_manager()
    self:init_monster_manager()
    self:init_bullet_manager()
end

function game_fight_layer:show(monster_list)
    self:setVisible(true)
    self:render_player_list()
    self:render_monster_list(monster_list)

    self:register_schedule()
    self:register_keyboard_event()

    local _random_num = math.random(1,100)
    if _random_num <= g_data.enemy_attack then--发生敌袭，敌方先手攻击一轮
        for m_k, m_v in pairs(self.monster_list) do
            local _random_aim = math.random(1, table.nums(self.body_list))
            self:add_attack_queue(m_v,self.body_list[_random_aim])
        end
    end
end

function game_fight_layer:hide()
    if not tolua.isnull(self.node_schedule) then
        self.node_schedule:removeFromParent()
    end
    self.node_schedule = nil

    self:remove_key_board_event()

    self:setVisible(false)
end

function game_fight_layer:register_schedule()
    if not self.node_schedule then
        self.node_schedule = cc.Node:create()
        self:addChild(self.node_schedule)
    end
    self.node_schedule:scheduleUpdateWithPriorityLua(function(delta_time)
        --如果当前处于等待状态则不作处理
        if self.is_wait then return end
        if not next(self.attack_queue) then return end
        local _tab = table.remove(self.attack_queue, 1)
        if _tab and next(_tab) then
            self:play_attack_action(_tab)
        end
    end, 0)
end

function game_fight_layer:add_attack_queue(att_node, def_node, param)
    self.attack_queue[#self.attack_queue + 1] = {att_node, def_node, param}
end

function game_fight_layer:play_attack_action(att_action)
    self.is_wait = true
    local _bullet = self:get_bullet(att_action[3])
    _bullet:setPosition(att_action[1]:getPosition())
    _bullet:runAction(cc.Sequence:create(
        cc.MoveTo:create(1, cc.p(att_action[2]:getPosition())),
        cc.CallFunc:create(function()
            self.is_wait = false
            --播放爆炸动画
            self:play_boom_action(att_action[2],att_action[3])
            --扣血逻辑处理
            att_action[2]:on_hit(att_action[3])
            self:remove_bullet(_bullet)
        end)
    ))
end

function game_fight_layer:play_boom_action(node,param)

end

return game_fight_layer