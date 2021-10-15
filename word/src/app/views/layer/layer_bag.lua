local base_observer = require("app.public.base_observer")
local layer_bag = class("layer_bag", base_observer)

function layer_bag:init()
    self.table_view = cc.TableView:create(self.size_rank_list)
    self.table_view:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.table_view:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.table_view:setPosition(cc.p(0, 0))
    self.table_view:setDelegate()
    self:addChild(self.table_view)
    self.table_view:setBounceable(false);
    self.table_view:registerScriptHandler(handler(self, self.did_scroll), cc.SCROLLVIEW_SCRIPT_SCROLL)
    self.table_view:registerScriptHandler(handler(self, self.get_cell_size), cc.TABLECELL_SIZE_FOR_INDEX)
    self.table_view:registerScriptHandler(handler(self, self.cell_at_index), cc.TABLECELL_SIZE_AT_INDEX)
    self.table_view:registerScriptHandler(handler(self, self.cell_touched), cc.TABLECELL_TOUCHED)
    self.table_view:registerScriptHandler(handler(self, self.number_of_cells), cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
end

--滚动时的回掉函数
function layer_bag:did_scroll(table_view)
end

--列表项的尺寸
function layer_bag:get_cell_size()
    return 60, 60
end

--创建列表项
--index 从0计数
function layer_bag:cell_at_index(table_view, index)
    local _index = index + 1
    local cell = view:dequeueCell()
    if nil == cell then
        cell = cc.TableViewCell:new()
        -- cell:setContentSize(cc.size(self.size_rank_list.width,100))
        local _item = self:create_rank_item()
        _item:setPosition(cc.p(self.size_rank_list.width/2, 95/2))
        _item:setName("glory_battle_rank_item")
        self:render_token_rank_item(_item, _index)
        cell:addChild(_item)
    else
        local _task_item = cell:getChildByName("glory_battle_rank_item")
        self:render_token_rank_item(_task_item, _index)
    end
    return cell
end

--cell点击处理
function layer_bag:cell_touched(table_view, cell)
end

--列表项的数量
function layer_bag:number_of_cells(table_view)
    return 50
end

return layer_bag