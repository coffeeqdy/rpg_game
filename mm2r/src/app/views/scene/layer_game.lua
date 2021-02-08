local global_define = require("app.public.global.global_define")
local ui_observer = require("app.public.util.ui_observer")

local game_map = require("app.views.ui.game_map")
local game_body = require("app.views.ui.game_body")
local game_menu = require("app.views.ui.game_menu")
local game_fight_layer = require("app.views.ui.game_fight_layer")

local _M = {}

function _M:init_value()
    self.move_time = 0
end

function _M:init_layer_game()
    --创建一个遮罩
    local _node_clip = cc.ClippingNode:create()
    self:addChild(_node_clip)
    local _sprite_stencil = ccui.Scale9Sprite:create("public_res/stencil.png")
    _sprite_stencil:setContentSize(cc.size(200,200))
    _node_clip:setStencil(_sprite_stencil)
    _node_clip:setInverted(false)

    self.layer_game = cc.CSLoader:createNode('game/layer_game.csb')
    _node_clip:addChild(self.layer_game)

    --地图在下
    self.game_map = game_map.new()
    self.layer_game:addChild(self.game_map, 1)

    --游戏角色
    self.game_body = game_body.new()
    self.layer_game:addChild(self.game_body, 2)
    
    --操作菜单（背包、装备等等）
    self.game_menu = game_menu.new()
    self.layer_game:addChild(self.game_menu, 3)
    self.game_menu:setVisible(false)

    --战斗场景
    self.game_fight_layer = game_fight_layer.new()
    self.layer_game:addChild(self.game_fight_layer, 3)
    self.game_fight_layer:setVisible(false)

    self:init_value()

    self:register_game_listener()
    self:register_schedule()
end

function _M:register_game_listener()
    ui_observer.get_instance():register_listener(global_define.observer_type.operate, global_define.observer_name.move_left_press, function()
        if self.game_menu:isVisible() then
            return
        end
        self.game_map:on_move_left(1)
    end)
    ui_observer.get_instance():register_listener(global_define.observer_type.operate, global_define.observer_name.move_right_press, function()
        if self.game_menu:isVisible() then
            return
        end
        self.game_map:on_move_right(1)
    end)
    ui_observer.get_instance():register_listener(global_define.observer_type.operate, global_define.observer_name.move_up_press, function()
        if self.game_menu:isVisible() then
            return
        end
        self.game_map:on_move_up(1)
    end)
    ui_observer.get_instance():register_listener(global_define.observer_type.operate, global_define.observer_name.move_down_press, function()
        if self.game_menu:isVisible() then
            return
        end
        self.game_map:on_move_down(1)
    end)
    
    ui_observer.get_instance():register_listener(global_define.observer_type.operate, global_define.observer_name.move_left_release, function()
        if self.game_menu:isVisible() then
            self.game_menu:on_move_left()
            return
        end
        self.game_map:on_move_left(2)
    end)
    ui_observer.get_instance():register_listener(global_define.observer_type.operate, global_define.observer_name.move_right_release, function()
        if self.game_menu:isVisible() then
            self.game_menu:on_move_right()
            return
        end
        self.game_map:on_move_right(2)
    end)
    ui_observer.get_instance():register_listener(global_define.observer_type.operate, global_define.observer_name.move_up_release, function()
        if self.game_menu:isVisible() then
            self.game_menu:on_move_up()
            return
        end
        self.game_map:on_move_up(2)
    end)
    ui_observer.get_instance():register_listener(global_define.observer_type.operate, global_define.observer_name.move_down_release, function()
        if self.game_menu:isVisible() then
            self.game_menu:on_move_down()
            return
        end
        self.game_map:on_move_down(2)
    end)
end

function _M:register_schedule()
    if not self.node_schedule then
        self.node_schedule = cc.Node:create()
        self:addChild(self.node_schedule)
    end
    self.node_schedule:scheduleUpdateWithPriorityLua(function(delta_time)
        --如果当前是移动状态，则有概率遇到怪物
        --遇到怪物有个安全时间，安全时间内不会遇到怪物
        --如果超过安全时间，则概率遇到怪物
        if self.game_map:is_moving() then
            self.move_time = self.move_time + delta_time
            if self.move_time > self:get_safe_time() then
                if self:check_meet_monster() then
                    self:reset_move_state()
                end
            end
        end
    end, 0)
end

function _M:get_safe_time()
    return 4
end

function _M:check_meet_monster()
    local _square = self.game_map:get_collect_square(self.game_body)
    local _percent = _square:get_meet_percent()
    local _num_random = math.random(1, 10000)
    if _num_random < _percent then
        local _monster_data = _square:get_monster_list()
        self.game_fight_layer:show(_monster_data)
        return true
    end
    return false
end

function _M:reset_move_state()
    self.move_time = 0
    self.game_map:on_reset_move_state()
end

return _M