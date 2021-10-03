local ui_fight_user = class("ui_fight_user", cc.Node)

function ui_fight_user:ctor()
    self.node_root = cc.CSLoader:createNode()
end

return ui_fight_user