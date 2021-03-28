local public_module = require("app.public.util.public_module")

local game_fight_layer = {}

function game_fight_layer:init_ui()
    local _layer_color = cc.LayerColor:create(cc.c4b(0,0,0,255),display.width,display.height)
    _layer_color:setPosition(-display.cx, -display.cy)
    self:addChild(_layer_color)

    local _node_ui = cc.CSLoader:createNode("game/layer_fight.csb")
    self:addChild(_node_ui)

    local _node_base_operate = _node_ui:getChildByName("node_base_operate")

    self.btn_attack = _node_base_operate:getChildByName("btn_attack")--攻击
    self.btn_car = _node_base_operate:getChildByName("btn_car")--乘降
    self.btn_trick = _node_base_operate:getChildByName("btn_trick")--特技
    self.btn_prop = _node_base_operate:getChildByName("btn_prop")--道具
    self.btn_other = _node_base_operate:getChildByName("btn_other")--其他

    self.table_btn_base_operate = {
        self.btn_attack,self.btn_car,self.btn_trick,self.btn_prop,self.btn_other
    }

    self.node_other = _node_ui:getChildByName("node_other")--其他菜单
    
    self.btn_run_away = self.node_other:getChildByName("btn_run_away")--逃跑
    self.btn_defence = self.node_other:getChildByName("btn_defence")--防御
    self.btn_safe = self.node_other:getChildByName("btn_safe")--保护
    self.btn_system = self.node_other:getChildByName("btn_system")--系统

    local _size = self.btn_attack:getContentSize()
    public_module.create_direct(self.btn_attack,cc.p(_size.width/2, _size.height + 40), 90)
    public_module.create_direct(self.btn_car,cc.p(_size.width/2, _size.height + 40), 90)
    public_module.create_direct(self.btn_trick,cc.p(_size.width/2, _size.height + 40), 90)
    public_module.create_direct(self.btn_prop,cc.p(_size.width/2, _size.height + 40), 90)
    public_module.create_direct(self.btn_other,cc.p(_size.width/2, _size.height + 40), 90)
    
    local _size = self.btn_run_away:getContentSize()
    public_module.create_direct(self.btn_run_away,cc.p(_size.width - 40, _size.height/2), 0)
    public_module.create_direct(self.btn_defence,cc.p(_size.width - 40, _size.height/2), 0)
    public_module.create_direct(self.btn_safe,cc.p(_size.width - 40, _size.height/2), 0)
    public_module.create_direct(self.btn_system,cc.p(_size.width - 40, _size.height/2), 0)

    self:select_base_operate(1)

    self:register_fight_operate_handler()
end

function game_fight_layer:register_fight_operate_handler()
    self.btn_attack:addClickEventListener(function()
        --攻击
    end)
    self.btn_car:addClickEventListener(function()
        --乘降
    end)
    self.btn_trick:addClickEventListener(function()
        --特技
    end)
    self.btn_prop:addClickEventListener(function()
        --道具背包
    end)
    self.btn_other:addClickEventListener(function()
        --其他菜单
        self.node_other:setVisible(not self.node_other:isVisible())
    end)
    
    self.btn_run_away:addClickEventListener(function()
        --逃跑
        self:hide()
    end)
    self.btn_defence:addClickEventListener(function()
        --防御
    end)
    self.btn_safe:addClickEventListener(function()
        --保护
    end)
    self.btn_system:addClickEventListener(function()
        --系统
    end)
end

function game_fight_layer:select_base_operate(index)
    if index > table.nums(self.table_btn_base_operate) then return end
    if index < 1 then return end

    self.current_index = index
    for i = 1, #self.table_btn_base_operate do
        self.table_btn_base_operate[i].sprite_direct:setVisible(i == self.current_index)
    end
end

return game_fight_layer