import os

path_list = {
    1,2,3,4,5,6,7,8,9,10,11,12,13
}

n=0
for k in path_list:
    path = "D:\\rpg_game\\mm2r_ui\\cocosstudio\\game\\res\\map\\world_map" + str(k)
    print(path)
    if os.listdir(path):
        fileList=os.listdir(path)
        m = 0
        for i in fileList:
            oldname=path+ os.sep + fileList[m]
            newname="D:\\rpg_game\\mm2r_ui\\cocosstudio\\game\\res\\map\\world_map\\world_map_" + str(n) + ".png"
            print(oldname,'======>',newname)
            os.rename(oldname,newname)
            m+=1
            n+=1