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
local OriLua_TAB = gui.Tab(gui.Reference("Settings"), "orilua.LL", "OriLua LL")
local OriLua_LL_GBOX = gui.Groupbox(OriLua_TAB, "Updater", 10, 10, 160, 0)
local OriLua_LL_CURRENTVERSION = gui.Text(OriLua_LL_GBOX, "Current version: v" .. CURRENTVERSION)
local OriLua_LL_LATESTVERSION = gui.Text(OriLua_LL_GBOX, "Latest version: v" .. LATESTVERSION)
local OriLua_LL_UPDATE = gui.Button(OriLua_LL_GBOX, "Update", Update)
local OriLua_LL_CHANGELOG_GBOX = gui.Groupbox(OriLua_TAB, "Changelog", 190, 10, 290, 0)
local OriLua_LL_ORILUA_GBOX = gui.Groupbox(OriLua_TAB, "HvH", 10, 190, 470, 0)
local OriLua_LL_CHANGELOG_TEXT = gui.Text(OriLua_LL_CHANGELOG_GBOX, http.Get("https://raw.githubusercontent.com/LunarLuzogSM/OriLua/master/changelog.txt"))
--------------------------------------
