--服务中心，全局

local public_module = require("app.public.util.public_module")
local base_observer = require("app.public.base.base_observer")
local cmd_define = require("app.public.global.cmd_define")
server_center = class("server_center", base_observer)

function server_center:ctor()
    public_module.append_table(self, "app.server.logon_server")
    public_module.append_table(self, "app.server.game_server")
    public_module.append_table(self, "app.server.user_server")
    public_module.append_table(self, "app.server.prop_server")

    self:register_observer()
end

function server_center:get_listen_list()
    return {
        {cmd_define.main_game, cmd_define.sub_fight_result_req},
        {cmd_define.main_game, cmd_define.sub_find_fight_req},
        {cmd_define.main_game, cmd_define.sub_stop_auto_fight_req},
    }
end

function server_center:on_deal_event(main_id, sub_id, data)
    local _res = self:deal_msg(main_id, sub_id, data)
    if not _res then
        self:send_event(cmd_define.main_system, cmd_define.sub_req_error, {
            main_id = main_id,
            sub_id = sub_id,
            data = data
        })
    end
end

function server_center:deal_msg(main_id, sub_id, data)
    if main_id == cmd_define.main_game then
        return self:deal_game_msg(sub_id, data)
    elseif main_id == cmd_define.main_logon then
        return self:deal_logon_msg(sub_id, data)
    elseif main_id == cmd_define.main_user then
        return self:deal_user_msg(sub_id, data)
    end
    return false
end

server_center.new()