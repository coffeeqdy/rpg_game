
local LogNode = class("LogNode",cc.Node)

local MAX_LEN = 680
local _num_tag_label = 10
function LogNode:ctor()
    local _node_view = cc.Node:create()
    self:addChild(_node_view)
    self.node_view = _node_view

    local _layer_bg = cc.LayerColor:create(cc.c4b(255,255,255,255),MAX_LEN+40,600)
    _node_view:addChild(_layer_bg)

    self:init_ui()
    self:register_touch_event()
    self:register_change_scene()

    --初始默认不显示
    self.node_view:setVisible(false)
end

local _instance = nil

function LogNode:get_instance()
    if not _instance then
        local _node = nil
        local _scene = cc.Director:getInstance():getRunningScene()
        if _scene then
            _node = _scene:getChildByName("error_log_node")
        end
        if _node then
            _instance = _node
        else
            _instance = LogNode.new()
            _instance:retain()
            _instance:setName("error_log_node")
        end
    end
    return _instance
end

function LogNode:init_ui()
    self.listView = ccui.ListView:create()
    self.listView:setContentSize(MAX_LEN+20,600)
    self.listView:setPosition(20,0)
    self.node_view:addChild(self.listView)

    ---纵向按钮---
    local _table_btn_v = {
        {"关闭",function() self.node_view:setVisible(false) end},
        {"搜索路径",function() self:on_print_search_path() end},
        {"lua内存占用",function() self:on_print_lua_memory() end},
        {"纹理内存占用",function() self:on_print_memory() end},
        {"error",function() self:on_show_error_log() end},
        {"warning",function() self:on_show_warning_log() end},
        {"清理日志",function() self.listView:removeAllChildren() end},
        {"日志关\n点击打开",function(_sender)
            self.bool_is_open_log = not self.bool_is_open_log
            local _label_switch = _sender:getChildByTag(_num_tag_label)
            if self.bool_is_open_log then
                _label_switch:setString("日志开\n点击关闭")
            else
                _label_switch:setString("日志关\n点击打开")
            end
        end},
    }
    self.bool_is_open_log = false   --  默认不开启日志
    for i = 1, #_table_btn_v do
        local _btn_v = ccui.Layout:create()
        _btn_v:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        _btn_v:setBackGroundColor(cc.c3b(100,100,100))
        _btn_v:setContentSize(100,50)
        local _label_content = cc.Label:create()
        _label_content:setString(_table_btn_v[i][1])
        _label_content:setPosition(50,25)
        _label_content:setTag(_num_tag_label)
        _btn_v:addChild(_label_content)
        _btn_v._func_callback = _table_btn_v[i][2]
        self.node_view:addChild(_btn_v)
        _btn_v:setPosition(MAX_LEN+40 + (math.floor((i - 1) / 8) * 110),550 - (i - 1) % 8 * 65)
        _btn_v:setTouchEnabled(true)
        _btn_v:addTouchEventListener(function(_sender,_state,_touch)
            if _state == ccui.TouchEventType.began then
                if _sender._func_callback then
                    _sender._func_callback(_sender)
                end
            end
        end)
    end

    ---横向按钮---从右向左布局
    local _table_btn_h = {
        {"帧率关",function(_sender)
            self.bool_is_open_frame = not self.bool_is_open_frame
            local _label_switch = _sender:getChildByTag(_num_tag_label)
            if self.bool_is_open_frame then
                _label_switch:setString("帧率开")
            else
                _label_switch:setString("帧率关")
            end
            cc.Director:getInstance():setDisplayStats(self.bool_is_open_frame)
        end},
        {"清理缓存",function(_sender)
            local _is_success, _str = pcall(cc.UserDefault:getInstance().getXMLFilePath, cc.UserDefault:getInstance())
            if _is_success then
                cc.FileUtils:getInstance():removeFile(_str)
                self:on_print_string("清理缓存完成")
            else
                self:on_print_string("清理缓存失败，本环境不支持")
            end
        end},
    }
    self.bool_is_open_frame = false     --  默认不开启帧率显示
    for i = 1, #_table_btn_h do
        local _btn_h = ccui.Layout:create()
        _btn_h:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        _btn_h:setBackGroundColor(cc.c3b(100,100,100))
        _btn_h:setContentSize(100,50)
        local _label_content = cc.Label:create()
        _label_content:setString(_table_btn_h[i][1])
        _label_content:setPosition(50,25)
        _label_content:setTag(_num_tag_label)
        _btn_h:addChild(_label_content)
        _btn_h._func_callback = _table_btn_h[i][2]
        self.node_view:addChild(_btn_h)
        _btn_h:setPosition(MAX_LEN-70 - (i - 1) * 120,600)
        _btn_h:setTouchEnabled(true)
        _btn_h:addTouchEventListener(function(_sender,_state,_touch)
            if _state == ccui.TouchEventType.began then
                if _sender._func_callback then
                    _sender._func_callback(_sender)
                end
            end
        end)
    end
end

function LogNode:register_touch_event()
    local _ccp_begin = nil
    local on_touch_began = function(touch, event)
        if self.node_view:isVisible() then
            return false
        end
        _ccp_begin = touch:getLocation()
        if _ccp_begin.x > 100 then
            _ccp_begin = nil
            return false
        else
            return true
        end
    end
    local on_touch_moved = function(touch, event)
    end
    local on_touch_ended = function(touch, event)
        if not _ccp_begin then return end
        local _ccp_end = touch:getLocation()
        if _ccp_end.x - _ccp_begin.x >= 100 then
            self.node_view:setVisible(true)
            self:on_print_all_string()
        else
            self.node_view:setVisible(false)
        end
        _ccp_begin = nil
    end
    local on_touch_cancelled = function(touch, event)
        _ccp_begin = nil
    end

    --触摸事件监听
	local _eventListener_touch = cc.EventListenerTouchOneByOne:create()
    _eventListener_touch:setSwallowTouches(false)
    _eventListener_touch:registerScriptHandler(on_touch_began,cc.Handler.EVENT_TOUCH_BEGAN )
    _eventListener_touch:registerScriptHandler(on_touch_moved,cc.Handler.EVENT_TOUCH_MOVED )
    _eventListener_touch:registerScriptHandler(on_touch_ended,cc.Handler.EVENT_TOUCH_ENDED )
    _eventListener_touch:registerScriptHandler(on_touch_cancelled,cc.Handler.EVENT_TOUCH_CANCELLED )
    self.eventListener_touch = _eventListener_touch
    
	local _eventDispather = self:getEventDispatcher()
	_eventDispather:addEventListenerWithSceneGraphPriority(self.eventListener_touch, self)
end

function LogNode:on_print_string(_str)
    local _number_count = self.listView:getChildrenCount()
    if _number_count == 100 then
        self.listView:removeItem(0)
    end
    
    local _text = ccui.Text:create("","fonts/FZZY.TTF",24)
    _text:setTextColor(cc.c3b(0,0,0))
    _text:ignoreContentAdaptWithSize(true)
    _text:setTextAreaSize(cc.size(MAX_LEN, 0))
    _text:setString(_str)
    _text:addClickEventListener(function()
        local public_module = require("app.public.util.public_module")
        public_module.copy_string(_str)
    end)
    _text:setTouchEnabled(true)
    self.listView:pushBackCustomItem(_text)
    self.listView:jumpToBottom()
end

function LogNode:on_add_str(_str)
    if self.bool_is_open_log then
        --这里提供了打印日志的两种方式
        --方式1：如果日志显示节点当前是隐藏的则加入到打印列表等待下次显示节点的时候再一次性打印出来
        -- if self.node_view:isVisible() then
        --     self:on_print_string(_str)
        -- else
        --     self.table_log = self.table_log or {}
        --     self.table_log[#self.table_log + 1] = _str
        -- end
        --方式2：来一条日志就打印一条
        self:on_print_string(_str)
    end
end

function LogNode:on_print_all_string()
    self.table_log = self.table_log or {}
    for i = 1, #self.table_log do
        self:on_print_string(self.table_log[i])
    end
    self.table_log = {}
end

function LogNode:register_change_scene()
    local _eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    local _eventListener_custom = cc.EventListenerCustom:create("director_after_set_next_scene",
    handler(self, function()
        self:on_change_scene()
    end))
    _eventDispatcher:addEventListenerWithFixedPriority(_eventListener_custom, 2)
end

function LogNode:on_change_scene()
    if self:getParent() then
        self:removeFromParent()
    end
    cc.Director:getInstance():getRunningScene():addChild(self,100000)
end

function LogNode:on_print_search_path()
    local _path = cc.FileUtils:getInstance():getSearchPaths()
    self:on_print_string(">>>>>搜索路径<<<<<")
    for i,v in pairs(_path) do
        if v then
            self:on_print_string(v)
        end
    end
end

function LogNode:on_print_texture_memory()
    local _str = cc.Director:getInstance():getTextureCache():getCachedTextureInfo()
    local _table_strSplit = string.split(_str,"\n")
    for i = 1, #_table_strSplit do
        if _table_strSplit[i] then
            self:on_print_string(_table_strSplit[i])
        end
    end
end

function LogNode:on_print_lua_memory()
    local _count = collectgarbage("count")
    self:on_print_string("lua内存占用>>>" .. _count)
end

function LogNode:on_print_memory()
    local _str = cc.Director:getInstance():getTextureCache():getCachedTextureInfo()
    local _number_length = string.len(_str)
    local _number_began,_number_ended = string.find( _str,"TextureCache dumpDebugInfo",_number_length - 100)
    if _number_began and _number_ended then
        local _number_KB_begin,_number_KB_end = string.find(_str,"KB",_number_ended)
        local _number_MB_begin,_number_MB_end = string.find(_str,"MB",_number_KB_end)
        local _str_new = string.sub(_str,_number_KB_end+1,_number_MB_begin-1)
        _str_new = string.gsub(_str_new,"[(]","")
        _str_new = string.gsub(_str_new," ","")
        local _str_final = string.format("现在内存是: %sM", _str_new)
        self:on_print_string(_str_final)
    else
        self:on_print_string("未获取到内存数据")
    end
end

function LogNode:add_error_log(_str)
    self.table_error_str = self.table_error_str or {}
    --只保留最先10条报错日志（防止错误循环保存导致数据过大而卡顿）
    if #self.table_error_str < 10 then
        self.table_error_str[#self.table_error_str + 1] = _str
    end
    --报错直接弹提示
    local public_module = require("app.public.util.public_module")
    public_module.show_error_dlg(_str)
end

function LogNode:on_show_error_log()
    if self.table_error_str and next(self.table_error_str) then
        self.listView:removeAllChildren()
        for i = 1, #self.table_error_str do
            self:on_print_string(self.table_error_str[i])
            self:on_print_string("----------------我是分割线----------------")
        end
    else
        self:on_print_string("暂无错误日志")
    end
end

function LogNode:add_warning_log(msg)
    self.table_warning_str = self.table_warning_str or {}
    --只保留最先10条报错日志（防止错误循环保存导致数据过大而卡顿）
    if #self.table_warning_str < 30 then
        self.table_warning_str[#self.table_warning_str + 1] = msg
    end
end

function LogNode:on_show_warning_log()
    if self.table_warning_str and next(self.table_warning_str) then
        self.listView:removeAllChildren()
        for i = 1, #self.table_warning_str do
            self:on_print_string(self.table_warning_str[i])
        end
    else
        self:on_print_string("暂无warning日志")
    end
end

function LogNode:on_dump_log(tab,space)
    space = space or 0
    for i, v in pairs(tab) do
        if type(v) == "table" then
            self:on_dump_log(v,space + 1)
        else
            local _str_space = ""
            for i = 1, space do
                _str_space = _str_space .. "  "
            end
            self:on_print_string(_str_space .. i .. "=" .. v)
        end
    end
end

function LogNode:clear_warning_log()
    self.table_warning_str = {}
end

return LogNode