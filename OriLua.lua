-- OriLua --
-- Made By LunarLuzog Aka ShiinaChan#5523 --

--------------------------------------
print("Successfully Loaded OriLua")
--------------------------------------
local CURRENTVERSION = "1.0"
local LATESTVERSION = http.Get("https://raw.githubusercontent.com/LunarLuzogSM/OriLua/master/version.txt")
local function Update() 
    if CURRENTVERSION ~= LATESTVERSION then
        currentScript = file.Open(GetScriptName(), "w")
        currentScript:Write(http.Get("https://raw.githubusercontent.com/LunarLuzogSM/OriLua/master/OriLua.lua"))
        currentScript:Close()
        LoadScript(GetScriptName())
    end
end
--------------------------------------
local OriLua_WINDOW = gui.Window("orilua", "OriLua", 100, 100, 500, 500)
--------------------------------------
local OriLua_TAB = gui.Tab(gui.Reference("Settings"), "orilua.updater", "OriLua Updater")
local OriLua_UPDATER_GBOX = gui.Groupbox(OriLua_TAB, "Updater", 10, 10, 160, 0)
local OriLua_UPDATER_CURRENTVERSION = gui.Text(OriLua_UPDATER_GBOX, "Current version: v" .. CURRENTVERSION)
local OriLua_UPDATER_LATESTVERSION = gui.Text(OriLua_UPDATER_GBOX, "Latest version: v" .. LATESTVERSION)
local OriLua_UPDATER_UPDATE = gui.Button(OriLua_UPDATER_GBOX, "Update", Update)
local OriLua_UPDATER_CHANGELOG_GBOX = gui.Groupbox(OriLua_TAB, "Changelog", 190, 10, 360, 0)
local OriLua_UPDATER_CHANGELOG_TEXT = gui.Text(OriLua_UPDATER_CHANGELOG_GBOX, http.Get("https://raw.githubusercontent.com/LunarLuzogSM/OriLua/master/changelog.txt"))
--------------------------------------
