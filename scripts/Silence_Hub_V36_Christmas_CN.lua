-- Silence hub / WH1T3 GUI
-- doors mods + tools, saves stuff to workspace if your executor can writefile

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local GUI_NAME = "SilenceHub"

-- "hub" is a small toolbox your buttons can use, e.g. hub.notify("你好！")
-- (it gets filled in further down, after the UI exists)
local hub = { player = player }

--   edit this part     (buttons, credits, descriptions)
--
-- Every button is a table with these fields:
--   name        = text shown on the button
--   description = what shows when you tap the three dots
--   confirm     = true  -> asks "确定吗？" before running
--   confirmText = (optional) your own "are you sure" message
--   icon        = (optional) emoji shown before the name
--   run         = the code that runs when the button is pressed
--
-- To add a button: copy one block, paste it under the last one
-- (don't forget the comma after the closing brace!), change the text.

-- Name shown in the title bar and on the loading screen
local HUB_TITLE = "Silence Hub"

-- Keys that show/hide the hub (the floating  always works too).
-- Want the old key back? Use:  { Enum.KeyCode.RightShift, Enum.KeyCode.F }
local TOGGLE_KEYS = { Enum.KeyCode.RightShift }


-- Messages printed in the Roblox chat when the hub finishes loading
local CHAT_ANNOUNCE = true
local CHAT_MESSAGES = {
	"<b><font color='rgb(192, 54, 66)'>Silence Hub 已加载</font></b>",
	"<b><font color='rgb(192, 54, 66)'>站长：Rip_Silence (#idkman06483)  |  副站长：WH1T3 (#relayhost) </font></b>",
	"<b><font color='rgb(192, 54, 66)'>界面：WH1T3（副站长）   |   聊天签名文案：RealblueYT</font></b>",
	"<b><font color='rgb(192, 54, 66)'>V36 更新来晚了，感谢等待！</font></b>",
}

-- Big intro text over Doors' own menu (does nothing outside Doors)
local SHOW_DOORS_INTRO = true
local DOORS_INTRO_TEXT = "Silence Hub"

-- Scripts that get a 🆕 badge (and show up in Home > NEW SCRIPTS). Use the exact script name.
-- Next update: clear this list and add the new names.
local NEW_SCRIPTS = {
	["疯狂模式 1.2"] = true,
	["懒得写说明了"] = true,
}

--  BACKGROUND MUSIC  (you DON'T need to edit this: paste IDs in the Music tab!)
-- Each track needs ONE of these:
--   id   = a Roblox audio id (number or "rbxassetid://123")
--   url  = a direct link to an .mp3/.ogg (downloaded + played via your executor)
--   file = a file already inside your executor's workspace folder
-- Add as many tracks as you like, the ⏮ / ⏭ buttons cycle them.
local MUSIC_AUTOPLAY = true -- start the music when the hub finishes loading
local MUSIC_VOLUME = 50     -- 0 to 100
local MUSIC_TRACKS = {
	-- { name = "诡异主题", id = 1234567890 },
	-- { name = "阴森钢琴", url = "https://example.com/creepy-piano.mp3" },
	-- { name = "我的歌曲",      file = "HalloweenHub/song.mp3" },
}

--  SCRIPT TABS  (all the scripts from Testing.txt)
-- Each tab has a list of buttons. Same fields as described above:
--   name, description, subtitle (small text under the name),
--   confirm / confirmText, run = function() ... end
-- To add a script: copy a block, paste it in the right tab, edit it.
local SCRIPT_TABS = {
	{
		name = "模式",
		section = "尽情享受这些模式",
		buttons = {
			{
				name = "遗忘模式",
				subtitle = "运行完美",
				description = "运行完美",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/Wy7PSxjz"))()
				end,
			},
			{
				name = "惊悚模式",
				subtitle = "作者：DripCapyBara",
				description = "作者：DripCapyBara",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/DripCapybara/Doors-Modes/refs/heads/main/CreepyMode/ObfuscatedMain.lua"))()
				end,
			},
			{
				name = "组合模式（修复版）",
				subtitle = "修复：Gab",
				description = "修复：Gab",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzzGabbbb/TheCombined/refs/heads/main/CombinedModeFixedWAAAAAAAAAAAAAAAAAAAAAAAAAAAAA.lua"))()
				end,
			},
			{
				name = "极限硬核模式（已更新）",
				subtitle = "作者：Zunxd",
				description = "作者：Zunxd",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junxd-03/UltraHardModeUpdate/refs/heads/main/UltraHardMode.lua"))()
				end,
			},
			{
				name = "岩浆模式（重制版）",
				subtitle = "重制：Guestly (Celestian)",
				description = "重制：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/Laver-Mode-Remake"))()
				end,
			},
			{
				name = "朦胧模式（重制版）",
				subtitle = "重制：Guestly (Celestian)",
				description = "重制：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Hazy-Mode-Recreated-made-by-Guestly-(Celestian)-on-Discord"))()
				end,
			},
			{
				name = "黑暗模式（修复版）",
				subtitle = "修复：Gab",
				description = "修复：Gab",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzzGabbbb/-/refs/heads/main/Dark%20Mode%20Fixed.lua"))()
				end,
			},
			{
				name = "部件模式",
				subtitle = "作者：Guestly (Celestian)",
				description = "作者：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/Parts-Mode"))()
				end,
			},
			{
				name = "虚空模式",
				subtitle = "鸣谢：Minh_Dcord",
				description = "鸣谢：Minh_Dcord",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/minh-scripter/doors_void/refs/heads/main/Doors_Void_Mode.txt"))()
				end,
			},
			{
				name = "空无模式",
				subtitle = "作者：RealblueYT & LDLT_Legacy",
				description = "作者：RealblueYT & LDLT_Legacy",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Null-mode/refs/heads/main/Null%20mode%20alpha%20by%20RealblueYT%20and%20LDLT_legacy"))()
				end,
			},
			{
				name = "癫狂模式",
				subtitle = "作者：RealblueYT",
				description = "作者：RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/realbluedeptrainhat/Cazy-mode/refs/heads/main/cazy-mode%20.txt", true))()
				end,
			},
			{
				name = "恐惧模式 V2",
				subtitle = "作者：Reboundplayz",
				description = "作者：Reboundplayz",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/Doors%20Fear%20Mode"))()
				end,
			},
			{
				name = "腐坏模式",
				subtitle = "作者：Junin_320hy",
				description = "作者：Junin_320hy",
				run = function()
loadstring(game:HttpGet("https://github.com/junin724/Doors-modes/raw/refs/heads/main/Corrupted%20mode%20By%20me"))()
				end,
			},
			{
				name = "迷雾模式（发布版）",
				subtitle = "作者：Vuivuiviu2",
				description = "作者：Vuivuiviu2",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Ganyu06112/Fog-Mode/refs/heads/main/Fog-Mode.lua"))()
				end,
			},
			{
				name = "不可能+模式 V1.8（重做）",
				subtitle = "作者：Guestly (Celestian), Rip Voorpro's Impossible Mode",
				description = "作者：Guestly (Celestian), Rip Voorpro's Impossible Mode",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Outernal/Doors/refs/heads/main/Impossible-Mode-Plus"))()
				end,
			},
			{
				name = "幻象模式（简易版）",
				subtitle = "鸣谢：Guestly (Celestian)",
				description = "鸣谢：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Hallucination-Mode-(Easy-Version)-Made-by-Celestian-on-Discord"))()
				end,
			},
			{
				name = "沉浸模式（修复版）",
				subtitle = "作者：LocalPlayer",
				description = "作者：LocalPlayer",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/fixedImmkersivemodeabitbutbyes"))()
				end,
			},
			{
				name = "梦魇模式",
				subtitle = "作者：Kodbol & Remade by Reboundplayz",
				description = "作者：Kodbol & Remade by Reboundplayz",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/YbkbZ3fp"))()
				end,
			},
			{
				name = "癫乱模式",
				subtitle = "作者：Guestly (Celestian) & Vuivuiviu2",
				description = "作者：Guestly (Celestian) & Vuivuiviu2",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Insanitas-Mode-Made-By-Guestly-And-Vuivuiviu2"))()
				end,
			},
			{
				name = "比萨斯模式",
				subtitle = "作者：Guestly (Celestian)",
				description = "作者：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/Bissastant-Mode"))()
				end,
			},
			{
				name = "炼狱模式",
				subtitle = "作者：Anctarus7105",
				description = "作者：Anctarus7105",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Anctarus7105/My-Modes/refs/heads/main/Inferno.lua"))()
				end,
			},
			{
				name = "恐怖模式（修复版）",
				subtitle = "原始鸣谢：Chrono；修复鸣谢：THE_LOSTW3R",
				description = "原始鸣谢：Chrono；修复鸣谢：THE_LOSTW3R",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostw3r/Mods/main/HorrorMode.lua"))()
				end,
			},
			{
				name = "疯狂模式",
				subtitle = "鸣谢：Guestly (Celestian)",
				description = "鸣谢：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/lynguyen26031993-design/-u/refs/heads/main/crazy-mode"))()
				end,
			},
			{
				name = "空旷模式",
				subtitle = "作者：FenzerPlayerPressure",
				description = "作者：FenzerPlayerPressure",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/FenzerPlayerPressure/SubVersions/refs/heads/main/Roomy%20Mode.lua"))()
				end,
			},
			{
				name = "阴森模式",
				subtitle = "作者：Rip_Silence",
				description = "作者：Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Scary%20Mode"))()
				end,
			},
			{
				name = "天龙模式 V2",
				subtitle = "作者：Rip_Silence",
				description = "作者：Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Draco%20Mode%20(Fully%20Completed)"))()
				end,
			},
			{
				name = "灌篮模式",
				subtitle = "作者：Zunxd",
				description = "作者：Zunxd",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Baller-mode/refs/heads/main/Mode"))()
				end,
			},
			{
				name = "暴狂模式",
				subtitle = "作者：RealblueYT",
				description = "作者：RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Critazy-mode-/refs/heads/main/Critazy%20mode.LocalPlayer"))()
				end,
			},
			{
				name = "铃铛模式",
				subtitle = "作者：Chu be te liet",
				description = "作者：Chu be te liet",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/chubeteliet-cpu/Ringer-doors/refs/heads/main/RINGER-DOORS-NEW!", true))()
				end,
			},
			{
				name = "恶魔模式（修复版）",
				subtitle = "修复：Smile & Tuffmu Chicken Boy",
				description = "修复：Smile & Tuffmu Chicken Boy",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/datdoors/Devilmodefixed.main/refs/heads/main/Devilmodefixed"))()
				end,
			},
			{
				name = "房间模式",
				subtitle = "作者：Gab",
				description = "作者：Gab",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/WLjeQQWm"))()
				end,
			},
			{
				name = "禅意模式",
				subtitle = "作者：Anctarus7105",
				description = "作者：Anctarus7105",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Anctarus7105/My-Modes/refs/heads/main/AyZen%20Mode/Mode.lua"))()
				end,
			},
			{
				name = "异样模式",
				subtitle = "作者：Guestly (Celestian)",
				description = "作者：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/Strange-Mode"))()
				end,
			},
			{
				name = "无政府模式",
				subtitle = "发布：Anctarus7105",
				description = "发布：Anctarus7105",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Anctarus7105/Recreated-modes/refs/heads/main/Anarchy%20Release"))()
				end,
			},
			{
				name = "极端模式（重制版）",
				subtitle = "重制：Guestly (Celestian)",
				description = "重制：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Extreme-Mode-Recreated-made-by-Guestly"))()
				end,
			},
			{
				name = "混沌 + 回溯模式",
				subtitle = "作者：Anctarus7105 & Aboba288-Abobic",
				description = "作者：Anctarus7105 & Aboba288-Abobic",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Anctarus7105/Recreated-modes/refs/heads/main/Chaos%20Recall%20V1.0"))()
				end,
			},
			{
				name = "黄貂鱼模式",
				subtitle = "作者：Anzor",
				description = "作者：Anzor",
				run = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Anzor5458/Doors-stingray-mod/refs/heads/main/Anzor'))()
				end,
			},
			{
				name = "中等模式",
				subtitle = "作者：someone that idk",
				description = "作者：someone that idk",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Medium-Mode-Made-by-someone-that-idk"))()
				end,
			},
			{
				name = "疯癫模式",
				subtitle = "作者：TheDarkMan & Recreated By Guestly (Celestian)",
				description = "作者：TheDarkMan & Recreated By Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/Insane-Mode"))()
				end,
			},
			{
				name = "极寒模式",
				subtitle = "作者：Guestly (Celestian)",
				description = "作者：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/Arctic-Mode-(Beta)-By-Guestly-And-Vuivuiviu2"))()
				end,
			},
			{
				name = "硬核模式（但很烂）",
				subtitle = "作者：RipperHC",
				description = "作者：RipperHC",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/KendrickFan59/privatev2/refs/heads/main/efdff"))()
				end,
			},
			{
				name = "铃铛模式（重制）",
				subtitle = "重制：RealblueYT",
				description = "重制：RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/realbluedeptrai/Ringer-mode/refs/heads/main/ringer%20mode%20remake", true))()
				end,
			},
			{
				name = "虚无模式 V2",
				subtitle = "作者：Guestly (Celestian) & Vuivuiviu2 & Voorpr0",
				description = "作者：Guestly (Celestian) & Vuivuiviu2 & Voorpr0",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/Voidness-Mode-Made-By-Guestly-Vuivuiviu2-And-Voorpr0", true))()
				end,
			},
			{
				name = "禁忌模式（重制版）",
				subtitle = "鸣谢：Noah and Recreated By Guestly (Celestian)",
				description = "鸣谢：Noah and Recreated By Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Forbidden-Mode-recreated-by-Guestly"))()
				end,
			},
			{
				name = "月狂模式 V6（重制版）",
				subtitle = "作者：Guestly & Vuivuiviu2 & Nowhywhat & VoorPr0",
				description = "作者：Guestly & Vuivuiviu2 & Nowhywhat & VoorPr0",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Nowhywhat/Cooking/main/LunacyMode.lua"))()
				end,
			},
			{
				name = "破碎模式 V5",
				subtitle = "鸣谢：Nhankgnew",
				description = "鸣谢：Nhankgnew",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/talales/Nhankg./refs/heads/main/the%20fragments%20v5"))()
				end,
			},
			{
				name = "堕落模式（转载）",
				subtitle = "作者：Guestly (Celestian)",
				description = "作者：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/Degenerate-Mode-Reposted"))()
				end,
			},
			{
				name = "硬核模式（修复版）",
				subtitle = "作者：Noonie & Ping；硬核模式修复鸣谢：THE_LOSTW3R",
				description = "作者：Noonie & Ping；硬核模式修复鸣谢：THE_LOSTW3R",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostw3r/Mods/main/HardcoreMode.lua"))()
				end,
			},
			{
				name = "混乱模式",
				subtitle = "运行完美",
				description = "运行完美",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/localplayerr/Doors-stuff/refs/heads/main/Mayhem%20mode%20recreate/Code"))()
				end,
			},
			{
				name = "无尽模式（修复版）",
				subtitle = "作者：DripCapybara & Fixed By Gab",
				description = "作者：DripCapybara & Fixed By Gab",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/EnSmizjL/raw"))()
				end,
			},
			{
				name = "空洞模式",
				subtitle = "作者：someone that idk",
				description = "作者：someone that idk",
				run = function()
loadstring(game:HttpGet("https://rawscripts.net/raw/DOORS-DAILY-RUNS-Hollow-Mode-91878"))()
				end,
			},
			{
				name = "玻璃模式",
				subtitle = "作者：Guestly",
				description = "作者：Guestly",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/lynguyen26031993-design/-u/refs/heads/main/Glassy%20Mode"))()
				end,
			},
			{
				name = "僵尸模式",
				subtitle = "作者：Grampy",
				description = "作者：Grampy",
				run = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/GrampyMods/ZombieMode/refs/heads/main/mode'))()
				end,
			},
			{
				name = "硬核模式（再次高清重制）",
				description = "加载并运行：硬核模式（再次高清重制）。",
				run = function()
local url = "https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/main/Hardcore-Mode-Re-Remastered-Made-By-Guestly-Vuivuiviu2-Nowhywhat-Voorpr0"

local ok, err = pcall(function()
loadstring(game:HttpGet(url, true))()
end)

if not ok then
warn("[加载错误]", err)
else
print("[加载成功]")
end
				end,
			},
			{
				name = "Gab 的破碎模式（有点坏了）",
				subtitle = "作者：Gab",
				description = "作者：Gab",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/nMgH5Jwa"))()
				end,
			},
			{
				name = "沉浸模式（重制）",
				subtitle = "重制：RealblueYT",
				description = "重制：RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/immersive-remake/refs/heads/main/Immersive-remake-loaded-localplayer-Origin-script.lua"))()
				end,
			},
			{
				name = "极限硬核模式 V3（重制）",
				subtitle = "重制：RealblueYT",
				description = "重制：RealblueYT",
				run = function()
loadstring(game:HttpGet("https://arch-http.vercel.app/files/projecthradmodv3"))()
				end,
			},
			{
				name = "破碎模式 V4（修复版）",
				subtitle = "作者：Jabiss",
				description = "作者：Jabiss",
				run = function()
loadstring(game:HttpGet("https://glot.io/snippets/h81q93s9qb/raw/main.lua"))()
				end,
			},
			{
				name = "Plamen6789 的硬核模式（重制）",
				subtitle = "重制：Zunxd",
				description = "重制：Zunxd",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Hardcore-mode/refs/heads/main/hardcore.lua"))()
				end,
			},
			{
				name = "理智崩坏模式（重做）",
				subtitle = "鸣谢：Kotyara19k & ReboundPlayz & Voorpr0",
				description = "鸣谢：Kotyara19k & ReboundPlayz & Voorpr0",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Anctarus7105/Recreated-modes/refs/heads/main/Insanity%20Reworked%201.3"))()
				end,
			},
			{
				name = "潜行者模式（???）",
				subtitle = "作者：Leo -LDX-",
				description = "作者：Leo -LDX-",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/leonardocostagaucheuroleonardo-sketch/Stalkermodofc/refs/heads/main/README.md"))()
				end,
			},
			{
				name = "恐惧模式（重制）",
				subtitle = "重制：RealblueYT",
				description = "重制：RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Fearmode-/refs/heads/main/Fearmodereamake.txt"))()
				end,
			},
			{
				name = "梗图模式",
				subtitle = "作者：Chu be te liet",
				description = "作者：Chu be te liet",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/chubeteliet-cpu/meme-mode-m-p/refs/heads/main/Meme-mode-ma-hoa", true))()
				end,
			},
			{
				name = "圣诞模式",
				subtitle = "鸣谢：Chill Guy",
				description = "鸣谢：Chill Guy",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Idk-lol2/xmasmode/refs/heads/main/xmasmode.txt"))()
				end,
			},
			{
				name = "硬核模式 V4（旧版本）",
				subtitle = "作者：Noonie & Ping",
				description = "作者：Noonie & Ping",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/localplayerr/Doors-stuff/refs/heads/main/Hardcore%20v4%20recreate/main%20code"))()
				end,
			},
			{
				name = "不可能模式（重制）",
				subtitle = "重制：RealblueYT & Smile",
				description = "重制：RealblueYT & Smile",
				run = function()
loadstring(game:HttpGet("https://arch-http.vercel.app/files/Projectimpossiblebyrealblueytandsmile"))()
				end,
			},
			{
				name = "精神分裂模式",
				subtitle = "作者：GroxMC (Fake)",
				description = "作者：GroxMC (Fake)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/tranthienhao872-ship-it/Mode/refs/heads/main/Mode%20doors%20test"))()
				end,
			},
			{
				name = "破碎模式 V4（重制）",
				subtitle = "重制：RealblueYT",
				description = "重制：RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/fragmented-v4-fixe/refs/heads/main/fragmentedv4fixed.lua"))()
				end,
			},
			{
				name = "终极梦魇模式 V8.2",
				subtitle = "鸣谢：Tuffmu Chicken Boy",
				description = "鸣谢：Tuffmu Chicken Boy",
				run = function()
loadstring(game:HttpGet("https://arch-http.vercel.app/files/ByTuffmuScriptVersion8.2UltimateNightmareMode.txt"))()
				end,
			},
			{
				name = "不可能模式（再堕落）",
				subtitle = "作者：Guestly (Celestian)",
				description = "作者：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/Impossible-Mode-Re-Degenerate-Made-By-Guestly"))()
				end,
			},
			{
				name = "Gab 的硬核模式（多人）",
				subtitle = "作者：Gab",
				description = "作者：Gab",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/b9jTt9zi"))()
				end,
			},
			{
				name = "Gab 的硬核模式（单人）",
				subtitle = "作者：Gab",
				description = "作者：Gab",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/jTrCetvx"))()
				end,
			},
			{
				name = "寂静模式 V3",
				subtitle = "作者：Rip_Silence",
				description = "作者：Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Silence%20Mode"))()
				end,
			},
			{
				name = "堕落模式（黑暗版）",
				subtitle = "鸣谢：Guestly (Celestian)",
				description = "鸣谢：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Darkness-Degenerate-Mode-Made-By-Guestly"))()
				end,
			},
			{
				name = "奇兹尼斯模式",
				subtitle = "制作：Guestly (Celestian)",
				description = "制作：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Cizinuness-Mode-Made-By-Guestly", true))()
				end,
			},
			{
				name = "催眠模式",
				subtitle = "作者：Guestly (Celestian)",
				description = "作者：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/Suggestions-Mode"))()
				end,
			},
			{
				name = "梦核模式",
				subtitle = "作者：Guestly & VoorPr0",
				description = "作者：Guestly & VoorPr0",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Dreamcore-Mode-Made-by-Guestly-and-Voorpr0"))()
				end,
			},
			{
				name = "大灾变模式",
				subtitle = "作者：Guestly (Celestian) & Vuivuiviu3",
				description = "作者：Guestly (Celestian) & Vuivuiviu3",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Cataclysm-Mode-made-by-Guestly-and-Vuivuiviu3"))()
				end,
			},
			{
				name = "悲哀模式",
				subtitle = "鸣谢：someone that idk",
				description = "鸣谢：someone that idk",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/LLGCAllIWantIsYou/urban-broccoli/refs/heads/main/SadnessMode.lua"))()
				end,
			},
			{
				name = "朦胧模式 + 极端模式（合并）",
				subtitle = "鸣谢：Guestly (Celestian)",
				description = "鸣谢：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Hazy%2BExtreme-Mode-made-by-Guestly-on-Discord"))()
				end,
			},
			{
				name = "硬核模式（重做）",
				subtitle = "作者：RealblueYT",
				description = "作者：RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Hradcore-by-noonies-remakes/refs/heads/main/Hradcore%20reworker%20by%20RealblueYT%20chubeteliet%20LDLT_legacy"))()
				end,
			},
			{
				name = "破碎模式 V4（非官方）",
				subtitle = "鸣谢：someone that idk",
				description = "鸣谢：someone that idk",
				run = function()
loadstring(game:HttpGet("https://glot.io/snippets/h7zlma80wm/raw/Main.java"))()
				end,
			},
			{
				name = "惊骇模式",
				subtitle = "运行完美",
				description = "运行完美",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Teilsthebfdifan/Modhub-assets/refs/heads/main/TerrorModeOBF.lua"))()
				end,
			},
			{
				name = "硬核模式（重制）",
				subtitle = "重制：Junin_320hy",
				description = "重制：Junin_320hy",
				run = function()
loadstring(game:HttpGet("https://github.com/junin724/Doors-modes/raw/refs/heads/main/Hardcore%2520mode%2520remake"))()
				end,
			},
			{
				name = "无尽模式（重制）",
				subtitle = "重制：Chu be te liet",
				description = "重制：Chu be te liet",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/binhlforsaken156-sys/Enless-mode-remake/refs/heads/main/Endless-remake-by-chubeteliet.txt", true))()
				end,
			},
			{
				name = "恐惧模式（再次高清重制）",
				subtitle = "鸣谢：RealblueYT",
				description = "鸣谢：RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Fear-mode-re_remastere/refs/heads/main/obfuscated_script-1769600892332.lua.txt"))()
				end,
			},
			{
				name = "幻象模式（困难版）",
				subtitle = "鸣谢：Guestly (Celestian)",
				description = "鸣谢：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Hallucination-Mode-(Hard-Version)-Made-by-Celestian-On-Discord"))()
				end,
			},
			{
				name = "灾变模式",
				subtitle = "鸣谢：Guestly & Vuivuiviu4",
				description = "鸣谢：Guestly & Vuivuiviu4",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Cataclysmic-Mode-Made-by-Guestly-and-Vuivuiviu4"))()
				end,
			},
			{
				name = "白雾模式",
				subtitle = "作者：Minh_DCord",
				description = "作者：Minh_DCord",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/White%20Haze%20Mode"))()
				end,
			},
			{
				name = "混沌模式 V1（硬核版）",
				subtitle = "鸣谢：DJ SD (Tunder8401) & Rip_Silence",
				description = "鸣谢：DJ SD (Tunder8401) & Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Chaos-Mode-Hardcore-Version/refs/heads/main/Chaos%20Mode%20V1%20(Hardcore%20Version)"))()
				end,
			},
			{
				name = "矿区模式",
				subtitle = "作者：Gab",
				description = "作者：Gab",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/Hgn6DarS"))()
				end,
			},
			{
				name = "难度模式",
				subtitle = "作者：eoyoustme",
				description = "作者：eoyoustme",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/41450088/refs/heads/main/Difficulty%20mode%20fix"))()
				end,
			},
			{
				name = "精神病态模式",
				subtitle = "作者：someone that idk",
				description = "作者：someone that idk",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/Psychotic-mode/main/monste%20and%20Door%20Sounds.lua"))()
				end,
			},
			{
				name = "漆黑模式",
				subtitle = "作者：Chu be te liet",
				description = "作者：Chu be te liet",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/chubeteliet-cpu/Darkness-mode/refs/heads/main/Darkness%20mode%20rework", true))()
				end,
			},
			{
				name = "突袭者模式",
				subtitle = "作者：Rip_Silence",
				description = "作者：Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Stryker-Mode-(Fully-Completed)"))()
				end,
			},
			{
				name = "不可能模式（测试版）",
				subtitle = "作者：RealBlueYT",
				description = "作者：RealBlueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/realbluedeptrainhat/Impossible-alpha-/refs/heads/main/impossible%20alpha.txt", true))()
				end,
			},
			{
				name = "无尽模式（eliazbp92）",
				description = "加载并运行：无尽模式（eliazbp92）。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eliazbp92-collab/Endless-mode/refs/heads/main/Script.lua"))()
				end,
			},
			{
				name = "硬核模式（超老版本）",
				subtitle = "版本非常非常老，可能无法在 Hotel+ 使用",
				description = "非常非常非常老的硬核模式。老到离谱，可能无法在 Hotel+ 使用。",
				confirm = true,
				confirmText = "这个硬核模式非常非常非常老，老到离谱，可能无法在 Hotel+ 使用。还是运行吗？",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/jackpetersmithwarr-collab/DoorsHardmodeold/main/MAINSCRIPT"))()
				end,
			},
			{
				name = "格拉迪什模式",
				description = "加载并运行：格拉迪什模式。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/J63633S/Gradish-mode/main/Main%20script."))()
				end,
			},
			{
				name = "硬核模式（重拍加强版）",
				description = "加载并运行：硬核模式（重拍加强版）。",
				run = function()
loadstring(game:HttpGet("https://github.com/tranthienhao872-ship/Hardcore-Retake/raw/refs/heads/main/Plus%20again"))()
				end,
			},
		},
	},
	{
		name = "额外",
		section = "非常酷的东西",
		buttons = {
			{
				name = "二层主题地图",
				subtitle = "更新：Zunxd",
				description = "更新：Zunxd",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junxd-03/Floor-2/refs/heads/main/New"))()
				end,
			},
			{
				name = "迷雾地图",
				subtitle = "???",
				description = "???",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Fog-doors/refs/heads/main/Fogg"))()
				end,
			},
			{
				name = "恶魔地图（红图）",
				subtitle = "666 666 666",
				description = "666 666 666",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/Monoxide/refs/heads/main/DEMON"))()
				end,
			},
			{
				name = "铁锈地图",
				subtitle = "作者：RealblueYT",
				description = "作者：RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Rust-maps/refs/heads/main/Rustmapuptdate.txt"))()
				end,
			},
			{
				name = "门把手刷取",
				subtitle = "作者：Vynixius",
				description = "作者：Vynixius",
				run = function()
getgenv().Config = {
    MinContainers = 10,
    MinCoins = 50,
    UseLockpick = false,
    UseRobuxKnobsBoost = false
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/6e87698669de88a8f81d6348ce368b73.lua"))()
				end,
			},
			{
				name = "Verity 脚本",
				subtitle = "作者：ItzzGabbbb (Minecraft Mod btw)",
				description = "作者：ItzzGabbbb (Minecraft Mod btw)",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/sqdSTwKt/raw"))()
				end,
			},
			{
				name = "彩虹房间",
				subtitle = "鸣谢：UnknownReturnz 提供了这个脚本",
				description = "鸣谢：UnknownReturnz 提供了这个脚本",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Doors-Hub/refs/heads/main/Rainbow-Room"))()
				end,
			},
			{
				name = "脚本模式 V1（发布版）",
				subtitle = "作者：Munciseek",
				description = "作者：Munciseek",
				run = function()
loadstring(game:HttpGet("https://illunox.qzz.io/api/scripts/42b63e919ea74a999f2fec6ffdc02de1"))()
				end,
			},
			{
				name = "发电机硬核模式",
				subtitle = "作者：Indexell",
				description = "作者：Indexell",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IdkMyNameLoll/PublicScripts/refs/heads/main/HardGenIThinkReupload"))()
				end,
			},
			{
				name = "寒意光（请看说明）",
				subtitle = "你需要先死一次，然后才能看到寒意光",
				description = "你需要先死一次，然后才能看到寒意光",
				run = function()
loadstring(game:HttpGet('https://pastebin.com/raw/nCYbqkAb'))()
				end,
			},
			{
				name = "光影着色（可用）",
				description = "加载并运行：光影着色（可用）。",
				run = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/randomstring0/pshade-ultimate/refs/heads/main/src/cd.lua'))()
				end,
			},
			{
				name = "键盘（可用）",
				description = "加载并运行：键盘（可用）。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GGH52lan/GGH52lan/main/keyboard.txt"))()
				end,
			},
			{
				name = "客户端性能测试（安全）",
				subtitle = "运行一次简短、有上限的响应性检测",
				description = "旧版无限打印循环的安全替代品，不会故意卡死客户端。",
				confirm = true,
				confirmText = "要跑一次简短的性能检测吗？会在控制台打印一个小结果。",
				run = function()
					local started = os.clock()
					local checksum = 0
					for i = 1, 20000 do
						checksum += i % 97
					end
					print(("[DoorsModesHub] 安全测试完成，用时 %.4f 秒（校验值 %d）"):format(os.clock() - started, checksum))
				end,
			},
			{
				name = "断线脚本（请看说明）",
				subtitle = "执行这个之后，只有你自己会被踢下线",
				description = "执行这个之后，只有你自己会被踢下线",
				confirm = true,
				confirmText = "这会把你自己踢出游戏。确定吗？",
				run = function()
game.Players.LocalPlayer:Kick("你干嘛真的执行这个啊兄弟？")
				end,
			},
			{
				name = "冲刺耐力 V5",
				description = "加载并运行：冲刺耐力 V5。",
				run = function()
_G.msrhyan_config_sprint = {
timetospeedexpire = 25, -- TIME TO EXPIRE STAMINA ( 0 = INFINITE )
cooldowntime = 5,
sprintspeed = 50,
speedapplytime = 0.3,
speedremovetime = 0.5,
staminarecovertime = 10,
effectfadetime = 0.2,
showstaminamessages = true,
customstaminamessage = "你的耐力用完了，请等待 %ds！",
enableeffects = true,
effectcolor = {100, 200, 255},
staminabarcolor = {0, 162, 255},
sprintfov = 120,
normalfov = 70,
usewhileloading = false,
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/Sc-Rhyan57/MsProject/refs/heads/main/projects/DOORS-SPRINT.lua"))()
				end,
			},
			{
				name = "IndiHome 脚本（整蛊）",
				subtitle = "作者：OG Hunger (New)",
				description = "作者：OG Hunger (New)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/Hardcore/refs/heads/main/IndiHome"))()
				end,
			},
			{
				name = "Hotel- 界面（仅限 Hotel-）",
				subtitle = "作者：someone that idk",
				description = "作者：someone that idk",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/En0eCsJd"))()
				end,
			},
			{
				name = "简易脚本加载器",
				subtitle = "鸣谢：someone that idk",
				description = "鸣谢：someone that idk",
				run = function()
loadstring(game:HttpGet("https://rawscripts.net/raw/DOORS-DAILY-RUNS-Simple-Script-Loader-92632"))()
				end,
			},
			{
				name = "开发者管理面板（需要管理员面板）",
				subtitle = "鸣谢：someone that idk",
				description = "鸣谢：someone that idk",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/SHRTRYScriptMANhere/DoorsDevPanel/refs/heads/main/devpanel.lua",true))()
				end,
			},
			{
				name = "翠绿裂隙",
				subtitle = "作者：Guestly (Celestian)",
				description = "作者：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/Viridis-Rift"))()
				end,
			},
			{
				name = "故障裂隙",
				subtitle = "作者：Guestly (Celestian)",
				description = "作者：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/Glitch-Rift"))()
				end,
			},
			{
				name = "顽劣裂隙",
				subtitle = "作者：Guestly (Celestian)",
				description = "作者：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/Mischievous-Rift"))()
				end,
			},
			{
				name = "添加隐藏实体",
				subtitle = "鸣谢：Rip_Silence",
				description = "鸣谢：Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Him-Entity-Main.lua"))()
				end,
			},
			{
				name = "游戏文件记录器",
				subtitle = "作者：Guestly (Celestian)",
				description = "作者：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Scripts/refs/heads/main/Game-Files-Logger"))()
				end,
			},
			{
				name = "门号显示",
				subtitle = "鸣谢：Lucas",
				description = "鸣谢：Lucas",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/LukeLor/LukeLor/refs/heads/main/DoorDisplay.lua"))()
				end,
			},
			{
				name = "友善 Rush",
				subtitle = "鸣谢：Lucas",
				description = "鸣谢：Lucas",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/LukeLor/LukeLor/refs/heads/main/Helpful%20Rush.lua"))()
				end,
			},
			{
				name = "帮忙的 Jack（仅限 Hotel-）",
				subtitle = "作者：Anctarus7105",
				description = "作者：Anctarus7105",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Anctarus7105/Random-Files/refs/heads/main/HelpingJack.lua"))()
				end,
			},
			{
				name = "捕兽夹屏蔽",
				subtitle = "鸣谢：Lucas",
				description = "鸣谢：Lucas",
				run = function()
workspace.DescendantAdded:Connect(function(Object)
if Object.Name == "Snare" and Object:FindFirstChild("Snare") then
print("snare")
local ds = coroutine.create(function()
while task.wait() do
if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Object.Hitbox.Position).Magnitude < 8 and Object.Hitbox.CanTouch == true then
Object.Hitbox.CanTouch = false

local lock = game:GetObjects("rbxassetid://134623425206809")[1]
lock.Parent = workspace
local newlock = lock.Lock
newlock.ParticleEmitter.Enabled = true
newlock.Parent = Object.Hitbox
lock:Destroy()

local effects= game:GetObjects("rbxassetid://107175245956530")[1] -- Curious: 82037744082799
effects.Parent = workspace
for _, effecth in effects:GetChildren() do
print( effecth.Name)
effecth.Parent = Object.Snare.Holes
print("已挂载："..effecth.Name)

end

effects:Destroy()
game:GetService("TweenService"):Create(Object.Snare.Holes, TweenInfo.new(0), {Color = Color3.fromRGB(0,0,0)}):Play()
game:GetService("TweenService"):Create(Object.Snare.Holes, TweenInfo.new(0.25), {Color = Color3.fromRGB(100, 146, 219)}):Play()--Curious: 248, 217, 109
task.wait(0.1)
newlock.ParticleEmitter.Texture = "rbxassetid://135389918701762"
task.wait(0.1)
newlock.ParticleEmitter.Texture = "rbxassetid://75134945132260"
task.wait(0.1)
newlock.ParticleEmitter.Texture = "rbxassetid://113033745280657"
task.wait(0.1)
newlock.ParticleEmitter.Texture = "rbxassetid://92040110017917"
task.wait(0.1)
newlock.ParticleEmitter.Texture = "rbxassetid://109471683017650"
task.wait(0.1)
newlock.ParticleEmitter.Texture = "rbxassetid://92040110017917"
task.wait(0.1)
newlock.ParticleEmitter.Texture = "rbxassetid://109471683017650"
print("特效已完成")
end
end
end)
coroutine.resume(ds)
end
end)
				end,
			},
			{
				name = "速通计时器",
				subtitle = "鸣谢：Iliankvth",
				description = "鸣谢：Iliankvth",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Iliankytb/Iliankytb/main/SpeedrunTimer"))()
				end,
			},
			{
				name = "THE OVERDOORS V2.5（重制）",
				subtitle = "重制：RealblueYT",
				description = "重制：RealblueYT",
				run = function()
loadstring(game:HttpGet("https://arch-http.vercel.app/files/Projectoverdoors" ))()
				end,
			},
			{
				name = "c00lkidd 追逐战（请看说明）",
				subtitle = "执行这个脚本，然后去追逐战",
				description = "执行这个脚本，然后去追逐战",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IdkMyNameLoll/PublicScripts/refs/heads/main/c00lkiddSeek"))()
				end,
			},
			{
				name = "Abrisam 的冲刺条",
				subtitle = "鸣谢：Abrisam",
				description = "鸣谢：Abrisam",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/MgWAd5WQ"))()
				end,
			},
			{
				name = "失落矿区",
				subtitle = "鸣谢：Cosplayer",
				description = "鸣谢：Cosplayer",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Other-Modes-Script/refs/heads/main/The-Lost-Mines"))()
				end,
			},
			{
				name = "脚本模式（重制）",
				subtitle = "作者：Reboundplayz",
				description = "作者：Reboundplayz",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/Script%20Mode"))()
				end,
			},
			{
				name = "THE OVERDOORS（最终版）",
				subtitle = "鸣谢：Chu be te liet",
				description = "鸣谢：Chu be te liet",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/chubeteliet-cpu/OVERDOORS-rework-ver/refs/heads/main/OVERDOORS%20entity%20finale%20upd", true))()
				end,
			},
			{
				name = "紫色摇曳光（全部裂隙）",
				description = "加载并运行：紫色摇曳光（全部裂隙）。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/lukahudeev-sys/Purple-shakelight/refs/heads/main/all%20rifts"))()
				end,
			},
		},
	},
	{
		name = "经典模式",
		section = "仅限超级硬核模式",
		buttons = {
			{
				name = "硬核模式【原版】",
				subtitle = "经典模式",
				description = "经典模式",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/hsrvGG1d"))()
				end,
			},
			{
				name = "恐惧模式【原版】",
				subtitle = "经典模式",
				description = "经典模式",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/cool59572/freestuff/main/Fear_mode_multiplayer.lua"))()
				end,
			},
			{
				name = "不可能模式【原版】",
				subtitle = "经典模式",
				description = "经典模式",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Ukazix/impossible-mode/refs/heads/main/Protected_79.lua.txt", true))()
				end,
			},
		},
	},
	{
		name = "合集",
		section = "尽情享用这些脚本",
		buttons = {
			{
				name = "Nullfire 脚本",
				description = "加载并运行：Nullfire 脚本。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TeamNullFire/NullFire/main/loader.lua"))()
				end,
			},
			{
				name = "Rapture Hub DoorsV1.2",
				description = "加载并运行：Rapture Hub DoorsV1.2。",
				run = function()
--[[
WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
loadstring(game:HttpGet("https://raw.githubusercontent.com/RaptureOfc/Rapture-Doors-Released-1.0-New/refs/heads/main/Doors%20Release%20Rapture"))()
				end,
			},
			{
				name = "Ms Paint V4",
				description = "加载并运行：Ms Paint V4。",
				run = function()
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/002c19202c9946e6047b0c6e0ad51f84.lua"))()
				end,
			},
			{
				name = "Ms Doors",
				description = "加载并运行：Ms Doors。",
				run = function()
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Msdoors-By-Rhyan57-54579"))()
				end,
			},
			{
				name = "硬核模式透视",
				subtitle = "能帮你判断硬核实体什么时候来",
				description = "能帮你判断硬核实体什么时候来",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Qiwikox12/stubrawl/refs/heads/main/DoorsHardcoreESP.txt", true))()
				end,
			},
			{
				name = "脚本包",
				description = "加载并运行：脚本包。",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/Piw5bqGq", true))()
				end,
			},
			{
				name = "LolHax 合集",
				description = "加载并运行：LolHax 合集。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxexploiterz/Release-Lolhax/refs/heads/main/LX%20Doors%20v3.lua"))()
				end,
			},
			{
				name = "Sexsation - Doors（免费）",
				description = "加载并运行：Sexsation - Doors（免费）。",
				run = function()
loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/730854e5b6499ee91deb1080e8e12ae3.lua"))()
				end,
			},
			{
				name = "深渊合集",
				subtitle = "鸣谢：FireBacon & wop2p",
				description = "鸣谢：FireBacon & wop2p",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/therealcookiemonsterof1966/AbysallContinued/main/Games/Doors/Main.luau"))()
				end,
			},
			{
				name = "Vynixius",
				description = "加载并运行：Vynixius。",
				run = function()
loadstring(game:HttpGet("https://vynixius.win/loader.luau", true))()
				end,
			},
			{
				name = "星界合集",
				subtitle = "Oogway",
				description = "Oogway",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/8cKJvTwg", true))()
				end,
			},
			{
				name = "LHKing 合集",
				subtitle = "LHking123456",
				description = "LHking123456",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/LHking123456/Dhjfdr9hk/refs/heads/main/Doors", true))()
				end,
			},
			{
				name = "HubHubHub",
				description = "加载并运行：HubHubHub。",
				run = function()
loadstring(game:HttpGet("https://rawscripts.net/raw/DOORS-DAILY-RUNS-HubHubHub-92582"))()
				end,
			},
			{
				name = "欢乐合集",
				description = "加载并运行：欢乐合集。",
				run = function()
loadstring(game:HttpGet("https://rawscripts.net/raw/DOORS-DAILY-RUNS-Joy-hub-93382"))()
				end,
			},
			{
				name = "Doors 合集 + 编辑器（测试版）",
				subtitle = "作者：Loper367",
				description = "作者：Loper367",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/razumenkonikita9-cmyk/Doors-hub-Editor/refs/heads/main/D.lua"))()
				end,
			},
			{
				name = "Guestly 的 Doors 模式合集 V3",
				subtitle = "鸣谢：Guestly (Celestian)",
				description = "鸣谢：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/GUESTLY-DOORS-MODE-HUB"))()
				end,
			},
			{
				name = "Guestly 的新 Doors 模式合集",
				subtitle = "作者：Guestly (Celestian)",
				description = "作者：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/DOORS-MODES-HUB"))()
				end,
			},
			{
				name = "Eukard 的 Doors 模式合集",
				subtitle = "作者：Eukard",
				description = "作者：Eukard",
				run = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Aboba228-Abobic/Eukard-s-Hub/refs/heads/main/EukardsHub'))()
				end,
			},
			{
				name = "Grampy 的 Doors 模式合集",
				subtitle = "作者：Grampy",
				description = "作者：Grampy",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GrampyMods/doorsmodshub/refs/heads/main/script"))()
				end,
			},
			{
				name = "Doors 模式合集 V1（最老版本??）",
				subtitle = "Doors 模式合集最老版本???",
				description = "Doors 模式合集最老版本???",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Unknown"))()
				end,
			},
			{
				name = "AmadeyHunter 的 Doors 工具合集 重整版 V20?",
				subtitle = "鸣谢：AmadeyHunter",
				description = "鸣谢：AmadeyHunter",
				run = function()
loadstring(game:HttpGet("https://github.com/AmadeyHunter/BackUp/raw/refs/heads/main/Doors-Utilities-Hub-Reorganized-V20"))()
				end,
			},
			{
				name = "Anctarus7105 的合集 V3.5",
				subtitle = "鸣谢：Anctarus7105",
				description = "鸣谢：Anctarus7105",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Anctarus7105/My-creations/refs/heads/main/Anctarus7105'sHubV3.5"))()
				end,
			},
			{
				name = "Twinkhook 合集",
				subtitle = "比深渊合集更好 • 自带上帝模式",
				description = "这个合集的另一个版本，比深渊合集更好，而且自带上帝模式。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/sillyleo67/Doors/refs/heads/main/Twinkhook.lua"))()
				end,
			},
		},
	},
	{
		name = "经典旧版",
		section = "仅限 Hotel- 使用",
		buttons = {
			{
				name = "硬核模式（经典版）",
				subtitle = "修复：THE_LOSTW3R",
				description = "修复：THE_LOSTW3R",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostw3r/Mods/main/HardcoreMode%5BLEGACY%5D.lua"))()
				end,
			},
			{
				name = "不可能模式（经典版）",
				subtitle = "作者：reboundplayz",
				description = "作者：reboundplayz",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Impossible-Mode-Legacy-Made-by-reboundplayz"))()
				end,
			},
			{
				name = "混乱模式（经典版）",
				subtitle = "作者：ItzzGabbbb",
				description = "作者：ItzzGabbbb",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzzGabbbb/MayhemModeLegacy1.0/refs/heads/main/DoorsMayhemModeLegacy.lua"))()
				end,
			},
			{
				name = "恐惧模式（经典版）",
				subtitle = "作者：reboundplayz",
				description = "作者：reboundplayz",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/Fear%20Mode%20LEGACY"))()
				end,
			},
		},
	},
	{
		name = "实体",
		section = "自定义实体生成器",
		buttons = {
			{
				name = "硬核 A-60 生成器",
				description = "加载并运行：硬核 A-60 生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Idk-lol2/a-60aa/refs/heads/main/---%3D%3D%3D%3D%3D%3D%20a-60%20agresiv%20spawner%20%3D%3D%3D%3D%3D%3D---.txt"))()
				end,
			},
			{
				name = "Him 生成器",
				description = "加载并运行：Him 生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Idk"))()
				end,
			},
			{
				name = "饥饿者生成器",
				description = "加载并运行：饥饿者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Hungerd/refs/heads/main/Entity"))()
				end,
			},
			{
				name = "Munci 生成器",
				description = "加载并运行：Munci 生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Munci-entity/refs/heads/main/Munci-20"))()
				end,
			},
			{
				name = "折磨者生成器（请看说明）",
				subtitle = "在第 0 门执行折磨者生成器，然后打开下一扇门",
				description = "在第 0 门执行折磨者生成器，然后打开下一扇门",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/ohh/refs/heads/main/Torment12"))()
				end,
			},
			{
				name = "创伤者生成器",
				description = "加载并运行：创伤者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Trauma-entity/refs/heads/main/Trauma"))()
				end,
			},
			{
				name = "骚扰者生成器（请看说明）",
				subtitle = "在第 0 门执行骚扰者生成器，然后打开下一扇门",
				description = "在第 0 门执行骚扰者生成器，然后打开下一扇门",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/talales/Nhankg.-/refs/heads/main/intro%20fragmented"))()
				end,
			},
			{
				name = "执念者生成器（请看说明）",
				subtitle = "在第 0 门执行执念者生成器，然后打开下一扇门",
				description = "在第 0 门执行执念者生成器，然后打开下一扇门",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/Mayhem-mode-enity/main/Hard%20Obsession.lua"))()
				end,
			},
			{
				name = "硬核惊惧者生成器（重制）",
				description = "加载并运行：硬核惊惧者生成器（重制）。",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/Dread%20Remake"))()
				end,
			},
			{
				name = "旋风者生成器（第一阶段）",
				description = "加载并运行：旋风者生成器（第一阶段）。",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/7jJP8zZb/raw"))()
				end,
			},
			{
				name = "质问者生成器",
				description = "加载并运行：质问者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Custom-Entity/refs/heads/main/Questioner-Entity"))()
				end,
			},
			{
				name = "暴恐者生成器",
				description = "加载并运行：暴恐者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/Spawn-terrorist/main/Spawn.lua"))()
				end,
			},
			{
				name = "寂静者生成器",
				description = "加载并运行：寂静者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Silence%20Entity"))()
				end,
			},
			{
				name = "解冻者生成器",
				description = "加载并运行：解冻者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/Custom-Entity/refs/heads/main/Defrost"))()
				end,
			},
			{
				name = "微笑者生成器（重制）",
				description = "加载并运行：微笑者生成器（重制）。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Smiler/refs/heads/main/Smi6"))()
				end,
			},
			{
				name = "回弹者生成器（重制）",
				description = "加载并运行：回弹者生成器（重制）。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Rebound-/refs/heads/main/Rebound"))()
				end,
			},
			{
				name = "鹿神生成器（重制）",
				description = "加载并运行：鹿神生成器（重制）。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/back/refs/heads/main/Deer%20God"))()
				end,
			},
			{
				name = "终止者生成器",
				description = "加载并运行：终止者生成器。",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/ofutwkjb/raw"))()
				end,
			},
			{
				name = "WH1T3 生成器（重制）",
				description = "加载并运行：WH1T3 生成器（重制）。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/Impossible/refs/heads/main/Wh1t3"))()
				end,
			},
			{
				name = "咯咯笑生成器",
				subtitle = "每个房间只生成 1 只咯咯笑",
				description = "每个房间只生成 1 只咯咯笑",
				run = function()
getgenv().GIGGLE_SPAWN_CONFIG = {
Damage = 6,
AttackingTime = math.random(7, 10), -- The time giggle will be attacking for.
FallSpeed = 3, -- Speed for when giggle spawns, can be mininum 2 and how high you want

Stunnable = true, -- If set to true, Giggle will be stunnable with glowstick
StunTime = 5, -- The time giggle will be stun for

RagdollThrowForce = 50, -- The Ragdoll's Force when its thrown
RagdollDissapears = true, -- If set to true the ragdoll will dissapear once giggle finishes attacking.

RoomSpawning = {
Enabled = true -- If set to false, giggle will spawn around the player.
},

PlayerSpawning = { -- This table will be used if Room Spawning is Disabled
MinRadius = -20, -- The minimum distance giggle can spawn from the player.
MaxRadius = 20. -- The maximum distance giggle can spawn from the player.
},

SpawningKey = { -- Key for Spawning
Enabled = false, -- If enabled once the key is pressed, giggle will spawn.
Key = "G" -- Key that is used for spawning giggle
}
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/DripCapybara/Test/refs/heads/main/Doors/GiggleSpawn.lua"))()
				end,
			},
			{
				name = "执念者生成器（重制）",
				description = "加载并运行：执念者生成器（重制）。",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/xlnpKWXo/raw"))()
				end,
			},
			{
				name = "A-100 生成器",
				description = "加载并运行：A-100 生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/Impossible/refs/heads/main/A-100"))()
				end,
			},
			{
				name = "A-75 生成器",
				description = "加载并运行：A-75 生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eliazbp92-collab/Rooms-low-detailed-mode-doors/refs/heads/main/A-75"))()
				end,
			},
			{
				name = "眩晕者生成器",
				description = "加载并运行：眩晕者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/ohh/refs/heads/main/Daze11"))()
				end,
			},
			{
				name = "神明生成器",
				subtitle = "作者：ItzzGabbbb",
				description = "作者：ItzzGabbbb",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/lAn7TCVE/raw"))()
				end,
			},
			{
				name = "R-40 生成器",
				description = "加载并运行：R-40 生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzzGabbbb/R-40-Spawner-Fixed/refs/heads/main/Doors%20Entity%20R-40.txt"))()
				end,
			},
			{
				name = "气流者生成器",
				description = "加载并运行：气流者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/ohh/refs/heads/main/Draft1"))()
				end,
			},
			{
				name = "慌乱者生成器",
				description = "加载并运行：慌乱者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/talales/Nhankg./refs/heads/main/Fluster"))()
				end,
			},
			{
				name = "鮟鱇者生成器",
				description = "加载并运行：鮟鱇者生成器。",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/GQCHNZE1"))()
				end,
			},
			{
				name = "一氧化碳生成器",
				description = "加载并运行：一氧化碳生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/back/refs/heads/main/Monoxide1"))()
				end,
			},
			{
				name = "深渊者生成器",
				description = "加载并运行：深渊者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/back/refs/heads/main/Depthter"))()
				end,
			},
			{
				name = "闪现者生成器",
				description = "加载并运行：闪现者生成器。",
				run = function()
loadstring(game:HttpGet("https://github.com/PABMAXICHAC/doors-monsters-scripts/raw/main/blinkcrux"))()
				end,
			},
			{
				name = "沉睡者生成器",
				description = "加载并运行：沉睡者生成器。",
				run = function()
--[[
WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
_G.dozerSpawnerSettings = {
dozerSpawnCD = 1,
ticksBeforeChecking = 10,
tomorrowTexts = 10,
SpawnerSettings = {
SpawnByUser = false, --set to true if you want to spawn Dozer
SpawnKeybind = Enum.KeyCode.Z,

SpawnRandomSettings = {
MathRandomSpawn1 = 10,
MathRandomSpawn2 = 15
}
}
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/IdkMyNameLoll/34921473024732147312483297412/refs/heads/main/dozerspawner"))()
				end,
			},
			{
				name = "合体者生成器",
				description = "加载并运行：合体者生成器。",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/Conjoinment%20Spawner"))()
				end,
			},
			{
				name = "怨念者生成器",
				description = "加载并运行：怨念者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/arkanzulfadliputra-oss/Entities-Models/refs/heads/main/Mod/Entity/With%20Jumpscare/Grudge.lua"))()
				end,
			},
			{
				name = "终止者（但很烂）生成器",
				description = "加载并运行：终止者（但很烂）生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/KendrickFan59/privatev2/refs/heads/main/ceaser"))()
				end,
			},
			{
				name = "病毒生成器",
				subtitle = "实体模型：ItzzGabbb 制作",
				description = "实体模型：ItzzGabbb 制作",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Private-Entity/refs/heads/main/Virus-Entity"))()
				end,
			},
			{
				name = "恐惧者生成器",
				description = "加载并运行：恐惧者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Custom-Entity/refs/heads/main/Fear-Nightmare-Mode"))()
				end,
			},
			{
				name = "350 生成器",
				description = "加载并运行：350 生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/350-entity/refs/heads/main/350"))()
				end,
			},
			{
				name = "G-95 生成器",
				description = "加载并运行：G-95 生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/G-95-v2/refs/heads/main/Entity"))()
				end,
			},
			{
				name = "B ∆ B 生成器",
				description = "加载并运行：B ∆ B 生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Private-Entity/refs/heads/main/B_%E2%88%86_B-Entity-Fixed"))()
				end,
			},
			{
				name = "嘶鸣者生成器",
				description = "加载并运行：嘶鸣者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Hiss/refs/heads/main/obfuscated_script-1769948042346.lua.txt"))()
				end,
			},
			{
				name = "B-444 生成器",
				subtitle = "作者：ItzzGabbbb",
				description = "作者：ItzzGabbbb",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/9dkXpSyy/raw"))()
				end,
			},
			{
				name = "A-185 生成器",
				description = "加载并运行：A-185 生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Private-Entity/refs/heads/main/A-185-Entity-Made-By-Someone"))()
				end,
			},
			{
				name = "毁灭者生成器",
				description = "加载并运行：毁灭者生成器。",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/zlwFiRuW/raw"))()
				end,
			},
			{
				name = "滑稽脸生成器",
				description = "加载并运行：滑稽脸生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Private-Entity/refs/heads/main/Trollface-Entity"))()
				end,
			},
			{
				name = "回弹者生成器（请看说明）",
				subtitle = "在第 0 门执行回弹者生成器，然后打开下一扇门",
				description = "在第 0 门执行回弹者生成器，然后打开下一扇门",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/ohh/refs/heads/main/Rebound"))()
				end,
			},
			{
				name = "奔跑的 Fredbear 生成器",
				description = "加载并运行：奔跑的 Fredbear 生成器。",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/wbEc0ThZ"))()
				end,
			},
			{
				name = "撕裂者生成器（重制）",
				description = "加载并运行：撕裂者生成器（重制）。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Ripperr/refs/heads/main/Ripperremake.lua"))()
				end,
			},
			{
				name = "冻伤者生成器（重制）",
				description = "加载并运行：冻伤者生成器（重制）。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/back/refs/heads/main/Frostbite1"))()
				end,
			},
			{
				name = "Pim 生成器",
				description = "加载并运行：Pim 生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Private-Entity/refs/heads/main/Pim-Entitiy-Made-By-TheDarkMan1334-And-Remastered-By-Me"))()
				end,
			},
			{
				name = "A-60 生成器（重制）",
				description = "加载并运行：A-60 生成器（重制）。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/A-60%20Spawner"))()
				end,
			},
			{
				name = "Ch4s3r_Thre4t 生成器",
				description = "加载并运行：Ch4s3r_Thre4t 生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Private-Entity/refs/heads/main/Ch4s3r_Thre4t-Entity"))()
				end,
			},
			{
				name = "终止者生成器（重制）",
				description = "加载并运行：终止者生成器（重制）。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Cease-Spawner-(Remake)"))()
				end,
			},
			{
				name = "Z-88 生成器",
				subtitle = "鸣谢：Burgerware",
				description = "鸣谢：Burgerware",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Private-Entity/refs/heads/main/Z-88-Entity-Made-By-Burgerware"))()
				end,
			},
			{
				name = "空无生成器",
				description = "加载并运行：空无生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/41450088/refs/heads/main/Null"))()
				end,
			},
			{
				name = "恐惧者生成器（重制）",
				description = "加载并运行：恐惧者生成器（重制）。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/nightmare/refs/heads/main/Fear"))()
				end,
			},
			{
				name = "扭曲者生成器",
				description = "加载并运行：扭曲者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/localplayerr/Doors-stuff/refs/heads/main/Immersive%20mode/Distort"))()
				end,
			},
			{
				name = "织造者生成器",
				description = "加载并运行：织造者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/localplayerr/Doors-stuff/refs/heads/main/Immersive%20mode/Fabricility"))()
				end,
			},
			{
				name = "漆黑者生成器",
				description = "加载并运行：漆黑者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Black-smile/refs/heads/main/Black"))()
				end,
			},
			{
				name = "索取者生成器",
				description = "加载并运行：索取者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/Doors-Mode-Remakes/refs/heads/main/Claim.lua"))()
				end,
			},
			{
				name = "死亡生成器",
				description = "加载并运行：死亡生成器。",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/death"))()
				end,
			},
			{
				name = "莫里亚蒂生成器",
				description = "加载并运行：莫里亚蒂生成器。",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/moriarty"))()
				end,
			},
			{
				name = "混沌者生成器",
				description = "加载并运行：混沌者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/J63633S/Laver-mode/refs/heads/main/Chaotic"))()
				end,
			},
			{
				name = "腐蚀者生成器",
				description = "加载并运行：腐蚀者生成器。",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/corrode"))()
				end,
			},
			{
				name = "Classio-Reboundier 生成器",
				description = "加载并运行：Classio-Reboundier 生成器。",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/classicorebuondier"))()
				end,
			},
			{
				name = "惊惧者生成器（请看说明）",
				subtitle = "在第 0 门执行惊惧者生成器，然后打开下一扇门",
				description = "在第 0 门执行惊惧者生成器，然后打开下一扇门",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/talales/Nhankg_/refs/heads/main/intro%20fragmented"))()
				end,
			},
			{
				name = "撕裂者生成器（Gab 制作）",
				description = "加载并运行：撕裂者生成器（Gab 制作）。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzzGabbbb/RipperSpawner/refs/heads/main/RipperEntityFromHardcoreMode.lua"))()
				end,
			},
			{
				name = "蓝化者生成器",
				description = "加载并运行：蓝化者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Bluyer-entity/refs/heads/main/Bluyer"))()
				end,
			},
			{
				name = "电击者生成器",
				description = "加载并运行：电击者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Shocker-entity/refs/heads/main/Shocker"))()
				end,
			},
			{
				name = "深潜者生成器",
				description = "加载并运行：深潜者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Depth-v2/refs/heads/main/Entity"))()
				end,
			},
			{
				name = "涌流者生成器",
				description = "加载并运行：涌流者生成器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Surge-entity/refs/heads/main/Surge"))()
				end,
			},
			{
				name = "实体生成器合集",
				description = "加载并运行：实体生成器合集。",
				run = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/plamen6789/UtilitiesHub/main/UtilitiesGUI'))()
				end,
			},
			{
				name = "旧版 Seek",
				description = "加载并运行：旧版 Seek。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/StovenChaos/Doors/refs/heads/main/Old%20seek.lua"))()
				end,
			},
			{
				name = "A-60（混沌实体）",
				description = "加载并运行：A-60（混沌实体）。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Custom-Entity/refs/heads/main/A-60-Chaos-Entity"))()
				end,
			},
			{
				name = "噪音（含故障版）",
				description = "加载并运行：噪音（含故障版）。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Outernal/Doors/refs/heads/main/Noise(IncludeGlitchVersion)"))()
				end,
			},
			{
				name = "头目生成器",
				subtitle = "作者：Pepo Mods",
				description = "作者：Pepo Mods",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/bonellocristian78-lab/Gradish-Mode/main/Honcho.lua"))()
				end,
			},
		},
	},
	{
		name = "道具",
		section = "尽情享用这些自定义道具",
		buttons = {
			{
				name = "指引蜡烛（已更新）",
				subtitle = "修复：Junbbinopro",
				description = "修复：Junbbinopro",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Guiding-light-candle/refs/heads/main/Candle"))()
				end,
			},
			{
				name = "金色小熊手电",
				description = "加载并运行：金色小熊手电。",
				run = function()
loadstring(game:HttpGet(("https://raw.githubusercontent.com/aadyian9000/the-thing/main/GoldenGummyFlashlight.lua"),true))()
				end,
			},
			{
				name = "黑洞（超模）",
				description = "加载并运行：黑洞（超模）。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/iimateiYT/Scripts/main/Black%20Hole.lua"))()
				end,
			},
			{
				name = "七无卷轴",
				description = "加载并运行：七无卷轴。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Ahma174/Tool/refs/heads/main/Doors%20Scroll%20Of%20Sevenless.lua"))()
				end,
			},
			{
				name = "长矛（MC 物品）",
				subtitle = "作者：Nowhywhats",
				description = "作者：Nowhywhats",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Spear-Minecraft-Item-Made-By-Nowhywhat"))()
				end,
			},
			{
				name = "好奇蜡烛",
				subtitle = "作者：Kodbol",
				description = "作者：Kodbol",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/kodbolx/kodbolhub/refs/heads/main/curiouscandle.lua"))()
				end,
			},
			{
				name = "Ambush 玩偶",
				description = "加载并运行：Ambush 玩偶。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Plushie-Item/refs/heads/main/Ambush-Plushie"))()
				end,
			},
			{
				name = "Rush 玩偶",
				description = "加载并运行：Rush 玩偶。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eliazbp92-collab/Plushie1/refs/heads/main/Rush"))()
				end,
			},
			{
				name = "Gubby 工具",
				subtitle = "作者：Indexell",
				description = "作者：Indexell",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IdkMyNameLoll/PublicScripts/refs/heads/main/IsThatAGubbyTool"))()
				end,
			},
			{
				name = "十字架",
				subtitle = "作者：PenguinManiack",
				description = "作者：PenguinManiack",
				run = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/PenguinManiack/Crucifix/main/Crucifix.lua'))()
				end,
			},
			{
				name = "手雷",
				description = "加载并运行：手雷。",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/zeFBYYy9", true))()
				end,
			},
			{
				name = "无限维生素",
				description = "加载并运行：无限维生素。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/refs/heads/main/Inf_Vitamins.lua"))()
				end,
			},
			{
				name = "月亮药水（修复版）",
				subtitle = "有时候挺有用",
				description = "有时候挺有用",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/MoonJug"))()
				end,
			},
			{
				name = "鲁格手枪",
				description = "加载并运行：鲁格手枪。",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/WcYCnACD"))()
				end,
			},
			{
				name = "火箭筒",
				description = "加载并运行：火箭筒。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/persopoiu/scripts/refs/heads/main/RocketLauncher/script.lua"))()
				end,
			},
			{
				name = "手电筒 V1",
				description = "加载并运行：手电筒 V1。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/binhlforsaken156-sys/Flash-light/refs/heads/main/Flash-light-V1", true))()
				end,
			},
			{
				name = "幸运方块",
				description = "加载并运行：幸运方块。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/NTTTTTTTT/upload/refs/heads/main/content/5d91c0185bdc4dd5b80c84c50d8ba78e_obf.lua",true))()
				end,
			},
			{
				name = "螺旋药瓶",
				description = "加载并运行：螺旋药瓶。",
				run = function()
loadstring(game:HttpGet('https://gist.githubusercontent.com/IdkMyNameLoll/8b05c837bea9effac2554340465b4be1/raw/3f3be0ee72e7f153db39a16a40fa63dce6cde72d/SpiralBottle'))()
				end,
			},
			{
				name = "基金会十字架",
				subtitle = "可以把任何物体钉上十字架，点一下那个物体就行",
				description = "可以把任何物体钉上十字架，点一下那个物体就行",
				run = function()
_G.CR_Uses = 1000000
_G.CR_IsCurious = false
_G.CR_HoldKeyRequired = "false"

loadstring(game:HttpGet("https://raw.githubusercontent.com/IdkMyNameLoll/PublicScripts/refs/heads/main/crucifix_E_A_A"))()
				end,
			},
			{
				name = "A-60 玩偶",
				description = "加载并运行：A-60 玩偶。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Plushie-Item/refs/heads/main/A-60-Plushie"))()
				end,
			},
			{
				name = "A-90 玩偶",
				description = "加载并运行：A-90 玩偶。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eliazbp92-collab/Plushie1/refs/heads/main/A-90"))()
				end,
			},
			{
				name = "幸运饼干",
				description = "加载并运行：幸运饼干。",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/TefMKs39/raw"))()
				end,
			},
			{
				name = "指引手电",
				description = "加载并运行：指引手电。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/binhlforsaken156-sys/Guiding-flash-light/refs/heads/main/Guiding-flash-light.lua", true))()
				end,
			},
			{
				name = "翠绿光药水",
				description = "加载并运行：翠绿光药水。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Scripts/refs/heads/main/Viridislight-Jug"))()
				end,
			},
			{
				name = "Jeff 的小费罐",
				description = "加载并运行：Jeff 的小费罐。",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/Hsuiugnr"))()
				end,
			},
			{
				name = "整蛊十字架",
				description = "加载并运行：整蛊十字架。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Other-Item-Scripts/refs/heads/main/Troll-Crucifix"))()
				end,
			},
			{
				name = "月光药瓶",
				description = "加载并运行：月光药瓶。",
				run = function()
loadstring(game:HttpGet('https://gist.githubusercontent.com/IdkMyNameLoll/04d7dd5e02688624b958b8c2604b924c/raw/9e86b34249f44ed2dd433176e67daaf3db30cde8/MoonBottle'))()
				end,
			},
			{
				name = "Shedletsky 彩蛋（Eggletsky）",
				description = "加载并运行：Shedletsky 彩蛋（Eggletsky）。",
				run = function()
--[[
WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local tool = game:GetObjects("rbxassetid://74933357788345")[1]
tool.Parent = player:WaitForChild("Backpack")

local animationId = "rbxassetid://6516424098"
local animTrack

tool.Equipped:Connect(function()
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)

if animTrack then
animTrack:Stop(0)
animTrack:Destroy()
animTrack = nil
end

local animation = Instance.new("Animation")
animation.AnimationId = animationId

animTrack = animator:LoadAnimation(animation)
animTrack.Priority = Enum.AnimationPriority.Action4
animTrack.Looped = true
animTrack:Play(0, 1, 1)
animTrack:AdjustWeight(1)
end)

tool.Unequipped:Connect(function()
if animTrack then
animTrack:Stop(0)
animTrack:Destroy()
animTrack = nil
end
end)
				end,
			},
			{
				name = "翠绿打火机（需要打火机）",
				description = "加载并运行：翠绿打火机（需要打火机）。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/kodbolx/kodbolhub/refs/heads/main/Items/Viridis%20lighter.lua"))()
				end,
			},
			{
				name = "灯笼道具",
				description = "加载并运行：灯笼道具。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Item/refs/heads/main/lantern"))()
				end,
			},
			{
				name = "螺旋药水（修复版）",
				description = "加载并运行：螺旋药水（修复版）。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/Spiral-Jug"))()
				end,
			},
			{
				name = "火焰喷射器",
				subtitle = "鸣谢：JohnyGaming#2917",
				description = "鸣谢：JohnyGaming#2917",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/JohnyGamingLUA/FlamethrowerDOORS/main/obfuscated.lua"))()
				end,
			},
			{
				name = "草地平板",
				description = "加载并运行：草地平板。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Matthew201322/Doors-Scriptee/refs/heads/main/grass%20tablet.lua"))()
				end,
			},
			{
				name = "Seek 玩偶",
				description = "加载并运行：Seek 玩偶。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Seek-Plushie"))()
				end,
			},
			{
				name = "Screech 玩偶",
				description = "加载并运行：Screech 玩偶。",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/CRYiKPZX"))()
				end,
			},
			{
				name = "翠绿光药瓶",
				description = "加载并运行：翠绿光药瓶。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Scripts/refs/heads/main/Viridislight-Bottle"))()
				end,
			},
			{
				name = "紫色摇曳光",
				description = "加载并运行：紫色摇曳光。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostw3r/Scripts/refs/heads/main/PurpleFlashlight.lua"))()
				end,
			},
			{
				name = "遗弃工具",
				description = "加载并运行：遗弃工具。",
				run = function()
loadstring(game:HttpGet("https://rawscripts.net/raw/DOORS-DAILY-RUNS-forsaken-useless-tool-pack-94779"))()
				end,
			},
			{
				name = "Maxwell 工具",
				description = "加载并运行：Maxwell 工具。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/CastiSeek/Maxwell-the-cat-script/refs/heads/main/main.lua"))()
				end,
			},
			{
				name = "Rebound 玩偶",
				description = "加载并运行：Rebound 玩偶。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Plushie-Item/refs/heads/main/Rebound-Plushie"))()
				end,
			},
			{
				name = "魔法书",
				description = "加载并运行：魔法书。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/skkenrgjt/HAHAHAH/refs/heads/main/MagicRunner"))()
				end,
			},
			{
				name = "管理员耳光",
				subtitle = "作者：Guestly (Celestian)",
				description = "作者：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Scripts/refs/heads/main/Admin-Slap-For-DOORS-made-by-Celestian-(Guestly)-on-Discord"))()
				end,
			},
			{
				name = "Seek 枪",
				description = "加载并运行：Seek 枪。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/persopoiu/scripts/main/seekgun.lua"))()
				end,
			},
			{
				name = "NVCS-3000",
				description = "加载并运行：NVCS-3000。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostw3r/Scripts/main/NVCS-3000.lua"))()
				end,
			},
			{
				name = "M249 机枪",
				description = "加载并运行：M249 机枪。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/hi822010/Extras-Gliese-Hub-Doors/refs/heads/main/M249"))()
				end,
			},
			{
				name = "AK-47 步枪",
				description = "加载并运行：AK-47 步枪。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzzGabbbb/AK47Fixed/refs/heads/main/Ak47ByPenguinManiackFixedByGab.lua"))()
				end,
			},
			{
				name = "道具发放器 V3 | Doors",
				subtitle = "Darli17",
				description = "Darli17",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Darli17/Entities/refs/heads/main/Tools", true))()
				end,
			},
			{
				name = "RobHub X 道具发放器",
				description = "加载并运行：RobHub X 道具发放器。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Darli17/DOORS-REBOUNCES/refs/heads/main/main-ig"))()
				end,
			},
			{
				name = "星光桶",
				description = "加载并运行：星光桶。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/notpoiu/Scripts/refs/heads/main/StarJug.lua"))()
				end,
			},
			{
				name = "顽劣十字架",
				description = "加载并运行：顽劣十字架。",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Teilsthebfdifan/Modhub-assets/refs/heads/main/MischievousV2Test.lua"))()
				end,
			},
			{
				name = "大小棒（已更新）",
				description = "加载并运行：大小棒（已更新）。",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/dy85jtB6/raw"))()
				end,
			},
			{
				name = "故障十字架特效（光敏警告）",
				subtitle = "光敏警告 • 不会给你十字架",
				description = "光敏警告：给十字架加故障特效。不会给你十字架，但你拿到十字架时会自动生效。",
				confirm = true,
				confirmText = "光敏警告：这会给十字架加故障特效。如果闪光或故障特效会让你不适，请不要运行。它不会给你十字架。还是运行吗？",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/ptp98dnD/raw"))()
				end,
			},
		},
	},
	{
		name = "模式 2",
		section = "模式第二部分",
		buttons = {
			{
				name = "硬核模式（高清重制）",
				subtitle = "鸣谢：someone that idk",
				description = "鸣谢：someone that idk",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/daiayday/HardcoreRemastered/refs/heads/main/obf_L6zO2N0sG5ehDHd56JBc5z70TZ2piVOvIqsgE88741HXGrwv7E4qd6c8axu8z4oh.lua.txt"))()
				end,
			},
			{
				name = "破碎模式（复刻??）",
				subtitle = "重制：THE_LOSTW3R",
				description = "重制：THE_LOSTW3R",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostw3r/Mods/refs/heads/main/FragmentedModeRemake.lua"))()
				end,
			},
			{
				name = "不可能模式（高清重制）",
				subtitle = "作者：Neko tiv (Chu be te liet) & RealblueYT",
				description = "作者：Neko tiv (Chu be te liet) & RealblueYT",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/iH9k0iU9/raw"))()
				end,
			},
			{
				name = "岩浆模式 V2.1（修复版）",
				subtitle = "修复：Reboundplayz",
				description = "修复：Reboundplayz",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/laver%20mode"))()
				end,
			},
			{
				name = "梦魇模式 V2",
				subtitle = "作者：Kodbol & Asif",
				description = "作者：Kodbol & Asif",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Kodbol/Doors/refs/heads/main/Nightmare%20Mode/Main.lua"))()
				end,
			},
			{
				name = "硬核模式（回归版）",
				subtitle = "作者：Reboundplayz",
				description = "作者：Reboundplayz",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/hc%20revisited"))()
				end,
			},
			{
				name = "低模房间模式",
				subtitle = "作者：Rebound",
				description = "作者：Rebound",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eliazbp92-collab/Rooms-low-detailed-mode-doors/refs/heads/main/Script"))()
				end,
			},
			{
				name = "极致模式",
				subtitle = "作者：OG Hunger (New) & Thanhpok",
				description = "作者：OG Hunger (New) & Thanhpok",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/Extremely/refs/heads/main/Extremely%20Mode"))()
				end,
			},
			{
				name = "终结模式",
				subtitle = "作者：UnknownReturnz",
				description = "作者：UnknownReturnz",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/hT2Q5AKa/raw"))()
				end,
			},
			{
				name = "混沌模式 V1",
				subtitle = "鸣谢：DJ SD (Tunder8401)",
				description = "鸣谢：DJ SD (Tunder8401)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Tunder8401/Doors-Modes/refs/heads/main/Chaos%20Mode"))()
				end,
			},
			{
				name = "眼睛模式（赌运气）",
				subtitle = "作者：Guestly, also get rare eyes to get a CW",
				description = "作者：Guestly, also get rare eyes to get a CW",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/EYES-MODE"))()
				end,
			},
			{
				name = "熄灭模式",
				subtitle = "作者：Anctarus7105",
				description = "作者：Anctarus7105",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Anctarus7105/My-Modes/refs/heads/main/SnufferV1.lua"))()
				end,
			},
			{
				name = "断电模式",
				subtitle = "作者：Rip_Silence",
				description = "作者：Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Blackout-Mode-Main.lua"))()
				end,
			},
			{
				name = "失控模式",
				subtitle = "作者：Rip_Silence",
				description = "作者：Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Unhinged-Mode-Main.lua"))()
				end,
			},
			{
				name = "幽灵模式",
				subtitle = "作者：Anctarus7105",
				description = "作者：Anctarus7105",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Anctarus7105/My-Modes/refs/heads/main/Ghostly.lua"))()
				end,
			},
			{
				name = "感染模式",
				subtitle = "作者：Leo -LXD-",
				description = "作者：Leo -LXD-",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Doors-Hub/refs/heads/main/Infection-Mode-Made-By-Leo"))()
				end,
			},
			{
				name = "休眠模式",
				subtitle = "作者：Idk.chud",
				description = "作者：Idk.chud",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Other-Modes-Script/refs/heads/main/Dormant-Mode-Made-By-Chud"))()
				end,
			},
			{
				name = "究极硬核模式",
				subtitle = "作者：UnknownReturnz",
				description = "作者：UnknownReturnz",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/jGU3jxSe/raw"))()
				end,
			},
			{
				name = "故障模式（修复版）",
				subtitle = "作者：TheDarkMan1334",
				description = "作者：TheDarkMan1334",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Broken-Mode-V1.8-Fixed-Version"))()
				end,
			},
			{
				name = "混乱模式（重制）",
				subtitle = "作者：OG Hunger (New)",
				description = "作者：OG Hunger (New)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/Mayhem-Remake/refs/heads/main/Mayhem%20Remake"))()
				end,
			},
			{
				name = "优雅模式（重制）",
				subtitle = "鸣谢：someone that idk",
				description = "鸣谢：someone that idk",
				run = function()
loadstring(game:HttpGet("https://github.com/IdkMyNameLoll/PublicScripts/raw/refs/heads/main/DoorsXGrace.lua", true))()
				end,
			},
			{
				name = "超级疯狂模式",
				subtitle = "鸣谢：Dt_roblx doors:))",
				description = "鸣谢：Dt_roblx doors:))",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme2/dm123/refs/heads/main/super%20crazy%20mode"))()
				end,
			},
			{
				name = "黑暗通道模式",
				subtitle = "作者：Rebound",
				description = "作者：Rebound",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eliazbp92-collab/Dark-passage-mode/refs/heads/main/Script"))()
				end,
			},
			{
				name = "硬核模式（重拍）",
				subtitle = "作者：Purple Hatso",
				description = "作者：Purple Hatso",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Hardcore-Mode-(Retake)"))()
				end,
			},
			{
				name = "不可能模式 V2（高清重制）",
				subtitle = "作者：RealblueYT",
				description = "作者：RealblueYT",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/NLdC5hRo/raw"))()
				end,
			},
			{
				name = "破碎模式（重燃）",
				subtitle = "作者：OG Hunger (New)",
				description = "作者：OG Hunger (New)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/Fragmentend-Reiginited/refs/heads/main/Fragmented%20Reiginited"))()
				end,
			},
			{
				name = "硬核重燃模式（重制版）",
				subtitle = "鸣谢：Guestly (Celestian)",
				description = "鸣谢：Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/Hardcore-Reignited-(Recreated)"))()
				end,
			},
			{
				name = "负片模式",
				subtitle = "作者：Rebound",
				description = "作者：Rebound",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eliazbp92-collab/WHAT-IS-A-SOILD-OCTO-ROTRAY-PHONE-/refs/heads/main/Script"))()
				end,
			},
			{
				name = "心智模式",
				subtitle = "作者：TheLastOne",
				description = "作者：TheLastOne",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TheLastOne5778/Read/refs/heads/main/Mental%20Mode"))()
				end,
			},
			{
				name = "深渊模式",
				subtitle = "作者：Grampy",
				description = "作者：Grampy",
				run = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/GrampyMods/AbyssMode/refs/heads/main/mainfile'))()
				end,
			},
			{
				name = "冰霜模式",
				subtitle = "作者：RealblueYT",
				description = "作者：RealblueYT",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/vpHzXSDy/raw"))()
				end,
			},
			{
				name = "超拥挤模式",
				subtitle = "鸣谢：Zunxd",
				description = "鸣谢：Zunxd",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Doors-sieu-don-mode/refs/heads/main/Modeee"))()
				end,
			},
			{
				name = "硬核模式（堕落）",
				subtitle = "作者：RealblueYT",
				description = "作者：RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Hardcore-degenerate/refs/heads/main/hardcore%20degenerate.txt"))()
				end,
			},
			{
				name = "破碎模式测试版（复刻）",
				subtitle = "作者：Hello Im Rippah",
				description = "作者：Hello Im Rippah",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/brylesantos38-cell/FragmentedModeAlphaRecreation/refs/heads/main/obfuscated_script-1783648290063.lua.txt"))()
				end,
			},
			{
				name = "幻象模式（不可能版）",
				subtitle = "鸣谢：Guestly (Celestian) and Rip_Silence",
				description = "鸣谢：Guestly (Celestian) and Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Hallucination-Mode-SUPER-IMPOSSIBLE-/refs/heads/main/Hallucination%20Mode%20(IMPOSSIBLE)"))()
				end,
			},
			{
				name = "渺茫模式 最终版（不可能）",
				subtitle = "鸣谢：Chu be the liet & AmadeyHunter & Rip_Silence",
				description = "鸣谢：Chu be the liet & AmadeyHunter & Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Improbable-Mode-Final-Version"))()
				end,
			},
			{
				name = "不可能模式 V1.8（测试版）",
				subtitle = "有点坏 • 鸣谢：Oof",
				description = "Oof 的不可能模式 V1.8（测试版）。注意：这个有点坏，部分功能可能不正常。",
				confirm = true,
				confirmText = "这个模式有点坏（测试版），部分功能可能不正常。还是运行吗？",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/NTTTTTTTT/upload/refs/heads/main/content/eaeb44fe563342b38ab1f6ee9735e584_obf.lua", true))()
				end,
			},
			{
				name = "疯狂模式 1.2",
				subtitle = "疯狂模式",
				description = "疯狂模式 1.2",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/VOny4364/raw"))()
				end,
			},
			{
				name = "懒得写说明了",
				subtitle = "还没测试过",
				description = "还没测试过，自行承担风险。",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/WVzszleB/raw",true))()
				end,
			},
		},
	},
}

local UPDATE_LOGS = {
[[V36 - 抱歉让大家久等了，这次比我想的久得多。感谢等待！

WH1T3（relayhost）帮忙重做了整个界面，现在成为副站长。全新外观 + 圣诞主题、新的工具页、最常使用、今日脚本、紧急隐藏按钮、手机适配（屏幕按钮）+ 可开关的快捷键、新徽章、排序按钮、笔记页、视野滑条 + FPS 提升、音乐播放列表 + 随机播放、新配色。

新增：疯狂模式 1.2、懒得写说明了、无尽模式、旧版 Seek、A-60（混沌实体）、不可能模式 V1.8（测试版）、不可能模式 V2（高清重制）、噪音（含故障版）、紫色摇曳光（全部裂隙）、Twinkhook 合集、头目生成器、故障十字架特效、硬核模式（超老版本）、格拉迪什模式、硬核模式（重拍加强版）、混乱模式（重制 + 经典版）、休眠模式、幽灵模式、究极硬核模式、熄灭模式、终结模式、负片模式、黑暗通道模式、低模房间模式、Doors 合集 + 编辑器（测试版）、彩虹房间、Maxwell 工具、整蛊十字架、A-60 / 回弹者 / A-90 / Ambush / Rush 玩偶，以及旋风者、A-100、A-75、A-185、执念者、Pim、质问者、B ∆ B 和 Ch4s3r_Thre4t 生成器。

更新：硬核重燃模式、WH1T3 生成器（重制）、故障模式。

替换：骗人模式 → 僵尸模式，月狂模式（重制）→ 精神分裂模式。

移除已锁定/已删除的脚本：恐惧模式、困难模式、水位上升模式、兽人模式。]],
}
-- People shown in the "致谢" tab
-- (subtitle = short line under the name, description = shown in the details)
local CREDITS = {
	{
		name = "寂静（Silence）",
		subtitle = "Hub 作者（Rip_Silence）",
		description = "Doors 模式合集的作者，超酷的人。",
	},
	{
		name = "WH1T3（副站长）",
		subtitle = "Hub 副站长（relayhost）",
		description = "Doors 模式合集副站长。做了整套界面、V36 更新、手机适配和圣诞主题。",
	},
	{
		name = "Greed_GamingMobile",
		subtitle = "灵感来源",
		description = "本 Hub 灵感来自 Greed_GamingMobile 的 Hub。",
	},
	{
		name = "RealblueYT",
		subtitle = "聊天签名文案",
		description = "鸣谢：RealblueYT 的聊天签名文案",
	},
	{
		name = "WH1T3（界面作者）",
		subtitle = "制作了 Hub 界面",
		description = "Doors 模式合集界面的设计者（万圣节版与圣诞版）。",
	},
	{
		name = "WH1T3（V36 界面更新）",
		subtitle = "主导 V36 界面改版",
		description = "提议并主导 V36 界面升级：工具页、最常使用、紧急隐藏按钮和手机操作。",
	},
	{
		name = "WH1T3（手机适配）",
		subtitle = "推动手机与平板适配",
		description = "确保 Hub 在手机上好用：用屏幕按钮代替快捷键。",
	},
	{
		name = "匿名者",
		subtitle = "协助编写部分界面 / Hub 代码",
		description = "协助写了界面上一些功能的代码，喜欢南瓜。",
	},
	{
		name = "你！",
		subtitle = "感谢使用本 Hub",
		description = "鸣谢：你！（谢谢你使用我的 Hub）",
	},
}

-- (You can stop editing here, the rest is the engine.)

-- SAVED DATA (favorites, playlist, settings). Needs writefile/readfile;
-- without them everything still works, it just isn't remembered.
local HttpService = game:GetService("HttpService")
local SAVE_FILE = "HalloweenHub_v6_save.json"
local saved = {
	favorites = {},
	playlist = {},
	notifications = true,
	confirm = false,
	loop = true,
	runs = {},
	accent = "蔓越莓",
	antiAfk = true,
	keybinds = true,
	sort = "default",
	autoHide = false,
	shuffle = false,
	notes = "",
	streak = 0,
	bestStreak = 0,
	lastDay = "",
	rainbow = false,
	sparkles = true,
}

-- Load only recognized fields and validate their types. A corrupted or
-- manually edited save file should never replace settings with bad values.
pcall(function()
	if isfile and readfile and isfile(SAVE_FILE) then
		local ok, data = pcall(function()
			return HttpService:JSONDecode(readfile(SAVE_FILE))
		end)

		if ok and type(data) == "table" then
			if type(data.favorites) == "table" then
				saved.favorites = data.favorites
			end
			if type(data.playlist) == "table" then
				saved.playlist = data.playlist
			end
			if type(data.notifications) == "boolean" then
				saved.notifications = data.notifications
			end
			if type(data.confirm) == "boolean" then
				saved.confirm = data.confirm
			end
			if type(data.loop) == "boolean" then
				saved.loop = data.loop
			end
			if type(data.runs) == "table" then
				for k, v in pairs(data.runs) do
					if type(k) == "string" and type(v) == "number" then
						saved.runs[k] = v
					end
				end
			end
			if type(data.lang) == "string" then
				saved.lang = data.lang
			end
			if type(data.keybinds) == "boolean" then
				saved.keybinds = data.keybinds
			end
			if type(data.quickBar) == "boolean" then
				saved.quickBar = data.quickBar
			end
			if type(data.accent) == "string" then
				saved.accent = data.accent
			end
			if type(data.antiAfk) == "boolean" then
				saved.antiAfk = data.antiAfk
			end
			if type(data.sort) == "string" then
				saved.sort = data.sort
			end
			if type(data.autoHide) == "boolean" then
				saved.autoHide = data.autoHide
			end
			if type(data.shuffle) == "boolean" then
				saved.shuffle = data.shuffle
			end
			if type(data.autoplay) == "boolean" then
				saved.autoplay = data.autoplay
			end
			if type(data.seenV12) == "boolean" then
				saved.seenV12 = data.seenV12
			end
			if type(data.rainbow) == "boolean" then
				saved.rainbow = data.rainbow
			end
			if type(data.sparkles) == "boolean" then
				saved.sparkles = data.sparkles
			end
			if type(data.seenV11) == "boolean" then
				saved.seenV11 = data.seenV11
			end
			if type(data.streak) == "number" then
				saved.streak = math.max(0, math.floor(data.streak))
			end
			if type(data.bestStreak) == "number" then
				saved.bestStreak = math.max(0, math.floor(data.bestStreak))
			end
			if type(data.lastDay) == "string" then
				saved.lastDay = data.lastDay:sub(1, 10)
			end
			if type(data.seenV10) == "boolean" then
				saved.seenV10 = data.seenV10
			end
			if type(data.notes) == "string" then
				saved.notes = data.notes:sub(1, 4000)
			end
			if type(data.volume) == "number" then
				saved.volume = math.clamp(data.volume, 0, 100)
			end
			if type(data.last) == "table" then
				saved.last = data.last
			end
		end
	end
end)

local function saveData()
	pcall(function()
		if writefile then
			writefile(SAVE_FILE, HttpService:JSONEncode(saved))
		end
	end)
end

local saveToken = 0
local function saveSoon() -- for sliders: saves 1s after you stop moving
	saveToken += 1
	local mine = saveToken
	task.delay(1, function()
		if mine == saveToken then
			saveData()
		end
	end)
end

-- LANGUAGES (English, Spanish, Portuguese, French). Settings > Language to change it.
-- First run uses your Roblox language automatically. Script names stay as they are.
local LANGS = {
	{ code = "en", name = "英语" },
	{ code = "es", name = "Español" },
	{ code = "pt", name = "Português" },
	{ code = "fr", name = "Français" },
}
local TRANSLATIONS = {}
local langCode = saved.lang
if langCode == nil then
	local okL, localeId = pcall(function()
		return game:GetService("LocalizationService").RobloxLocaleId
	end)
	langCode = okL and tostring(localeId):sub(1, 2):lower() or "en"
end
if langCode ~= "en" and not TRANSLATIONS[langCode] then
	langCode = "en"
end
-- Add-ons can set HubHooks.textFilter = function(text) ... end to restyle every piece of UI text.
local HubHooks = { textFilter = nil }

local function T(text, code)
	if type(text) ~= "string" then
		return text
	end
	local tr = TRANSLATIONS[code or langCode]
	local res = (tr and tr[text]) or text
	if HubHooks.textFilter then
		local okF, out = pcall(HubHooks.textFilter, res)
		if okF and type(out) == "string" then
			return out
		end
	end
	return res
end
local function TL(code, key, ...)
	local okF, out = pcall(string.format, T(key, code), ...)
	return okF and out or key
end
local function TF(key, ...)
	return TL(langCode, key, ...)
end

local keyNames = {}
for _, k in ipairs(TOGGLE_KEYS) do
	table.insert(keyNames, k.Name)
end
-- true on phones/tablets without a keyboard
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local TOGGLE_KEY_TEXT = (#keyNames > 0 and not isMobile) and table.concat(keyNames, " / ") or T("圆形按钮")

-- Remove ANY old copies (older versions or a previous run of this script)
local OLD_NAMES = { "HalloweenHub", "HalloweenHubV2", "HalloweenHubV3", "HalloweenHubV4", "HalloweenHubV5", "Silence hub V36. WH1T3 hub V6", "DoorsModesHubV37", "DoorsModesHubV36", "Silence hub V36 - WH1T3 GUI V7.5", "Silence hub V36 - WH1T3 GUI V10", "Silence hub V36 - WH1T3 GUI V11", "Silence hub V36 - WH1T3 GUI V12", GUI_NAME }
for _, child in ipairs(playerGui:GetChildren()) do
	if table.find(OLD_NAMES, child.Name) then
		child:Destroy()
	end
end

-- THEME + HELPERS
local THEME = {
	bg = Color3.fromRGB(15, 20, 17),
	panel = Color3.fromRGB(23, 30, 26),
	panelLight = Color3.fromRGB(34, 44, 38),
	line = Color3.fromRGB(52, 64, 57),
	orange = Color3.fromRGB(192, 54, 66), -- main accent (name kept so old add-ons still work)
	purple = Color3.fromRGB(52, 64, 57), -- was the 2nd accent, now just the outline grey
	text = Color3.fromRGB(232, 226, 214),
	muted = Color3.fromRGB(135, 145, 138),
	danger = Color3.fromRGB(214, 84, 70),
	font = Enum.Font.Gotham,
	fontMed = Enum.Font.GothamMedium,
	fontBold = Enum.Font.GothamBold,
}
-- newer roblox font if the client has it, otherwise Gotham stays
pcall(function()
	local a, b, c = Enum.Font.BuilderSans, Enum.Font.BuilderSansMedium, Enum.Font.BuilderSansBold
	THEME.font, THEME.fontMed, THEME.fontBold = a, b, c
end)

-- Accent color presets (Settings > Accent color). Applied when the hub starts.
local ACCENTS = {
	{ name = "蔓越莓", main = Color3.fromRGB(192, 54, 66) },
	{ name = "冬青", main = Color3.fromRGB(96, 158, 108) },
	{ name = "黄金", main = Color3.fromRGB(212, 172, 84) },
	{ name = "霜白", main = Color3.fromRGB(148, 192, 210) },
	{ name = "糖果", main = Color3.fromRGB(220, 124, 140) },
	{ name = "骨白", main = Color3.fromRGB(214, 206, 190) },
	{ name = "墨黑", main = Color3.fromRGB(116, 136, 196) },
	{ name = "灰烬", main = Color3.fromRGB(160, 160, 164) },
}
local accentIndex = 1
for i, a in ipairs(ACCENTS) do
	if a.name == saved.accent then
		accentIndex = i
	end
end
THEME.orange = ACCENTS[accentIndex].main

-- make("Frame", { Size = ..., ... }, parent) -> creates, sets props, parents LAST
local function make(class, props, parent)
	local obj = Instance.new(class)
	if obj:IsA("GuiObject") then
		obj.BorderSizePixel = 0
	end
	if obj:IsA("GuiButton") then
		obj.AutoButtonColor = false
	end
	for prop, value in pairs(props) do
		obj[prop] = value
	end
	obj.Parent = parent
	return obj
end

local function tween(obj, time, props, style, dir)
	local t = TweenService:Create(
		obj,
		TweenInfo.new(time, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out),
		props
	)
	t:Play()
	return t
end

local function pulse(obj, prop, toValue, time)
	TweenService:Create(
		obj,
		TweenInfo.new(time or 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
		{ [prop] = toValue }
	):Play()
end

local function corner(obj, radius)
	return make("UICorner", { CornerRadius = UDim.new(0, radius) }, obj)
end

local function stroke(obj, color, thickness)
	return make("UIStroke", {
		Color = color,
		Thickness = thickness,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, obj)
end

local layoutCounter = 0
local function nextOrder()
	layoutCounter += 1
	return layoutCounter
end

-- Fades a frame and everything inside it
local function fadeOut(root, time)
	local info = TweenInfo.new(time)
	local function go(obj)
		if obj:IsA("GuiObject") then
			TweenService:Create(obj, info, { BackgroundTransparency = 1 }):Play()
		end
		if obj:IsA("TextLabel") or obj:IsA("TextButton") then
			TweenService:Create(obj, info, { TextTransparency = 1 }):Play()
		end
		if obj:IsA("UIStroke") then
			TweenService:Create(obj, info, { Transparency = 1 }):Play()
		end
	end
	go(root)
	for _, d in ipairs(root:GetDescendants()) do
		go(d)
	end
end

-- Global connections get cleaned up when the UI is destroyed
local connections = {}
local function track(conn)
	table.insert(connections, conn)
	return conn
end

local gui = make("ScreenGui", {
	Name = GUI_NAME,
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	DisplayOrder = 100,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, playerGui) -- change this parent if your hub loads differently

gui.Destroying:Connect(function()
	for _, c in ipairs(connections) do
		c:Disconnect()
	end
end)

-- EVERYTHING BELOW RUNS INSIDE pcall:
-- if anything errors, the UI removes itself (no stuck boxes)
-- and the error is printed.
local ok, err = pcall(function()
	-- Layer order: effects 1 < window 5 < pumpkin 10 < toasts 50 < loading 100
	local effectsLayer = make("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ZIndex = 1,
	}, gui)

	-- TOASTS
	local notificationsEnabled = saved.notifications ~= false

	local toastHolder = make("Frame", {
		Size = UDim2.new(0, 260, 1, -30),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -12, 0, 12),
		BackgroundTransparency = 1,
		ZIndex = 50,
	}, gui)
	make("UIListLayout", {
		Padding = UDim.new(0, 6),
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, toastHolder)

	local function notify(text, duration)
		if not notificationsEnabled then
			return
		end
		local slot = make("Frame", {
			Size = UDim2.fromOffset(250, 44),
			BackgroundTransparency = 1,
			LayoutOrder = nextOrder(),
		}, toastHolder)
		local toast = make("Frame", {
			Size = UDim2.fromScale(1, 1),
			Position = UDim2.new(1.4, 0, 0, 0),
			BackgroundColor3 = THEME.panel,
		}, slot)
		corner(toast, 4)
		stroke(toast, THEME.line, 1)
		make("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -24, 1, 0),
			Position = UDim2.fromOffset(16, 0),
			Text = T(text),
			TextColor3 = THEME.text,
			Font = THEME.fontMed,
			TextSize = 14,
			TextWrapped = true,
		}, toast)

		-- thin accent bar on the left + a timer line that shrinks until the toast leaves
		toast.ClipsDescendants = true
		local accentBar = make("Frame", {
			Size = UDim2.new(0, 2, 1, 0),
			BackgroundColor3 = THEME.orange,
		}, toast)
		local timerBar = make("Frame", {
			Size = UDim2.new(1, 0, 0, 2),
			Position = UDim2.new(0, 0, 1, -2),
			BackgroundColor3 = THEME.orange,
		}, toast)
		tween(timerBar, duration or 2.5, { Size = UDim2.new(0, 0, 0, 2) }, Enum.EasingStyle.Linear)
		tween(toast, 0.3, { Position = UDim2.new(0, 0, 0, 0) }, Enum.EasingStyle.Quint)
		task.delay(duration or 2.5, function()
			tween(toast, 0.25, { Position = UDim2.new(1.4, 0, 0, 0) }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			task.wait(0.3)
			slot:Destroy()
		end)
	end
	hub.notify = notify -- now your buttons can call hub.notify("text")

	-- Runs a callback safely: one broken button can't break the whole UI
	local function safeCall(fn, ...)
		local success, e = pcall(fn, ...)
		if not success then
			warn("[HalloweenHub] 回调错误：", e)
			notify("脚本错误（详见控制台）")
		end
	end

	-- DRAGGING (mouse + touch). A short tap counts as a click.
	local function makeDraggable(handle, target, onTap, onDrop)
		local dragging, moved = false, false
		local dragStart, startPos

		handle.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				dragging, moved = true, false
				dragStart = input.Position
				startPos = target.Position
			end
		end)
		track(UserInputService.InputChanged:Connect(function(input)
			if not dragging then
				return
			end
			if input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch then
				local delta = input.Position - dragStart
				if delta.Magnitude > 6 then
					moved = true
				end
				if moved then
					target.Position = UDim2.new(
						startPos.X.Scale, startPos.X.Offset + delta.X,
						startPos.Y.Scale, startPos.Y.Offset + delta.Y
					)
				end
			end
		end))
		track(UserInputService.InputEnded:Connect(function(input)
			if not dragging then
				return
			end
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				dragging = false
				if moved then
					if onDrop then
						onDrop()
					end
				elseif onTap then
					onTap()
				end
			end
		end))
	end

	-- WINDOW (sized to fit your screen)
	local BASE_W, BASE_H = 470, 300

	local screen = gui.AbsoluteSize
	if screen.X < 100 or screen.Y < 100 then
		local cam = workspace.CurrentCamera
		screen = cam and cam.ViewportSize or Vector2.new(800, 450)
	end
	local fit = math.clamp(math.min(screen.X * 0.9 / BASE_W, screen.Y * 0.75 / BASE_H), 0.5, 1)
	local userScale = 1
	local function targetScale()
		return fit * userScale
	end

	local window = make("Frame", {
		Size = UDim2.fromOffset(BASE_W, BASE_H),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		BackgroundColor3 = THEME.bg,
		Visible = false,
		ZIndex = 5,
	}, gui)
	corner(window, 6)
	local uiScale = make("UIScale", { Scale = 0.7 }, window)

	-- flat 1px outline. (borderGrad / titleGrad stay as nil so add-ons that read them don't break)
	stroke(window, THEME.line, 1)
	local borderGrad, titleGrad = nil, nil
	local rainbowOn = false
	local function setRainbow() end
	local function accentSequence()
		return ColorSequence.new(THEME.orange, THEME.orange)
	end

	local topBar = make("Frame", {
		Size = UDim2.new(1, 0, 0, 36),
		BackgroundColor3 = THEME.panel,
	}, window)
	corner(topBar, 6)
	make("Frame", {
		Size = UDim2.new(1, 0, 0, 12),
		Position = UDim2.new(0, 0, 1, -12),
		BackgroundColor3 = THEME.panel,
	}, topBar)

	local titleLabel = make("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -150, 1, 0),
		Position = UDim2.fromOffset(12, 0),
		RichText = true,
		Text = HUB_TITLE .. string.format(
			'  <font size="11" color="rgb(%d,%d,%d)">v36</font>',
			math.floor(THEME.muted.R * 255 + 0.5), math.floor(THEME.muted.G * 255 + 0.5), math.floor(THEME.muted.B * 255 + 0.5)
		),
		TextColor3 = THEME.text,
		Font = THEME.fontBold,
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, topBar)

	local function topButton(text, xOffset, color)
		local b = make("TextButton", {
			Size = UDim2.fromOffset(28, 28),
			Position = UDim2.new(1, xOffset, 0, 4),
			BackgroundColor3 = color,
			Text = text,
			TextColor3 = THEME.text,
			Font = THEME.fontBold,
			TextSize = 16,
		}, topBar)
		corner(b, 4)
		return b
	end
	local minBtn = topButton("-", -68, THEME.purple)
	local closeBtn = topButton("X", -34, THEME.danger)
	local musicBtn = topButton("", -102, THEME.panelLight)

	local body = make("Frame", {
		Size = UDim2.new(1, 0, 1, -36),
		Position = UDim2.fromOffset(0, 36),
		BackgroundTransparency = 1,
	}, window)

	local tabList = make("ScrollingFrame", {
		Size = UDim2.new(0, 124, 1, -14),
		Position = UDim2.fromOffset(8, 6),
		BackgroundTransparency = 1,
		ScrollBarThickness = 2,
		ScrollBarImageColor3 = THEME.line,
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
	}, body)
	make("UIListLayout", {
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, tabList)

	local pageArea = make("Frame", {
		Size = UDim2.new(1, -148, 1, -14),
		Position = UDim2.fromOffset(140, 6),
		BackgroundColor3 = THEME.panel,
	}, body)
	corner(pageArea, 5)

	-- DIALOG (one reusable popup: details, confirmations, close)
	local overlay = make("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.4,
		Active = true, -- blocks clicks from reaching the window underneath
		Visible = false,
		ZIndex = 20,
	}, window)
	corner(overlay, 6)

	local dialog = make("Frame", {
		Size = UDim2.fromOffset(330, 190),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		BackgroundColor3 = THEME.panel,
	}, overlay)
	corner(dialog, 6)
	local dialogStroke = stroke(dialog, THEME.purple, 1)
	local dialogScale = make("UIScale", { Scale = 1 }, dialog)

	local dialogTitle = make("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -20, 0, 36),
		Position = UDim2.fromOffset(10, 6),
		Text = "",
		TextColor3 = THEME.text,
		Font = THEME.fontBold,
		TextSize = 16,
		TextTruncate = Enum.TextTruncate.AtEnd,
	}, dialog)

	-- scrolls if the text is long
	local bodyScroll = make("ScrollingFrame", {
		Size = UDim2.new(1, -24, 1, -96),
		Position = UDim2.fromOffset(12, 44),
		BackgroundTransparency = 1,
		ScrollBarThickness = 2,
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
	}, dialog)
	local dialogBody = make("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -6, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Text = "",
		TextColor3 = THEME.text,
		Font = THEME.font,
		TextSize = 14,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
	}, bodyScroll)

	local function dialogButton()
		local b = make("TextButton", {
			Size = UDim2.new(0.5, -15, 0, 32),
			BackgroundColor3 = THEME.purple,
			Text = "",
			TextColor3 = THEME.text,
			Font = THEME.fontBold,
			TextSize = 14,
		}, dialog)
		corner(b, 4)
		return b
	end
	local btnA, btnB = dialogButton(), dialogButton()
	local callbackA, callbackB

	btnA.MouseButton1Click:Connect(function()
		overlay.Visible = false
		if callbackA then
			safeCall(callbackA)
		end
	end)
	btnB.MouseButton1Click:Connect(function()
		overlay.Visible = false
		if callbackB then
			safeCall(callbackB)
		end
	end)

	-- opts = { title, body, accent, a = {text, color, callback}, b = {text, color, callback} }
	-- If you only give "a", it becomes one wide button.
	local function showDialog(opts)
		dialogStroke.Color = opts.accent or THEME.purple
		dialogTitle.Text = T(opts.title or "")
		dialogBody.Text = T(opts.body or "")
		bodyScroll.CanvasPosition = Vector2.new(0, 0)

		btnA.Text = T(opts.a[1])
		btnA.BackgroundColor3 = opts.a[2] or THEME.purple
		callbackA = opts.a[3]

		if opts.b then
			btnA.Size = UDim2.new(0.5, -15, 0, 32)
			btnA.Position = UDim2.new(0, 10, 1, -42)
			btnB.Visible = true
			btnB.Position = UDim2.new(0.5, 5, 1, -42)
			btnB.Text = T(opts.b[1])
			btnB.BackgroundColor3 = opts.b[2] or THEME.danger
			callbackB = opts.b[3]
		else
			btnA.Size = UDim2.new(1, -20, 0, 32)
			btnA.Position = UDim2.new(0, 10, 1, -42)
			btnB.Visible = false
			callbackB = nil
		end

		overlay.Visible = true
		dialogScale.Scale = 0.85
		tween(dialogScale, 0.2, { Scale = 1 }, Enum.EasingStyle.Back)
	end

	-- The popup behind every three-dots button
	local function showDetails(def, kind)
		local text = T(def.description or "暂无说明。")
		text ..= "\n\n" .. T("类型：") .. " " .. T(kind)
		if def.subtitle and kind == "Credit" then
			text ..= "\n" .. T("身份：") .. " " .. T(def.subtitle)
		end
		if kind == "Button" then
			text ..= "\n" .. T("运行前确认：") .. " " .. (def.confirm and T("是") or T("否"))
		end
		local extra = def.getExtra and def.getExtra()
		showDialog({
			title = (def.icon and (def.icon .. " ") or "") .. T(def.name),
			body = text,
			accent = THEME.purple,
			a = { "关闭", THEME.purple },
			b = extra,
		})
	end

	-- OPEN / CLOSE (minimize = hide into the pumpkin)
	local isOpen = false

	local function setOpen(open)
		if open == isOpen then
			return
		end
		isOpen = open
		if open then
			window.Visible = true
			uiScale.Scale = targetScale() * 0.7
			tween(uiScale, 0.3, { Scale = targetScale() }, Enum.EasingStyle.Back)
		else
			tween(uiScale, 0.2, { Scale = 0.05 }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			task.delay(0.22, function()
				if not isOpen then
					window.Visible = false
				end
			end)
		end
	end

	local function askToClose()
		showDialog({
			title = "这就走了？",
			body = "确定要关闭 Hub 吗？",
			accent = THEME.danger,
			a = { "继续", THEME.purple },
			b = { "关闭", THEME.danger, function()
				setOpen(false)
				task.wait(0.3)
				gui:Destroy()
			end },
		})
	end

	makeDraggable(topBar, window)
	closeBtn.MouseButton1Click:Connect(askToClose)
	minBtn.MouseButton1Click:Connect(function()
		setOpen(false)
		notify("已最小化，点圆形按钮把它叫回来。")
	end)

	-- BACKGROUND MUSIC
	local MarketplaceService = game:GetService("MarketplaceService")

	local musicOn = false
	local musicVolume = math.clamp(saved.volume or MUSIC_VOLUME, 0, 100)
	local loopTrack = saved.loop ~= false
	local shuffleOn = saved.shuffle == true
	local autoplayOn = saved.autoplay
	if autoplayOn == nil then
		autoplayOn = MUSIC_AUTOPLAY
	end
	local playToken = 0
	local musicToggleSet -- filled in when the Music tab is built
	local musicListeners = {} -- called whenever the song / play state changes
	local nowLabel -- the "正在播放" label (Music tab)

	local playlist = {}
	for _, t in ipairs(MUSIC_TRACKS) do
		table.insert(playlist, t)
	end
	for _, t in ipairs(saved.playlist) do
		table.insert(playlist, t)
	end
	local current = (type(saved.last) == "table" and saved.last) or playlist[1]
	local loadedTrack = nil

	local sound = make("Sound", {
		Name = "HubMusic",
		Looped = loopTrack,
		Volume = musicVolume / 100,
	}, gui) -- lives inside the hub, so closing the hub stops the music

	local function fireMusicChanged()
		for _, fn in ipairs(musicListeners) do
			task.spawn(fn)
		end
	end

	local function updateMusicButton()
		tween(musicBtn, 0.15, {
			BackgroundColor3 = musicOn and THEME.orange or THEME.panelLight,
		})
	end

	local function trackName(t)
		return (t and t.name) or "未知歌曲"
	end

	local function sameTrack(a, b)
		return a ~= nil and b ~= nil
			and tostring(a.id) == tostring(b.id)
			and tostring(a.url) == tostring(b.url)
			and tostring(a.file) == tostring(b.file)
	end

	local function indexOfTrack(t)
		for i, other in ipairs(playlist) do
			if sameTrack(other, t) then
				return i
			end
		end
		return nil
	end

	-- Turns a track entry into something Sound.SoundId understands
	local function resolveTrack(track)
		if track.id and tostring(track.id) ~= "" and tostring(track.id) ~= "0" then
			local id = tostring(track.id)
			if not id:find("rbxasset") and not id:find("http") then
				id = "rbxassetid://" .. id
			end
			return id
		end

		local getAsset = getcustomasset or getsynasset
		if getAsset and writefile and isfile then
			local path = track.file
			if track.url then
				local safeName = tostring(track.name or "track"):gsub("%W", "_")
				path = path or ("HalloweenHub_" .. safeName .. ".mp3")
				if not isfile(path) then
					writefile(path, game:HttpGet(track.url))
				end
			end
			if path and isfile(path) then
				return getAsset(path)
			end
		end
		return nil
	end

	local function ensureTrack()
		if loadedTrack == current then
			return true
		end
		local okRes, soundId = pcall(resolveTrack, current)
		if not okRes or not soundId then
			notify(TF("加载不了 \"%s\"（ID / 链接 / 文件有问题？）", trackName(current)), 4)
			return false
		end
		sound:Stop()
		sound.SoundId = soundId
		loadedTrack = current
		return true
	end

	local function setMusic(on)
		if on then
			if not current then
				notify("请先在音乐页粘贴音频 ID。", 3.5)
				on = false
			elseif not ensureTrack() then
				on = false
			else
				sound:Play()
				notify(TF("正在播放：%s", trackName(current)), 2.5)

				-- warn if Roblox refuses to load it (private audio / wrong id)
				playToken += 1
				local myToken = playToken
				task.delay(8, function()
					if myToken == playToken and musicOn and sound.Parent and not sound.IsLoaded then
						notify("这首歌放不出来。ID 错了，或者音频是私有的。", 4.5)
					end
				end)
			end
		else
			playToken += 1
			sound:Pause()
		end
		musicOn = on
		updateMusicButton()
		if musicToggleSet then
			musicToggleSet(on)
		end
		fireMusicChanged()
		return on
	end

	local function playTrack(track)
		current = track
		loadedTrack = nil
		saved.last = { name = track.name, id = track.id, url = track.url, file = track.file }
		saveData()
		sound:Stop()
		setMusic(true)
	end

	local function stepTrack(dir)
		if #playlist == 0 then
			notify("播放列表是空的。先播放一个 ID，再点保存。", 3.5)
			return
		end
		local i = indexOfTrack(current) or (dir > 0 and 0 or 1)
		if shuffleOn and #playlist > 1 then
			local r = i
			while r == i do
				r = math.random(#playlist)
			end
			i = r
		else
			i = (i - 1 + dir) % #playlist + 1
		end
		playTrack(playlist[i])
	end

	-- Paste an id, a "rbxassetid://..." or a Creator Store link
	local function playById(text)
		local digits = tostring(text or ""):match("%d+")
		if not digits or #digits < 5 then
			notify("这看着不像一个音频 ID。", 3)
			return
		end
		local name = "ID " .. digits
		local okInfo, info = pcall(function()
			return MarketplaceService:GetProductInfo(tonumber(digits))
		end)
		if okInfo and type(info) == "table" then
			if info.AssetTypeId and info.AssetTypeId ~= 3 then
				notify("这个 ID 不是音频素材。", 3.5)
				return
			end
			if info.Name then
				name = info.Name
			end
		end
		notify(TF("正在加载 %s...", name), 2)
		playTrack({ name = name, id = digits })
	end

	local function saveCurrentToPlaylist()
		if not current then
			notify("还没东西可保存，先播放一个 ID。", 3)
			return
		end
		if indexOfTrack(current) then
			notify("已经在你的播放列表里了。", 2)
			return
		end
		local entry = { name = current.name, id = current.id, url = current.url, file = current.file }
		table.insert(playlist, entry)
		table.insert(saved.playlist, entry)
		saveData()
		notify(TF("已保存：%s", trackName(entry)), 2.5)
		fireMusicChanged()
	end

	local function removeFromPlaylist(track)
		local i = indexOfTrack(track)
		if i then
			table.remove(playlist, i)
		end
		for j, t in ipairs(saved.playlist) do
			if sameTrack(t, track) then
				table.remove(saved.playlist, j)
				break
			end
		end
		saveData()
		fireMusicChanged()
	end

	local function setLoop(on)
		loopTrack = on
		sound.Looped = on
		saved.loop = on
		saveData()
	end

	sound.Ended:Connect(function() -- only fires when "循环" is off
		if musicOn and not loopTrack then
			stepTrack(1)
		end
	end)

	local function fmtTime(s)
		s = math.max(0, math.floor(s or 0))
		return string.format("%d:%02d", s // 60, s % 60)
	end

	local function nowPlayingText()
		if not current then
			return T("还没选中歌曲。\n在下面粘贴音频 ID 然后点播放。")
		end
		local line = (musicOn and "▶ " or "⏸ ") .. trackName(current)
		if sound.IsLoaded and sound.TimeLength > 0 then
			line ..= "\n" .. fmtTime(sound.TimePosition) .. " / " .. fmtTime(sound.TimeLength)
		end
		return line
	end

	task.spawn(function()
		while gui.Parent do
			if nowLabel and nowLabel.Parent then
				nowLabel.Text = nowPlayingText()
			end
			task.wait(0.5)
		end
	end)

	musicBtn.MouseButton1Click:Connect(function()
		setMusic(not musicOn)
	end)
	-- TABS + COMPONENTS
	local pages = {}
	local tabButtons = {}
	local staleTabs, sortRebuilders = {}, {}
	local builders = {}          -- script tabs fill themselves the first time you open them
	local refreshers = {}        -- pages that rebuild every time you open them
	local confirmScripts = saved.confirm == true -- Settings > "运行前确认"
	local recent = {}            -- last scripts you ran (this session)

	local function pushRecent(def)
		for i = #recent, 1, -1 do
			if recent[i].key == def.key then
				table.remove(recent, i)
			end
		end
		table.insert(recent, 1, def)
		while #recent > 10 do
			table.remove(recent)
		end
	end

	-- Runs a script button WITHOUT freezing the hub, counts it for "最常使用",
	-- and tells you if it worked or failed.
	-- Turns ugly executor errors into something a human can read
	local function friendlyError(msg)
		local low = msg:lower()
		if low:find("http 404", 1, true) or low:find("404 (not found)", 1, true) then
			return T("脚本链接已失效（404），可能已经被删了。")
		elseif low:find("http requests are not enabled", 1, true) then
			return T("你的执行器拦截了这次下载。")
		elseif low:find("timed out", 1, true) then
			return T("下载超时了，再试一次。")
		elseif low:find("loadstring", 1, true) and low:find("nil value", 1, true) then
			return T("你的执行器不支持 loadstring。")
		end
		return msg:sub(1, 100)
	end

	local activeScripts = {} -- prevent accidental double-taps from starting duplicates
	local function runScript(def)
		if activeScripts[def.key] then
			notify(TF("⏳ %s 已经在运行了。", def.name), 2.5)
			return
		end
		activeScripts[def.key] = true
		notify(TF("▶ 正在加载 %s...", def.name), 2)
		pushRecent(def)
		hub.lastRun = def
		hub.sessionRuns = (hub.sessionRuns or 0) + 1
		if saved.autoHide then
			setOpen(false)
		end
		saved.runs[def.key] = (saved.runs[def.key] or 0) + 1
		saveSoon()
		task.spawn(function()
			local t0 = os.clock()
			local success, e = xpcall(def.run, function(err)
				return debug.traceback(tostring(err), 2)
			end)
			activeScripts[def.key] = nil
			if success then
				notify(TF("%s 启动完成（%.1f 秒）", def.name, os.clock() - t0), 2.5)
			else
				warn("[DoorsModesHub] " .. def.name .. " 失败：\n" .. tostring(e))
				notify(TF("%s 失败：%s", def.name, friendlyError(tostring(e))), 5)
			end
		end)
	end

	local tabInds = {} -- the little glowing bar on the left of the active tab
	local activePageName = nil
	local function showPage(name)
		for pageName, page in pairs(pages) do
			local active = (pageName == name)
			if active and not page.Visible then
				-- new page slides up into place
				page.Position = UDim2.fromOffset(6, 24)
				tween(page, 0.3, { Position = UDim2.fromOffset(6, 6) }, Enum.EasingStyle.Quint)
			end
			page.Visible = active
			tween(tabButtons[pageName], 0.15, {
				BackgroundColor3 = active and THEME.purple or THEME.bg,
				TextColor3 = active and Color3.new(1, 1, 1) or THEME.text,
			})
			local ind = tabInds[pageName]
			if ind then
				tween(ind, 0.25, { Size = UDim2.fromOffset(3, active and 16 or 0) }, Enum.EasingStyle.Quint)
			end
		end
		activePageName = name
		local build = builders[name]
		if build then
			builders[name] = nil
			task.spawn(build)
		end
		local stale = staleTabs[name]
		if stale then
			staleTabs[name] = nil
			local rebuild = sortRebuilders[name]
			if rebuild then
				rebuild()
			end
		end
		local refresh = refreshers[name]
		if refresh then
			task.spawn(refresh)
		end
	end

	local function createTab(name)
		local btn = make("TextButton", {
			Size = UDim2.new(1, 0, 0, 32),
			BackgroundColor3 = THEME.bg,
			Text = T(name),
			TextColor3 = THEME.text,
			Font = THEME.fontMed,
			TextSize = 13,
			TextTruncate = Enum.TextTruncate.AtEnd,
			LayoutOrder = nextOrder(),
		}, tabList)
		corner(btn, 4)
		local ind = make("Frame", {
			Size = UDim2.fromOffset(3, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 3, 0.5, 0),
			BackgroundColor3 = THEME.orange,
		}, btn)
		corner(ind, 2)
		tabInds[name] = ind
		btn.MouseEnter:Connect(function()
			if activePageName ~= name then
				tween(btn, 0.12, { BackgroundColor3 = THEME.panelLight })
			end
		end)
		btn.MouseLeave:Connect(function()
			if activePageName ~= name then
				tween(btn, 0.12, { BackgroundColor3 = THEME.bg })
			end
		end)

		local page = make("ScrollingFrame", {
			Size = UDim2.new(1, -12, 1, -12),
			Position = UDim2.fromOffset(6, 6),
			BackgroundTransparency = 1,
			ScrollBarImageColor3 = THEME.line,
			ScrollBarThickness = 3,
			CanvasSize = UDim2.new(),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			Visible = false,
		}, pageArea)
		make("UIListLayout", {
			Padding = UDim.new(0, 6),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}, page)

		pages[name] = page
		tabButtons[name] = btn
		btn.MouseButton1Click:Connect(function()
			showPage(name)
		end)
		return page
	end

	local function addSection(page, text)
		local label = make("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 20),
			Text = T(text),
			TextColor3 = THEME.muted,
			Font = THEME.fontMed,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			LayoutOrder = nextOrder(),
		}, page)
		-- thin line under every section title
		local line = make("Frame", {
			Size = UDim2.new(1, 0, 0, 1),
			Position = UDim2.new(0, 0, 1, -1),
			BackgroundColor3 = THEME.line,
		}, label)
		return label
	end

	local function addLabel(page, text, height, color)
		return make("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, height or 40),
			Text = T(text),
			TextColor3 = color or THEME.text,
			Font = THEME.font,
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			TextWrapped = true,
			LayoutOrder = nextOrder(),
		}, page)
	end

	-- The three-dots button (drawn with 3 little circles, so no font issues)
	local function addDots(parent, def, kind, position)
		local b = make("TextButton", {
			Size = UDim2.fromOffset(28, 30),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = position,
			BackgroundTransparency = 1,
			Text = "",
		}, parent)

		local dots = {}
		for i = 1, 3 do
			local d = make("Frame", {
				Size = UDim2.fromOffset(4, 4),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, (i - 2) * 7),
				BackgroundColor3 = THEME.muted,
			}, b)
			corner(d, 2)
			dots[i] = d
		end
		b.MouseEnter:Connect(function()
			for _, d in ipairs(dots) do
				tween(d, 0.12, { BackgroundColor3 = THEME.orange })
			end
		end)
		b.MouseLeave:Connect(function()
			for _, d in ipairs(dots) do
				tween(d, 0.12, { BackgroundColor3 = THEME.muted })
			end
		end)
		b.MouseButton1Click:Connect(function()
			showDetails(def, kind)
		end)
		return b
	end

	local function hoverEffect(row)
		local rowStroke = row:FindFirstChildOfClass("UIStroke")
		local rowScale = make("UIScale", { Scale = 1 }, row)
		row.ClipsDescendants = true -- keeps the ripple inside the button
		row.MouseEnter:Connect(function()
			tween(row, 0.15, { BackgroundColor3 = THEME.panelLight })
			if rowStroke then
				tween(rowStroke, 0.15, { Color = THEME.orange })
			end
		end)
		row.MouseLeave:Connect(function()
			tween(row, 0.15, { BackgroundColor3 = THEME.bg })
			tween(rowScale, 0.1, { Scale = 1 })
			if rowStroke then
				tween(rowStroke, 0.15, { Color = THEME.purple })
			end
		end)
		-- press squish + a ripple that grows from where you clicked/tapped
		row.MouseButton1Down:Connect(function(x, y)
			tween(rowScale, 0.08, { Scale = 0.985 })
			pcall(function()
				local s = uiScale.Scale
				local rel = Vector2.new(x, y) - row.AbsolutePosition
				local ripple = make("Frame", {
					Size = UDim2.fromOffset(0, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromOffset(rel.X / s, rel.Y / s),
					BackgroundColor3 = THEME.orange,
					BackgroundTransparency = 0.85,
				}, row)
				corner(ripple, 999)
				local size = math.max(row.AbsoluteSize.X / s, 80) * 1.6
				tween(ripple, 0.5, {
					Size = UDim2.fromOffset(size, size),
					BackgroundTransparency = 1,
				})
				task.delay(0.55, function()
					ripple:Destroy()
				end)
			end)
		end)
		row.MouseButton1Up:Connect(function()
			tween(rowScale, 0.15, { Scale = 1 }, Enum.EasingStyle.Back)
		end)
	end

	-- BUTTON: def = { name, description, confirm, confirmText, icon, subtitle, run }
	-- (no "run" = just opens the details, used by the Credits tab)
	local function addButton(page, def)
		local hasSub = def.subtitle ~= nil
		local kind = def.kind or (def.run and "Button" or "Info")

		local row = make("TextButton", {
			Size = UDim2.new(1, 0, 0, hasSub and 46 or 36),
			BackgroundColor3 = THEME.bg,
			Text = "",
			LayoutOrder = nextOrder(),
		}, page)
		corner(row, 4)
		stroke(row, THEME.purple, 1)

		make("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -48, 0, hasSub and 24 or 36),
			Position = UDim2.fromOffset(12, hasSub and 4 or 0),
			Text = (def.icon and (def.icon .. "  ") or "") .. T(def.name),
			TextColor3 = THEME.text,
			Font = THEME.fontMed,
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
		}, row)
		if hasSub then
			make("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, -48, 0, 18),
				Position = UDim2.fromOffset(12, 24),
				Text = T(def.subtitle),
				TextColor3 = THEME.muted,
				Font = THEME.font,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate = Enum.TextTruncate.AtEnd,
			}, row)
		end

		addDots(row, def, kind, UDim2.new(1, -6, 0.5, 0))
		hoverEffect(row)

		if def.script and not def.getExtra then
			def.getExtra = function()
				local fav = saved.favorites[def.key] == true
				return {
					fav and "取消收藏" or "收藏",
					THEME.orange,
					function()
						saved.favorites[def.key] = (not fav) or nil
						saveData()
						notify(fav and "已取消收藏" or "已加入收藏", 2)
					end,
				}
			end
		end

		local function runIt()
			if def.script then
				runScript(def)
			else
				def.run()
			end
		end

		row.MouseButton1Click:Connect(function()
			if not def.run then
				showDetails(def, kind)
			elseif def.confirm or (def.script and confirmScripts) then
				showDialog({
					title = "确定吗？",
					body = def.confirmText or TF("确定要执行 %s 吗？", def.name),
					accent = THEME.orange,
					a = { "取消", THEME.panelLight },
					b = { "执行", THEME.orange, runIt },
				})
			else
				safeCall(runIt)
			end
		end)
		return row
	end

	-- TOGGLE: def = { name, description, icon, default, onChange }
	local function addToggle(page, def)
		local state = def.default or false

		local row = make("TextButton", {
			Size = UDim2.new(1, 0, 0, 36),
			BackgroundColor3 = THEME.bg,
			Text = "",
			LayoutOrder = nextOrder(),
		}, page)
		corner(row, 4)

		make("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -100, 1, 0),
			Position = UDim2.fromOffset(12, 0),
			Text = (def.icon and (def.icon .. "  ") or "") .. T(def.name),
			TextColor3 = THEME.text,
			Font = THEME.fontMed,
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
		}, row)

		local switch = make("Frame", {
			Size = UDim2.fromOffset(40, 20),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -42, 0.5, 0),
			BackgroundColor3 = THEME.panelLight,
		}, row)
		corner(switch, 5)

		local knob = make("Frame", {
			Size = UDim2.fromOffset(16, 16),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 2, 0.5, 0),
			BackgroundColor3 = THEME.text,
		}, switch)
		corner(knob, 4)

		local function render()
			tween(switch, 0.15, { BackgroundColor3 = state and THEME.orange or THEME.panelLight })
			tween(knob, 0.15, {
				Position = state and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
			})
		end
		render()

		addDots(row, def, "Toggle", UDim2.new(1, -6, 0.5, 0))
		hoverEffect(row)

		row.MouseButton1Click:Connect(function()
			state = not state
			render()
			if def.onChange then
				safeCall(def.onChange, state)
			end
		end)
		return row, function(newState) -- lets other code flip the switch silently
			state = newState
			render()
		end
	end

	-- SLIDER: def = { name, description, icon, min, max, default, onChange }
	local function addSlider(page, def)
		local min, max = def.min, def.max
		local value = def.default or min

		local row = make("Frame", {
			Size = UDim2.new(1, 0, 0, 52),
			BackgroundColor3 = THEME.bg,
			LayoutOrder = nextOrder(),
		}, page)
		corner(row, 4)

		make("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -110, 0, 24),
			Position = UDim2.fromOffset(12, 4),
			Text = (def.icon and (def.icon .. "  ") or "") .. T(def.name),
			TextColor3 = THEME.text,
			Font = THEME.fontMed,
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
		}, row)

		local valueLabel = make("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(50, 24),
			Position = UDim2.new(1, -92, 0, 4),
			Text = tostring(value),
			TextColor3 = THEME.muted,
			Font = THEME.fontBold,
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Right,
		}, row)

		addDots(row, def, "Slider", UDim2.new(1, -6, 0, 18))

		-- Big invisible hit area so it's easy to grab on a phone
		local hit = make("TextButton", {
			Size = UDim2.new(1, -24, 0, 22),
			Position = UDim2.fromOffset(12, 28),
			BackgroundTransparency = 1,
			Text = "",
		}, row)

		local bar = make("Frame", {
			Size = UDim2.new(1, 0, 0, 8),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.fromScale(0, 0.5),
			BackgroundColor3 = THEME.panelLight,
		}, hit)
		corner(bar, 4)

		local fill = make("Frame", {
			Size = UDim2.fromScale((value - min) / (max - min), 1),
			BackgroundColor3 = THEME.orange,
		}, bar)
		corner(fill, 4)

		local sliding = false
		local function update(x)
			if bar.AbsoluteSize.X <= 0 then
				return
			end
			local rel = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
			value = math.floor(min + (max - min) * rel + 0.5)
			fill.Size = UDim2.fromScale(rel, 1)
			valueLabel.Text = tostring(value)
			if def.onChange then
				safeCall(def.onChange, value)
			end
		end

		hit.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				sliding = true
				update(input.Position.X)
			end
		end)
		track(UserInputService.InputChanged:Connect(function(input)
			if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch) then
				update(input.Position.X)
			end
		end))
		track(UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				sliding = false
			end
		end))
		return row
	end

	-- SORTING: a button next to every search box cycles Default / A→Z / Z→A / Newest
	local SORT_MODES = {
		{ id = "default", label = "↕ 默认" },
		{ id = "az", label = "A→Z" },
		{ id = "za", label = "Z→A" },
		{ id = "new", label = "🆕 最新" },
	}
	local sortMode = "default"
	for _, m in ipairs(SORT_MODES) do
		if m.id == saved.sort then
			sortMode = m.id
		end
	end
	local sortButtons = {}

	local function currentSortLabel()
		for _, m in ipairs(SORT_MODES) do
			if m.id == sortMode then
				return m.label
			end
		end
		return SORT_MODES[1].label
	end

	local function cycleSort()
		local idx = 1
		for i, m in ipairs(SORT_MODES) do
			if m.id == sortMode then
				idx = i
			end
		end
		sortMode = SORT_MODES[idx % #SORT_MODES + 1].id
		saved.sort = sortMode
		saveData()
		for _, b in ipairs(sortButtons) do
			b.Text = T(currentSortLabel())
		end
		for name in pairs(sortRebuilders) do
			staleTabs[name] = true
		end
		notify(TF("↕ 排序：%s", T(currentSortLabel())), 1.5)
	end

	-- SCRIPT TAB: a tab with a search box + sort button + all its script buttons.
	-- Buttons are created the first time you open the tab (keeps startup fast).
	local function createScriptTab(tabDef)
		local page = createTab(tabDef.name)
		tabButtons[tabDef.name].Text = T(tabDef.name) .. "  " .. #tabDef.buttons
		local rows = {}
		local query = ""
		local built, building = false, false

		local top = make("Frame", {
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundTransparency = 1,
			LayoutOrder = 0,
		}, page)

		local box = make("TextBox", {
			Size = UDim2.new(1, -74, 1, 0),
			BackgroundColor3 = THEME.bg,
			PlaceholderText = TF("搜索 %d 个脚本或作者...", #tabDef.buttons),
			PlaceholderColor3 = THEME.muted,
			Text = "",
			TextColor3 = THEME.text,
			Font = THEME.font,
			TextSize = 14,
			ClearTextOnFocus = false,
			TextXAlignment = Enum.TextXAlignment.Left,
		}, top)
		corner(box, 4)
		stroke(box, THEME.purple, 1)
		make("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }, box)

		local sortBtn = make("TextButton", {
			Size = UDim2.fromOffset(68, 30),
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.fromScale(1, 0),
			BackgroundColor3 = THEME.panelLight,
			Text = T(currentSortLabel()),
			TextColor3 = THEME.text,
			Font = THEME.fontMed,
			TextSize = 12,
			TextTruncate = Enum.TextTruncate.AtEnd,
		}, top)
		corner(sortBtn, 4)
		table.insert(sortButtons, sortBtn)

		local function matches(lowerName)
			return query == "" or lowerName:find(query, 1, true) ~= nil
		end

		box:GetPropertyChangedSignal("Text"):Connect(function()
			query = box.Text:lower()
			for _, entry in ipairs(rows) do
				entry.row.Visible = matches(entry.name)
			end
		end)

		addSection(page, tabDef.section)

		local function orderedList()
			local list = table.clone(tabDef.buttons)
			if sortMode == "az" then
				table.sort(list, function(a, b)
					return a.name:lower() < b.name:lower()
				end)
			elseif sortMode == "za" then
				table.sort(list, function(a, b)
					return a.name:lower() > b.name:lower()
				end)
			elseif sortMode == "new" then
				local n = #list
				for i = 1, math.floor(n / 2) do
					list[i], list[n - i + 1] = list[n - i + 1], list[i]
				end
			end
			return list
		end

		local function buildRows()
			if building then
				return
			end
			building = true
			for _, entry in ipairs(rows) do
				entry.row:Destroy()
			end
			rows = {}
			local loadingLabel = addLabel(page, TF("正在加载 %d 个脚本...", #tabDef.buttons), 20, THEME.muted)
			for i, def in ipairs(orderedList()) do
				def.script = true
				local row = addButton(page, def)
				local lowerName = def.hay or def.name:lower()
				row.Visible = matches(lowerName)
				table.insert(rows, { row = row, name = lowerName })
				if i % 12 == 0 then
					task.wait() -- let the game breathe while we build
				end
			end
			loadingLabel:Destroy()
			built = true
			building = false
		end

		sortBtn.MouseButton1Click:Connect(function()
			cycleSort()
			staleTabs[tabDef.name] = nil
			if built then
				task.spawn(buildRows)
			end
		end)
		sortRebuilders[tabDef.name] = function()
			if built then
				task.spawn(buildRows)
			end
		end
		builders[tabDef.name] = buildRows
	end

	-- FLOATING PUMPKIN (tap = show/hide, drag = move)
	local PUMPKIN_HOME = UDim2.fromOffset(14, math.floor(screen.Y / 2) - 22)

	local pumpkin = make("TextButton", {
		Size = UDim2.fromOffset(44, 44),
		Position = PUMPKIN_HOME,
		BackgroundColor3 = THEME.panel,
		Text = "S",
		TextColor3 = THEME.text,
		TextSize = 20,
		Font = THEME.fontBold,
		Visible = false,
		ZIndex = 10,
	}, gui)
	corner(pumpkin, 6)
	stroke(pumpkin, THEME.line, 1)

	local function clampToScreen(obj)
		local size = obj.AbsoluteSize
		local pos = obj.AbsolutePosition
		local x = math.clamp(pos.X, 6, math.max(6, gui.AbsoluteSize.X - size.X - 6))
		local y = math.clamp(pos.Y, 6, math.max(6, gui.AbsoluteSize.Y - size.Y - 6))
		tween(obj, 0.2, { Position = UDim2.fromOffset(x, y) })
	end

	makeDraggable(pumpkin, pumpkin, function()
		setOpen(not isOpen)
	end, function()
		clampToScreen(pumpkin)
	end)

	local ready = false

	-- KEYBINDS (PC) + ON-SCREEN BUTTONS (mobile). Both can be turned on/off in Settings.
	local keybindsOn = saved.keybinds ~= false
	local quickBarOn = saved.quickBar
	if quickBarOn == nil then
		quickBarOn = isMobile -- phones get the buttons automatically
	end
	local PANIC_KEY = Enum.KeyCode.End
	local RUN_LAST_KEY = Enum.KeyCode.RightControl
	local MUSIC_KEY = Enum.KeyCode.Insert

	local function runLast()
		if hub.lastRun then
			runScript(hub.lastRun)
		else
			notify("还没运行过", 2)
		end
	end

	-- Tiny faint dot that only exists while PANIC is on, so touch players can bring everything back
	local panicDot = make("TextButton", {
		Size = UDim2.fromOffset(28, 28),
		Position = UDim2.fromOffset(8, 8),
		BackgroundColor3 = THEME.panel,
		BackgroundTransparency = 0.8,
		Text = "·",
		TextColor3 = THEME.text,
		TextTransparency = 0.4,
		TextSize = 20,
		Font = THEME.fontBold,
		Visible = false,
		ZIndex = 60,
	}, gui)
	corner(panicDot, 6)

	-- Floating quick bar:  panic,  run last script,  music (drag it anywhere)
	local quickBar = make("Frame", {
		Size = UDim2.fromOffset(158, 48),
		Position = UDim2.new(0, 14, 0, math.floor(screen.Y / 2) + 40),
		BackgroundColor3 = THEME.panel,
		Visible = false,
		ZIndex = 10,
	}, gui)
	corner(quickBar, 6)
	stroke(quickBar, THEME.line, 1)
	make("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 8),
	}, quickBar)
	local function quickButton(text, callback)
		local b = make("TextButton", {
			Size = UDim2.fromOffset(42, 38),
			BackgroundColor3 = THEME.panelLight,
			Text = text,
			TextSize = 20,
			TextColor3 = THEME.text,
			Font = THEME.fontBold,
			ZIndex = 11,
		}, quickBar)
		corner(b, 5)
		b.MouseButton1Click:Connect(function()
			safeCall(callback)
		end)
	end

	local function updateQuickBar()
		quickBar.Visible = quickBarOn and pumpkin.Visible
	end
	pumpkin:GetPropertyChangedSignal("Visible"):Connect(updateQuickBar)
	makeDraggable(quickBar, quickBar, nil, function()
		clampToScreen(quickBar)
	end)

	-- PANIC: hides the hub, pumpkin and quick bar and stops the music. Press again to bring it back.
	local panicHidden = false
	local function panicToggle()
		panicHidden = not panicHidden
		panicDot.Visible = panicHidden
		if panicHidden then
			setOpen(false)
			pcall(setMusic, false)
			pumpkin.Visible = false
		else
			pumpkin.Visible = true
			setOpen(true)
		end
	end
	panicDot.MouseButton1Click:Connect(panicToggle)

	quickButton("", panicToggle)
	quickButton("", runLast)
	quickButton("", function()
		setMusic(not musicOn)
	end)
	track(UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed or not ready or not keybindsOn then
			return
		end
		if input.KeyCode == PANIC_KEY then
			panicToggle()
		elseif panicHidden then
			return
		elseif table.find(TOGGLE_KEYS, input.KeyCode) then
			setOpen(not isOpen)
		elseif input.KeyCode == RUN_LAST_KEY then
			runLast()
		elseif input.KeyCode == MUSIC_KEY then
			pcall(setMusic, not musicOn)
		end
	end))

	-- PAGES
	-- NOTES (saved automatically)
	do
		addSection(notesTab, "我的笔记")
		addLabel(notesTab, "随便写：点子、音频 ID、脚本名。会自动保存。", 36, THEME.muted)
		local notesBox = make("TextBox", {
			Size = UDim2.new(1, 0, 0, 170),
			BackgroundColor3 = THEME.bg,
			PlaceholderText = T("在这里输入笔记..."),
			PlaceholderColor3 = THEME.muted,
			Text = saved.notes or "",
			TextColor3 = THEME.text,
			Font = THEME.font,
			TextSize = 14,
			MultiLine = true,
			TextWrapped = true,
			ClearTextOnFocus = false,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			LayoutOrder = nextOrder(),
		}, notesTab)
		corner(notesBox, 4)
		stroke(notesBox, THEME.purple, 1)
		make("UIPadding", {
			PaddingLeft = UDim.new(0, 10),
			PaddingRight = UDim.new(0, 10),
			PaddingTop = UDim.new(0, 8),
			PaddingBottom = UDim.new(0, 8),
		}, notesBox)
		notesBox.FocusLost:Connect(function()
			saved.notes = notesBox.Text:sub(1, 4000)
			saveData()
		end)
		addButton(notesTab, {
			name = "复制笔记",
			description = "复制你所有的笔记（需要 setclipboard）。",
			run = function()
				saved.notes = notesBox.Text:sub(1, 4000)
				if setclipboard then
					setclipboard(saved.notes)
					notify("已复制！", 2)
				else
					notify(saved.notes, 6)
				end
			end,
		})
		addButton(notesTab, {
			name = "清空笔记",
			description = "删除你在笔记里写的所有内容。",
			confirm = true,
			confirmText = "要删除所有笔记吗？",
			run = function()
				notesBox.Text = ""
				saved.notes = ""
				saveData()
				notify("已清空", 2)
			end,
		})
	end

	-- One flat list of every script (ids are used for favorites)
	local ALL_SCRIPTS = {}
	for _, tabDef in ipairs(SCRIPT_TABS) do
		for _, def in ipairs(tabDef.buttons) do
			def.script = true
			def.tab = tabDef.name
			def.key = tabDef.name .. "|" .. def.name
			def.hay = (def.name .. " " .. (def.subtitle or "")):lower()
			if NEW_SCRIPTS[def.name] and not def.icon then
				def.icon = "NEW"
			end
			table.insert(ALL_SCRIPTS, def)
		end
	end
	local totalScripts = #ALL_SCRIPTS

	-- Empties a page (keeps its layout + optional search box)
	local function clearPage(page, keep)
		for _, child in ipairs(page:GetChildren()) do
			if not child:IsA("UIListLayout") and child ~= keep then
				child:Destroy()
			end
		end
	end

	local function makeSearchBox(page, placeholder)
		local box = make("TextBox", {
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundColor3 = THEME.bg,
			PlaceholderText = placeholder,
			PlaceholderColor3 = THEME.muted,
			Text = "",
			TextColor3 = THEME.text,
			Font = THEME.font,
			TextSize = 14,
			ClearTextOnFocus = false,
			TextXAlignment = Enum.TextXAlignment.Left,
			LayoutOrder = 0,
		}, page)
		corner(box, 4)
		stroke(box, THEME.purple, 1)
		make("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }, box)
		return box
	end

	-- Tab order = the order you see on the left
	local homeTab = createTab("主页")
	local favTab = createTab("收藏")
	local searchTab = createTab("搜索")
	for _, tabDef in ipairs(SCRIPT_TABS) do
		createScriptTab(tabDef)
	end
	local musicTab = createTab("音乐")
	local playlistTab = createTab("播放列表")
	local notesTab = createTab("笔记")
	local effectsTab = createTab("特效")
	local toolsTab = createTab("工具")
	local settingsTab = createTab("设置")
	local updatesTab = createTab("更新")
	local creditsTab = createTab("致谢")

	-- HOME
	addSection(homeTab, "欢迎")
	addLabel(
		homeTab,
		TF("你好 %s！已加载 %d 个脚本。点圆形按钮或按 %s 显示/隐藏。用搜索页找任何脚本，点星标收藏，在音乐页粘贴任意音频 ID。", player.DisplayName, totalScripts, TOGGLE_KEY_TEXT),
		100
	)
	local fpsLabel = addLabel(homeTab, "帧率：...", 20, THEME.muted)
	addButton(homeTab, {
		name = "随机模式",
		description = "从模式页随机挑一个模式，运行前会先问你。",
		run = function()
			local pool = {}
			for _, def in ipairs(ALL_SCRIPTS) do
				if def.tab == "模式" or def.tab == "模式 2" then
					table.insert(pool, def)
				end
			end
			local pick = pool[math.random(#pool)]
			showDialog({
				title = "".. pick.name,
				body = T(pick.description or "") .. "\n\n" .. T("要运行吗？"),
				accent = THEME.orange,
				a = { "否", THEME.panelLight },
				b = { "运行！", THEME.orange, function()
					runScript(pick)
				end },
			})
		end,
	})
	addButton(homeTab, {
		name = "说圣诞快乐",
		description = "弹出一个圣诞小窗。适合拿来测试的第一个按钮。",
		run = function()
			notify("圣诞快乐！")
		end,
	})

	addButton(homeTab, {
		name = "重跑上一个脚本",
		description = "再跑一次本次会话里最后运行的那个脚本。",
		run = function()
			if hub.lastRun then
				runScript(hub.lastRun)
			else
				notify("还没运行过", 2)
			end
		end,
	})

	addButton(homeTab, {
		name = "关于",
		description = "Hub 的版本信息。",
		run = function()
			showDialog({
				title = "".. HUB_TITLE,
				body = totalScripts .. " 个脚本  •  "
					.. (isMobile and T("点圆形按钮显示/隐藏，= 紧急隐藏") or (T("显示/隐藏：") .. " " .. TOGGLE_KEY_TEXT .. "  •  " .. T("紧急隐藏：") .. " End"))
					.. "\n\n" .. T("Hub 作者 Rip_Silence & WH1T3（副站长），界面 WH1T3。感谢使用！") .. "\n\n" .. T("V36 更新来晚了，感谢等待！"),
				accent = THEME.orange,
				a = { "关闭", THEME.purple },
			})
		end,
	})
	addSection(homeTab, "🆕 新脚本")
	do
		local shownNew = 0
		for _, def in ipairs(ALL_SCRIPTS) do
			if NEW_SCRIPTS[def.name] and shownNew < 6 then
				shownNew += 1
				local copy = table.clone(def)
				copy.subtitle = T(def.tab) .. (def.subtitle and ("  •  " .. def.subtitle) or "")
				addButton(homeTab, copy)
			end
		end
		addLabel(homeTab, "每个新脚本名字前都有 🆕。", 20, THEME.muted)
	end
	addSection(homeTab, "今日脚本")
	do
		local day = tonumber(os.date("%j")) or 1
		local year = tonumber(os.date("%Y")) or 2026
		local pick = ALL_SCRIPTS[(day * 7 + year) % #ALL_SCRIPTS + 1]
		local copy = table.clone(pick)
		copy.subtitle = pick.tab .. (pick.subtitle and ("  •  " .. pick.subtitle) or "")
		addButton(homeTab, copy)
	end
	local allTimeLabel = addLabel(homeTab, TF("累计运行脚本：%d", 0), 20, THEME.muted)
	local statsLabel = addLabel(homeTab, TF("收藏：%d  •  ▶ 本次会话：%d", 0, 0), 20, THEME.muted)
	refreshers["主页"] = function()
		local total = 0
		for _, n in pairs(saved.runs) do
			total += n
		end
		allTimeLabel.Text = TF("累计运行脚本：%d", total)
		local favCount = 0
		for _ in pairs(saved.favorites) do
			favCount += 1
		end
		statsLabel.Text = TF("收藏：%d  •  ▶ 本次会话：%d", favCount, hub.sessionRuns or 0)
	end

	local StatsService = game:GetService("统计")
	local sessionStart = os.clock()
	local frames, lastTime = 0, os.clock()
	track(RunService.RenderStepped:Connect(function()
		frames += 1
		local now = os.clock()
		if now - lastTime >= 1 then
			local okPing, ping = pcall(function()
				return StatsService.Network.ServerStatsItem["数据延迟"]:GetValue()
			end)
			local up = math.floor(now - sessionStart)
			fpsLabel.Text = string.format(
				"FPS：%d  •  延迟：%s  •  " .. T("本次会话") .. ": %02d:%02d",
				math.floor(frames / (now - lastTime) + 0.5),
				okPing and (math.floor(ping + 0.5) .. " 毫秒") or "无",
				math.floor(up / 60), up % 60
			)
			frames, lastTime = 0, now
		end
	end))

	-- FAVORITES + RECENT (rebuilt every time you open the tab)
	refreshers["收藏"] = function()
		clearPage(favTab)
		addSection(favTab, "收藏")
		addButton(favTab, {
			name = "复制我的收藏列表",
			description = "复制你所有收藏脚本的名字，方便分享（需要 setclipboard）。",
			run = function()
				local names = {}
				for _, def in ipairs(ALL_SCRIPTS) do
					if saved.favorites[def.key] then
						table.insert(names, def.name)
					end
				end
				if #names == 0 then
					notify("暂时没有可复制的内容", 2)
					return
				end
				local text = table.concat(names, "\n")
				if setclipboard then
					setclipboard(text)
					notify("已复制！", 2)
				else
					notify(text, 6)
				end
			end,
		})
		local count = 0
		for _, def in ipairs(ALL_SCRIPTS) do
			if saved.favorites[def.key] then
				count += 1
				addButton(favTab, def)
			end
		end
		if count == 0 then
			addLabel(favTab, "这里还空着。点任意脚本上的 ⋮ 选「收藏」。", 36, THEME.muted)
		end
		addSection(favTab, "最常使用")
		local ranked = {}
		for _, def in ipairs(ALL_SCRIPTS) do
			local n = saved.runs[def.key]
			if n and n > 0 then
				table.insert(ranked, { def = def, n = n })
			end
		end
		table.sort(ranked, function(a, b)
			return a.n > b.n
		end)
		if #ranked == 0 then
			addLabel(favTab, "运行几个脚本后，你最常用的会出现在这里。", 20, THEME.muted)
		end
		for i = 1, math.min(5, #ranked) do
			local copy = table.clone(ranked[i].def)
			copy.subtitle = TF("已运行 %d 次", ranked[i].n) .. (copy.subtitle and ("  •  " .. copy.subtitle) or "")
			addButton(favTab, copy)
		end
		addSection(favTab, "最近运行")
		if #recent == 0 then
			addLabel(favTab, "你运行过的脚本会出现在这里。", 20, THEME.muted)
		end
		for _, def in ipairs(recent) do
			addButton(favTab, def)
		end
	end

	-- SEARCH (all scripts at once)
	local globalBox = makeSearchBox(searchTab, TF("搜索全部 %d 个脚本或作者...", totalScripts))
	local searchToken = 0
	local function runSearch()
		searchToken += 1
		local mine = searchToken
		task.wait(0.25) -- wait until you stop typing
		if mine ~= searchToken then
			return
		end
		clearPage(searchTab, globalBox)
		local q = globalBox.Text:lower()
		if #q < 2 then
			addLabel(searchTab, "输入至少 2 个字母就能一次搜遍所有分页。", 36, THEME.muted)
			return
		end
		local shown = 0
		for _, def in ipairs(ALL_SCRIPTS) do
			if (def.hay or def.name:lower()):find(q, 1, true) then
				shown += 1
				if shown > 40 then
					break
				end
				local copy = table.clone(def)
				copy.subtitle = T(def.tab) .. (def.subtitle and ("  •  " .. def.subtitle) or "")
				addButton(searchTab, copy)
			end
		end
		if shown == 0 then
			addLabel(searchTab, TF("没找到 \"%s\"。", globalBox.Text), 24, THEME.muted)
		elseif shown > 40 then
			addLabel(searchTab, "只显示前 40 个，多打几个字母缩小范围。", 36, THEME.muted)
		end
	end
	globalBox:GetPropertyChangedSignal("Text"):Connect(function()
		task.spawn(runSearch)
	end)
	task.spawn(runSearch)

	-- MUSIC
	addSection(musicTab, "正在播放")
	nowLabel = addLabel(musicTab, nowPlayingText(), 40)

	addSection(musicTab, "播放任意音频 ID")
	local idRow = make("Frame", {
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundTransparency = 1,
		LayoutOrder = nextOrder(),
	}, musicTab)
	local idBox = make("TextBox", {
		Size = UDim2.new(1, -78, 1, 0),
		BackgroundColor3 = THEME.bg,
		PlaceholderText = T("粘贴音频 ID 或链接..."),
		PlaceholderColor3 = THEME.muted,
		Text = "",
		TextColor3 = THEME.text,
		Font = THEME.font,
		TextSize = 14,
		ClearTextOnFocus = false,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, idRow)
	corner(idBox, 4)
	stroke(idBox, THEME.purple, 1)
	make("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }, idBox)
	local playIdBtn = make("TextButton", {
		Size = UDim2.fromOffset(70, 34),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.fromScale(1, 0),
		BackgroundColor3 = THEME.orange,
		Text = T("▶ 播放"),
		TextColor3 = THEME.text,
		Font = THEME.fontBold,
		TextSize = 14,
	}, idRow)
	corner(playIdBtn, 4)
	playIdBtn.MouseButton1Click:Connect(function()
		safeCall(playById, idBox.Text)
	end)
	idBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			safeCall(playById, idBox.Text)
		end
	end)

	local controls = make("Frame", {
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundTransparency = 1,
		LayoutOrder = nextOrder(),
	}, musicTab)
	make("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, controls)
	local function controlButton(text, callback)
		local b = make("TextButton", {
			Size = UDim2.new(0.25, -5, 1, 0),
			BackgroundColor3 = THEME.panelLight,
			Text = T(text),
			TextColor3 = THEME.text,
			Font = THEME.fontBold,
			TextSize = 15,
			LayoutOrder = nextOrder(),
		}, controls)
		corner(b, 4)
		b.MouseButton1Click:Connect(function()
			safeCall(callback)
		end)
		return b
	end
	controlButton("⏮", function() stepTrack(-1) end)
	controlButton("⏯", function() setMusic(not musicOn) end)
	controlButton("⏭", function() stepTrack(1) end)
	controlButton("保存", saveCurrentToPlaylist)

	addSection(musicTab, "设置")
	local _, setMusicSwitch = addToggle(musicTab, {
		name = "背景音乐",
		description = "开关音乐。标题栏上那个按钮效果一样。",
		default = false,
		onChange = function(on)
			setMusic(on)
		end,
	})
	musicToggleSet = setMusicSwitch
	addToggle(musicTab, {
		name = "单曲循环",
		description = "开 = 单曲无限循环。关 = 放完后自动跳到播放列表的下一首。",
		default = loopTrack,
		onChange = setLoop,
	})

	addToggle(musicTab, {
		name = "随机播放",
		description = "开 = 下一首随机挑。⏭ / ⏮ 按钮和歌曲放完时（单曲循环关）都生效。",
		default = shuffleOn,
		onChange = function(on)
			shuffleOn = on
			saved.shuffle = on
			saveData()
		end,
	})
	addToggle(musicTab, {
		name = "启动时续播音乐",
		description = "开 = 打开 Hub 时自动放上一首。想安静开局就关掉。",
		default = autoplayOn,
		onChange = function(on)
			autoplayOn = on
			saved.autoplay = on
			saveData()
		end,
	})
	addSlider(musicTab, {
		name = "音乐音量",
		description = "音乐多大声音（0 = 静音，100 = 最大）。",
		min = 0,
		max = 100,
		default = musicVolume,
		onChange = function(v)
			musicVolume = v
			sound.Volume = v / 100
			saved.volume = v
			saveSoon()
		end,
	})
	addLabel(
		musicTab,
		"哪里找 ID：创作者商店 > 音频，打开一首歌，把页面上的数字（或整条链接）复制过来。有些音频是私有的，放不出来。点保存可以把歌留在播放列表。",
		84,
		THEME.muted
	)

	-- PLAYLIST (rebuilt when you open it or when songs change)
	local function buildPlaylistPage()
		clearPage(playlistTab)
		addSection(playlistTab, "你的播放列表")
		if #playlist == 0 then
			addLabel(playlistTab, "空的。先在本页播放一个 ID，再点保存。", 36, THEME.muted)
		end
		for _, trackEntry in ipairs(playlist) do
			addButton(playlistTab, {
				name = trackName(trackEntry),
				icon = sameTrack(trackEntry, current) and "▶" or "",
				subtitle = trackEntry.id and ("ID " .. tostring(trackEntry.id)) or (trackEntry.url and "Link" or "File"),
				description = "点歌名就能播放，用「移除」把它从播放列表删掉。",
				kind = "Song",
				run = function()
					playTrack(trackEntry)
				end,
				getExtra = function()
					return { "移除", THEME.danger, function()
						removeFromPlaylist(trackEntry)
						notify("已从播放列表移除", 2)
					end }
				end,
			})
		end
	end
	refreshers["播放列表"] = buildPlaylistPage
	table.insert(musicListeners, function()
		if playlistTab.Visible then
			buildPlaylistPage()
		end
	end)

	-- EFFECTS
	local batsOn = false
	local batToken = 0

	local function startBats()
		batToken += 1
		local token = batToken
		for _ = 1, 8 do
			task.spawn(function()
				local bat = make("TextLabel", {
					BackgroundTransparency = 1,
					Text = "*",
					TextColor3 = Color3.fromRGB(222, 184, 96),
					TextSize = math.random(18, 30),
					Size = UDim2.fromOffset(40, 40),
					Position = UDim2.new(-0.2, 0, 0.5, 0),
				}, effectsLayer)
				task.wait(math.random() * 2)
				while batsOn and token == batToken and bat.Parent do
					local y = math.random() * 0.8 + 0.05
					local dur = math.random(40, 80) / 10
					bat.Position = UDim2.new(-0.1, 0, y, 0)
					tween(bat, dur, {
						Position = UDim2.new(1.1, 0, math.clamp(y + (math.random() - 0.5) * 0.3, 0, 0.95), 0),
					}, Enum.EasingStyle.Linear)
					task.wait(dur)
				end
				bat:Destroy()
			end)
		end
	end

	addSection(effectsTab, "圣诞小玩意")
	addToggle(effectsTab, {
		name = "流星",
		description = "小星星从屏幕飞过，纯装饰。",
		default = false,
		onChange = function(on)
			batsOn = on
			if on then
				startBats()
			else
				batToken += 1
				effectsLayer:ClearAllChildren()
			end
		end,
	})
	addButton(effectsTab, {
		name = "飘雪",
		description = "让雪花从屏幕上方飘几秒。",
		run = function()
			for _ = 1, 20 do
				task.spawn(function()
					task.wait(math.random() * 1.5)
					local x = math.random()
					local p = make("TextLabel", {
						BackgroundTransparency = 1,
						Text = "•",
						TextColor3 = Color3.new(1, 1, 1),
						TextSize = math.random(18, 30),
						Size = UDim2.fromOffset(40, 40),
						Position = UDim2.new(x, 0, -0.1, 0),
					}, effectsLayer)
					local dur = math.random(20, 40) / 10
					tween(p, dur, {
						Position = UDim2.new(x, 0, 1.1, 0),
						Rotation = math.random(-180, 180),
					}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
					task.wait(dur)
					p:Destroy()
				end)
			end
		end,
	})

	-- TOOLS
	addSection(toolsTab, "本次会话")
	local VirtualUser = game:GetService("VirtualUser")
	local afkConn
	local function setAntiAfk(on)
		if afkConn then
			afkConn:Disconnect()
			afkConn = nil
		end
		if on then
			afkConn = track(player.Idled:Connect(function()
				pcall(function()
					VirtualUser:CaptureController()
					VirtualUser:ClickButton2(Vector2.new())
				end)
			end))
		end
	end
	setAntiAfk(saved.antiAfk ~= false)
	addToggle(toolsTab, {
		name = "防挂机",
		description = "防止 Roblox 因为你挂机（20 分钟）把你踢掉。长时间跑图很好用。会保存。",
		default = saved.antiAfk ~= false,
		onChange = function(on)
			saved.antiAfk = on
			saveData()
			setAntiAfk(on)
		end,
	})
	addButton(toolsTab, {
		name = "紧急隐藏（全部藏起来）",
		description = "立刻隐藏 Hub、悬浮 S 按钮并停止音乐。再按一次、按 End 键，或点左上角那个淡淡的小圆点就能全部恢复。",
		run = panicToggle,
	})
	addButton(toolsTab, {
		name = "重进服务器",
		description = "把你传送回同一个游戏。",
		confirm = true,
		confirmText = "要重进这个游戏吗？你会离开当前服务器。",
		run = function()
			game:GetService("TeleportService"):Teleport(game.PlaceId, player)
		end,
	})
	addButton(toolsTab, {
		name = "复制地图 ID / 服务器 ID",
		description = "复制地图 ID 和本服务器的 job id（需要 setclipboard）。",
		run = function()
			local text = "地图 ID：" .. game.PlaceId .. " | 服务器 ID：" .. game.JobId
			if setclipboard then
				setclipboard(text)
				notify("已复制！", 2)
			else
				notify(text, 6)
			end
		end,
	})
	if setfpscap then
		addSlider(toolsTab, {
			name = "FPS 上限",
			description = "修改你的 FPS 上限（需要 setfpscap）。",
			min = 30,
			max = 240,
			default = 60,
			onChange = function(v)
				setfpscap(v)
			end,
		})
	end

	addSection(toolsTab, "视觉")
	do
	local Lighting = game:GetService("Lighting")
	local startCamera = workspace.CurrentCamera
	local startFov = startCamera and startCamera.FieldOfView or 70
	addSlider(toolsTab, {
		name = "视野角度",
		description = "修改视角视野范围（游戏可能会重置它）。用「重置视野」恢复。",
		min = 40,
		max = 120,
		default = math.floor(startFov + 0.5),
		onChange = function(v)
			local cam = workspace.CurrentCamera
			if cam then
				cam.FieldOfView = v
			end
		end,
	})
	addButton(toolsTab, {
		name = "重置视野",
		description = "把视野恢复成 Hub 启动时的数值。",
		run = function()
			local cam = workspace.CurrentCamera
			if cam then
				cam.FieldOfView = startFov
			end
		end,
	})
	local boostRestore = nil
	addToggle(toolsTab, {
		name = "FPS 提升",
		description = "关掉阴影、降低画质来提升 FPS。关掉这个开关即可还原原来的设置。",
		default = false,
		onChange = function(on)
			if on then
				boostRestore = { shadows = Lighting.GlobalShadows }
				pcall(function()
					boostRestore.quality = settings().Rendering.QualityLevel
				end)
				Lighting.GlobalShadows = false
				pcall(function()
					settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
				end)
				notify("FPS 提升 开", 2)
			elseif boostRestore then
				Lighting.GlobalShadows = boostRestore.shadows
				if boostRestore.quality then
					pcall(function()
						settings().Rendering.QualityLevel = boostRestore.quality
					end)
				end
				boostRestore = nil
				notify("FPS 提升 关", 2)
			end
		end,
	})
	end

	addSection(toolsTab, "执行器检测")
	local exName = "未知"
	pcall(function()
		if identifyexecutor then
			exName = tostring((identifyexecutor()))
		end
	end)
	local function has(fnName)
		local okH, v = pcall(function()
			return (getgenv and getgenv()[fnName]) or getfenv(0)[fnName]
		end)
		return okH and v ~= nil
	end
	local function mark(fnName)
		return (has(fnName) and "" or "") .. fnName
	end
	addLabel(
		toolsTab,
		"执行器：" .. exName .. "\n"
			.. mark("loadstring") .. "   " .. mark("writefile") .. "   " .. mark("readfile") .. "\n"
			.. mark("setclipboard") .. "   " .. mark("setfpscap") .. "   " .. mark("getgenv") .. "\n"
			.. T("如果脚本按钮点不动，先检查上面这些。"),
		84,
		THEME.muted
	)

	addSection(toolsTab, "数据")
	addButton(toolsTab, {
		name = "重置收藏与统计",
		description = "清空收藏和最常使用的计数。播放列表和设置会保留。",
		confirm = true,
		confirmText = "要清空所有收藏和运行次数吗？",
		run = function()
			saved.favorites = {}
			saved.runs = {}
			saveData()
			notify("已清空", 2)
		end,
	})
	addButton(toolsTab, {
		name = "复制调试信息",
		description = "复制你的执行器、语言和 Hub 版本，方便报 bug 时粘贴（不含个人信息）。需要 setclipboard。",
		run = function()
			local text = table.concat({
				"Hub：" .. HUB_TITLE,
				"脚本：" .. totalScripts,
				"执行器：" .. exName,
				"语言：" .. tostring(langCode),
				"手机端：" .. tostring(isMobile),
				"地图 ID：" .. game.PlaceId,
				"loadstring：" .. tostring(has("loadstring")),
				"writefile：" .. tostring(has("writefile")),
				"setclipboard：" .. tostring(has("setclipboard")),
			}, "\n")
			if setclipboard then
				setclipboard(text)
				notify("已复制！", 2)
			else
				notify(text, 8)
			end
		end,
	})
	addButton(toolsTab, {
		name = "重置全部",
		description = "清空全部存档：收藏、统计、播放列表、笔记和设置。之后请重新运行 Hub。",
		confirm = true,
		confirmText = "要清空全部存档吗？此操作无法撤销。",
		run = function()
			for k in pairs(saved) do
				saved[k] = nil
			end
			saved.favorites, saved.playlist, saved.runs = {}, {}, {}
			saveData()
			notify("已全部重置，请重新运行 Hub。", 4)
		end,
	})

	-- SETTINGS
	addSection(settingsTab, "UI")
	addToggle(settingsTab, {
		name = "通知",
		description = "开关角落里的那些小提示。",
		default = notificationsEnabled,
		onChange = function(on)
			notificationsEnabled = on
			saved.notifications = on
			saveData()
		end,
	})
	addToggle(settingsTab, {
		name = "运行前确认",
		description = "打开后，每个脚本按钮运行前都会问「确定吗？」，手机上防误触很好用。",
		default = confirmScripts,
		onChange = function(on)
			confirmScripts = on
			saved.confirm = on
			saveData()
		end,
	})
	addToggle(settingsTab, {
		name = "运行脚本后隐藏界面",
		description = "运行脚本后 Hub 会自己藏起来，方便你看游戏。用圆形按钮、快捷键或快捷条把它叫回来。",
		default = saved.autoHide == true,
		onChange = function(on)
			saved.autoHide = on
			saveData()
		end,
	})
	addSlider(settingsTab, {
		name = "窗口大小 %",
		description = "把整个 Hub 放大或缩小（最大 130%，手机上更好点）。",
		min = 50,
		max = 130,
		default = 100,
		onChange = function(v)
			userScale = v / 100
			if isOpen then
				uiScale.Scale = targetScale()
			end
		end,
	})
	addSection(settingsTab, "操作（PC + 手机）")
	addToggle(settingsTab, {
		name = "快捷键（PC）",
		description = TF("快捷键：%s = 显示/隐藏，End = 紧急隐藏，右 Ctrl = 重跑上个脚本，Insert = 音乐开关。不用键盘的话可以关掉。", TOGGLE_KEY_TEXT),
		default = keybindsOn,
		onChange = function(on)
			keybindsOn = on
			saved.keybinds = on
			saveData()
		end,
	})
	addToggle(settingsTab, {
		name = "屏幕按钮（手机）",
		description = "显示一条可拖动的小快捷条（紧急隐藏、重跑上个脚本、音乐），手机和平板不用快捷键也能用。手机上默认开启。",
		default = quickBarOn,
		onChange = function(on)
			quickBarOn = on
			saved.quickBar = on
			saveData()
			updateQuickBar()
		end,
	})
	addSection(settingsTab, "外观")
	addButton(settingsTab, {
		name = "主题色",
		description = "切换 Hub 主题色：铁锈、骨白、苔绿、潮蓝、赭石、梅紫、墨黑、灰烬。会保存，下次运行 Hub 时生效。",
		run = function()
			accentIndex = accentIndex % #ACCENTS + 1
			saved.accent = ACCENTS[accentIndex].name
			saveData()
			notify(TF("已选择 %s，重新运行 Hub 后生效。", saved.accent), 4)
		end,
	})
	addButton(settingsTab, {
		name = "重置位置",
		description = "把 Hub 放回屏幕中间，S 按钮放回左边。",
		run = function()
			tween(window, 0.3, { Position = UDim2.fromScale(0.5, 0.5) })
			tween(pumpkin, 0.3, { Position = PUMPKIN_HOME })
		end,
	})
	addButton(settingsTab, {
		name = "关闭界面",
		description = "完全关闭 Hub（会先问你）。",
		run = askToClose,
	})

	-- CREDITS (people come from CREDITS at the top of the file)
	addSection(creditsTab, "团队")
	for _, person in ipairs(CREDITS) do
		person.kind = person.kind or "Credit"
		addButton(creditsTab, person)
	end
	addLabel(creditsTab, "点名字或它右边的三个点查看更多。", 36, THEME.muted)

	-- UPDATES (lines come from UPDATE_LOGS at the top of the file)
	addSection(updatesTab, "V36 更新")
	for _, line in ipairs(UPDATE_LOGS) do
		-- these are long, so give each label enough height for its lines
		local _, breaks = line:gsub("\n", "")
		addLabel(updatesTab, line, math.ceil(#line / 48) * 17 + breaks * 8 + 10)
	end

	-- Everything below plugs into helpers that already exist above:
	--   make(...)      builds a Roblox object        tween(...)  animates it
	--   addToggle / addButton / addSlider / addSection / addLabel  build menu rows
	--   notify(text, seconds)  shows a popup         track(conn)  auto-cleans connections
	-- New rows land at the BOTTOM of the tab you pass in (Effects, Tools, Home).

	-- A layer of our own. (The bats toggle clears effectsLayer, so we don't share it.)
	local fxLayer = make("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ZIndex = 1,
	}, gui)

	-- ONE function drives every falling/rising effect. Each effect is just a
	-- table of settings, so adding a new one later is only a few lines.
	-- "token" trick: stopping bumps the number, and every old loop notices
	-- its token is out of date and exits by itself.
	local particleTokens = {}
	local EFFECTS = {
		snow    = { name = "下雪",     icon = "", emoji = "•", color = Color3.fromRGB(255, 255, 255), count = 22, size = {12, 22}, time = {40, 80}, fromY = -0.1, toY = 1.1,  drift = 0.10, spin = false },
		leaves  = { name = "金粉", icon = "", emoji = "*", color = Color3.fromRGB(222, 184, 96),  count = 14, size = {16, 26}, time = {40, 70}, fromY = -0.1, toY = 1.1,  drift = 0.30, spin = true },
		rain    = { name = "暴风雪", icon = "", emoji = "•", color = Color3.fromRGB(214, 228, 238), count = 34, size = {8, 14},  time = {10, 20}, fromY = -0.1, toY = 1.1,  drift = 0.45, spin = false },
		ghosts  = { name = "彩灯",   icon = "", emoji = "•", color = Color3.fromRGB(255, 214, 128), count = 10, size = {16, 28}, time = {60, 100}, fromY = 1.1, toY = -0.1, drift = 0.20, spin = false },
		embers  = { name = "余烬",   icon = "", emoji = "*", color = Color3.fromRGB(232, 122, 58),  count = 16, size = {14, 24}, time = {40, 70}, fromY = 1.1,  toY = -0.1, drift = 0.15, spin = false },
	}

	local function stopEffect(kind)
		particleTokens[kind] = (particleTokens[kind] or 0) + 1
	end

	local function startEffect(kind)
		local def = EFFECTS[kind]
		stopEffect(kind) -- cancel any old copy first
		local token = particleTokens[kind]
		for _ = 1, def.count do
			task.spawn(function()
				local p = make("TextLabel", {
					BackgroundTransparency = 1,
					Text = def.emoji,
					TextColor3 = def.color or Color3.new(1, 1, 1),
					TextSize = math.random(def.size[1], def.size[2]),
					Size = UDim2.fromOffset(40, 40),
					Position = UDim2.new(0, 0, def.fromY, 0),
				}, fxLayer)
				task.wait(math.random() * 3) -- so they don't all start together
				-- keep going while: still the newest token AND the hub still exists
				while particleTokens[kind] == token and p:IsDescendantOf(game) do
					local x = math.random()
					local dur = math.random(def.time[1], def.time[2]) / 10
					local endX = math.clamp(x + (math.random() - 0.5) * def.drift, 0, 1)
					p.Position = UDim2.new(x, 0, def.fromY, 0)
					tween(p, dur, {
						Position = UDim2.new(endX, 0, def.toY, 0),
						Rotation = def.spin and math.random(-180, 180) or 0,
					}, Enum.EasingStyle.Linear)
					task.wait(dur)
				end
				p:Destroy()
			end)
		end
	end

	addSection(effectsTab, "特效")
	local effectSwitches = {} -- so "全部停止" can flip the switches back off
	for _, kind in ipairs({ "下雪", "落叶", "下雨", "幽灵", "余烬" }) do
		local def = EFFECTS[kind]
		local _, setSwitch = addToggle(effectsTab, {
			name = def.name,
			icon = def.icon,
			description = "纯装饰，随时可以关掉。",
			default = false,
			onChange = function(on)
				if on then
					startEffect(kind)
				else
					stopEffect(kind)
				end
			end,
		})
		effectSwitches[kind] = setSwitch
	end

	addButton(effectsTab, {
		name = "关闭全部特效",
		description = "一次性关掉所有特效。",
		run = function()
			for kind, setSwitch in pairs(effectSwitches) do
				stopEffect(kind)
				setSwitch(false)
			end
		end,
	})

	-- Lightning: a white frame that appears, dims, flickers once, then fades.
	local lightningBusy = false
	addButton(effectsTab, {
		name = "闪电",
		description = "屏幕上快速闪一下白光。警告：闪光，对闪光敏感的话别开。",
		confirm = true,
		confirmText = "这会让屏幕闪一下。继续吗？",
		run = function()
			if lightningBusy then
				return
			end
			lightningBusy = true
			local flash = make("Frame", {
				Size = UDim2.fromScale(1, 1),
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 0.35,
				ZIndex = 2,
			}, fxLayer)
			tween(flash, 0.12, { BackgroundTransparency = 0.9 })
			task.wait(0.15)
			flash.BackgroundTransparency = 0.5
			tween(flash, 0.7, { BackgroundTransparency = 1 })
			task.wait(0.75)
			flash:Destroy()
			lightningBusy = false
		end,
	})

	-- Warm tint: a ColorCorrectionEffect in Lighting (it only changes how YOUR screen looks).
	local Lighting = game:GetService("Lighting")
	local moonFx
	local function setBloodMoon(on)
		if moonFx then
			moonFx:Destroy()
			moonFx = nil
		end
		if on then
			moonFx = Instance.new("ColorCorrectionEffect")
			moonFx.Name = "HubWarmTint"
			moonFx.TintColor = Color3.fromRGB(255, 232, 204)
			moonFx.Contrast = 0.05
			moonFx.Saturation = 0.05
			moonFx.Parent = Lighting
		end
	end
	gui.Destroying:Connect(function()
		setBloodMoon(false) -- clean up if the hub gets closed
	end)
	addToggle(effectsTab, {
		name = "暖色调",
		description = "给整个屏幕加一层暖色调，关掉即恢复。",
		default = false,
		onChange = setBloodMoon,
	})

	-- TOOLS: reminder timer, server info, settings backup
	addSection(toolsTab, "附加")
	local reminderMinutes = 5
	addSlider(toolsTab, {
		name = "提醒分钟数",
		description = "选好分钟数，然后按「开始提醒」。",
		min = 1,
		max = 60,
		default = 5,
		onChange = function(v)
			reminderMinutes = math.floor(v + 0.5)
		end,
	})
	addButton(toolsTab, {
		name = "开始提醒",
		description = "时间到了会弹提示（长跑的时候不容易忘）。",
		run = function()
			local mins = reminderMinutes
			notify("⏱ 提醒已设定：" .. mins .. " 分钟", 3)
			task.delay(mins * 60, function()
				notify("⏰ 你的" .. mins .. " 分钟提醒到了！", 8)
			end)
		end,
	})
	addButton(toolsTab, {
		name = "服务器信息",
		description = "显示当前有多少玩家，以及这个服务器开了多久。",
		run = function()
			local up = math.floor(workspace.DistributedGameTime)
			notify(
				string.format(
					"玩家：%d/%d  •  运行时长：%d 小时 %02d 分",
					#Players:GetPlayers(),
					Players.MaxPlayers,
					up // 3600,
					(up % 3600) // 60
				),
				6
			)
		end,
	})
	addButton(toolsTab, {
		name = "复制设置备份",
		description = "把你保存的 Hub 数据（收藏、设置、笔记）全部复制成文本。需要 setclipboard。",
		run = function()
			local okJ, text = pcall(function()
				return HttpService:JSONEncode(saved)
			end)
			if okJ and setclipboard then
				setclipboard(text)
				notify("备份已复制！", 2)
			else
				notify("你的执行器不能写剪贴板", 4)
			end
		end,
	})

	-- HOME: daily streak. os.date("!%Y-%m-%d") = today's date (UTC) as text, e.g. "2026-10-13".
	-- If the last day you opened the hub was YESTERDAY the streak grows, otherwise it restarts at 1.
	do
		local today = os.date("!%Y-%m-%d")
		if saved.lastDay ~= today then
			local yesterday = os.date("!%Y-%m-%d", os.time() - 86400)
			if saved.lastDay == yesterday then
				saved.streak = (saved.streak or 0) + 1
			else
				saved.streak = 1
			end
			saved.bestStreak = math.max(saved.bestStreak or 0, saved.streak)
			saved.lastDay = today
			saveData()
		end
		addSection(homeTab, "连续打卡")
		addLabel(
			homeTab,
			"" .. saved.streak .. " 天连续  •  最佳：" .. (saved.bestStreak or saved.streak),
			20,
			THEME.orange
		)
	end


	-- Profile card: sits at the very bottom of the tab list (LayoutOrder 99999 = last)
	do
		local card = make("Frame", {
			Name = "ProfileCard",
			Size = UDim2.new(1, 0, 0, 46),
			BackgroundColor3 = THEME.bg,
			LayoutOrder = 99999,
		}, tabList)
		corner(card, 4)
		stroke(card, THEME.purple, 1)
		local avatar = make("ImageLabel", {
			Size = UDim2.fromOffset(34, 34),
			Position = UDim2.fromOffset(6, 6),
			BackgroundColor3 = THEME.panelLight,
			Image = "",
		}, card)
		corner(avatar, 17)
		make("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -46, 0, 20),
			Position = UDim2.fromOffset(44, 5),
			Text = player.DisplayName,
			TextColor3 = THEME.text,
			Font = THEME.fontBold,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
		}, card)
		make("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -46, 0, 16),
			Position = UDim2.fromOffset(44, 24),
			Text = "".. tostring(saved.streak or 1) .. " 天连续",
			TextColor3 = THEME.orange,
			Font = THEME.font,
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
		}, card)
		-- avatar comes from Roblox's servers, so load it in the background and ignore failures
		task.spawn(function()
			pcall(function()
				local img = Players:GetUserThumbnailAsync(
					player.UserId,
					Enum.ThumbnailType.HeadShot,
					Enum.ThumbnailSize.Size48x48
				)
				avatar.Image = img
			end)
		end)
	end

	-- ADD-ON API
	-- Other scripts can plug into the hub through getgenv().SilenceHub, e.g.
	--   local hub = getgenv().SilenceHub
	--   hub.addToggle(hub.settingsTab, { name = "我的开关", onChange = function(on) end })
	-- Add-ons register themselves in hub.addons[name] = { cleanup = function() end }
	-- so they get cleaned up when the hub closes.
	do
		local env = (getgenv and getgenv()) or _G
		local api = {
			version = "V13",
			gui = gui, window = window, tabList = tabList, settingsTab = settingsTab, THEME = THEME,
			make = make, tween = tween, pulse = pulse, corner = corner, stroke = stroke, notify = notify,
			addSection = addSection, addToggle = addToggle, addButton = addButton,
			startEffect = startEffect, stopEffect = stopEffect, EFFECTS = EFFECTS, fxLayer = fxLayer,
			borderGrad = borderGrad, titleGrad = titleGrad, accentSequence = accentSequence,
			isRainbow = function()
				return rainbowOn
			end,
			hooks = HubHooks,
			addons = {},
		}
		env.SilenceHub = api
		gui.Destroying:Connect(function()
			for _, addon in pairs(api.addons) do
				pcall(addon.cleanup)
			end
			if env.SilenceHub == api then
				env.SilenceHub = nil
			end
		end)
	end

	showPage("主页")

	-- loading screen
	local loading = make("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(11, 15, 13),
		ZIndex = 100,
	}, gui)

	-- if something stalls, drop the loading screen after 12s
	task.delay(12, function()
		if loading and loading.Parent then
			loading:Destroy()
			pumpkin.Visible = true
			ready = true
			setOpen(true)
		end
	end)

	local loadingActive = true

	make("TextLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromOffset(400, 30),
		Position = UDim2.fromScale(0.5, 0.5),
		Text = HUB_TITLE,
		TextColor3 = THEME.text,
		Font = THEME.fontBold,
		TextSize = 22,
	}, loading)

	do -- thin progress line under the title
		local bar = make("Frame", {
			AnchorPoint = Vector2.new(0.5, 0),
			Size = UDim2.fromOffset(120, 1),
			Position = UDim2.new(0.5, 0, 0.5, 24),
			BackgroundColor3 = THEME.line,
		}, loading)
		local barFill = make("Frame", {
			Size = UDim2.new(0, 0, 1, 0),
			BackgroundColor3 = THEME.orange,
		}, bar)
		tween(barFill, 1.3, { Size = UDim2.fromScale(1, 1) }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
	end

	make("TextLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 1),
		Size = UDim2.fromOffset(380, 20),
		Position = UDim2.new(0, 14, 1, -10),
		Text = "正在加载 " .. totalScripts .. " 个脚本... 久等了",
		TextColor3 = THEME.muted,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = THEME.font,
		TextSize = 13,
	}, loading)

	task.wait(1.4)

	loadingActive = false
	fadeOut(loading, 0.5)
	task.wait(0.55)
	loading:Destroy()

	pumpkin.Visible = true
	ready = true
	setOpen(true)
	notify(TF("欢迎，%s！", player.DisplayName), 3)

	-- Background music (resumes your last song, if you played one before)
	if autoplayOn and current then
		task.spawn(setMusic, true)
	end

	-- Chat announcement
	if CHAT_ANNOUNCE then
		task.spawn(function()
			pcall(function()
				local channel = game:GetService("TextChatService").TextChannels:FindFirstChild("RBXGeneral")
				if not channel then
					return
				end
				for _, message in ipairs(CHAT_MESSAGES) do
					channel:DisplaySystemMessage(message)
					task.wait(1.5)
				end
			end)
		end)
	end

	-- Intro text over the Doors menu (skipped when MainUI doesn't exist)
	if SHOW_DOORS_INTRO then
		task.spawn(function()
			pcall(function()
				local mainUI = playerGui:FindFirstChild("MainUI")
				local mainFrame = mainUI and mainUI:FindFirstChild("MainFrame")
				local introText = mainFrame and mainFrame:FindFirstChild("IntroText")
				if not introText then
					return
				end
				local intro = introText:Clone()
				intro.Parent = mainUI
				intro.Name = "Hub 介绍"
				intro.Visible = true
				intro.Text = DOORS_INTRO_TEXT
				intro.TextTransparency = 0

				local underline = intro:FindFirstChild("Underline")
				if underline then
					tween(underline, 3, { Size = UDim2.new(1.1, 0, 0.015, 6) }, Enum.EasingStyle.Linear)
					task.wait(7)
					tween(underline, 1.3, { Size = UDim2.new(0.95, 0, 0.015, 6) }, Enum.EasingStyle.Linear)
					tween(underline, 2, { ImageTransparency = 1 }, Enum.EasingStyle.Linear)
					tween(underline, 7, { Size = UDim2.new(0, 0, 0.015, 6) }, Enum.EasingStyle.Linear)
				end
				tween(intro, 2, { TextTransparency = 1 }, Enum.EasingStyle.Linear)
				task.wait(2.3)
				intro.Visible = false
				task.wait(4)
				intro:Destroy()
			end)
		end)
	end

end)

if not ok then
	warn("[HalloweenHub] 启动失败：", err)
	gui:Destroy()
end
