
cc.FileUtils:getInstance():setPopupNotify(false)

local _is_open_debug = true
if _is_open_debug then
    local breakInfoFun,xpCallFun = require("LuaDebugjit")("localhost",7003)
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(breakInfoFun, 0.5, false)
end

function __G__TRACKBACK__(errorMessage)
    local message = errorMessage
    local msg = debug.traceback(errorMessage, 3)
    
    if DEBUG ~= 0 then
        local tool_board = require("app.public.util.tool_board")
        if tool_board and tool_board.get_instance() then
            tool_board.get_instance():add_error_log(msg)
        end
    end

    return msg
end

require "config"
require "cocos.init"
--不调用输出
if DEBUG == 0 then
    print = function()
    end
    dump = function()
    end
    release_print = function()
    end
else
    local tool_board = require("app.public.util.tool_board")
    local _print_ = print
    print = function(...)
        _print_(...)
        if tool_board and tool_board.get_instance() then
            tool_board.get_instance():on_add_str({...})
        end
    end
end

local function main()
    collectgarbage("collect")   --做一次完整的垃圾收集循环
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    math.randomseed(os.time())

    require("app.public.global.global_data").load()--全局变量加载
    require("app.server.server_center")--服务中心加载
    
    if CC_SHOW_FPS then
        cc.Director:getInstance():setDisplayStats(true)
    end
    local scene = cc.Scene:create()
    local _layer = require("app.views.scene.game_scene").new()
    scene:addChild(_layer)
    cc.Director:getInstance():runWithScene(scene)
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
