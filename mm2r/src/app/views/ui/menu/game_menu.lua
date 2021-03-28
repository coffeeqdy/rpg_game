--游戏菜单（背包、装备等等）

local global_define = require("app.public.global.global_define")
local ui_observer = require("app.public.util.ui_observer")

local game_menu = class("game_menu", cc.Node)

function game_menu:ctor()

end

function game_menu:on_move_left()
end

function game_menu:on_move_right()
end

function game_menu:on_move_up()
end

function game_menu:on_move_down()
end

return game_menu