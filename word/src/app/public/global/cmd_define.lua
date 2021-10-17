local cmd_define = {}

--登陆主命令
cmd_define.main_logon = 1

--用户主命令
cmd_define.main_user = 2

--游戏主命令
cmd_define.main_game = 3
cmd_define.sub_stop_auto_fight_req = 1--停止挂机请求
cmd_define.sub_stop_auto_fight_rsp = 2--停止挂机返回
cmd_define.sub_find_fight_req = 3--搜索战斗请求
cmd_define.sub_find_fight_rsp = 4--搜索战斗返回
cmd_define.sub_fight_result_req = 5--战斗结果请求
cmd_define.sub_fight_result_rsp = 6--战斗结果返回

--系统主命令
cmd_define.main_system = 10
cmd_define.sub_req_error = 1--错误

return cmd_define