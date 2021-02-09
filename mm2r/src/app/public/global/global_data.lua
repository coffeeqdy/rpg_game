local body_data = require("app.public.global.body_data")

local global_data = {}

function global_data.load()
    --读取全局变量
    g_data = {}
    g_data.move_speed = 200
    g_data.player = {[1]=body_data.new()}
end

return global_data