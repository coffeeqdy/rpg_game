local body_data = require("app.public.data.body_data")

local global_data = {}

function global_data.load()
    --读取全局变量
    g_data = {}
    g_data.player = {[1]=body_data.new()}
    g_data.language = 0--默认中文
    g_data.gate_id = 1--当前关卡
    g_data.wait_time = 3--找怪等待时间
end

return global_data