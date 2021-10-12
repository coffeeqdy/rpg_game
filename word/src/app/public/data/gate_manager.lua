local gate_config = require("app.public.config")

local gate_manager = class("gate_manager")

local _instance = nil

function gate_manager.get_instance()
    if not _instance then
        _instance = gate_manager.new()
    end
    return _instance
end

function gate_manager:ctor()
    --TODO解析关卡信息
end

function gate_manager:get_gate_info(gate_id)
end

return gate_manager