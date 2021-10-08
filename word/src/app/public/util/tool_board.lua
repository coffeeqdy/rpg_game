
local public_module = require("app.public.util.public_module")
local string_config = require("app.public.string_config.string")

local tool_board = class("tool_board",cc.Node)

local _num_tag_label = 10
function tool_board:init_right_btns()
    self.table_btn_v = {
        {"搜索路径",1,function() self:on_print_search_path() end},
        {"lua内存占用",2,function() self:on_print_lua_memory() end},
        {"纹理内存占用",3,function() self:on_print_memory() end},
        {"error",4,function() self:on_show_error_log() end},
        {"warning",5,function() self:on_show_warning_log() end},
        {"清理日志",6,function() self.listView:removeAllChildren() end},
        {"日志关\n点击打开",7,function(_sender)
            self.bool_is_open_log = not self.bool_is_open_log
            local _label_switch = _sender:getChildByTag(_num_tag_label)
            if self.bool_is_open_log then
                _label_switch:setString("日志开\n点击关闭".."("..(_sender.btn_index or "")..")")
            else
                _label_switch:setString("日志关\n点击打开".."("..(_sender.btn_index or "")..")")
            end
        end},
        {"全局倒计时",8,function()
            self:on_print_string("全局倒计时列表")
            local ServerTimer = require("app.public.data.ServerTimer")
            local _time_table = ServerTimer.getInstance():get_all_time_table() or {}
            for i,v in pairs(_time_table) do
                self:on_print_string("["..(v.tag or "no-tag").."]---" .. (v.total_time - v.current_time))
            end
        end},
        {"帧率关",9,function(_sender)
            self.bool_is_open_frame = not self.bool_is_open_frame
            local _label_switch = _sender:getChildByTag(_num_tag_label)
            if self.bool_is_open_frame then
                _label_switch:setString("帧率开".."("..(_sender.btn_index or "")..")")
            else
                _label_switch:setString("帧率关".."("..(_sender.btn_index or "")..")")
            end
            cc.Director:getInstance():setDisplayStats(self.bool_is_open_frame)
        end},
        {"测试",10,function(sender)
        end},
    }
end

local MAX_LEN = 680
local public_toast_text = require("app.public.tips.public_toast_text")
function tool_board:ctor()
    local _node_view = cc.Node:create()
    self:addChild(_node_view)
    _node_view:setPosition(0, 50)
    self.node_view = _node_view

    local _layer_bg = cc.LayerColor:create(cc.c4b(255,255,255,255),MAX_LEN+40,600)
    _node_view:addChild(_layer_bg)
    self:init_right_btns()
    self:init_ui()
    self:register_touch_event()
    self:register_change_scene()

    --初始默认不显示
    self.node_view:setVisible(false)
end

local _instance = nil

function tool_board:get_instance()
    if not _instance then
        local _node = nil
        local _scene = cc.Director:getInstance():getRunningScene()
        if _scene then
            _node = _scene:getChildByName("error_log_node")
        end
        if _node then
            _instance = _node
        else
            _instance = tool_board.new()
            _instance:retain()
            _instance:setName("error_log_node")
            if _scene then
                _scene:addChild(_instance)
            end
        end
    end
    return _instance
end

function tool_board:init_ui()
    self.listView = ccui.ListView:create()
    self.listView:setContentSize(MAX_LEN+20,600)
    self.listView:setPosition(20,0)
    self.node_view:addChild(self.listView)

    ---纵向按钮---
    self.bool_is_open_log = false   --  默认不开启日志
    self.bool_is_open_MQ = true     --  默认开启MQ
    self.bool_is_open_frame = false     --  默认不开启帧率显示

    ---横向按钮---从右向左布局
    local _table_btn_h = {
        {"关闭",function() self.node_view:setVisible(false) end},
        {"账号信息",function()end},
        {"环境信息",function(_sender)
            self:on_print_string("可写目录 >>>> " .. cc.FileUtils:getInstance():getWritablePath(),nil,true)
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
    for i = 1, #_table_btn_h do
        local _btn_h = ccui.Layout:create()
        _btn_h:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        _btn_h:setBackGroundColor(cc.c3b(100,100,100))
        _btn_h:setContentSize(110,50)
        local _label_content = ccui.Text:create(_table_btn_h[i][1],"fonts/FZZY.TTF",20)
        _label_content:setPosition(55,25)
        _label_content:setTag(_num_tag_label)
        _label_content:setTextHorizontalAlignment(1)
        _btn_h:addChild(_label_content)
        _btn_h._func_callback = _table_btn_h[i][2]
        self.node_view:addChild(_btn_h)
        _btn_h:setPosition(MAX_LEN-80 - (i - 1) * 115,600)
        _btn_h:setTouchEnabled(true)
        _btn_h:addTouchEventListener(function(_sender,_state,_touch)
            if _state == ccui.TouchEventType.began then
                if _sender._func_callback then
                    _sender._func_callback(_sender)
                end
            end
        end)
    end
    self.node_right_ui = cc.Node:create()
    self.node_view:addChild(self.node_right_ui)
    self.table_btns = {}
    local _str = cc.UserDefault:getInstance():getStringForKey("tool_board_use_btns","none")
    if _str == "none" then
        self:add_all_btns()
    else
        local _tab = string.split(_str,",")
        for i = 1, #_tab do
            self:add_btn(tonumber(_tab[i]))
        end
    end
    self:render_btns_ui()

    --输入
    local _layout = ccui.Layout:create()
    _layout:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
    _layout:setBackGroundColor(cc.c3b(200,200,200))
    _layout:setContentSize(MAX_LEN-100,50)
    _layout:setAnchorPoint(0, 1)
    _layout:setPosition(0,0)
    _layout:setTouchEnabled(false)
    self.node_view:addChild(_layout)
    self.edit_box = ccui.EditBox:create(cc.size(MAX_LEN-100, 50),"PublicRes/BtnBack.png")
    self.edit_box:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
    self.edit_box:setAnchorPoint(0, 1)
    self.edit_box:setPosition(0,0)
    self.edit_box:setPlaceHolder("控制台输入")
    self.node_view:addChild(self.edit_box)
	self.edit_box:registerScriptEditBoxHandler(function(type,editbox,...)
        -- self:on_print_string("type="..type)
        -- self:on_print_string("["..editbox:getText().."]")
        -- self:on_dump_log({...})
    end)
    local _btn_send = ccui.Layout:create()
    _btn_send:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
    _btn_send:setBackGroundColor(cc.c3b(200,66,66))
    _btn_send:setContentSize(120,50)
    _btn_send:setAnchorPoint(0, 1)
    _btn_send:setPosition(MAX_LEN-80,0)
    _btn_send:setTouchEnabled(true)
    self.node_view:addChild(_btn_send)
    local _label_content = ccui.Text:create("Enter","fonts/FZZY.TTF",20)
    _label_content:setPosition(60,25)
    _label_content:setTag(_num_tag_label)
    _label_content:setTextHorizontalAlignment(1)
    _btn_send:addChild(_label_content)
    _btn_send:addTouchEventListener(function(_sender,_state,_touch)
        if _state == ccui.TouchEventType.began then
            local _str = self.edit_box:getText()
            if _str == "" then return end
            self:on_parse_console_command(_str)
        end
    end)
end

function tool_board:on_parse_console_command(str)
    if string.sub(str,1,5) == "-add " then
        local _id = tonumber(string.sub(str,6,-1))
        if _id and self:add_btn(_id) then
            self:save_btns()
            self:render_btns_ui()
            self:on_print_string("新增按钮成功" .. _id)
        else
            self:on_print_string("新增按钮失败")
        end
    elseif string.sub(str,1,8) == "-remove " then
        local _id = tonumber(string.sub(str,9,-1))
        if _id and self:remove_btn(_id) then
            self:save_btns()
            self:render_btns_ui()
            self:on_print_string("移除按钮成功" .. _id)
        else
            self:on_print_string("移除按钮失败")
        end
    elseif string.sub(str,1,5) == "-show" then
        self:on_print_string("所有可用功能及对应id如下：")
        for i = 1, #self.table_btn_v do
            self:on_print_string(self.table_btn_v[i][1].."----"..self.table_btn_v[i][2])
        end
    elseif string.sub(str,1,8) == "-add all" then
        self:add_all_btns()
        self:save_btns()
        self:render_btns_ui()
        self:on_print_string("添加所有功能成功")
    elseif string.sub(str,1,11) == "-remove all" then
        self.table_btns = {}
        self:save_btns()
        self:render_btns_ui()
        self:on_print_string("移除所有功能成功")
    elseif string.sub(str,1,7) == "-event " then
        local _tab = string.split(str, " ")
        local ui_observer = require("app.public.util.ui_observer")
        ui_observer.get_instance():send_event(_tab[2], _tab[3])
        self:on_print_string("发送事件" .. _tab[2] .. "-" .._tab[3])
    elseif string.sub(str, 1, 5) == "-help" then
        self:on_print_string("----------------help----------------\n",nil,true)
        self:on_print_string("*注* 除help之外所有指令后面要加一个空格，否则无法识别",nil,true)
        self:on_print_string("-add 增加按钮（例：-add 11）",nil,true)
        self:on_print_string("-remove 移除按钮（例：-remove 11）",nil,true)
        self:on_print_string("-show 显示所有按钮及id（例：-show）",nil,true)
        self:on_print_string("-add all 添加所有按钮（例：-add all）",nil,true)
        self:on_print_string("-remove all 移除所有按钮（例：-remove all）",nil,true)
        self:on_print_string("\n----------------help----------------",nil,true)
    else
        self:on_print_string(str)
    end
end

function tool_board:register_touch_event()
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

function tool_board:on_print_string(_str, color, is_ignore)
    local _number_count = self.listView:getChildrenCount()
    if _number_count == 1000 then
        self.listView:removeItem(0)
    end

    if not is_ignore then
        _str = _str .."   【".. os.date().."】"
    end
    
    local _text = ccui.Text:create(_str,"fonts/FZZY.TTF",24)
    _text:setTextColor(color or cc.c3b(0,0,0))
    _text:ignoreContentAdaptWithSize(true)
    _text:setTextAreaSize(cc.size(MAX_LEN, 0))
    _text:addClickEventListener(function()
        public_module.copy_string(_str)
        public_module.toast(string_config.copy_success)
    end)
    _text:setTouchEnabled(true)
    self.listView:pushBackCustomItem(_text)
    self.listView:jumpToBottom()
end

function tool_board:on_add_str(tabStr)
    if self.bool_is_open_log then
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
        self:on_print_string(_str_print)
    end
    if tabStr[1] == 1 then
        self:on_print_string("[1]print" .. (tabStr[2] or ""),cc.c3b(255,66,66))
    elseif tabStr[1] == 2 then
        self:on_print_string("[2]print" .. (tabStr[2] or ""),cc.c3b(155,155,55))
    elseif tabStr[1] == 3 then
        self:on_print_string("[3]print" .. (tabStr[2] or ""),cc.c3b(66,66,255))
    elseif tabStr[1] == 4 then
        self:on_print_string("[4]print" .. (tabStr[2] or ""))
    end
end

function tool_board:on_print_all_string()
    self.table_log = self.table_log or {}
    for i = 1, #self.table_log do
        self:on_print_string(self.table_log[i])
    end
    self.table_log = {}
end

function tool_board:register_change_scene()
    local _eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    local _eventListener_custom = cc.EventListenerCustom:create("director_after_set_next_scene",
    handler(self, function()
        self:on_change_scene()
    end))
    _eventDispatcher:addEventListenerWithFixedPriority(_eventListener_custom, 2)
end

function tool_board:on_change_scene()
    if self:getParent() then
        self:removeFromParent()
    end
    cc.Director:getInstance():getRunningScene():addChild(self,100000)
end

function tool_board:on_print_search_path()
    local _path = cc.FileUtils:getInstance():getSearchPaths()
    self:on_print_string(">>>>>搜索路径<<<<<")
    for i,v in pairs(_path) do
        if v then
            self:on_print_string(v)
        end
    end
end

function tool_board:on_print_texture_memory()
    local _str = cc.Director:getInstance():getTextureCache():getCachedTextureInfo()
    local _table_strSplit = string.split(_str,"\n")
    for i = 1, #_table_strSplit do
        if _table_strSplit[i] then
            self:on_print_string(_table_strSplit[i])
        end
    end
end

function tool_board:on_print_lua_memory()
    local _count = collectgarbage("count")
    self:on_print_string("lua内存占用>>>" .. _count)
end

function tool_board:on_print_memory()
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

function tool_board:add_error_log(_str, is_ignore)
    self.table_error_str = self.table_error_str or {}
    --只保留最先10条报错日志（防止错误循环保存导致数据过大而卡顿）
    if #self.table_error_str < 10 then
        self.table_error_str[#self.table_error_str + 1] = _str
    else
        return
    end
    --报错直接弹提示
    if is_ignore then return end
    public_module.show_error_dlg(_str)
end

function tool_board:on_show_error_log()
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

function tool_board:add_warning_log(msg)
    self.table_warning_str = self.table_warning_str or {}
    --只保留最先10条报错日志（防止错误循环保存导致数据过大而卡顿）
    if #self.table_warning_str < 30 then
        self.table_warning_str[#self.table_warning_str + 1] = msg
    end
end

function tool_board:on_show_warning_log()
    if self.table_warning_str and next(self.table_warning_str) then
        self.listView:removeAllChildren()
        for i = 1, #self.table_warning_str do
            self:on_print_string(self.table_warning_str[i])
        end
    else
        self:on_print_string("暂无warning日志")
    end
end

function tool_board:on_dump_log(tab,space)
    space = space or 0
    for i, v in pairs(tab) do
        local _key = tostring(i)
        if string.sub(_key,1,2) ~= "__" then
            local _str_space = ""
            for i = 1, space do
                _str_space = _str_space .. "　　"
            end
            if type(v) == "table" then
                self:on_print_string(_str_space .. i .. "= {",nil,true)
                self:on_dump_log(v,space + 1)
                self:on_print_string(_str_space .. "}",nil,true)
            else
                if type(v) == "function" then
                    self:on_print_string(_str_space .. i .. "=function",nil,true)
                elseif type(v) == "userdata" then
                    self:on_print_string(_str_space .. i .. "=userdata",nil,true)
                elseif type(v) == "boolean" then
                    self:on_print_string(_str_space .. i .. "=" .. (v and "true" or "false"),nil,true)
                elseif type(v) == "string" then
                    self:on_print_string(_str_space .. i .. "=\"" .. v.."\"",nil,true)
                else
                    self:on_print_string(_str_space .. i .. "=" .. (v or "nil"),nil,true)
                end
            end
        end
    end
end

function tool_board:add_btn(id)
    for i = 1, #self.table_btns do
        if self.table_btns[i][2] == id then
            return false
        end
    end
    for i = 1, #self.table_btn_v do
        if self.table_btn_v[i][2] == id then
            self.table_btns[#self.table_btns + 1] = self.table_btn_v[i]
            break
        end
    end
    table.sort(self.table_btns,function(v1,v2)
        return v1[2] < v2[2]
    end)
    return true
end

function tool_board:remove_btn(id)
    for i = 1, #self.table_btns do
        if self.table_btns[i][2] == id then
            table.remove(self.table_btns, i)
            return true
        end
    end
    return false
end

function tool_board:add_all_btns()
    self.table_btns = {}
    for i = 1, #self.table_btn_v do
        self.table_btns[i] = self.table_btn_v[i]
    end
end

function tool_board:render_btns_ui()
    self.node_right_ui:removeAllChildren()
    for i = 1, #self.table_btns do
        local _btn_v = ccui.Layout:create()
        _btn_v:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        _btn_v:setBackGroundColor(cc.c3b(100,100,100))
        _btn_v:setContentSize(150,50)
        local _label_content = ccui.Text:create(self.table_btns[i][1].."("..self.table_btns[i][2]..")","fonts/FZZY.TTF",20)
        _label_content:setPosition(75,25)
        _label_content:setTag(_num_tag_label)
        _label_content:setTextHorizontalAlignment(1)
        _btn_v:addChild(_label_content)
        _btn_v._func_callback = self.table_btns[i][3]
        _btn_v.btn_index = self.table_btns[i][2]
        self.node_right_ui:addChild(_btn_v)
        _btn_v:setPosition(MAX_LEN+40 + (math.floor((i - 1) / 8) * 160),550 - (i - 1) % 8 * 65)
        _btn_v:setTouchEnabled(true)
        _btn_v:addTouchEventListener(function(_sender,_state,_touch)
            if _state == ccui.TouchEventType.began then
                if _sender._func_callback then
                    _sender._func_callback(_sender)
                end
            end
        end)
    end
end
function tool_board:save_btns()
    local _str = ""
    for i = 1, #self.table_btns do
        _str = _str .. self.table_btns[i][2]
        if i ~= #self.table_btns then
            _str = _str .. ","
        end
    end
    cc.UserDefault:getInstance():setStringForKey("tool_board_use_btns",_str)
end

function tool_board:clear_warning_log()
    self.table_warning_str = {}
end

return tool_board
