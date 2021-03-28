--游戏角色

local global_define = require("app.public.global.global_define")
local ui_observer = require("app.public.util.ui_observer")

local game_body = class("game_body", cc.Node)

function game_body:ctor()
    self.body_list = {}

    local _sprite = cc.Sprite:create("public_res/toastback.png")
    self:addChild(_sprite)
end

function game_body:on_move_left()
end

function game_body:on_move_right()
end

function game_body:on_move_up()
end

function game_body:on_move_down()
end

return game_body