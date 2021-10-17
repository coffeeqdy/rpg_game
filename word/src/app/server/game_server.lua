--游戏服务
--主责：战斗模块

local cmd_define = require("app.public.global.cmd_define")
local gate_manager = require("app.public.config.gate_manager")

local game_server = {}

function game_server:deal_game_msg(sub_id, data)
    if sub_id == cmd_define.sub_stop_auto_fight_req then
        self:send_event(cmd_define.main_game, cmd_define.sub_stop_auto_fight_rsp, {})
        return true
    elseif sub_id == cmd_define.sub_find_fight_req then
        if not data then return false end
        local _info = gate_manager.get_instance():get_gate_info(data.gate_id)
        if not _info then return false end
        if not _info.enemy then return false end
        local _index = math.random(1, #_info.enemy)
        self:send_event(cmd_define.main_game, cmd_define.sub_find_fight_rsp, {enemy = _info.enemy[_index]})
        return true
    elseif sub_id == cmd_define.sub_fight_result_req then
        self:send_event(cmd_define.main_game, cmd_define.sub_fight_result_rsp, {})
        return true
    end
    return false
end

return game_server