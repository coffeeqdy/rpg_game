---------------------------------------------------------------
--基本操作整合

local global_define = require("app.public.global.global_define")
local ui_observer = require("app.public.util.ui_observer")

local _M = {}

function _M:init_layer_operate()
    self.layer_operate = cc.CSLoader:createNode('game/layer_operate.csb')
    self:addChild(self.layer_operate)

    self:parse_operate_ui()

    self:register_keyboard_event()
    self:register_button_event()
end

function _M:parse_operate_ui()
    self.btn_menu = self.layer_operate:getChildByName("btn_menu")
    self.btn_quick_1 = self.layer_operate:getChildByName("btn_quick_1")
    self.btn_quick_2 = self.layer_operate:getChildByName("btn_quick_2")
    self.btn_quick_3 = self.layer_operate:getChildByName("btn_quick_3")
    self.btn_quick_left = self.layer_operate:getChildByName("btn_quick_left")
    self.btn_quick_right = self.layer_operate:getChildByName("btn_quick_right")
    self.btn_quick_u = self.layer_operate:getChildByName("btn_quick_u")
    self.btn_quick_i = self.layer_operate:getChildByName("btn_quick_i")
    self.btn_quick_j = self.layer_operate:getChildByName("btn_quick_j")
    self.btn_quick_k = self.layer_operate:getChildByName("btn_quick_k")
    
    self.node_joystick = self.layer_operate:getChildByName("node_joystick")
    self.sprite_joystick = self.node_joystick:getChildByName("sprite_joystick")
end

function _M:register_keyboard_event()
    local function keyboardPressed(keyCode, event)
        if cc.KeyCode.KEY_A == keyCode then
            ui_observer.get_instance():send_event(global_define.observer_type.operate, global_define.observer_name.move_left_press)
        elseif cc.KeyCode.KEY_S == keyCode then
            ui_observer.get_instance():send_event(global_define.observer_type.operate, global_define.observer_name.move_down_press)
        elseif cc.KeyCode.KEY_D == keyCode then
            ui_observer.get_instance():send_event(global_define.observer_type.operate, global_define.observer_name.move_right_press)
        elseif cc.KeyCode.KEY_W == keyCode then
            ui_observer.get_instance():send_event(global_define.observer_type.operate, global_define.observer_name.move_up_press)
        end
    end
    local function keyboardReleased(keyCode, event)
        if cc.KeyCode.KEY_A == keyCode then
            ui_observer.get_instance():send_event(global_define.observer_type.operate, global_define.observer_name.move_left_release)
        elseif cc.KeyCode.KEY_S == keyCode then
            ui_observer.get_instance():send_event(global_define.observer_type.operate, global_define.observer_name.move_down_release)
        elseif cc.KeyCode.KEY_D == keyCode then
            ui_observer.get_instance():send_event(global_define.observer_type.operate, global_define.observer_name.move_right_release)
        elseif cc.KeyCode.KEY_W == keyCode then
            ui_observer.get_instance():send_event(global_define.observer_type.operate, global_define.observer_name.move_up_release)
        end
    end
    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(keyboardPressed, cc.Handler.EVENT_KEYBOARD_PRESSED)
    listener:registerScriptHandler(keyboardReleased, cc.Handler.EVENT_KEYBOARD_RELEASED)
    local eventDispatcher = self.layer_operate:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self.layer_operate)
end

function _M:register_button_event()
    self.btn_quick_1:addClickEventListener(function()
        --快捷键1
    end)
    self.btn_quick_2:addClickEventListener(function()
        --快捷键2
    end)
    self.btn_quick_3:addClickEventListener(function()
        --快捷键3
    end)
end

return _M