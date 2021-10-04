local base_observer = require("app.public.base_observer")
local layer_main = class("layer_main", base_observer)

local layer_auto_fight = require("app.views.layer.layer_auto_fight")

function layer_main:init()
    self.node_root = cc.CSLoader:createNode("scene/layer_main.csb")
    local _node_top = self.node_root:getChildByName("node_top")
    local _node_bottom = self.node_root:getChildByName("node_bottom")
    local _node_center = self.node_root:getChildByName("node_center")
    self:addChild(self.node_root)
    self:init_top(_node_top)
    self:init_center(_node_center)
    self:init_bottom(_node_bottom)
end

function layer_main:get_listen_list()
end

function layer_main:on_deal_event(id, data)
end

function layer_main:init_top(node_top)
    self.text_nick = node_top:getChildByName("text_nick")
    self.text_id = node_top:getChildByName("text_id")
    self.text_place = node_top:getChildByName("text_place")
    self.text_gold = node_top:getChildByName("text_gold")
    self.text_diamond = node_top:getChildByName("text_diamond")
    self.text_war_score = node_top:getChildByName("text_war_score")
end

function layer_main:init_center(node_center)
    local _list_view = node_center:getChildByName("list_view")
    local _panel = _list_view:getChildByName("Panel_1")
    self.text_att_p = _panel:getChildByName("text_att_p")
    self.text_att_m = _panel:getChildByName("text_att_m")
    self.text_def_p = _panel:getChildByName("text_def_p")
    self.text_def_m = _panel:getChildByName("text_def_m")
    self.text_crit = _panel:getChildByName("text_crit")
    self.text_hit = _panel:getChildByName("text_hit")
    self.text_evd = _panel:getChildByName("text_evd")
    self.text_dmg = _panel:getChildByName("text_dmg")
end

function layer_main:init_bottom(node_bottom)
    self.btn_fight = node_bottom:getChildByName("btn_fight")--自动挂机
    self.btn_bag = node_bottom:getChildByName("btn_bag")--背包
    self.btn_equip = node_bottom:getChildByName("btn_equip")--装备
    self.btn_activity = node_bottom:getChildByName("btn_activity")--活动
    self.btn_set = node_bottom:getChildByName("btn_set")--设置
    self.btn_shop = node_bottom:getChildByName("btn_shop")--商店
    self.btn_title = node_bottom:getChildByName("btn_title")--称号
    self.btn_achievement = node_bottom:getChildByName("btn_achievement")--成就
    self.btn_war = node_bottom:getChildByName("btn_war")--战场
    self.btn_gift = node_bottom:getChildByName("btn_gift")--礼包

    self.btn_fight:addClickEventListener(handler(self, self.click_event))
    self.btn_bag:addClickEventListener(handler(self, self.click_event))
    self.btn_equip:addClickEventListener(handler(self, self.click_event))
    self.btn_activity:addClickEventListener(handler(self, self.click_event))
    self.btn_set:addClickEventListener(handler(self, self.click_event))
    self.btn_shop:addClickEventListener(handler(self, self.click_event))
    self.btn_title:addClickEventListener(handler(self, self.click_event))
    self.btn_achievement:addClickEventListener(handler(self, self.click_event))
    self.btn_war:addClickEventListener(handler(self, self.click_event))
    self.btn_gift:addClickEventListener(handler(self, self.click_event))
end

function layer_main:click_event(btn)
    if btn == self.btn_fight then
        self:show_auto_fight()
    elseif btn == self.btn_bag then
    elseif btn == self.btn_equip then
    elseif btn == self.btn_activity then
    elseif btn == self.btn_set then
    elseif btn == self.btn_shop then
    elseif btn == self.btn_title then
    elseif btn == self.btn_achievement then
    elseif btn == self.btn_war then
    elseif btn == self.btn_gift then
    end
end

function layer_main:show_auto_fight()
    if not self.layer_auto_fight then
        self.layer_auto_fight = layer_auto_fight.new()
        self:addChild(self.layer_auto_fight)
    end
    self.layer_auto_fight:show()
end

return layer_main