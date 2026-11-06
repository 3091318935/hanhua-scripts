--[[
  Silence Hub V36 汉化版 · 诊断加载器 (CN-LOADER-1)

  用法：整段执行本文件，或
  loadstring(game:HttpGet("https://cdn.jsdelivr.net/gh/3091318935/hanhua-scripts@main/scripts/loader.lua"))()

  设计目标：先无条件弹出一个窗口，再分步下载并执行汉化版脚本。
  这样即使下载失败 / 编译失败 / 运行报错，也一定能看到原因，不会再"什么都不显示"。
]]

local LOADER_VER = "CN-LOADER-1"
local REPO = "3091318935/hanhua-scripts"

local TARGETS = {
	{ n = "jsDelivr v2",        u = "https://cdn.jsdelivr.net/gh/" .. REPO .. "@main/scripts/Silence_Hub_V36_Christmas_CN_v2.lua" },
	{ n = "fastly.jsDelivr v2", u = "https://fastly.jsdelivr.net/gh/" .. REPO .. "@main/scripts/Silence_Hub_V36_Christmas_CN_v2.lua" },
	{ n = "gcore.jsDelivr v2",  u = "https://gcore.jsdelivr.net/gh/" .. REPO .. "@main/scripts/Silence_Hub_V36_Christmas_CN_v2.lua" },
	{ n = "jsDelivr 旧路径",    u = "https://cdn.jsdelivr.net/gh/" .. REPO .. "@main/scripts/Silence_Hub_V36_Christmas_CN.lua" },
	{ n = "raw.githubusercontent", u = "https://raw.githubusercontent.com/" .. REPO .. "/main/scripts/Silence_Hub_V36_Christmas_CN_v2.lua" },
	{ n = "ghfast 镜像",        u = "https://ghfast.top/https://raw.githubusercontent.com/" .. REPO .. "/main/scripts/Silence_Hub_V36_Christmas_CN_v2.lua" },
}

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function pickParent()
	local ok, hui = pcall(function()
		if type(gethui) == "function" then return gethui() end
		return nil
	end)
	if ok and hui then return hui end
	local ok2, cg = pcall(function() return game:GetService("CoreGui") end)
	if ok2 and cg then return cg end
	return playerGui
end

local gui = Instance.new("ScreenGui")
gui.Name = "CNLoaderDiag"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 9999
pcall(function() gui.Parent = pickParent() end)
if not gui.Parent then gui.Parent = playerGui end

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 640, 0, 340)
frame.Position = UDim2.new(0, 60, 0, 80)
frame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(192, 54, 66)
stroke.Thickness = 1
stroke.Transparency = 0.35
stroke.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 34)
title.Position = UDim2.new(0, 14, 0, 6)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(240, 240, 245)
title.Text = "汉化版加载诊断 · " .. LOADER_VER
title.Parent = frame

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -38, 0, 8)
close.BackgroundColor3 = Color3.fromRGB(38, 38, 44)
close.BorderSizePixel = 0
close.Font = Enum.Font.GothamBold
close.TextSize = 16
close.TextColor3 = Color3.fromRGB(240, 240, 245)
close.Text = "X"
close.Parent = frame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = close

local body = Instance.new("TextLabel")
body.Size = UDim2.new(1, -28, 1, -52)
body.Position = UDim2.new(0, 14, 0, 44)
body.BackgroundTransparency = 1
body.Font = Enum.Font.Code
body.TextSize = 14
body.TextWrapped = true
body.TextXAlignment = Enum.TextXAlignment.Left
body.TextYAlignment = Enum.TextYAlignment.Top
body.TextColor3 = Color3.fromRGB(214, 214, 220)
body.Text = ""
body.Parent = frame

close.MouseButton1Click:Connect(function()
	pcall(function() gui:Destroy() end)
end)

local lines = {}
local function log(msg)
	lines[#lines + 1] = tostring(msg)
	while #lines > 20 do table.remove(lines, 1) end
	body.Text = table.concat(lines, "\n")
	pcall(function() print("[CN-LOADER] " .. tostring(msg)) end)
end

local function httpGet(url)
	local methods = {}
	if type(game.HttpGet) == "function" then
		table.insert(methods, function() return game:HttpGet(url, true) end)
	end
	if type(game.HttpGetAsync) == "function" then
		table.insert(methods, function() return game:HttpGetAsync(url) end)
	end
	if type(request) == "function" then
		table.insert(methods, function()
			local r = request({ Url = url, Method = "GET" })
			if type(r) == "table" then return r.Body end
			return r
		end)
	end
	if type(http_request) == "function" then
		table.insert(methods, function()
			local r = http_request({ Url = url, Method = "GET" })
			if type(r) == "table" then return r.Body end
			return r
		end)
	end
	if syn and type(syn.request) == "function" then
		table.insert(methods, function()
			local r = syn.request({ Url = url, Method = "GET" })
			if type(r) == "table" then return r.Body end
			return r
		end)
	end
	local errs = {}
	for _, f in ipairs(methods) do
		local ok, res = pcall(f)
		if ok and type(res) == "string" and #res > 1000 then
			return res
		end
		if not ok then errs[#errs + 1] = tostring(res) end
	end
	if #errs == 0 then errs[#errs + 1] = "执行器没有可用的 HTTP 方法" end
	return nil, table.concat(errs, " | ")
end

task.spawn(function()
	local funcs = pcall(function()
		local name = "未知"
		if type(identifyexecutor) == "function" then
			local ok2, n = pcall(identifyexecutor)
			if ok2 and type(n) == "string" then name = n end
		end
		log("执行器：" .. name)
		log("开始下载汉化版脚本…")

		local src, used = nil, nil
		for _, t in ipairs(TARGETS) do
			log("→ " .. t.n)
			local body, err = httpGet(t.u)
			if body then
				log("  已下载 " .. tostring(#body) .. " 字节")
				if body:find('game:GetService("统计")', 1, true) then
					log("  × 旧版文件（含 Service(\"统计\")），跳过")
				elseif not body:find("UPDATE_LOGS", 1, true) then
					log("  × 内容不完整，跳过")
				else
					src = body
					used = t.n
					break
				end
			else
				local e = tostring(err)
				if #e > 70 then e = e:sub(1, 70) .. "…" end
				log("  × 失败：" .. e)
			end
		end

		if not src then
			log("结论：所有镜像都取不到文件。")
			log("多半是执行器的 HttpGet 被限制，或全部域名被墙。")
			return
		end

		log("来源：" .. tostring(used) .. "（已确认是新版）")
		local fn, lerr = loadstring(src)
		if not fn then
			log("编译失败：" .. tostring(lerr))
			return
		end
		log("编译通过，开始执行…")

		local ok, rerr = pcall(fn)
		if ok then
			log("执行完成，未抛错。")
		else
			log("运行报错：" .. tostring(rerr))
			return
		end

		task.wait(1.5)
		local found = false
		for _, d in ipairs(playerGui:GetDescendants()) do
			if d:IsA("ScreenGui") and d.Name ~= "CNLoaderDiag" and d.Enabled then
				found = true
				break
			end
		end
		if found then
			log("已检测到脚本界面 ✔ 按 RightShift 或点圆形按钮开关。")
			task.delay(8, function()
				pcall(function() gui:Destroy() end)
			end)
		else
			log("执行没有报错，但没看到新界面。")
			log("请把这整段内容截图发给我。")
		end
	end)
	if not funcs then
		log("加载器自身出错：" .. tostring(funcs))
	end
end)
