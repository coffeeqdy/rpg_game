--地图

local global_define = require("app.public.global.global_define")
local ui_observer = require("app.public.util.ui_observer")

local g_move_size = 32--每格的距离
local g_view_width = 352--11格
local g_view_height = 352--11格

local game_map = class("game_map", cc.Node)

function game_map:ctor()
    --先创建好缓存中所需方格
    --后续地图移动只需刷新方格UI即可
    local _cache_col = g_view_width / g_move_size + 4--左右各预留2格
    local _cache_row = g_view_height / g_move_size + 4--上下各预留2格
    
    local _begin_pos_lt = cc.p(-(_cache_col - 1) * g_move_size / 2, -(_cache_row - 1) * g_move_size / 2)--左下角初始角

    self.table_squares = {}
    for i = 1, _cache_col do
        self.table_squares[i] = {}
        for j = 1, _cache_row do
            self.table_squares[i][j] = self:create_square()
            self:addChild(self.table_squares[i][j])
            self.table_squares[i][j]:setPosition(cc.pAdd(_begin_pos_lt, cc.p((i - 1) * g_move_size, (j - 1) * g_move_size)))
        end
    end
end

function game_map:create_square()
    local _square = cc.CSLoader:createNode("game/map_square.csb")
    _square.sprite_square = _square:getChildByName("sprite_square")
    _square.sprite_surprise = _square:getChildByName("sprite_surprise")
    return _square
end

function game_map:on_move_left()
end

function game_map:on_move_right()
end

function game_map:on_move_up()
end

function game_map:on_move_down()
end

return game_map