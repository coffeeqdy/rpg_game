local ui_fight_user = class("ui_fight_user", cc.Node)

function ui_fight_user:ctor()
    self.node_root = cc.CSLoader:createNode("scene/ui_fight_user.csb")

    self.loading_bar = self.node_root:getChildByName("loading_bar")
    self.text_info = self.node_root:getChildByName("text_info")
end

return ui_fight_user