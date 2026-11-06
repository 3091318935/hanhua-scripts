-- Silence hub / WH1T3 GUI
-- doors mods + tools, saves stuff to workspace if your executor can writefile

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local GUI_NAME = "SilenceHub"

-- "hub" is a small toolbox your buttons can use, e.g. hub.notify("Hi!")
-- (it gets filled in further down, after the UI exists)
local hub = { player = player }

--   edit this part     (buttons, credits, descriptions)
--
-- Every button is a table with these fields:
--   name        = text shown on the button
--   description = what shows when you tap the three dots
--   confirm     = true  -> asks "Are you sure?" before running
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
	"<b><font color='rgb(192, 54, 66)'>Silence Hub loaded</font></b>",
	"<b><font color='rgb(192, 54, 66)'>Owner: Rip_Silence (#idkman06483)  |  Co-Owner: WH1T3 (#relayhost) </font></b>",
	"<b><font color='rgb(192, 54, 66)'>GUI by WH1T3 (Co-Owner) & Credit to RealblueYT for The Sign Text In Chat</font></b>",
	"<b><font color='rgb(192, 54, 66)'>Sorry for the delay on V36, thanks for waiting!</font></b>",
}

-- Big intro text over Doors' own menu (does nothing outside Doors)
local SHOW_DOORS_INTRO = true
local DOORS_INTRO_TEXT = "Silence Hub"

-- Scripts that get a 🆕 badge (and show up in Home > NEW SCRIPTS). Use the exact script name.
-- Next update: clear this list and add the new names.
local NEW_SCRIPTS = {
	["Madness Mode 1.2"] = true,
	["too lazy to put text here"] = true,
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
	-- { name = "Spooky Theme", id = 1234567890 },
	-- { name = "Creepy Piano", url = "https://example.com/creepy-piano.mp3" },
	-- { name = "My Song",      file = "HalloweenHub/song.mp3" },
}

--  SCRIPT TABS  (all the scripts from Testing.txt)
-- Each tab has a list of buttons. Same fields as described above:
--   name, description, subtitle (small text under the name),
--   confirm / confirmText, run = function() ... end
-- To add a script: copy a block, paste it in the right tab, edit it.
local SCRIPT_TABS = {
	{
		name = "Modes",
		section = "Have Fun With These Modes",
		buttons = {
			{
				name = "Forgotten Mode",
				subtitle = "Working Perfectly",
				description = "Working Perfectly",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/Wy7PSxjz"))()
				end,
			},
			{
				name = "Creepy Mode",
				subtitle = "Made by DripCapyBara",
				description = "Made by DripCapyBara",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/DripCapybara/Doors-Modes/refs/heads/main/CreepyMode/ObfuscatedMain.lua"))()
				end,
			},
			{
				name = "Combined Mode (Fixed)",
				subtitle = "Fixed By Gab",
				description = "Fixed By Gab",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzzGabbbb/TheCombined/refs/heads/main/CombinedModeFixedWAAAAAAAAAAAAAAAAAAAAAAAAAAAAA.lua"))()
				end,
			},
			{
				name = "Ultra Hard Mode (UPDATED)",
				subtitle = "Made By Zunxd",
				description = "Made By Zunxd",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junxd-03/UltraHardModeUpdate/refs/heads/main/UltraHardMode.lua"))()
				end,
			},
			{
				name = "Laver Mode (Recreated)",
				subtitle = "Recreated By Guestly (Celestian)",
				description = "Recreated By Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/Laver-Mode-Remake"))()
				end,
			},
			{
				name = "Hazy Mode (Recreated)",
				subtitle = "Recreated by Guestly (Celestian)",
				description = "Recreated by Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Hazy-Mode-Recreated-made-by-Guestly-(Celestian)-on-Discord"))()
				end,
			},
			{
				name = "Dark Mode (Fixed)",
				subtitle = "Fixed By Gab",
				description = "Fixed By Gab",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzzGabbbb/-/refs/heads/main/Dark%20Mode%20Fixed.lua"))()
				end,
			},
			{
				name = "Part Mode",
				subtitle = "Made By Guestly (Celestian)",
				description = "Made By Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/Parts-Mode"))()
				end,
			},
			{
				name = "Void Mode",
				subtitle = "Credit to Minh_Dcord",
				description = "Credit to Minh_Dcord",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/minh-scripter/doors_void/refs/heads/main/Doors_Void_Mode.txt"))()
				end,
			},
			{
				name = "Null Mode",
				subtitle = "Made by RealblueYT & LDLT_Legacy",
				description = "Made by RealblueYT & LDLT_Legacy",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Null-mode/refs/heads/main/Null%20mode%20alpha%20by%20RealblueYT%20and%20LDLT_legacy"))()
				end,
			},
			{
				name = "Cazy Mode",
				subtitle = "Made By RealblueYT",
				description = "Made By RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/realbluedeptrainhat/Cazy-mode/refs/heads/main/cazy-mode%20.txt", true))()
				end,
			},
			{
				name = "Fear Mode V2",
				subtitle = "Made By Reboundplayz",
				description = "Made By Reboundplayz",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/Doors%20Fear%20Mode"))()
				end,
			},
			{
				name = "Corrupted Mode",
				subtitle = "Made by Junin_320hy",
				description = "Made by Junin_320hy",
				run = function()
loadstring(game:HttpGet("https://github.com/junin724/Doors-modes/raw/refs/heads/main/Corrupted%20mode%20By%20me"))()
				end,
			},
			{
				name = "Fog Mode (Released)",
				subtitle = "Made By Vuivuiviu2",
				description = "Made By Vuivuiviu2",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Ganyu06112/Fog-Mode/refs/heads/main/Fog-Mode.lua"))()
				end,
			},
			{
				name = "Impossible+ Mode V1.8 (Reworked)",
				subtitle = "Made By Guestly (Celestian), Rip Voorpro's Impossible Mode",
				description = "Made By Guestly (Celestian), Rip Voorpro's Impossible Mode",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Outernal/Doors/refs/heads/main/Impossible-Mode-Plus"))()
				end,
			},
			{
				name = "Hallucination Mode (Easy Version)",
				subtitle = "Credit to Guestly (Celestian)",
				description = "Credit to Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Hallucination-Mode-(Easy-Version)-Made-by-Celestian-on-Discord"))()
				end,
			},
			{
				name = "Immersive Mode (Fixed)",
				subtitle = "Made by LocalPlayer",
				description = "Made by LocalPlayer",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/fixedImmkersivemodeabitbutbyes"))()
				end,
			},
			{
				name = "Nightmare Mode",
				subtitle = "Made by Kodbol & Remade by Reboundplayz",
				description = "Made by Kodbol & Remade by Reboundplayz",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/YbkbZ3fp"))()
				end,
			},
			{
				name = "Insanitas Mode",
				subtitle = "Made by Guestly (Celestian) & Vuivuiviu2",
				description = "Made by Guestly (Celestian) & Vuivuiviu2",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Insanitas-Mode-Made-By-Guestly-And-Vuivuiviu2"))()
				end,
			},
			{
				name = "Bissastant Mode",
				subtitle = "Made by Guestly (Celestian)",
				description = "Made by Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/Bissastant-Mode"))()
				end,
			},
			{
				name = "Inferno Mode",
				subtitle = "Made by Anctarus7105",
				description = "Made by Anctarus7105",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Anctarus7105/My-Modes/refs/heads/main/Inferno.lua"))()
				end,
			},
			{
				name = "Horror Mode (Fixed)",
				subtitle = "Original Credit to Chrono and Credit to THE_LOSTW3R for fixing it",
				description = "Original Credit to Chrono and Credit to THE_LOSTW3R for fixing it",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostw3r/Mods/main/HorrorMode.lua"))()
				end,
			},
			{
				name = "Crazy Mode",
				subtitle = "Credit to Guestly (Celestian)",
				description = "Credit to Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/lynguyen26031993-design/-u/refs/heads/main/crazy-mode"))()
				end,
			},
			{
				name = "Roomy Mode",
				subtitle = "Made by FenzerPlayerPressure",
				description = "Made by FenzerPlayerPressure",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/FenzerPlayerPressure/SubVersions/refs/heads/main/Roomy%20Mode.lua"))()
				end,
			},
			{
				name = "Scary Mode",
				subtitle = "Made by Rip_Silence",
				description = "Made by Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Scary%20Mode"))()
				end,
			},
			{
				name = "Draco Mode V2",
				subtitle = "Made by Rip_Silence",
				description = "Made by Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Draco%20Mode%20(Fully%20Completed)"))()
				end,
			},
			{
				name = "Baller Mode",
				subtitle = "Made by Zunxd",
				description = "Made by Zunxd",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Baller-mode/refs/heads/main/Mode"))()
				end,
			},
			{
				name = "Critazy Mode",
				subtitle = "Made by RealblueYT",
				description = "Made by RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Critazy-mode-/refs/heads/main/Critazy%20mode.LocalPlayer"))()
				end,
			},
			{
				name = "Ringer Mode",
				subtitle = "Made by Chu be te liet",
				description = "Made by Chu be te liet",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/chubeteliet-cpu/Ringer-doors/refs/heads/main/RINGER-DOORS-NEW!", true))()
				end,
			},
			{
				name = "Devil Mode (Fixed)",
				subtitle = "Fixed by Smile & Tuffmu Chicken Boy",
				description = "Fixed by Smile & Tuffmu Chicken Boy",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/datdoors/Devilmodefixed.main/refs/heads/main/Devilmodefixed"))()
				end,
			},
			{
				name = "Rooms Mode",
				subtitle = "Made by Gab",
				description = "Made by Gab",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/WLjeQQWm"))()
				end,
			},
			{
				name = "AyZen Mode",
				subtitle = "Made by Anctarus7105",
				description = "Made by Anctarus7105",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Anctarus7105/My-Modes/refs/heads/main/AyZen%20Mode/Mode.lua"))()
				end,
			},
			{
				name = "Strange Mode",
				subtitle = "Made By Guestly (Celestian)",
				description = "Made By Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/Strange-Mode"))()
				end,
			},
			{
				name = "Anarchy Mode",
				subtitle = "Released By Anctarus7105",
				description = "Released By Anctarus7105",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Anctarus7105/Recreated-modes/refs/heads/main/Anarchy%20Release"))()
				end,
			},
			{
				name = "Extreme Mode (Recreated)",
				subtitle = "Recreated by Guestly (Celestian)",
				description = "Recreated by Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Extreme-Mode-Recreated-made-by-Guestly"))()
				end,
			},
			{
				name = "Chaos + Recall Mode",
				subtitle = "Made by Anctarus7105 & Aboba288-Abobic",
				description = "Made by Anctarus7105 & Aboba288-Abobic",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Anctarus7105/Recreated-modes/refs/heads/main/Chaos%20Recall%20V1.0"))()
				end,
			},
			{
				name = "Stingray Mode",
				subtitle = "Made by Anzor",
				description = "Made by Anzor",
				run = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Anzor5458/Doors-stingray-mod/refs/heads/main/Anzor'))()
				end,
			},
			{
				name = "Medium Mode",
				subtitle = "Made by someone that idk",
				description = "Made by someone that idk",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Medium-Mode-Made-by-someone-that-idk"))()
				end,
			},
			{
				name = "Insane Mode",
				subtitle = "Made by TheDarkMan & Recreated By Guestly (Celestian)",
				description = "Made by TheDarkMan & Recreated By Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/Insane-Mode"))()
				end,
			},
			{
				name = "Arctic Mode",
				subtitle = "Made by Guestly (Celestian)",
				description = "Made by Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/Arctic-Mode-(Beta)-By-Guestly-And-Vuivuiviu2"))()
				end,
			},
			{
				name = "Hardcore Mode (But Bad)",
				subtitle = "Made by RipperHC",
				description = "Made by RipperHC",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/KendrickFan59/privatev2/refs/heads/main/efdff"))()
				end,
			},
			{
				name = "Ringer Mode (Remake)",
				subtitle = "Remaked by RealblueYT",
				description = "Remaked by RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/realbluedeptrai/Ringer-mode/refs/heads/main/ringer%20mode%20remake", true))()
				end,
			},
			{
				name = "Voidness Mode V2",
				subtitle = "Made by Guestly (Celestian) & Vuivuiviu2 & Voorpr0",
				description = "Made by Guestly (Celestian) & Vuivuiviu2 & Voorpr0",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/Voidness-Mode-Made-By-Guestly-Vuivuiviu2-And-Voorpr0", true))()
				end,
			},
			{
				name = "Forbidden Mode (Recreated)",
				subtitle = "Credit to Noah and Recreated By Guestly (Celestian)",
				description = "Credit to Noah and Recreated By Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Forbidden-Mode-recreated-by-Guestly"))()
				end,
			},
			{
				name = "Lunacy Mode V6 (Recreated)",
				subtitle = "Made by Guestly & Vuivuiviu2 & Nowhywhat & VoorPr0",
				description = "Made by Guestly & Vuivuiviu2 & Nowhywhat & VoorPr0",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Nowhywhat/Cooking/main/LunacyMode.lua"))()
				end,
			},
			{
				name = "Fragmented Mode V5",
				subtitle = "Credit to Nhankgnew",
				description = "Credit to Nhankgnew",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/talales/Nhankg./refs/heads/main/the%20fragments%20v5"))()
				end,
			},
			{
				name = "Degenerate Mode (Reposted)",
				subtitle = "Made by Guestly (Celestian)",
				description = "Made by Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/Degenerate-Mode-Reposted"))()
				end,
			},
			{
				name = "Hardcore Mode (Fixed)",
				subtitle = "Made By Noonie & Ping and Credit to THE_LOSTW3R for fixing the Hardcore Mode",
				description = "Made By Noonie & Ping and Credit to THE_LOSTW3R for fixing the Hardcore Mode",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostw3r/Mods/main/HardcoreMode.lua"))()
				end,
			},
			{
				name = "Mayhem Mode",
				subtitle = "Working Perfectly",
				description = "Working Perfectly",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/localplayerr/Doors-stuff/refs/heads/main/Mayhem%20mode%20recreate/Code"))()
				end,
			},
			{
				name = "Endless Mode (Fixed)",
				subtitle = "Made by DripCapybara & Fixed By Gab",
				description = "Made by DripCapybara & Fixed By Gab",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/EnSmizjL/raw"))()
				end,
			},
			{
				name = "Hollow Mode",
				subtitle = "Made by someone that idk",
				description = "Made by someone that idk",
				run = function()
loadstring(game:HttpGet("https://rawscripts.net/raw/DOORS-DAILY-RUNS-Hollow-Mode-91878"))()
				end,
			},
			{
				name = "Glassy Mode",
				subtitle = "Made by Guestly",
				description = "Made by Guestly",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/lynguyen26031993-design/-u/refs/heads/main/Glassy%20Mode"))()
				end,
			},
			{
				name = "Zombie Mode",
				subtitle = "Made by Grampy",
				description = "Made by Grampy",
				run = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/GrampyMods/ZombieMode/refs/heads/main/mode'))()
				end,
			},
			{
				name = "Hardcore Mode (Re-Remastered)",
				description = "Loads and runs Hardcore Mode (Re-Remastered).",
				run = function()
local url = "https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/main/Hardcore-Mode-Re-Remastered-Made-By-Guestly-Vuivuiviu2-Nowhywhat-Voorpr0"

local ok, err = pcall(function()
loadstring(game:HttpGet(url, true))()
end)

if not ok then
warn("[Loadstring Error]", err)
else
print("[Loaded Successfully]")
end
				end,
			},
			{
				name = "Gab's Fragmented Mode (Kinda Broken)",
				subtitle = "Made By Gab",
				description = "Made By Gab",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/nMgH5Jwa"))()
				end,
			},
			{
				name = "Immersive Mode (Remake)",
				subtitle = "Remake by RealblueYT",
				description = "Remake by RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/immersive-remake/refs/heads/main/Immersive-remake-loaded-localplayer-Origin-script.lua"))()
				end,
			},
			{
				name = "Ultra Hard Mode V3 (Remake)",
				subtitle = "Remake by RealblueYT",
				description = "Remake by RealblueYT",
				run = function()
loadstring(game:HttpGet("https://arch-http.vercel.app/files/projecthradmodv3"))()
				end,
			},
			{
				name = "Fragmented Mode V4 (Fixed)",
				subtitle = "Made By Jabiss",
				description = "Made By Jabiss",
				run = function()
loadstring(game:HttpGet("https://glot.io/snippets/h81q93s9qb/raw/main.lua"))()
				end,
			},
			{
				name = "Plamen6789's Hardcore Mode (Remake)",
				subtitle = "Remaked By Zunxd",
				description = "Remaked By Zunxd",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Hardcore-mode/refs/heads/main/hardcore.lua"))()
				end,
			},
			{
				name = "Insanity Mode (Reworked)",
				subtitle = "Credit to Kotyara19k & ReboundPlayz & Voorpr0",
				description = "Credit to Kotyara19k & ReboundPlayz & Voorpr0",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Anctarus7105/Recreated-modes/refs/heads/main/Insanity%20Reworked%201.3"))()
				end,
			},
			{
				name = "Stalker Mode (???)",
				subtitle = "Made by Leo -LDX-",
				description = "Made by Leo -LDX-",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/leonardocostagaucheuroleonardo-sketch/Stalkermodofc/refs/heads/main/README.md"))()
				end,
			},
			{
				name = "Fear Mode (Remake)",
				subtitle = "Remaked by RealblueYT",
				description = "Remaked by RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Fearmode-/refs/heads/main/Fearmodereamake.txt"))()
				end,
			},
			{
				name = "Meme Mode",
				subtitle = "Made by Chu be te liet",
				description = "Made by Chu be te liet",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/chubeteliet-cpu/meme-mode-m-p/refs/heads/main/Meme-mode-ma-hoa", true))()
				end,
			},
			{
				name = "Christmas Mode",
				subtitle = "Credit to Chill Guy",
				description = "Credit to Chill Guy",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Idk-lol2/xmasmode/refs/heads/main/xmasmode.txt"))()
				end,
			},
			{
				name = "Hardcore Mode V4 (Old Version)",
				subtitle = "Made by Noonie & Ping",
				description = "Made by Noonie & Ping",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/localplayerr/Doors-stuff/refs/heads/main/Hardcore%20v4%20recreate/main%20code"))()
				end,
			},
			{
				name = "Impossible Mode (Remake)",
				subtitle = "Remaked by RealblueYT & Smile",
				description = "Remaked by RealblueYT & Smile",
				run = function()
loadstring(game:HttpGet("https://arch-http.vercel.app/files/Projectimpossiblebyrealblueytandsmile"))()
				end,
			},
			{
				name = "Schizophrenia Mode",
				subtitle = "Made by GroxMC (Fake)",
				description = "Made by GroxMC (Fake)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/tranthienhao872-ship-it/Mode/refs/heads/main/Mode%20doors%20test"))()
				end,
			},
			{
				name = "Fragmented Mode V4 (Remake)",
				subtitle = "Remaked by RealblueYT",
				description = "Remaked by RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/fragmented-v4-fixe/refs/heads/main/fragmentedv4fixed.lua"))()
				end,
			},
			{
				name = "Ultimate Nightmare Mode V8.2",
				subtitle = "Credit to Tuffmu Chicken Boy",
				description = "Credit to Tuffmu Chicken Boy",
				run = function()
loadstring(game:HttpGet("https://arch-http.vercel.app/files/ByTuffmuScriptVersion8.2UltimateNightmareMode.txt"))()
				end,
			},
			{
				name = "Impossible Mode (Re-Degenerate)",
				subtitle = "Made by Guestly (Celestian)",
				description = "Made by Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/Impossible-Mode-Re-Degenerate-Made-By-Guestly"))()
				end,
			},
			{
				name = "Gab's Hardcore Mode (MultiPlayer)",
				subtitle = "Made By Gab",
				description = "Made By Gab",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/b9jTt9zi"))()
				end,
			},
			{
				name = "Gab's Hardcore Mode (SinglePlayer)",
				subtitle = "Made by Gab",
				description = "Made by Gab",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/jTrCetvx"))()
				end,
			},
			{
				name = "Silence Mode V3",
				subtitle = "Made By Rip_Silence",
				description = "Made By Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Silence%20Mode"))()
				end,
			},
			{
				name = "Degenerate Mode (Darkness Version)",
				subtitle = "Credit to Guestly (Celestian)",
				description = "Credit to Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Darkness-Degenerate-Mode-Made-By-Guestly"))()
				end,
			},
			{
				name = "Cizinuness Mode",
				subtitle = "Created by Guestly (Celestian)",
				description = "Created by Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Cizinuness-Mode-Made-By-Guestly", true))()
				end,
			},
			{
				name = "Suggestion Mode",
				subtitle = "Made By Guestly (Celestian)",
				description = "Made By Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/Suggestions-Mode"))()
				end,
			},
			{
				name = "Dreamcore Mode",
				subtitle = "Made by Guestly & VoorPr0",
				description = "Made by Guestly & VoorPr0",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Dreamcore-Mode-Made-by-Guestly-and-Voorpr0"))()
				end,
			},
			{
				name = "Cataclysm Mode",
				subtitle = "Made by Guestly (Celestian) & Vuivuiviu3",
				description = "Made by Guestly (Celestian) & Vuivuiviu3",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Cataclysm-Mode-made-by-Guestly-and-Vuivuiviu3"))()
				end,
			},
			{
				name = "Sadness Mode",
				subtitle = "Credit to someone that idk",
				description = "Credit to someone that idk",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/LLGCAllIWantIsYou/urban-broccoli/refs/heads/main/SadnessMode.lua"))()
				end,
			},
			{
				name = "Hazy Mode + Extreme Mode (Combined)",
				subtitle = "Credit to Guestly (Celestian)",
				description = "Credit to Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Hazy%2BExtreme-Mode-made-by-Guestly-on-Discord"))()
				end,
			},
			{
				name = "Hardcore Mode (Reworker)",
				subtitle = "Made by RealblueYT",
				description = "Made by RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Hradcore-by-noonies-remakes/refs/heads/main/Hradcore%20reworker%20by%20RealblueYT%20chubeteliet%20LDLT_legacy"))()
				end,
			},
			{
				name = "Fragmented Mode V4 (Not Official)",
				subtitle = "Credit to someone that idk",
				description = "Credit to someone that idk",
				run = function()
loadstring(game:HttpGet("https://glot.io/snippets/h7zlma80wm/raw/Main.java"))()
				end,
			},
			{
				name = "Terror Mode",
				subtitle = "Working Perfectly",
				description = "Working Perfectly",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Teilsthebfdifan/Modhub-assets/refs/heads/main/TerrorModeOBF.lua"))()
				end,
			},
			{
				name = "Hardcore Mode (Remake)",
				subtitle = "Remake by Junin_320hy",
				description = "Remake by Junin_320hy",
				run = function()
loadstring(game:HttpGet("https://github.com/junin724/Doors-modes/raw/refs/heads/main/Hardcore%2520mode%2520remake"))()
				end,
			},
			{
				name = "Endless Mode (Remake)",
				subtitle = "Remaked by Chu be te liet",
				description = "Remaked by Chu be te liet",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/binhlforsaken156-sys/Enless-mode-remake/refs/heads/main/Endless-remake-by-chubeteliet.txt", true))()
				end,
			},
			{
				name = "Fear Mode (Re-Remastered)",
				subtitle = "Credit to RealblueYT",
				description = "Credit to RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Fear-mode-re_remastere/refs/heads/main/obfuscated_script-1769600892332.lua.txt"))()
				end,
			},
			{
				name = "Hallucination Mode (Hard Version)",
				subtitle = "Credit to Guestly (Celestian)",
				description = "Credit to Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Hallucination-Mode-(Hard-Version)-Made-by-Celestian-On-Discord"))()
				end,
			},
			{
				name = "Cataclysmic Mode",
				subtitle = "Credit to Guestly & Vuivuiviu4",
				description = "Credit to Guestly & Vuivuiviu4",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Modes/refs/heads/main/Cataclysmic-Mode-Made-by-Guestly-and-Vuivuiviu4"))()
				end,
			},
			{
				name = "White Haze Mode",
				subtitle = "Made by Minh_DCord",
				description = "Made by Minh_DCord",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/White%20Haze%20Mode"))()
				end,
			},
			{
				name = "Chaos Mode V1 (Hardcore Version)",
				subtitle = "Credit to DJ SD (Tunder8401) & Rip_Silence",
				description = "Credit to DJ SD (Tunder8401) & Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Chaos-Mode-Hardcore-Version/refs/heads/main/Chaos%20Mode%20V1%20(Hardcore%20Version)"))()
				end,
			},
			{
				name = "The Mines Mode",
				subtitle = "Made by Gab",
				description = "Made by Gab",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/Hgn6DarS"))()
				end,
			},
			{
				name = "Difficulty Mode",
				subtitle = "Made by eoyoustme",
				description = "Made by eoyoustme",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/41450088/refs/heads/main/Difficulty%20mode%20fix"))()
				end,
			},
			{
				name = "Psychotic Mode",
				subtitle = "Made by someone that idk",
				description = "Made by someone that idk",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/Psychotic-mode/main/monste%20and%20Door%20Sounds.lua"))()
				end,
			},
			{
				name = "Darkness Mode",
				subtitle = "Made by Chu be te liet",
				description = "Made by Chu be te liet",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/chubeteliet-cpu/Darkness-mode/refs/heads/main/Darkness%20mode%20rework", true))()
				end,
			},
			{
				name = "Stryker Mode",
				subtitle = "Made by Rip_Silence",
				description = "Made by Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Stryker-Mode-(Fully-Completed)"))()
				end,
			},
			{
				name = "Impossible Mode (Alpha)",
				subtitle = "Made by RealBlueYT",
				description = "Made by RealBlueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/realbluedeptrainhat/Impossible-alpha-/refs/heads/main/impossible%20alpha.txt", true))()
				end,
			},
			{
				name = "Endless Mode (eliazbp92)",
				description = "Loads and runs Endless Mode (eliazbp92).",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eliazbp92-collab/Endless-mode/refs/heads/main/Script.lua"))()
				end,
			},
			{
				name = "Hardcore Mode (VERY OLD)",
				subtitle = "Very very very old, may not work on Hotel+",
				description = "A VERY VERY VERY old Hardcore Mode. It's old as hell and might not work on Hotel+.",
				confirm = true,
				confirmText = "This Hardcore Mode is VERY VERY VERY old. It's old asf and maybe won't work on Hotel+. Run it anyway?",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/jackpetersmithwarr-collab/DoorsHardmodeold/main/MAINSCRIPT"))()
				end,
			},
			{
				name = "Gradish Mode",
				description = "Loads and runs Gradish Mode.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/J63633S/Gradish-mode/main/Main%20script."))()
				end,
			},
			{
				name = "Hardcore Mode (Retake Plus)",
				description = "Loads and runs Hardcore Mode (Retake Plus).",
				run = function()
loadstring(game:HttpGet("https://github.com/tranthienhao872-ship/Hardcore-Retake/raw/refs/heads/main/Plus%20again"))()
				end,
			},
		},
	},
	{
		name = "Extra",
		section = "Very Cool Things",
		buttons = {
			{
				name = "Floor 2 Theme Map",
				subtitle = "Updated by Zunxd",
				description = "Updated by Zunxd",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junxd-03/Floor-2/refs/heads/main/New"))()
				end,
			},
			{
				name = "Fog Map",
				subtitle = "???",
				description = "???",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Fog-doors/refs/heads/main/Fogg"))()
				end,
			},
			{
				name = "Demon Map (Red Map)",
				subtitle = "666 666 666",
				description = "666 666 666",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/Monoxide/refs/heads/main/DEMON"))()
				end,
			},
			{
				name = "Rust Map",
				subtitle = "Made by RealblueYT",
				description = "Made by RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Rust-maps/refs/heads/main/Rustmapuptdate.txt"))()
				end,
			},
			{
				name = "Knob Farm",
				subtitle = "Made by Vynixius",
				description = "Made by Vynixius",
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
				name = "Verity Script",
				subtitle = "Made by ItzzGabbbb (Minecraft Mod btw)",
				description = "Made by ItzzGabbbb (Minecraft Mod btw)",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/sqdSTwKt/raw"))()
				end,
			},
			{
				name = "Rainbow Room",
				subtitle = "Credit to UnknownReturnz for giving me this script",
				description = "Credit to UnknownReturnz for giving me this script",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Doors-Hub/refs/heads/main/Rainbow-Room"))()
				end,
			},
			{
				name = "Script Mode V1 (Released)",
				subtitle = "Made By Munciseek",
				description = "Made By Munciseek",
				run = function()
loadstring(game:HttpGet("https://illunox.qzz.io/api/scripts/42b63e919ea74a999f2fec6ffdc02de1"))()
				end,
			},
			{
				name = "Generator Hard Mode",
				subtitle = "Made by Indexell",
				description = "Made by Indexell",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IdkMyNameLoll/PublicScripts/refs/heads/main/HardGenIThinkReupload"))()
				end,
			},
			{
				name = "Chill Light (READ THE DESCRIPTION)",
				subtitle = "You need to die first and then you can see the chill light",
				description = "You need to die first and then you can see the chill light",
				run = function()
loadstring(game:HttpGet('https://pastebin.com/raw/nCYbqkAb'))()
				end,
			},
			{
				name = "Shaders (Working)",
				description = "Loads and runs Shaders (Working).",
				run = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/randomstring0/pshade-ultimate/refs/heads/main/src/cd.lua'))()
				end,
			},
			{
				name = "Keyboard (Working)",
				description = "Loads and runs Keyboard (Working).",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GGH52lan/GGH52lan/main/keyboard.txt"))()
				end,
			},
			{
				name = "Client Performance Test (Safe)",
				subtitle = "Runs a short, bounded responsiveness check",
				description = "A safe alternative to the old infinite print loop. It never intentionally freezes the client.",
				confirm = true,
				confirmText = "Run a short performance check? It will print a small result to the console.",
				run = function()
					local started = os.clock()
					local checksum = 0
					for i = 1, 20000 do
						checksum += i % 97
					end
					print(("[DoorsModesHub] Safe test completed in %.4fs (checksum %d)"):format(os.clock() - started, checksum))
				end,
			},
			{
				name = "Disconnect Game (READ THE DESCRIPTION)",
				subtitle = "If u executed this, you are the only one who got disconnected",
				description = "If u executed this, you are the only one who got disconnected",
				confirm = true,
				confirmText = "This will kick YOU from the game. Are you sure?",
				run = function()
game.Players.LocalPlayer:Kick("Why do you even execute this bro?")
				end,
			},
			{
				name = "Sprint Stamina V5",
				description = "Loads and runs Sprint Stamina V5.",
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
customstaminamessage = "SUA STAMINA ACABOU, AGUARDE %ds!",
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
				name = "IndiHome Script (Troll)",
				subtitle = "Made By OG Hunger (New)",
				description = "Made By OG Hunger (New)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/Hardcore/refs/heads/main/IndiHome"))()
				end,
			},
			{
				name = "Hotel- Gui (Only Works In Hotel-)",
				subtitle = "Made by someone that idk",
				description = "Made by someone that idk",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/En0eCsJd"))()
				end,
			},
			{
				name = "Simple Script Loader",
				subtitle = "Credit to someone that idk",
				description = "Credit to someone that idk",
				run = function()
loadstring(game:HttpGet("https://rawscripts.net/raw/DOORS-DAILY-RUNS-Simple-Script-Loader-92632"))()
				end,
			},
			{
				name = "Dev Admin Panel (Need Admin Panel)",
				subtitle = "Credit to someone that idk",
				description = "Credit to someone that idk",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/SHRTRYScriptMANhere/DoorsDevPanel/refs/heads/main/devpanel.lua",true))()
				end,
			},
			{
				name = "Viridis Rift",
				subtitle = "Made By Guestly (Celestian)",
				description = "Made By Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/Viridis-Rift"))()
				end,
			},
			{
				name = "Glitch Rift",
				subtitle = "Made By Guestly (Celestian)",
				description = "Made By Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/Glitch-Rift"))()
				end,
			},
			{
				name = "Mischievous Rift",
				subtitle = "Made By Guestly (Celestian)",
				description = "Made By Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/Mischievous-Rift"))()
				end,
			},
			{
				name = "Add Secret Entity",
				subtitle = "Credit to Rip_Silence",
				description = "Credit to Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Him-Entity-Main.lua"))()
				end,
			},
			{
				name = "Game File Logger",
				subtitle = "Made By Guestly (Celestian)",
				description = "Made By Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Scripts/refs/heads/main/Game-Files-Logger"))()
				end,
			},
			{
				name = "Door Display",
				subtitle = "Credit to Lucas",
				description = "Credit to Lucas",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/LukeLor/LukeLor/refs/heads/main/DoorDisplay.lua"))()
				end,
			},
			{
				name = "Helpful Rush",
				subtitle = "Credit to Lucas",
				description = "Credit to Lucas",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/LukeLor/LukeLor/refs/heads/main/Helpful%20Rush.lua"))()
				end,
			},
			{
				name = "Helping Jack (Only Works On Hotel-)",
				subtitle = "Made by Anctarus7105",
				description = "Made by Anctarus7105",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Anctarus7105/Random-Files/refs/heads/main/HelpingJack.lua"))()
				end,
			},
			{
				name = "Snare Blocker",
				subtitle = "Credit to Lucas",
				description = "Credit to Lucas",
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
print("Parented: "..effecth.Name)

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
print("vfx finished")
end
end
end)
coroutine.resume(ds)
end
end)
				end,
			},
			{
				name = "Speedrun Timer",
				subtitle = "Credit to Iliankvth",
				description = "Credit to Iliankvth",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Iliankytb/Iliankytb/main/SpeedrunTimer"))()
				end,
			},
			{
				name = "THE OVERDOORS V2.5 (Remake)",
				subtitle = "Remake by RealblueYT",
				description = "Remake by RealblueYT",
				run = function()
loadstring(game:HttpGet("https://arch-http.vercel.app/files/Projectoverdoors" ))()
				end,
			},
			{
				name = "c00lkidd Seek Chase (READ THE DESCRIPTION)",
				subtitle = "Execute this script and then go to the seek chase",
				description = "Execute this script and then go to the seek chase",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IdkMyNameLoll/PublicScripts/refs/heads/main/c00lkiddSeek"))()
				end,
			},
			{
				name = "Abrisam's Sprint Bar",
				subtitle = "Credit to Abrisam",
				description = "Credit to Abrisam",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/MgWAd5WQ"))()
				end,
			},
			{
				name = "The Lost Mines",
				subtitle = "Credit to Cosplayer",
				description = "Credit to Cosplayer",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Other-Modes-Script/refs/heads/main/The-Lost-Mines"))()
				end,
			},
			{
				name = "Script Mode (Remake)",
				subtitle = "Made by Reboundplayz",
				description = "Made by Reboundplayz",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/Script%20Mode"))()
				end,
			},
			{
				name = "THE OVERDOORS (Final Version)",
				subtitle = "Credit to Chu be te liet",
				description = "Credit to Chu be te liet",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/chubeteliet-cpu/OVERDOORS-rework-ver/refs/heads/main/OVERDOORS%20entity%20finale%20upd", true))()
				end,
			},
			{
				name = "Purple Shakelight (All Rifts)",
				description = "Loads and runs Purple Shakelight (All Rifts).",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/lukahudeev-sys/Purple-shakelight/refs/heads/main/all%20rifts"))()
				end,
			},
		},
	},
	{
		name = "OG Modes",
		section = "Only works in Super Hard Mode",
		buttons = {
			{
				name = "Hardcore Mode [OG]",
				subtitle = "OG Mode",
				description = "OG Mode",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/hsrvGG1d"))()
				end,
			},
			{
				name = "Fear Mode [OG]",
				subtitle = "OG Mode",
				description = "OG Mode",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/cool59572/freestuff/main/Fear_mode_multiplayer.lua"))()
				end,
			},
			{
				name = "Impossible Mode [OG]",
				subtitle = "OG Mode",
				description = "OG Mode",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Ukazix/impossible-mode/refs/heads/main/Protected_79.lua.txt", true))()
				end,
			},
		},
	},
	{
		name = "Hubs",
		section = "Enjoy these scripts",
		buttons = {
			{
				name = "Nullfire Script",
				description = "Loads and runs Nullfire Script.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TeamNullFire/NullFire/main/loader.lua"))()
				end,
			},
			{
				name = "Rapture Hub DoorsV1.2",
				description = "Loads and runs Rapture Hub DoorsV1.2.",
				run = function()
--[[
WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
loadstring(game:HttpGet("https://raw.githubusercontent.com/RaptureOfc/Rapture-Doors-Released-1.0-New/refs/heads/main/Doors%20Release%20Rapture"))()
				end,
			},
			{
				name = "Ms Paint V4",
				description = "Loads and runs Ms Paint V4.",
				run = function()
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/002c19202c9946e6047b0c6e0ad51f84.lua"))()
				end,
			},
			{
				name = "Ms Doors",
				description = "Loads and runs Ms Doors.",
				run = function()
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Msdoors-By-Rhyan57-54579"))()
				end,
			},
			{
				name = "Hardcore Mode ESP",
				subtitle = "It may help u know when hardcore entity is coming",
				description = "It may help u know when hardcore entity is coming",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Qiwikox12/stubrawl/refs/heads/main/DoorsHardcoreESP.txt", true))()
				end,
			},
			{
				name = "Script Packs",
				description = "Loads and runs Script Packs.",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/Piw5bqGq", true))()
				end,
			},
			{
				name = "LolHax Hub",
				description = "Loads and runs LolHax Hub.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxexploiterz/Release-Lolhax/refs/heads/main/LX%20Doors%20v3.lua"))()
				end,
			},
			{
				name = "Sexsation - Doors (Free)",
				description = "Loads and runs Sexsation - Doors (Free).",
				run = function()
loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/730854e5b6499ee91deb1080e8e12ae3.lua"))()
				end,
			},
			{
				name = "Abyssal Hub",
				subtitle = "Credit to FireBacon & wop2p",
				description = "Credit to FireBacon & wop2p",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/therealcookiemonsterof1966/AbysallContinued/main/Games/Doors/Main.luau"))()
				end,
			},
			{
				name = "Vynixius",
				description = "Loads and runs Vynixius.",
				run = function()
loadstring(game:HttpGet("https://vynixius.win/loader.luau", true))()
				end,
			},
			{
				name = "Astral Hub",
				subtitle = "Oogway",
				description = "Oogway",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/8cKJvTwg", true))()
				end,
			},
			{
				name = "LHKing Hub",
				subtitle = "LHking123456",
				description = "LHking123456",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/LHking123456/Dhjfdr9hk/refs/heads/main/Doors", true))()
				end,
			},
			{
				name = "HubHubHub",
				description = "Loads and runs HubHubHub.",
				run = function()
loadstring(game:HttpGet("https://rawscripts.net/raw/DOORS-DAILY-RUNS-HubHubHub-92582"))()
				end,
			},
			{
				name = "Joy Hub",
				description = "Loads and runs Joy Hub.",
				run = function()
loadstring(game:HttpGet("https://rawscripts.net/raw/DOORS-DAILY-RUNS-Joy-hub-93382"))()
				end,
			},
			{
				name = "Doors Hub + Editor (Beta)",
				subtitle = "Made By Loper367",
				description = "Made By Loper367",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/razumenkonikita9-cmyk/Doors-hub-Editor/refs/heads/main/D.lua"))()
				end,
			},
			{
				name = "Guestly's Doors Modes Hub V3",
				subtitle = "Credit to Guestly (Celestian)",
				description = "Credit to Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/GUESTLY-DOORS-MODE-HUB"))()
				end,
			},
			{
				name = "Guestly's New Doors Modes Hub",
				subtitle = "Made by Guestly (Celestian)",
				description = "Made by Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Modes/refs/heads/main/DOORS-MODES-HUB"))()
				end,
			},
			{
				name = "Eukard's Doors Modes Hub",
				subtitle = "Made By Eukard",
				description = "Made By Eukard",
				run = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Aboba228-Abobic/Eukard-s-Hub/refs/heads/main/EukardsHub'))()
				end,
			},
			{
				name = "Grampy's Doors Modes Hub",
				subtitle = "Made by Grampy",
				description = "Made by Grampy",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GrampyMods/doorsmodshub/refs/heads/main/script"))()
				end,
			},
			{
				name = "Doors Modes Hub V1 (Oldest Version??)",
				subtitle = "Oldest Version Of Doors Modes Hub???",
				description = "Oldest Version Of Doors Modes Hub???",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Unknown"))()
				end,
			},
			{
				name = "AmadeyHunter's Doors Utilities Hub Reorganized V20?",
				subtitle = "Credit to AmadeyHunter",
				description = "Credit to AmadeyHunter",
				run = function()
loadstring(game:HttpGet("https://github.com/AmadeyHunter/BackUp/raw/refs/heads/main/Doors-Utilities-Hub-Reorganized-V20"))()
				end,
			},
			{
				name = "Anctarus7105's Hub V3.5",
				subtitle = "Credit to Anctarus7105",
				description = "Credit to Anctarus7105",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Anctarus7105/My-creations/refs/heads/main/Anctarus7105'sHubV3.5"))()
				end,
			},
			{
				name = "Twinkhook Hub",
				subtitle = "Better than Abyssal Hub • has God Mode",
				description = "Another version of the hub, better than the Abyssal Hub, and it has god mode.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/sillyleo67/Doors/refs/heads/main/Twinkhook.lua"))()
				end,
			},
		},
	},
	{
		name = "Legacy",
		section = "Only works in Hotel-",
		buttons = {
			{
				name = "Hardcore Mode (Legacy)",
				subtitle = "Fixed By THE_LOSTW3R",
				description = "Fixed By THE_LOSTW3R",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostw3r/Mods/main/HardcoreMode%5BLEGACY%5D.lua"))()
				end,
			},
			{
				name = "Impossible Mode (Legacy)",
				subtitle = "Made by reboundplayz",
				description = "Made by reboundplayz",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Impossible-Mode-Legacy-Made-by-reboundplayz"))()
				end,
			},
			{
				name = "Mayhem Mode (Legacy)",
				subtitle = "Made By ItzzGabbbb",
				description = "Made By ItzzGabbbb",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzzGabbbb/MayhemModeLegacy1.0/refs/heads/main/DoorsMayhemModeLegacy.lua"))()
				end,
			},
			{
				name = "Fear Mode (Legacy)",
				subtitle = "Made by reboundplayz",
				description = "Made by reboundplayz",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/Fear%20Mode%20LEGACY"))()
				end,
			},
		},
	},
	{
		name = "Entities",
		section = "Custom Entity Spawner",
		buttons = {
			{
				name = "Hardcore A-60 Spawner",
				description = "Loads and runs Hardcore A-60 Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Idk-lol2/a-60aa/refs/heads/main/---%3D%3D%3D%3D%3D%3D%20a-60%20agresiv%20spawner%20%3D%3D%3D%3D%3D%3D---.txt"))()
				end,
			},
			{
				name = "Him Spawner",
				description = "Loads and runs Him Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Idk"))()
				end,
			},
			{
				name = "Hungered Spawner",
				description = "Loads and runs Hungered Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Hungerd/refs/heads/main/Entity"))()
				end,
			},
			{
				name = "Munci Spawner",
				description = "Loads and runs Munci Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Munci-entity/refs/heads/main/Munci-20"))()
				end,
			},
			{
				name = "Torment Spawner (READ THE DESCRIPTION)",
				subtitle = "Execute Torment Spawner at door 0 and open the next door",
				description = "Execute Torment Spawner at door 0 and open the next door",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/ohh/refs/heads/main/Torment12"))()
				end,
			},
			{
				name = "Trauma Spawner",
				description = "Loads and runs Trauma Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Trauma-entity/refs/heads/main/Trauma"))()
				end,
			},
			{
				name = "Disturbance Spawner (READ THE DESCRIPTION)",
				subtitle = "Execute Disturbance Spawner at door 0 and open the next door",
				description = "Execute Disturbance Spawner at door 0 and open the next door",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/talales/Nhankg.-/refs/heads/main/intro%20fragmented"))()
				end,
			},
			{
				name = "Obsession Spawner (READ THE DESCRIPTION)",
				subtitle = "Execute Obsession Spawner at door 0 and open the next door",
				description = "Execute Obsession Spawner at door 0 and open the next door",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/Mayhem-mode-enity/main/Hard%20Obsession.lua"))()
				end,
			},
			{
				name = "Hardcore Dread Spawner (Remake)",
				description = "Loads and runs Hardcore Dread Spawner (Remake).",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/Dread%20Remake"))()
				end,
			},
			{
				name = "Twister Spawner (Phase 1)",
				description = "Loads and runs Twister Spawner (Phase 1).",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/7jJP8zZb/raw"))()
				end,
			},
			{
				name = "Questioner Spawner",
				description = "Loads and runs Questioner Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Custom-Entity/refs/heads/main/Questioner-Entity"))()
				end,
			},
			{
				name = "Terrorist Spawner",
				description = "Loads and runs Terrorist Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/Spawn-terrorist/main/Spawn.lua"))()
				end,
			},
			{
				name = "Silence Spawner",
				description = "Loads and runs Silence Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Silence%20Entity"))()
				end,
			},
			{
				name = "Defrost Spawner",
				description = "Loads and runs Defrost Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/Custom-Entity/refs/heads/main/Defrost"))()
				end,
			},
			{
				name = "Smiler Spawner (Remake)",
				description = "Loads and runs Smiler Spawner (Remake).",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Smiler/refs/heads/main/Smi6"))()
				end,
			},
			{
				name = "Rebound Spawner (Remake)",
				description = "Loads and runs Rebound Spawner (Remake).",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Rebound-/refs/heads/main/Rebound"))()
				end,
			},
			{
				name = "Deer God Spawner (Remake)",
				description = "Loads and runs Deer God Spawner (Remake).",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/back/refs/heads/main/Deer%20God"))()
				end,
			},
			{
				name = "Cease Spawner",
				description = "Loads and runs Cease Spawner.",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/ofutwkjb/raw"))()
				end,
			},
			{
				name = "WH1T3 Spawner (Remake)",
				description = "Loads and runs WH1T3 Spawner (Remake).",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/Impossible/refs/heads/main/Wh1t3"))()
				end,
			},
			{
				name = "Giggle Spawner",
				subtitle = "Only spawn 1 Giggle each room",
				description = "Only spawn 1 Giggle each room",
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
				name = "Obsession Spawner (Remake)",
				description = "Loads and runs Obsession Spawner (Remake).",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/xlnpKWXo/raw"))()
				end,
			},
			{
				name = "A-100 Spawner",
				description = "Loads and runs A-100 Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/Impossible/refs/heads/main/A-100"))()
				end,
			},
			{
				name = "A-75 Spawner",
				description = "Loads and runs A-75 Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eliazbp92-collab/Rooms-low-detailed-mode-doors/refs/heads/main/A-75"))()
				end,
			},
			{
				name = "Daze Spawner",
				description = "Loads and runs Daze Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/ohh/refs/heads/main/Daze11"))()
				end,
			},
			{
				name = "God Spawner",
				subtitle = "Made by ItzzGabbbb",
				description = "Made by ItzzGabbbb",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/lAn7TCVE/raw"))()
				end,
			},
			{
				name = "R-40 Spawner",
				description = "Loads and runs R-40 Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzzGabbbb/R-40-Spawner-Fixed/refs/heads/main/Doors%20Entity%20R-40.txt"))()
				end,
			},
			{
				name = "Draft Spawner",
				description = "Loads and runs Draft Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/ohh/refs/heads/main/Draft1"))()
				end,
			},
			{
				name = "Fluster Spawner",
				description = "Loads and runs Fluster Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/talales/Nhankg./refs/heads/main/Fluster"))()
				end,
			},
			{
				name = "Angler Spawner",
				description = "Loads and runs Angler Spawner.",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/GQCHNZE1"))()
				end,
			},
			{
				name = "Monoxide Spawner",
				description = "Loads and runs Monoxide Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/back/refs/heads/main/Monoxide1"))()
				end,
			},
			{
				name = "Depthter Spawner",
				description = "Loads and runs Depthter Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/back/refs/heads/main/Depthter"))()
				end,
			},
			{
				name = "Blink Spawner",
				description = "Loads and runs Blink Spawner.",
				run = function()
loadstring(game:HttpGet("https://github.com/PABMAXICHAC/doors-monsters-scripts/raw/main/blinkcrux"))()
				end,
			},
			{
				name = "Dozer Spawner",
				description = "Loads and runs Dozer Spawner.",
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
				name = "Conjoinment Spawner",
				description = "Loads and runs Conjoinment Spawner.",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/Conjoinment%20Spawner"))()
				end,
			},
			{
				name = "Grudge Spawner",
				description = "Loads and runs Grudge Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/arkanzulfadliputra-oss/Entities-Models/refs/heads/main/Mod/Entity/With%20Jumpscare/Grudge.lua"))()
				end,
			},
			{
				name = "Cease (But Bad) Spawner",
				description = "Loads and runs Cease (But Bad) Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/KendrickFan59/privatev2/refs/heads/main/ceaser"))()
				end,
			},
			{
				name = "Virus Spawner",
				subtitle = "Entity Model Made by ItzzGabbb",
				description = "Entity Model Made by ItzzGabbb",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Private-Entity/refs/heads/main/Virus-Entity"))()
				end,
			},
			{
				name = "Fear Spawner",
				description = "Loads and runs Fear Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Custom-Entity/refs/heads/main/Fear-Nightmare-Mode"))()
				end,
			},
			{
				name = "350 Spawner",
				description = "Loads and runs 350 Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/350-entity/refs/heads/main/350"))()
				end,
			},
			{
				name = "G-95 Spawner",
				description = "Loads and runs G-95 Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/G-95-v2/refs/heads/main/Entity"))()
				end,
			},
			{
				name = "B ∆ B Spawner",
				description = "Loads and runs B ∆ B Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Private-Entity/refs/heads/main/B_%E2%88%86_B-Entity-Fixed"))()
				end,
			},
			{
				name = "Hiss Spawner",
				description = "Loads and runs Hiss Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Hiss/refs/heads/main/obfuscated_script-1769948042346.lua.txt"))()
				end,
			},
			{
				name = "B-444 Spawner",
				subtitle = "Made by ItzzGabbbb",
				description = "Made by ItzzGabbbb",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/9dkXpSyy/raw"))()
				end,
			},
			{
				name = "A-185 Spawner",
				description = "Loads and runs A-185 Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Private-Entity/refs/heads/main/A-185-Entity-Made-By-Someone"))()
				end,
			},
			{
				name = "Ruinator Spawner",
				description = "Loads and runs Ruinator Spawner.",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/zlwFiRuW/raw"))()
				end,
			},
			{
				name = "Trollface Spawner",
				description = "Loads and runs Trollface Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Private-Entity/refs/heads/main/Trollface-Entity"))()
				end,
			},
			{
				name = "Rebound Spawner (READ THE DESCRIPTION)",
				subtitle = "Execute Rebound Spawner at door 0 and open the next door",
				description = "Execute Rebound Spawner at door 0 and open the next door",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/ohh/refs/heads/main/Rebound"))()
				end,
			},
			{
				name = "Running Fredbear Spawner",
				description = "Loads and runs Running Fredbear Spawner.",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/wbEc0ThZ"))()
				end,
			},
			{
				name = "Ripper Spawner (Remake)",
				description = "Loads and runs Ripper Spawner (Remake).",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Ripperr/refs/heads/main/Ripperremake.lua"))()
				end,
			},
			{
				name = "Frostbite Spawner (Remake)",
				description = "Loads and runs Frostbite Spawner (Remake).",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/back/refs/heads/main/Frostbite1"))()
				end,
			},
			{
				name = "Pim Spawner",
				description = "Loads and runs Pim Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Private-Entity/refs/heads/main/Pim-Entitiy-Made-By-TheDarkMan1334-And-Remastered-By-Me"))()
				end,
			},
			{
				name = "A-60 Spawner (Remake)",
				description = "Loads and runs A-60 Spawner (Remake).",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/A-60%20Spawner"))()
				end,
			},
			{
				name = "Ch4s3r_Thre4t Spawner",
				description = "Loads and runs Ch4s3r_Thre4t Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Private-Entity/refs/heads/main/Ch4s3r_Thre4t-Entity"))()
				end,
			},
			{
				name = "Cease Spawner (Remake)",
				description = "Loads and runs Cease Spawner (Remake).",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Cease-Spawner-(Remake)"))()
				end,
			},
			{
				name = "Z-88 Spawner",
				subtitle = "Credit to Burgerware",
				description = "Credit to Burgerware",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Private-Entity/refs/heads/main/Z-88-Entity-Made-By-Burgerware"))()
				end,
			},
			{
				name = "Null Spawner",
				description = "Loads and runs Null Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/41450088/refs/heads/main/Null"))()
				end,
			},
			{
				name = "Fear Spawner (Remake)",
				description = "Loads and runs Fear Spawner (Remake).",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/nightmare/refs/heads/main/Fear"))()
				end,
			},
			{
				name = "Distort Spawner",
				description = "Loads and runs Distort Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/localplayerr/Doors-stuff/refs/heads/main/Immersive%20mode/Distort"))()
				end,
			},
			{
				name = "Fabric Spawner",
				description = "Loads and runs Fabric Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/localplayerr/Doors-stuff/refs/heads/main/Immersive%20mode/Fabricility"))()
				end,
			},
			{
				name = "Black Spawner",
				description = "Loads and runs Black Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Black-smile/refs/heads/main/Black"))()
				end,
			},
			{
				name = "Claim Spawner",
				description = "Loads and runs Claim Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/Doors-Mode-Remakes/refs/heads/main/Claim.lua"))()
				end,
			},
			{
				name = "Death Spawner",
				description = "Loads and runs Death Spawner.",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/death"))()
				end,
			},
			{
				name = "Moriarty Spawner",
				description = "Loads and runs Moriarty Spawner.",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/moriarty"))()
				end,
			},
			{
				name = "Chaotic Spawner",
				description = "Loads and runs Chaotic Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/J63633S/Laver-mode/refs/heads/main/Chaotic"))()
				end,
			},
			{
				name = "Corrode Spawner",
				description = "Loads and runs Corrode Spawner.",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/corrode"))()
				end,
			},
			{
				name = "Classio-Reboundier Spawner",
				description = "Loads and runs Classio-Reboundier Spawner.",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/classicorebuondier"))()
				end,
			},
			{
				name = "Dread Spawner (READ THE DESCRIPTION)",
				subtitle = "Execute Dread Spawner at door 0 and open the next door",
				description = "Execute Dread Spawner at door 0 and open the next door",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/talales/Nhankg_/refs/heads/main/intro%20fragmented"))()
				end,
			},
			{
				name = "Ripper Spawner (Made by Gab)",
				description = "Loads and runs Ripper Spawner (Made by Gab).",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzzGabbbb/RipperSpawner/refs/heads/main/RipperEntityFromHardcoreMode.lua"))()
				end,
			},
			{
				name = "Bluyer Spawner",
				description = "Loads and runs Bluyer Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Bluyer-entity/refs/heads/main/Bluyer"))()
				end,
			},
			{
				name = "Shocker Spawner",
				description = "Loads and runs Shocker Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Shocker-entity/refs/heads/main/Shocker"))()
				end,
			},
			{
				name = "Depth Spawner",
				description = "Loads and runs Depth Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Depth-v2/refs/heads/main/Entity"))()
				end,
			},
			{
				name = "Surge Spawner",
				description = "Loads and runs Surge Spawner.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Surge-entity/refs/heads/main/Surge"))()
				end,
			},
			{
				name = "Entity Spawner Hub",
				description = "Loads and runs Entity Spawner Hub.",
				run = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/plamen6789/UtilitiesHub/main/UtilitiesGUI'))()
				end,
			},
			{
				name = "Old Seek",
				description = "Loads and runs Old Seek.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/StovenChaos/Doors/refs/heads/main/Old%20seek.lua"))()
				end,
			},
			{
				name = "A-60 (Chaos Entity)",
				description = "Loads and runs A-60 (Chaos Entity).",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Custom-Entity/refs/heads/main/A-60-Chaos-Entity"))()
				end,
			},
			{
				name = "Noise (Glitch Version Included)",
				description = "Loads and runs Noise (Glitch Version Included).",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Outernal/Doors/refs/heads/main/Noise(IncludeGlitchVersion)"))()
				end,
			},
			{
				name = "Honcho Spawner",
				subtitle = "By Pepo Mods",
				description = "By Pepo Mods",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/bonellocristian78-lab/Gradish-Mode/main/Honcho.lua"))()
				end,
			},
		},
	},
	{
		name = "Items",
		section = "Enjoy these custom items",
		buttons = {
			{
				name = "Guiding Candle (UPDATED)",
				subtitle = "Fixed by Junbbinopro",
				description = "Fixed by Junbbinopro",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Guiding-light-candle/refs/heads/main/Candle"))()
				end,
			},
			{
				name = "Golden Gummy Flashlight",
				description = "Loads and runs Golden Gummy Flashlight.",
				run = function()
loadstring(game:HttpGet(("https://raw.githubusercontent.com/aadyian9000/the-thing/main/GoldenGummyFlashlight.lua"),true))()
				end,
			},
			{
				name = "Black Hole (OVERPOWERED)",
				description = "Loads and runs Black Hole (OVERPOWERED).",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/iimateiYT/Scripts/main/Black%20Hole.lua"))()
				end,
			},
			{
				name = "Scroll Of Sevenless",
				description = "Loads and runs Scroll Of Sevenless.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Ahma174/Tool/refs/heads/main/Doors%20Scroll%20Of%20Sevenless.lua"))()
				end,
			},
			{
				name = "Spear (Minecraft Item)",
				subtitle = "Made by Nowhywhats",
				description = "Made by Nowhywhats",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Spear-Minecraft-Item-Made-By-Nowhywhat"))()
				end,
			},
			{
				name = "Curious Candle",
				subtitle = "Made by Kodbol",
				description = "Made by Kodbol",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/kodbolx/kodbolhub/refs/heads/main/curiouscandle.lua"))()
				end,
			},
			{
				name = "Ambush Plushie",
				description = "Loads and runs Ambush Plushie.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Plushie-Item/refs/heads/main/Ambush-Plushie"))()
				end,
			},
			{
				name = "Rush Plushie",
				description = "Loads and runs Rush Plushie.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eliazbp92-collab/Plushie1/refs/heads/main/Rush"))()
				end,
			},
			{
				name = "Gubby Tool",
				subtitle = "Made by Indexell",
				description = "Made by Indexell",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IdkMyNameLoll/PublicScripts/refs/heads/main/IsThatAGubbyTool"))()
				end,
			},
			{
				name = "Crucifix",
				subtitle = "Made by PenguinManiack",
				description = "Made by PenguinManiack",
				run = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/PenguinManiack/Crucifix/main/Crucifix.lua'))()
				end,
			},
			{
				name = "Grenade",
				description = "Loads and runs Grenade.",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/zeFBYYy9", true))()
				end,
			},
			{
				name = "Infinite Vitamins",
				description = "Loads and runs Infinite Vitamins.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/refs/heads/main/Inf_Vitamins.lua"))()
				end,
			},
			{
				name = "Moon Jug (Fixed)",
				subtitle = "Can be helpful sometimes",
				description = "Can be helpful sometimes",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/MoonJug"))()
				end,
			},
			{
				name = "Luger Pistol",
				description = "Loads and runs Luger Pistol.",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/WcYCnACD"))()
				end,
			},
			{
				name = "Rocket Launcher",
				description = "Loads and runs Rocket Launcher.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/persopoiu/scripts/refs/heads/main/RocketLauncher/script.lua"))()
				end,
			},
			{
				name = "Flashlight V1",
				description = "Loads and runs Flashlight V1.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/binhlforsaken156-sys/Flash-light/refs/heads/main/Flash-light-V1", true))()
				end,
			},
			{
				name = "Lucky Block",
				description = "Loads and runs Lucky Block.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/NTTTTTTTT/upload/refs/heads/main/content/5d91c0185bdc4dd5b80c84c50d8ba78e_obf.lua",true))()
				end,
			},
			{
				name = "Spiral Bottle",
				description = "Loads and runs Spiral Bottle.",
				run = function()
loadstring(game:HttpGet('https://gist.githubusercontent.com/IdkMyNameLoll/8b05c837bea9effac2554340465b4be1/raw/3f3be0ee72e7f153db39a16a40fa63dce6cde72d/SpiralBottle'))()
				end,
			},
			{
				name = "Foundation Crucifix",
				subtitle = "It can crucify any object you just need to click on any object",
				description = "It can crucify any object you just need to click on any object",
				run = function()
_G.CR_Uses = 1000000
_G.CR_IsCurious = false
_G.CR_HoldKeyRequired = "false"

loadstring(game:HttpGet("https://raw.githubusercontent.com/IdkMyNameLoll/PublicScripts/refs/heads/main/crucifix_E_A_A"))()
				end,
			},
			{
				name = "A-60 Plushie",
				description = "Loads and runs A-60 Plushie.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Plushie-Item/refs/heads/main/A-60-Plushie"))()
				end,
			},
			{
				name = "A-90 Plushie",
				description = "Loads and runs A-90 Plushie.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eliazbp92-collab/Plushie1/refs/heads/main/A-90"))()
				end,
			},
			{
				name = "Lucky Cookie",
				description = "Loads and runs Lucky Cookie.",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/TefMKs39/raw"))()
				end,
			},
			{
				name = "Guiding Flashlight",
				description = "Loads and runs Guiding Flashlight.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/binhlforsaken156-sys/Guiding-flash-light/refs/heads/main/Guiding-flash-light.lua", true))()
				end,
			},
			{
				name = "Viridislight Jug",
				description = "Loads and runs Viridislight Jug.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Scripts/refs/heads/main/Viridislight-Jug"))()
				end,
			},
			{
				name = "Jeff's Tip Jar",
				description = "Loads and runs Jeff's Tip Jar.",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/Hsuiugnr"))()
				end,
			},
			{
				name = "Troll Crucifix",
				description = "Loads and runs Troll Crucifix.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Other-Item-Scripts/refs/heads/main/Troll-Crucifix"))()
				end,
			},
			{
				name = "Moonlight Bottle",
				description = "Loads and runs Moonlight Bottle.",
				run = function()
loadstring(game:HttpGet('https://gist.githubusercontent.com/IdkMyNameLoll/04d7dd5e02688624b958b8c2604b924c/raw/9e86b34249f44ed2dd433176e67daaf3db30cde8/MoonBottle'))()
				end,
			},
			{
				name = "Shedletsky Egg (Eggletsky)",
				description = "Loads and runs Shedletsky Egg (Eggletsky).",
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
				name = "Viridis Lighter (Need Lighter)",
				description = "Loads and runs Viridis Lighter (Need Lighter).",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/kodbolx/kodbolhub/refs/heads/main/Items/Viridis%20lighter.lua"))()
				end,
			},
			{
				name = "Lantern Item",
				description = "Loads and runs Lantern Item.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Item/refs/heads/main/lantern"))()
				end,
			},
			{
				name = "Spiral Jug (Fixed)",
				description = "Loads and runs Spiral Jug (Fixed).",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/Spiral-Jug"))()
				end,
			},
			{
				name = "Flame Thrower",
				subtitle = "Credit to JohnyGaming#2917",
				description = "Credit to JohnyGaming#2917",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/JohnyGamingLUA/FlamethrowerDOORS/main/obfuscated.lua"))()
				end,
			},
			{
				name = "Grass Tablet",
				description = "Loads and runs Grass Tablet.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Matthew201322/Doors-Scriptee/refs/heads/main/grass%20tablet.lua"))()
				end,
			},
			{
				name = "Seek Plushie",
				description = "Loads and runs Seek Plushie.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Seek-Plushie"))()
				end,
			},
			{
				name = "Screech Plushie",
				description = "Loads and runs Screech Plushie.",
				run = function()
loadstring(game:HttpGet("https://pastebin.com/raw/CRYiKPZX"))()
				end,
			},
			{
				name = "Viridislight Bottle",
				description = "Loads and runs Viridislight Bottle.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Scripts/refs/heads/main/Viridislight-Bottle"))()
				end,
			},
			{
				name = "Purple Shakelight",
				description = "Loads and runs Purple Shakelight.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostw3r/Scripts/refs/heads/main/PurpleFlashlight.lua"))()
				end,
			},
			{
				name = "Forsaken Tools",
				description = "Loads and runs Forsaken Tools.",
				run = function()
loadstring(game:HttpGet("https://rawscripts.net/raw/DOORS-DAILY-RUNS-forsaken-useless-tool-pack-94779"))()
				end,
			},
			{
				name = "Maxwell Tool",
				description = "Loads and runs Maxwell Tool.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/CastiSeek/Maxwell-the-cat-script/refs/heads/main/main.lua"))()
				end,
			},
			{
				name = "Rebound Plushie",
				description = "Loads and runs Rebound Plushie.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Plushie-Item/refs/heads/main/Rebound-Plushie"))()
				end,
			},
			{
				name = "Magic Book",
				description = "Loads and runs Magic Book.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/skkenrgjt/HAHAHAH/refs/heads/main/MagicRunner"))()
				end,
			},
			{
				name = "Admin Slap",
				subtitle = "Made by Guestly (Celestian)",
				description = "Made by Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GuestlyTheGreatestGuest/Scripts/refs/heads/main/Admin-Slap-For-DOORS-made-by-Celestian-(Guestly)-on-Discord"))()
				end,
			},
			{
				name = "Seek Gun",
				description = "Loads and runs Seek Gun.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/persopoiu/scripts/main/seekgun.lua"))()
				end,
			},
			{
				name = "NVCS-3000",
				description = "Loads and runs NVCS-3000.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostw3r/Scripts/main/NVCS-3000.lua"))()
				end,
			},
			{
				name = "M249 Gun",
				description = "Loads and runs M249 Gun.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/hi822010/Extras-Gliese-Hub-Doors/refs/heads/main/M249"))()
				end,
			},
			{
				name = "AK-47 Gun",
				description = "Loads and runs AK-47 Gun.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzzGabbbb/AK47Fixed/refs/heads/main/Ak47ByPenguinManiackFixedByGab.lua"))()
				end,
			},
			{
				name = "Tool Giver V3 | Doors",
				subtitle = "Darli17",
				description = "Darli17",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Darli17/Entities/refs/heads/main/Tools", true))()
				end,
			},
			{
				name = "RobHub X Item Giver",
				description = "Loads and runs RobHub X Item Giver.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Darli17/DOORS-REBOUNCES/refs/heads/main/main-ig"))()
				end,
			},
			{
				name = "Barrel Of Starlight",
				description = "Loads and runs Barrel Of Starlight.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/notpoiu/Scripts/refs/heads/main/StarJug.lua"))()
				end,
			},
			{
				name = "Mischievous Crucifix",
				description = "Loads and runs Mischievous Crucifix.",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Teilsthebfdifan/Modhub-assets/refs/heads/main/MischievousV2Test.lua"))()
				end,
			},
			{
				name = "Size Stick (UPDATED)",
				description = "Loads and runs Size Stick (UPDATED).",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/dy85jtB6/raw"))()
				end,
			},
			{
				name = "Glitch Crucifix Effect (EPILEPSY WARNING)",
				subtitle = "Epilepsy warning • does NOT give you a crucifix",
				description = "EPILEPSY WARNING. Adds a glitch effect to the crucifix. Does NOT give you a crucifix, but applies the effect if you get one.",
				confirm = true,
				confirmText = "EPILEPSY WARNING: this adds a glitch effect to the crucifix. Don't run it if flashing or glitchy effects can affect you. It does NOT give you a crucifix. Run it anyway?",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/ptp98dnD/raw"))()
				end,
			},
		},
	},
	{
		name = "Modes 2",
		section = "Second section of modes",
		buttons = {
			{
				name = "Hardcore Mode (Remastered)",
				subtitle = "Credit to someone that idk",
				description = "Credit to someone that idk",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/daiayday/HardcoreRemastered/refs/heads/main/obf_L6zO2N0sG5ehDHd56JBc5z70TZ2piVOvIqsgE88741HXGrwv7E4qd6c8axu8z4oh.lua.txt"))()
				end,
			},
			{
				name = "Fragmented Mode (Recreation??)",
				subtitle = "Recreation By THE_LOSTW3R",
				description = "Recreation By THE_LOSTW3R",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostw3r/Mods/refs/heads/main/FragmentedModeRemake.lua"))()
				end,
			},
			{
				name = "Impossible Mode (Remastered)",
				subtitle = "Made by Neko tiv (Chu be te liet) & RealblueYT",
				description = "Made by Neko tiv (Chu be te liet) & RealblueYT",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/iH9k0iU9/raw"))()
				end,
			},
			{
				name = "Laver Mode V2.1 (Fixed)",
				subtitle = "Fixed By Reboundplayz",
				description = "Fixed By Reboundplayz",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/laver%20mode"))()
				end,
			},
			{
				name = "Nightmare Mode V2",
				subtitle = "Made By Kodbol & Asif",
				description = "Made By Kodbol & Asif",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Kodbol/Doors/refs/heads/main/Nightmare%20Mode/Main.lua"))()
				end,
			},
			{
				name = "Hardcore Mode (Revisited)",
				subtitle = "Made by Reboundplayz",
				description = "Made by Reboundplayz",
				run = function()
loadstring(game:HttpGet("https://github.com/reboundplayz/Doors-Fixed-Modes/raw/refs/heads/main/hc%20revisited"))()
				end,
			},
			{
				name = "Rooms Low Detailed Mode",
				subtitle = "Made by Rebound",
				description = "Made by Rebound",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eliazbp92-collab/Rooms-low-detailed-mode-doors/refs/heads/main/Script"))()
				end,
			},
			{
				name = "Extremely Mode",
				subtitle = "Made by OG Hunger (New) & Thanhpok",
				description = "Made by OG Hunger (New) & Thanhpok",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/Extremely/refs/heads/main/Extremely%20Mode"))()
				end,
			},
			{
				name = "Terminated Mode",
				subtitle = "Made By UnknownReturnz",
				description = "Made By UnknownReturnz",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/hT2Q5AKa/raw"))()
				end,
			},
			{
				name = "Chaos Mode V1",
				subtitle = "Credit to DJ SD (Tunder8401)",
				description = "Credit to DJ SD (Tunder8401)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Tunder8401/Doors-Modes/refs/heads/main/Chaos%20Mode"))()
				end,
			},
			{
				name = "Eyes Mode (Gamble)",
				subtitle = "Made By Guestly, also get rare eyes to get a CW",
				description = "Made By Guestly, also get rare eyes to get a CW",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/EYES-MODE"))()
				end,
			},
			{
				name = "Snuffer Mode",
				subtitle = "Made By Anctarus7105",
				description = "Made By Anctarus7105",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Anctarus7105/My-Modes/refs/heads/main/SnufferV1.lua"))()
				end,
			},
			{
				name = "Blackout Mode",
				subtitle = "Made By Rip_Silence",
				description = "Made By Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Blackout-Mode-Main.lua"))()
				end,
			},
			{
				name = "Unhinged Mode",
				subtitle = "Made By Rip_Silence",
				description = "Made By Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Unhinged-Mode-Main.lua"))()
				end,
			},
			{
				name = "Ghostly Mode",
				subtitle = "Made By Anctarus7105",
				description = "Made By Anctarus7105",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Anctarus7105/My-Modes/refs/heads/main/Ghostly.lua"))()
				end,
			},
			{
				name = "Infection Mode",
				subtitle = "Made By Leo -LXD-",
				description = "Made By Leo -LXD-",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Doors-Hub/refs/heads/main/Infection-Mode-Made-By-Leo"))()
				end,
			},
			{
				name = "Dormant Mode",
				subtitle = "Made By Idk.chud",
				description = "Made By Idk.chud",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TestingAcc12312390/Other-Modes-Script/refs/heads/main/Dormant-Mode-Made-By-Chud"))()
				end,
			},
			{
				name = "Mega Hard Mode",
				subtitle = "Made By UnknownReturnz",
				description = "Made By UnknownReturnz",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/jGU3jxSe/raw"))()
				end,
			},
			{
				name = "Broken Mode (Fixed)",
				subtitle = "Made by TheDarkMan1334",
				description = "Made by TheDarkMan1334",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Broken-Mode-V1.8-Fixed-Version"))()
				end,
			},
			{
				name = "Mayhem Mode (Remake)",
				subtitle = "Made By OG Hunger (New)",
				description = "Made By OG Hunger (New)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/Mayhem-Remake/refs/heads/main/Mayhem%20Remake"))()
				end,
			},
			{
				name = "Grace Mode (Remake)",
				subtitle = "Credit to someone that idk",
				description = "Credit to someone that idk",
				run = function()
loadstring(game:HttpGet("https://github.com/IdkMyNameLoll/PublicScripts/raw/refs/heads/main/DoorsXGrace.lua", true))()
				end,
			},
			{
				name = "Super Crazy Mode",
				subtitle = "Credit to Dt_roblx doors:))",
				description = "Credit to Dt_roblx doors:))",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme2/dm123/refs/heads/main/super%20crazy%20mode"))()
				end,
			},
			{
				name = "Dark Passage Mode",
				subtitle = "Made By Rebound",
				description = "Made By Rebound",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eliazbp92-collab/Dark-passage-mode/refs/heads/main/Script"))()
				end,
			},
			{
				name = "Hardcore Mode (Retake)",
				subtitle = "Made by Purple Hatso",
				description = "Made by Purple Hatso",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Hardcore-Mode-(Retake)"))()
				end,
			},
			{
				name = "Impossible Mode V2 (Remastered)",
				subtitle = "Made By RealblueYT",
				description = "Made By RealblueYT",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/NLdC5hRo/raw"))()
				end,
			},
			{
				name = "Fragmented Mode (Reignited)",
				subtitle = "Made by OG Hunger (New)",
				description = "Made by OG Hunger (New)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eoyoustme/Fragmentend-Reiginited/refs/heads/main/Fragmented%20Reiginited"))()
				end,
			},
			{
				name = "Hardcore Reignited Mode (Recreated)",
				subtitle = "Credit to Guestly (Celestian)",
				description = "Credit to Guestly (Celestian)",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/Hardcore-Reignited-(Recreated)"))()
				end,
			},
			{
				name = "Negative Mode",
				subtitle = "Made by Rebound",
				description = "Made by Rebound",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eliazbp92-collab/WHAT-IS-A-SOILD-OCTO-ROTRAY-PHONE-/refs/heads/main/Script"))()
				end,
			},
			{
				name = "Mental Mode",
				subtitle = "Made By TheLastOne",
				description = "Made By TheLastOne",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TheLastOne5778/Read/refs/heads/main/Mental%20Mode"))()
				end,
			},
			{
				name = "Abyss Mode",
				subtitle = "Made By Grampy",
				description = "Made By Grampy",
				run = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/GrampyMods/AbyssMode/refs/heads/main/mainfile'))()
				end,
			},
			{
				name = "Ice Mode",
				subtitle = "Made by RealblueYT",
				description = "Made by RealblueYT",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/vpHzXSDy/raw"))()
				end,
			},
			{
				name = "Super Packed Mode",
				subtitle = "Credit to Zunxd",
				description = "Credit to Zunxd",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Junbbinopro/Doors-sieu-don-mode/refs/heads/main/Modeee"))()
				end,
			},
			{
				name = "Hardcore Mode (Degenerate)",
				subtitle = "Made by RealblueYT",
				description = "Made by RealblueYT",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rrealblueyt-oss/Hardcore-degenerate/refs/heads/main/hardcore%20degenerate.txt"))()
				end,
			},
			{
				name = "Fragmented Mode Alpha (Recreation)",
				subtitle = "Made by Hello Im Rippah",
				description = "Made by Hello Im Rippah",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/brylesantos38-cell/FragmentedModeAlphaRecreation/refs/heads/main/obfuscated_script-1783648290063.lua.txt"))()
				end,
			},
			{
				name = "Hallucination Mode (IMPOSSIBLE VERSION)",
				subtitle = "Credit to Guestly (Celestian) and Rip_Silence",
				description = "Credit to Guestly (Celestian) and Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Hallucination-Mode-SUPER-IMPOSSIBLE-/refs/heads/main/Hallucination%20Mode%20(IMPOSSIBLE)"))()
				end,
			},
			{
				name = "Improbable Mode Final Version (IMPOSSIBLE)",
				subtitle = "Credits to Chu be the liet & AmadeyHunter & Rip_Silence",
				description = "Credits to Chu be the liet & AmadeyHunter & Rip_Silence",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkman60093/Doors-Modes/refs/heads/main/Improbable-Mode-Final-Version"))()
				end,
			},
			{
				name = "Impossible Mode V1.8 (Alpha)",
				subtitle = "Kinda broken • Credit to Oof",
				description = "Impossible Mode V1.8 (Alpha) by Oof. Heads up: this one is kinda broken, so some parts may not work right.",
				confirm = true,
				confirmText = "This mode is kinda broken (alpha version). Some things may not work right. Run it anyway?",
				run = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/NTTTTTTTT/upload/refs/heads/main/content/eaeb44fe563342b38ab1f6ee9735e584_obf.lua", true))()
				end,
			},
			{
				name = "Madness Mode 1.2",
				subtitle = "Madness Mode",
				description = "Madness Mode 1.2",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/VOny4364/raw"))()
				end,
			},
			{
				name = "too lazy to put text here",
				subtitle = "Not tested yet",
				description = "Not tested yet, run it at your own risk.",
				run = function()
loadstring(game:HttpGet("https://pastefy.app/WVzszleB/raw",true))()
				end,
			},
		},
	},
}

local UPDATE_LOGS = {
[[V36 - Sorry for the delay guys, this one took way longer than I wanted. Thanks for waiting!

WH1T3 (relayhost) helped on changing the whole GUI and is now Co-Owner. New look + Christmas theme, new Tools tab, Most Used, Script of the day, Panic button, mobile support (on-screen buttons) + keybinds you can turn on/off, NEW badges, sort buttons, Notes tab, FOV slider + FPS boost, music playlist + shuffle, new colors.

Added: Madness Mode 1.2, too lazy to put text here, Endless Mode, Old Seek, A-60 (Chaos Entity), Impossible Mode V1.8 (Alpha), Impossible Mode V2 (Remastered), Noise (Glitch Version Included), Purple Shakelight (All Rifts), Twinkhook Hub, Honcho Spawner, Glitch Crucifix Effect, Hardcore Mode (VERY OLD), Gradish Mode, Hardcore Mode (Retake Plus), Mayhem Mode (Remake + Legacy), Dormant Mode, Ghostly Mode, Mega Hard Mode, Snuffer Mode, Terminated Mode, Negative Mode, Dark Passage Mode, Rooms Low Detailed Mode, Doors Hub + Editor (Beta), Rainbow Room, Maxwell Tool, Troll Crucifix, A-60 / Rebound / A-90 / Ambush / Rush plushies, and the Twister, A-100, A-75, A-185, Obsession, Pim, Questioner, B ∆ B and Ch4s3r_Thre4t spawners.

Updated: Hardcore Reignited Mode, WH1T3 Spawner (Remake), Broken Mode.

Replaced: Scamer Mode with Zombie Mode, Lunacy Mode (Remake) with Schizophrenia Mode.

Removed locked/deleted scripts: Fear Mode, Hard Mode, Water Rises Mode, Furry Mode.]],
}
-- People shown in the "Credits" tab
-- (subtitle = short line under the name, description = shown in the details)
local CREDITS = {
	{
		name = "Silence",
		subtitle = "Hub creator (Rip_Silence)",
		description = "Creator of the Doors Modes Hub and very cool guy.",
	},
	{
		name = "WH1T3 (Co-Owner)",
		subtitle = "Co-Owner of the hub (relayhost)",
		description = "Co-Owner of the Doors Modes Hub. Made the whole GUI, the V36 update, the mobile support and the Christmas theme.",
	},
	{
		name = "Greed_GamingMobile",
		subtitle = "Inspiration",
		description = "This hub is inspired from Greed_GamingMobile's hub.",
	},
	{
		name = "RealblueYT",
		subtitle = "Sign text in chat",
		description = "Credit to RealblueYT for the sign text in chat.",
	},
	{
		name = "WH1T3 (GUI Creator)",
		subtitle = "Created the hub's GUI",
		description = "Creator and designer of the GUI of the Doors Modes Hub (Halloween and Christmas versions).",
	},
	{
		name = "WH1T3 (V36 GUI Update)",
		subtitle = "Directed the GUI changes of V36",
		description = "Asked for and directed the V36 GUI upgrades: Tools tab, Most Used, Panic button and mobile controls.",
	},
	{
		name = "WH1T3 (Mobile Support)",
		subtitle = "Pushed for phone & tablet support",
		description = "Made sure the hub works well on phones: on-screen buttons that replace the keybinds.",
	},
	{
		name = "Incognito",
		subtitle = "Helper of some code of the GUI/HUB",
		description = "A helper that makes the code behind some things of the GUI, likes pumpkins.",
	},
	{
		name = "You!",
		subtitle = "Thanks for executing the hub",
		description = "Credit to You! (For Executing My Hub)",
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
	accent = "Cranberry",
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
	{ code = "en", name = "English" },
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
local TOGGLE_KEY_TEXT = (#keyNames > 0 and not isMobile) and table.concat(keyNames, " / ") or T("the round button")

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
	{ name = "Cranberry", main = Color3.fromRGB(192, 54, 66) },
	{ name = "Holly", main = Color3.fromRGB(96, 158, 108) },
	{ name = "Gold", main = Color3.fromRGB(212, 172, 84) },
	{ name = "Frost", main = Color3.fromRGB(148, 192, 210) },
	{ name = "Candy", main = Color3.fromRGB(220, 124, 140) },
	{ name = "Bone", main = Color3.fromRGB(214, 206, 190) },
	{ name = "Ink", main = Color3.fromRGB(116, 136, 196) },
	{ name = "Ash", main = Color3.fromRGB(160, 160, 164) },
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
			warn("[HalloweenHub] callback error:", e)
			notify("Script error (see console)")
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
		local text = T(def.description or "No description yet.")
		text ..= "\n\n" .. T("Type:") .. " " .. T(kind)
		if def.subtitle and kind == "Credit" then
			text ..= "\n" .. T("Role:") .. " " .. T(def.subtitle)
		end
		if kind == "Button" then
			text ..= "\n" .. T("Asks before running:") .. " " .. (def.confirm and T("Yes") or T("No"))
		end
		local extra = def.getExtra and def.getExtra()
		showDialog({
			title = (def.icon and (def.icon .. " ") or "") .. T(def.name),
			body = text,
			accent = THEME.purple,
			a = { "Close", THEME.purple },
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
			title = "Leaving so soon?",
			body = "Are you sure you want to close the hub?",
			accent = THEME.danger,
			a = { "Stay", THEME.purple },
			b = { "Close", THEME.danger, function()
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
		notify("Minimized. Tap to bring the hub back.")
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
	local nowLabel -- the "Now playing" label (Music tab)

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
		return (t and t.name) or "Unknown song"
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
			notify(TF("Couldn't load \"%s\" (bad id / url / file?)", trackName(current)), 4)
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
				notify("Paste an audio ID in the Music tab first.", 3.5)
				on = false
			elseif not ensureTrack() then
				on = false
			else
				sound:Play()
				notify(TF("Now playing: %s", trackName(current)), 2.5)

				-- warn if Roblox refuses to load it (private audio / wrong id)
				playToken += 1
				local myToken = playToken
				task.delay(8, function()
					if myToken == playToken and musicOn and sound.Parent and not sound.IsLoaded then
						notify("This song won't load. Wrong id, or the audio is private.", 4.5)
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
			notify("Playlist is empty. Play an ID, then tap Save.", 3.5)
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
			notify("That doesn't look like an audio ID.", 3)
			return
		end
		local name = "ID " .. digits
		local okInfo, info = pcall(function()
			return MarketplaceService:GetProductInfo(tonumber(digits))
		end)
		if okInfo and type(info) == "table" then
			if info.AssetTypeId and info.AssetTypeId ~= 3 then
				notify("That ID is not an audio asset.", 3.5)
				return
			end
			if info.Name then
				name = info.Name
			end
		end
		notify(TF("Loading %s...", name), 2)
		playTrack({ name = name, id = digits })
	end

	local function saveCurrentToPlaylist()
		if not current then
			notify("Nothing to save yet. Play an ID first.", 3)
			return
		end
		if indexOfTrack(current) then
			notify("Already in your playlist.", 2)
			return
		end
		local entry = { name = current.name, id = current.id, url = current.url, file = current.file }
		table.insert(playlist, entry)
		table.insert(saved.playlist, entry)
		saveData()
		notify(TF("Saved: %s", trackName(entry)), 2.5)
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

	sound.Ended:Connect(function() -- only fires when "Loop" is off
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
			return T("Nothing selected yet.\nPaste an audio ID below and tap Play.")
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
	local confirmScripts = saved.confirm == true -- Settings > "Confirm before running"
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

	-- Runs a script button WITHOUT freezing the hub, counts it for "Most used",
	-- and tells you if it worked or failed.
	-- Turns ugly executor errors into something a human can read
	local function friendlyError(msg)
		local low = msg:lower()
		if low:find("http 404", 1, true) or low:find("404 (not found)", 1, true) then
			return T("The script link is dead (404). It may have been deleted.")
		elseif low:find("http requests are not enabled", 1, true) then
			return T("Your executor blocked the download.")
		elseif low:find("timed out", 1, true) then
			return T("The download timed out. Try again.")
		elseif low:find("loadstring", 1, true) and low:find("nil value", 1, true) then
			return T("Your executor doesn't support loadstring.")
		end
		return msg:sub(1, 100)
	end

	local activeScripts = {} -- prevent accidental double-taps from starting duplicates
	local function runScript(def)
		if activeScripts[def.key] then
			notify(TF("⏳ %s is already running.", def.name), 2.5)
			return
		end
		activeScripts[def.key] = true
		notify(TF("▶ Loading %s...", def.name), 2)
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
				notify(TF("%s finished starting (%.1fs)", def.name, os.clock() - t0), 2.5)
			else
				warn("[DoorsModesHub] " .. def.name .. " failed:\n" .. tostring(e))
				notify(TF("%s failed: %s", def.name, friendlyError(tostring(e))), 5)
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
					fav and "Unfavorite" or "Favorite",
					THEME.orange,
					function()
						saved.favorites[def.key] = (not fav) or nil
						saveData()
						notify(fav and "Removed from favorites" or "Added to favorites", 2)
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
					title = "Are you sure?",
					body = def.confirmText or TF("Are you sure you want to execute %s?", def.name),
					accent = THEME.orange,
					a = { "Cancel", THEME.panelLight },
					b = { "Execute", THEME.orange, runIt },
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
		{ id = "default", label = "↕ Default" },
		{ id = "az", label = "A→Z" },
		{ id = "za", label = "Z→A" },
		{ id = "new", label = "🆕 Newest" },
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
		notify(TF("↕ Sorting: %s", T(currentSortLabel())), 1.5)
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
			PlaceholderText = TF("Search %d scripts or creators...", #tabDef.buttons),
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
			local loadingLabel = addLabel(page, TF("Loading %d scripts...", #tabDef.buttons), 20, THEME.muted)
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
			notify("Nothing run yet", 2)
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
		addSection(notesTab, "MY NOTES")
		addLabel(notesTab, "Write anything here: ideas, audio IDs, script names. It saves automatically.", 36, THEME.muted)
		local notesBox = make("TextBox", {
			Size = UDim2.new(1, 0, 0, 170),
			BackgroundColor3 = THEME.bg,
			PlaceholderText = T("Type your notes here..."),
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
			name = "Copy notes",
			description = "Copies all your notes (needs setclipboard).",
			run = function()
				saved.notes = notesBox.Text:sub(1, 4000)
				if setclipboard then
					setclipboard(saved.notes)
					notify("Copied!", 2)
				else
					notify(saved.notes, 6)
				end
			end,
		})
		addButton(notesTab, {
			name = "Clear notes",
			description = "Deletes everything you wrote in Notes.",
			confirm = true,
			confirmText = "Delete all your notes?",
			run = function()
				notesBox.Text = ""
				saved.notes = ""
				saveData()
				notify("Cleared", 2)
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
	local homeTab = createTab("Home")
	local favTab = createTab("Favorites")
	local searchTab = createTab("Search")
	for _, tabDef in ipairs(SCRIPT_TABS) do
		createScriptTab(tabDef)
	end
	local musicTab = createTab("Music")
	local playlistTab = createTab("Playlist")
	local notesTab = createTab("Notes")
	local effectsTab = createTab("Effects")
	local toolsTab = createTab("Tools")
	local settingsTab = createTab("Settings")
	local updatesTab = createTab("Updates")
	local creditsTab = createTab("Credits")

	-- HOME
	addSection(homeTab, "WELCOME")
	addLabel(
		homeTab,
		TF("Hey %s! %d scripts loaded. Tap the round button or press %s to show/hide. Use the search tab to find any script, star your favorites, and paste any audio ID in the music tab.", player.DisplayName, totalScripts, TOGGLE_KEY_TEXT),
		100
	)
	local fpsLabel = addLabel(homeTab, "FPS: ...", 20, THEME.muted)
	addButton(homeTab, {
		name = "Random mode",
		description = "Picks a random mode from the Modes tabs and asks before running it.",
		run = function()
			local pool = {}
			for _, def in ipairs(ALL_SCRIPTS) do
				if def.tab == "Modes" or def.tab == "Modes 2" then
					table.insert(pool, def)
				end
			end
			local pick = pool[math.random(#pool)]
			showDialog({
				title = "".. pick.name,
				body = T(pick.description or "") .. "\n\n" .. T("Run it?"),
				accent = THEME.orange,
				a = { "No", THEME.panelLight },
				b = { "Run!", THEME.orange, function()
					runScript(pick)
				end },
			})
		end,
	})
	addButton(homeTab, {
		name = "Say merry christmas",
		description = "Shows a christmas popup. A good first button to test.",
		run = function()
			notify("Merry Christmas!")
		end,
	})

	addButton(homeTab, {
		name = "Run last script again",
		description = "Runs the last script you ran in this session again.",
		run = function()
			if hub.lastRun then
				runScript(hub.lastRun)
			else
				notify("Nothing run yet", 2)
			end
		end,
	})

	addButton(homeTab, {
		name = "About",
		description = "Version info for the hub.",
		run = function()
			showDialog({
				title = "".. HUB_TITLE,
				body = totalScripts .. " scripts  •  "
					.. (isMobile and T("Tap the round button to show/hide, = panic") or (T("Show/hide:") .. " " .. TOGGLE_KEY_TEXT .. "  •  " .. T("Panic:") .. " End"))
					.. "\n\n" .. T("Hub by Rip_Silence & WH1T3 (Co-Owner), GUI by WH1T3. Thanks for using the hub!") .. "\n\n" .. T("Sorry for the delay on V36, thanks for waiting!"),
				accent = THEME.orange,
				a = { "Close", THEME.purple },
			})
		end,
	})
	addSection(homeTab, "🆕 NEW SCRIPTS")
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
		addLabel(homeTab, "Every new script has a 🆕 in front of its name.", 20, THEME.muted)
	end
	addSection(homeTab, "SCRIPT OF THE DAY")
	do
		local day = tonumber(os.date("%j")) or 1
		local year = tonumber(os.date("%Y")) or 2026
		local pick = ALL_SCRIPTS[(day * 7 + year) % #ALL_SCRIPTS + 1]
		local copy = table.clone(pick)
		copy.subtitle = pick.tab .. (pick.subtitle and ("  •  " .. pick.subtitle) or "")
		addButton(homeTab, copy)
	end
	local allTimeLabel = addLabel(homeTab, TF("All-time scripts run: %d", 0), 20, THEME.muted)
	local statsLabel = addLabel(homeTab, TF("Favorites: %d  •  ▶ This session: %d", 0, 0), 20, THEME.muted)
	refreshers["Home"] = function()
		local total = 0
		for _, n in pairs(saved.runs) do
			total += n
		end
		allTimeLabel.Text = TF("All-time scripts run: %d", total)
		local favCount = 0
		for _ in pairs(saved.favorites) do
			favCount += 1
		end
		statsLabel.Text = TF("Favorites: %d  •  ▶ This session: %d", favCount, hub.sessionRuns or 0)
	end

	local StatsService = game:GetService("Stats")
	local sessionStart = os.clock()
	local frames, lastTime = 0, os.clock()
	track(RunService.RenderStepped:Connect(function()
		frames += 1
		local now = os.clock()
		if now - lastTime >= 1 then
			local okPing, ping = pcall(function()
				return StatsService.Network.ServerStatsItem["Data Ping"]:GetValue()
			end)
			local up = math.floor(now - sessionStart)
			fpsLabel.Text = string.format(
				"FPS: %d  •  Ping: %s  •  " .. T("Session") .. ": %02d:%02d",
				math.floor(frames / (now - lastTime) + 0.5),
				okPing and (math.floor(ping + 0.5) .. " ms") or "n/a",
				math.floor(up / 60), up % 60
			)
			frames, lastTime = 0, now
		end
	end))

	-- FAVORITES + RECENT (rebuilt every time you open the tab)
	refreshers["Favorites"] = function()
		clearPage(favTab)
		addSection(favTab, "FAVORITES")
		addButton(favTab, {
			name = "Copy my favorites list",
			description = "Copies the names of all your favorite scripts so you can share them (needs setclipboard).",
			run = function()
				local names = {}
				for _, def in ipairs(ALL_SCRIPTS) do
					if saved.favorites[def.key] then
						table.insert(names, def.name)
					end
				end
				if #names == 0 then
					notify("Nothing to copy yet", 2)
					return
				end
				local text = table.concat(names, "\n")
				if setclipboard then
					setclipboard(text)
					notify("Copied!", 2)
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
			addLabel(favTab, "Nothing here yet. Tap the ⋮ on any script and choose Favorite.", 36, THEME.muted)
		end
		addSection(favTab, "MOST USED")
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
			addLabel(favTab, "Your top scripts show up here after you run a few.", 20, THEME.muted)
		end
		for i = 1, math.min(5, #ranked) do
			local copy = table.clone(ranked[i].def)
			copy.subtitle = TF("Ran %dx", ranked[i].n) .. (copy.subtitle and ("  •  " .. copy.subtitle) or "")
			addButton(favTab, copy)
		end
		addSection(favTab, "RECENTLY RUN")
		if #recent == 0 then
			addLabel(favTab, "Scripts you run show up here.", 20, THEME.muted)
		end
		for _, def in ipairs(recent) do
			addButton(favTab, def)
		end
	end

	-- SEARCH (all scripts at once)
	local globalBox = makeSearchBox(searchTab, TF("Search all %d scripts or creators...", totalScripts))
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
			addLabel(searchTab, "Type at least 2 letters to search every tab at once.", 36, THEME.muted)
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
			addLabel(searchTab, TF("Nothing found for \"%s\".", globalBox.Text), 24, THEME.muted)
		elseif shown > 40 then
			addLabel(searchTab, "Showing the first 40. Type more letters to narrow it down.", 36, THEME.muted)
		end
	end
	globalBox:GetPropertyChangedSignal("Text"):Connect(function()
		task.spawn(runSearch)
	end)
	task.spawn(runSearch)

	-- MUSIC
	addSection(musicTab, "NOW PLAYING")
	nowLabel = addLabel(musicTab, nowPlayingText(), 40)

	addSection(musicTab, "PLAY ANY AUDIO ID")
	local idRow = make("Frame", {
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundTransparency = 1,
		LayoutOrder = nextOrder(),
	}, musicTab)
	local idBox = make("TextBox", {
		Size = UDim2.new(1, -78, 1, 0),
		BackgroundColor3 = THEME.bg,
		PlaceholderText = T("Paste audio ID or link..."),
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
		Text = T("▶ Play"),
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
	controlButton("Save", saveCurrentToPlaylist)

	addSection(musicTab, "SETTINGS")
	local _, setMusicSwitch = addToggle(musicTab, {
		name = "Background music",
		description = "Turns the music on or off. The button in the title bar does the same thing.",
		default = false,
		onChange = function(on)
			setMusic(on)
		end,
	})
	musicToggleSet = setMusicSwitch
	addToggle(musicTab, {
		name = "Loop this song",
		description = "ON = the song repeats forever. OFF = it moves on to the next song in your playlist when it ends.",
		default = loopTrack,
		onChange = setLoop,
	})

	addToggle(musicTab, {
		name = "Shuffle",
		description = "ON = the next song is picked at random. Works with the ⏭ / ⏮ buttons and when a song ends (Loop OFF).",
		default = shuffleOn,
		onChange = function(on)
			shuffleOn = on
			saved.shuffle = on
			saveData()
		end,
	})
	addToggle(musicTab, {
		name = "Resume music on start",
		description = "ON = your last song starts playing when the hub opens. Turn OFF if you want silence at the start.",
		default = autoplayOn,
		onChange = function(on)
			autoplayOn = on
			saved.autoplay = on
			saveData()
		end,
	})
	addSlider(musicTab, {
		name = "Music volume",
		description = "How loud the music is (0 = silent, 100 = max).",
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
		"Where to get IDs: Creator Store > Audio, open a song and copy the number (or the whole link) from the page. Some audio is private and won't play. Tap Save to keep a song in Playlist.",
		84,
		THEME.muted
	)

	-- PLAYLIST (rebuilt when you open it or when songs change)
	local function buildPlaylistPage()
		clearPage(playlistTab)
		addSection(playlistTab, "YOUR PLAYLIST")
		if #playlist == 0 then
			addLabel(playlistTab, "Empty. Play an ID in the tab, then tap Save.", 36, THEME.muted)
		end
		for _, trackEntry in ipairs(playlist) do
			addButton(playlistTab, {
				name = trackName(trackEntry),
				icon = sameTrack(trackEntry, current) and "▶" or "",
				subtitle = trackEntry.id and ("ID " .. tostring(trackEntry.id)) or (trackEntry.url and "Link" or "File"),
				description = "Tap the song to play it. Use Remove to delete it from your playlist.",
				kind = "Song",
				run = function()
					playTrack(trackEntry)
				end,
				getExtra = function()
					return { "Remove", THEME.danger, function()
						removeFromPlaylist(trackEntry)
						notify("Removed from playlist", 2)
					end }
				end,
			})
		end
	end
	refreshers["Playlist"] = buildPlaylistPage
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

	addSection(effectsTab, "CHRISTMAS STUFF")
	addToggle(effectsTab, {
		name = "Shooting stars",
		description = "Little stars fly across your screen. Purely decoration.",
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
		name = "Snow burst",
		description = "Makes snow fall from the top of the screen for a few seconds.",
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
	addSection(toolsTab, "SESSION")
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
		name = "Anti-AFK",
		description = "Stops Roblox from kicking you for being idle (20 min). Great for long runs. Saved.",
		default = saved.antiAfk ~= false,
		onChange = function(on)
			saved.antiAfk = on
			saveData()
			setAntiAfk(on)
		end,
	})
	addButton(toolsTab, {
		name = "Panic (hide everything)",
		description = "Instantly hides the hub and the floating S button and stops the music. Press it again, the End key, or tap the faint dot in the top-left corner to bring everything back.",
		run = panicToggle,
	})
	addButton(toolsTab, {
		name = "Rejoin server",
		description = "Teleports you back into this same game.",
		confirm = true,
		confirmText = "Rejoin this game? You'll leave the current server.",
		run = function()
			game:GetService("TeleportService"):Teleport(game.PlaceId, player)
		end,
	})
	addButton(toolsTab, {
		name = "Copy Place ID / Job ID",
		description = "Copies the place id and this server's job id (needs setclipboard).",
		run = function()
			local text = "PlaceId: " .. game.PlaceId .. " | JobId: " .. game.JobId
			if setclipboard then
				setclipboard(text)
				notify("Copied!", 2)
			else
				notify(text, 6)
			end
		end,
	})
	if setfpscap then
		addSlider(toolsTab, {
			name = "FPS cap",
			description = "Changes your max FPS (needs setfpscap).",
			min = 30,
			max = 240,
			default = 60,
			onChange = function(v)
				setfpscap(v)
			end,
		})
	end

	addSection(toolsTab, "VISUALS")
	do
	local Lighting = game:GetService("Lighting")
	local startCamera = workspace.CurrentCamera
	local startFov = startCamera and startCamera.FieldOfView or 70
	addSlider(toolsTab, {
		name = "Field of view",
		description = "Changes your camera field of view (the game may reset it). Use Reset FOV to go back.",
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
		name = "Reset FOV",
		description = "Puts your camera field of view back to what it was when the hub started.",
		run = function()
			local cam = workspace.CurrentCamera
			if cam then
				cam.FieldOfView = startFov
			end
		end,
	})
	local boostRestore = nil
	addToggle(toolsTab, {
		name = "FPS boost",
		description = "Turns off shadows and lowers graphics quality for more FPS. Turn it OFF to restore your old settings.",
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
				notify("FPS boost ON", 2)
			elseif boostRestore then
				Lighting.GlobalShadows = boostRestore.shadows
				if boostRestore.quality then
					pcall(function()
						settings().Rendering.QualityLevel = boostRestore.quality
					end)
				end
				boostRestore = nil
				notify("FPS boost OFF", 2)
			end
		end,
	})
	end

	addSection(toolsTab, "EXECUTOR CHECK")
	local exName = "Unknown"
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
		"Executor: " .. exName .. "\n"
			.. mark("loadstring") .. "   " .. mark("writefile") .. "   " .. mark("readfile") .. "\n"
			.. mark("setclipboard") .. "   " .. mark("setfpscap") .. "   " .. mark("getgenv") .. "\n"
			.. T("If a script button fails, check the above first."),
		84,
		THEME.muted
	)

	addSection(toolsTab, "DATA")
	addButton(toolsTab, {
		name = "Reset favorites & stats",
		description = "Clears your favorites and the Most used counters. Playlist and settings stay.",
		confirm = true,
		confirmText = "Clear all favorites and run counts?",
		run = function()
			saved.favorites = {}
			saved.runs = {}
			saveData()
			notify("Cleared", 2)
		end,
	})
	addButton(toolsTab, {
		name = "Copy debug info",
		description = "Copies your executor, language and hub version so you can paste it when reporting a bug (no personal info). Needs setclipboard.",
		run = function()
			local text = table.concat({
				"Hub: " .. HUB_TITLE,
				"Scripts: " .. totalScripts,
				"Executor: " .. exName,
				"Language: " .. tostring(langCode),
				"Mobile: " .. tostring(isMobile),
				"PlaceId: " .. game.PlaceId,
				"loadstring: " .. tostring(has("loadstring")),
				"writefile: " .. tostring(has("writefile")),
				"setclipboard: " .. tostring(has("setclipboard")),
			}, "\n")
			if setclipboard then
				setclipboard(text)
				notify("Copied!", 2)
			else
				notify(text, 8)
			end
		end,
	})
	addButton(toolsTab, {
		name = "Reset EVERYTHING",
		description = "Wipes ALL saved data: favorites, stats, playlist, notes and settings. Re-run the hub afterwards.",
		confirm = true,
		confirmText = "Wipe ALL saved data? This can't be undone.",
		run = function()
			for k in pairs(saved) do
				saved[k] = nil
			end
			saved.favorites, saved.playlist, saved.runs = {}, {}, {}
			saveData()
			notify("Everything reset. Re-run the hub.", 4)
		end,
	})

	-- SETTINGS
	addSection(settingsTab, "UI")
	addToggle(settingsTab, {
		name = "Notifications",
		description = "Turns the little popup messages in the corner on or off.",
		default = notificationsEnabled,
		onChange = function(on)
			notificationsEnabled = on
			saved.notifications = on
			saveData()
		end,
	})
	addToggle(settingsTab, {
		name = "Confirm before running",
		description = "When ON, every script button asks 'Are you sure?' before it runs. Handy to avoid misclicks on a phone.",
		default = confirmScripts,
		onChange = function(on)
			confirmScripts = on
			saved.confirm = on
			saveData()
		end,
	})
	addToggle(settingsTab, {
		name = "Hide hub after running a script",
		description = "After you run a script the hub hides itself so you can see the game. Bring it back with the round button, your key or the quick bar.",
		default = saved.autoHide == true,
		onChange = function(on)
			saved.autoHide = on
			saveData()
		end,
	})
	addSlider(settingsTab, {
		name = "Window size %",
		description = "Makes the whole hub bigger or smaller (up to 130% so it is easier to tap on phones).",
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
	addSection(settingsTab, "CONTROLS (PC + MOBILE)")
	addToggle(settingsTab, {
		name = "Keybinds (PC)",
		description = TF("Keyboard shortcuts: %s = show/hide, End = panic, Right Ctrl = run last script, Insert = music on/off. Turn OFF if you don't use a keyboard.", TOGGLE_KEY_TEXT),
		default = keybindsOn,
		onChange = function(on)
			keybindsOn = on
			saved.keybinds = on
			saveData()
		end,
	})
	addToggle(settingsTab, {
		name = "On-screen buttons (mobile)",
		description = "Shows a small draggable bar with panic, run last script and music, so phone and tablet players don't need the keybinds. ON by default on phones.",
		default = quickBarOn,
		onChange = function(on)
			quickBarOn = on
			saved.quickBar = on
			saveData()
			updateQuickBar()
		end,
	})
	addSection(settingsTab, "LOOK")
	addButton(settingsTab, {
		name = "Accent color",
		description = "Cycles the hub colors: Rust, Bone, Moss, Tide, Ochre, Plum, Ink, Ash. It's saved and shows up the next time you run the hub.",
		run = function()
			accentIndex = accentIndex % #ACCENTS + 1
			saved.accent = ACCENTS[accentIndex].name
			saveData()
			notify(TF("%s selected. Re-run the hub to apply it.", saved.accent), 4)
		end,
	})
	addButton(settingsTab, {
		name = "Reset positions",
		description = "Puts the hub back in the middle of the screen and the S button back on the left.",
		run = function()
			tween(window, 0.3, { Position = UDim2.fromScale(0.5, 0.5) })
			tween(pumpkin, 0.3, { Position = PUMPKIN_HOME })
		end,
	})
	addButton(settingsTab, {
		name = "Close UI",
		description = "Closes the hub completely (it asks you first).",
		run = askToClose,
	})

	-- CREDITS (people come from CREDITS at the top of the file)
	addSection(creditsTab, "THE TEAM")
	for _, person in ipairs(CREDITS) do
		person.kind = person.kind or "Credit"
		addButton(creditsTab, person)
	end
	addLabel(creditsTab, "Tap a name or its three dots to see more.", 36, THEME.muted)

	-- UPDATES (lines come from UPDATE_LOGS at the top of the file)
	addSection(updatesTab, "V36 UPDATE")
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
		snow    = { name = "Snow",     icon = "", emoji = "•", color = Color3.fromRGB(255, 255, 255), count = 22, size = {12, 22}, time = {40, 80}, fromY = -0.1, toY = 1.1,  drift = 0.10, spin = false },
		leaves  = { name = "Gold dust", icon = "", emoji = "*", color = Color3.fromRGB(222, 184, 96),  count = 14, size = {16, 26}, time = {40, 70}, fromY = -0.1, toY = 1.1,  drift = 0.30, spin = true },
		rain    = { name = "Blizzard", icon = "", emoji = "•", color = Color3.fromRGB(214, 228, 238), count = 34, size = {8, 14},  time = {10, 20}, fromY = -0.1, toY = 1.1,  drift = 0.45, spin = false },
		ghosts  = { name = "Lights",   icon = "", emoji = "•", color = Color3.fromRGB(255, 214, 128), count = 10, size = {16, 28}, time = {60, 100}, fromY = 1.1, toY = -0.1, drift = 0.20, spin = false },
		embers  = { name = "Embers",   icon = "", emoji = "*", color = Color3.fromRGB(232, 122, 58),  count = 16, size = {14, 24}, time = {40, 70}, fromY = 1.1,  toY = -0.1, drift = 0.15, spin = false },
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

	addSection(effectsTab, "EFFECTS")
	local effectSwitches = {} -- so "Stop all" can flip the switches back off
	for _, kind in ipairs({ "snow", "leaves", "rain", "ghosts", "embers" }) do
		local def = EFFECTS[kind]
		local _, setSwitch = addToggle(effectsTab, {
			name = def.name,
			icon = def.icon,
			description = "Decoration only. Turn it off any time.",
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
		name = "Stop all effects",
		description = "Turns off every effect at once.",
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
		name = "Lightning flash",
		description = "A quick white flash across the screen. WARNING: flashing light, skip it if you're sensitive to that.",
		confirm = true,
		confirmText = "This flashes the screen. Continue?",
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
		name = "Warm tint",
		description = "Gives your whole screen a warm tint. Turn it off to go back to normal.",
		default = false,
		onChange = setBloodMoon,
	})

	-- TOOLS: reminder timer, server info, settings backup
	addSection(toolsTab, "EXTRAS")
	local reminderMinutes = 5
	addSlider(toolsTab, {
		name = "Reminder minutes",
		description = "Pick how many minutes, then press Start reminder.",
		min = 1,
		max = 60,
		default = 5,
		onChange = function(v)
			reminderMinutes = math.floor(v + 0.5)
		end,
	})
	addButton(toolsTab, {
		name = "Start reminder",
		description = "Pops up a message when your time is up (handy so you don't lose track during long runs).",
		run = function()
			local mins = reminderMinutes
			notify("⏱Reminder set for " .. mins .. " min", 3)
			task.delay(mins * 60, function()
				notify("⏰ Your " .. mins .. " minute reminder is up!", 8)
			end)
		end,
	})
	addButton(toolsTab, {
		name = "Server info",
		description = "Shows how many players are here and how long this server has been running.",
		run = function()
			local up = math.floor(workspace.DistributedGameTime)
			notify(
				string.format(
					"Players: %d/%d  •  Uptime: %dh %02dm",
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
		name = "Copy settings backup",
		description = "Copies all your saved hub data (favorites, settings, notes) as text. Needs setclipboard.",
		run = function()
			local okJ, text = pcall(function()
				return HttpService:JSONEncode(saved)
			end)
			if okJ and setclipboard then
				setclipboard(text)
				notify("Backup copied!", 2)
			else
				notify("Your executor can't copy to the clipboard", 4)
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
		addSection(homeTab, "DAILY STREAK")
		addLabel(
			homeTab,
			"" .. saved.streak .. " day streak  •  Best: " .. (saved.bestStreak or saved.streak),
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
			Text = "".. tostring(saved.streak or 1) .. " day streak",
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
	--   hub.addToggle(hub.settingsTab, { name = "My toggle", onChange = function(on) end })
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

	showPage("Home")

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
		Text = "loading " .. totalScripts .. " scripts... sorry for the delay",
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
	notify(TF("Welcome, %s!", player.DisplayName), 3)

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
				intro.Name = "Hub Intro"
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
	warn("[HalloweenHub] failed to start:", err)
	gui:Destroy()
end
