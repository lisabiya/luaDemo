---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by wkx.
--- DateTime: 2019/5/29 11:00
---
Utils = {}

function printLine(word)
    if type(word) == "nil" then
        word = "divider"
    end
    print("\n********************" .. word .. "*******************************")
end

function maximum (a)
    local min = a[1]            -- 最大值索引
    local max = a[1]          -- 最大值
    for i, val in ipairs(a) do
        if val > max then
            max = val
        end
        if val < min then
            min = val
        end

    end
    return max, min
end

function printWeb()
    local http = require("socket.http")
    local url = "http://www.baidu.com"
    local resp = http.request(url)
    print(string.find(resp, "你"))
    print(string.sub(resp,1389,1391))

end
