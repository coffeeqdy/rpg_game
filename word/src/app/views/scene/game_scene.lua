
local game_scene = class("game_scene", cc.Layer)
local public_module = require("app.public.util.public_module")
local game_fight_layer = require("app.views.ui.fight.game_fight_layer")
local global_define = require("app.public.global.global_define")
local ui_observer = require("app.public.util.ui_observer")

function game_scene:ctor()
    self:setPosition(display.cx, display.cy)
end

return game_scene
