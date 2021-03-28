local body_data = require("app.public.data.body_data")
local map_config = require("app.public.config.map_config")
local monster_config = require("app.public.config.monster_config")

local global_data = {}

function global_data.load()
    --读取全局变量
    g_data = {}
    g_data.move_speed = 200
    g_data.map_config = map_config
    g_data.monster_config = monster_config
    g_data.player = {[1]=body_data.new()}
    g_data.enemy_attack = 2--敌袭概率
end

return global_data