local game_fight_layer = {}

function game_fight_layer:register_keyboard_event()
    local function keyboardPressed(keyCode, event)
        if cc.KeyCode.KEY_A == keyCode then
            self:go_left()
        elseif cc.KeyCode.KEY_S == keyCode then
            self:go_down()
        elseif cc.KeyCode.KEY_D == keyCode then
            self:go_right()
        elseif cc.KeyCode.KEY_W == keyCode then
            self:go_up()
        end
    end
    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(keyboardPressed, cc.Handler.EVENT_KEYBOARD_PRESSED)
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
    self.listener = listener
end

function game_fight_layer:remove_key_board_event()
    if self.listener then
        self:getEventDispatcher():removeEventListener(self.listener)
        self.listener = nil
    end
end

function game_fight_layer:go_left()
    local _index = self.current_index
    _index = _index - 1
    if _index < 1 then
        _index = table.nums(self.table_btn_base_operate)
    end
    self:select_base_operate(_index)
end

function game_fight_layer:go_right()
    local _index = self.current_index
    _index = _index + 1
    if _index > table.nums(self.table_btn_base_operate) then
        _index = 1
    end
    self:select_base_operate(_index)
end

function game_fight_layer:go_up()
end

function game_fight_layer:go_down()
end

return game_fight_layer