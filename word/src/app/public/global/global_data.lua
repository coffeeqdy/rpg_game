local body_data = require("app.public.data.body_data")
local map_config = require("app.public.config.map_config")
local monster_config = require("app.public.config.monster_config")

local global_data = {}

function global_data.load()
    --读取全局变量
    g_data = {}
    g_data.player = {[1]=body_data.new()}
    g_data.language = 0--默认中文
    g_data.gate_id = 1--当前关卡
end

return global_data