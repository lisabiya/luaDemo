module("luci.controller.admin.demo", package.seeall)
require "luci.tools.status"
--require("luci.sys")

function index()
    entry({ "admin", "demo" }, firstchild(), "Demo", 60).dependent = false
    entry({ "admin", "demo", "demo1" }, template("demo/index"), "demo1", 2)
    entry({ "admin", "demo", "demo1", "readDemo" }, call("readDemo"))
    entry({ "admin", "demo", "demo1", "test1" }, call("test"))
    entry({ "admin", "demo", "demo1", "testSocket" }, call("testSocket"))

end

function subTable(tabs, start, ends)
    length = #tabs
    newTabs = {}
    for i, v in ipairs(tabs) do
        if i >= start and i < ends then
            table.insert(newTabs, v)
        end
    end
    return newTabs
end

function readDemo()
    if luci.http.formvalue("status") == "1" then
        local rv = {
            uptime = "ceshi",
            leases = luci.tools.status.dhcp_leases(),
            leases6 = subTable(luci.tools.status.dhcp6_leases(), 1, 4),
        }

        luci.http.prepare_content("application/json")
        luci.http.write_json(rv)
        return
    end
end

function test()
    status = luci.http.formvalue("status")
    luci.http.prepare_content("application/json")
    devices = luci.sys.net.devices()
    --wifiList = luci.tools.status.wifi_networks()

    local uci = require "luci.model.uci".cursor()
    key = uci:get("uhttpd", "main", "key")
    env = luci.http.getenv()

    --local ini = require 'luci.tools.ini'
    --settings = ini.parse_file("/usr/app.ini")

    --local nixio = require "nixio"
    --local file, code, msg = nixio.open("/usr/app.ini", "r")
    --if file then
    --    data, code, msg = file:readall(limit)
    --end

    local fs = require "nixio.fs"
    data, code, msg = fs.readfile("/usr/app.ini")

    local json = require "luci.jsonc"

    fs.writefile("/usr/add.ini", json.stringify({ user = "dogger", pass = 123456 }))

    --local file = assert(io.open("/usr/app.ini", 'r'), 'Error loading file : /usr/app.ini');
    --local string = file:read("*all")
    --file:close()

    luci.http.write_json({ msg = "你好", status = status, env = env
    , devices = devices, key = key
    , set = data
    })
end

function testSocket()
    require "nixio"
    response = { "初始化" }
    local socket = nixio.socket("inet", "stream")
    local t = {}
    local tmp
    if not socket then
        response = { false, "创建socket失败" }
    end

    -- 测试连接
    if not socket:connect("175.24.128.25", "8090") then
        socket:close()
        response = { false, "服务无响应，连接服务器失败" }
    end
    -- 发送数据
    --socket:send("lua Socket测试")
    --repeat
    --    tmp = socket:recv(100)
    --
    --    if tmp == false then
    --        socket:close()
    --        return false, "响应超时"
    --    end
    --    tmp = tostring(tmp)
    --    t[#t + 1] = tmp
    --until #tmp < 1
    --socket:close()
    --local result = table.concat(t)
    --response = { true, result }

    luci.http.prepare_content("application/json")
    luci.http.write_json({ response = response })
end
