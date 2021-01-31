
cc.FileUtils:getInstance():setPopupNotify(false)

local _is_open_debug = true
if _is_open_debug then
    local breakInfoFun,xpCallFun = require("LuaDebugjit")("localhost",7003)
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(breakInfoFun, 0.5, false)
end

function __G__TRACKBACK__(errorMessage)
    local message = errorMessage
    local msg = debug.traceback(errorMessage, 3)
    
    local _node_log = require("app.public.util.lognode")
    if _node_log and _node_log.get_instance() then
        _node_log.get_instance():add_error_log(msg)
    end

    return msg
end

require "config"
require "cocos.init"

local create_log_node = function()
    local _node_log = require("app.public.util.lognode")
    local _print_ = print
    print = function(...)
        _print_(...)
        if _node_log and _node_log.get_instance() then
            local tabStr = {...}
            local _str_print = ""
            for i = 1, #tabStr do
                if type(tabStr[i]) == "userdata" then
                    _str_print = _str_print .. "userdata"
                elseif type(tabStr[i]) == "boolean" then
                    if tabStr[i] then
                        _str_print = _str_print .. "true"
                    else
                        _str_print = _str_print .. "false"
                    end
                elseif type(tabStr[i]) == "table" then
                    _str_print = _str_print .. "table"
                elseif tabStr[i] == nil then
                    _str_print = _str_print .. "nil"
                else
                    _str_print = _str_print .. tabStr[i]
                end
                if i ~= #tabStr then
                    _str_print = _str_print .. ","
                end
            end
            _node_log.get_instance():on_add_str(_str_print)
        end
    end
end

create_log_node()

local function main()
    collectgarbage("collect")   --做一次完整的垃圾收集循环
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    math.randomseed(os.time())
    
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
