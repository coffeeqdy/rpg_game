local enemy_manager = class("enemy_manager")

local _instance = nil

function enemy_manager.get_instance()
    if not _instance then
        _instance = enemy_manager.new()
    end
    return _instance
end

function enemy_manager:ctor()
    --TODO解析关卡信息
end

function enemy_manager:get_enemy_info(enemy_id)
end

return enemy_manager