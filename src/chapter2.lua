---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by linzi.
--- DateTime: 2019/5/28 23:50
---
chapter2 = {}

function chapter2.show()
    show1()
end

function show1()
    tab = { key1 = "val1", key2 = "val2" };
    --testFun(tab,
    --        function(key,val)--匿名函数
    --            return key.."="..val;
    --        end
    --);

    testFun(tab, printMe)
end

function printMe(a, b)
    print(a .. "####" .. b)
end

-- function_test2.lua 脚本文件
function testFun(tab, fun)
    for k, v in pairs(tab) do
        print(fun(k, v));
    end
end
