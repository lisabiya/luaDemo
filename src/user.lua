---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by wkx.
--- DateTime: 2019/5/28 17:44
---

user = {}


-- 定义一个常量
user.constant = "这是一个常量"

function user.func1()
    io.write("这是一个公有函数！\n")
    io.write("这是一个公有函数！\n")
    io.write("这是一个公有函数！\n")
end

local function func2()
    print("这是一个私有函数！")
end

function user.func3()
    func2()
end

user.html = [[
<html>
<head></head>
<body>
    <a href="http://www.runoob.com/">菜鸟教程</a>
</body>
</html>
]]