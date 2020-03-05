-- OriLua --
-- Made By LunarLuzog Aka ShiinaChan#5523 --

-------------------------------------- Print

print("Successfully Loaded OriLua")

-------------------------------------- Auto Update

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

-------------------------------------- Gui + Auto Update + Changelog

local OriLua_TAB = gui.Tab(gui.Reference("Settings"), "orilua.LL", "OriLua LL")
local OriLua_LL_UPDATER_GBOX = gui.Groupbox(OriLua_TAB, "Updater", 10, 10, 160, 0) -- Updater-GBOX
local OriLua_LL_CHANGELOG_GBOX = gui.Groupbox(OriLua_TAB, "Changelog", 190, 10, 290, 0) -- Changelog-GBOX
local OriLua_LL_VISUALS_GBOX = gui.Groupbox(OriLua_TAB, "Visuals", 10, 190, 470, 0) -- Visuals-GBOX
local OriLua_LL_MISCS_GBOX = gui.Groupbox(OriLua_TAB, "Miscs", 10, 190, 470, 0) -- Miscs-GBOX
local OriLua_LL_CURRENTVERSION = gui.Text(OriLua_LL_UPDATER_GBOX, "Current version: v" .. CURRENTVERSION)
local OriLua_LL_LATESTVERSION = gui.Text(OriLua_LL_UPDATER_GBOX, "Latest version: v" .. LATESTVERSION)
local OriLua_LL_UPDATE = gui.Button(OriLua_LL_UPDATER_GBOX, "Update", Update)
local OriLua_LL_CHANGELOG_TEXT = gui.Text(OriLua_LL_CHANGELOG_GBOX, http.Get("https://raw.githubusercontent.com/LunarLuzogSM/OriLua/master/changelog.txt"))

-------------------------------------- RainbowTrail (Exration -- https://aimware.net/forum/user-316054.html)

local TickCountValue = 64 * 2;
local DataItems = { };
local LastTickCount = globals.TickCount();

local function GetFadeRGB(Factor, Speed)
    local r = math.floor(math.sin(Factor * Speed) * 127 + 128)
    local g = math.floor(math.sin(Factor * Speed + 2) * 127 + 128)
    local b = math.floor(math.sin(Factor * Speed + 4) * 127 + 128)
    return r, g, b;
end

local function MotionTrajectory()
    
    local LocalPlayer = entities.GetLocalPlayer();
    if (LocalPlayer == nil or LocalPlayer:IsAlive() ~= true) then
        DataItems = { };
        return;
    end
    
    ScreenX, ScreenY = draw.GetScreenSize();
    
    for i = 1, #DataItems do
        local ItemCurrent = DataItems[i];
        local ItemNext = DataItems[i + 1];
        
        if (ItemCurrent ~= nil and ItemNext ~= nil) then
            local CPosX, CPosY = client.WorldToScreen(ItemCurrent.x, ItemCurrent.y, ItemCurrent.z);
            local NPosX, NPosY = client.WorldToScreen(ItemNext.x, ItemNext.y, ItemNext.z);

            if (CPosX ~= nil and CPosY ~= nil and NPosX ~= nil and NPosY ~= nil and CPosX < ScreenX and CPosY < ScreenY and NPosX < ScreenX and NPosY < ScreenY) then
                local ColorR, ColorG, ColorB = GetFadeRGB(i / 10, 1);
                draw.Color(ColorR, ColorG, ColorB, 255);
                draw.Line(CPosX, CPosY, NPosX, NPosY);
                draw.Line(CPosX + 1, CPosY + 1, NPosX + 1, NPosY + 1);
            end
        end
    end
    
    
    local CurrentTickCount = globals.TickCount();
    if (CurrentTickCount - LastTickCount < 1) then
        return;
    end
    
    LastTickCount = CurrentTickCount;
    
    local LocX, LocY, LocZ = LocalPlayer:GetAbsOrigin();
    local ItemData = { x = LocX, y = LocY, z = LocZ };

    table.insert(DataItems, 1, ItemData);
    if (#DataItems == TickCountValue + 1) then
        table.remove(DataItems, TickCountValue + 1);
    end
    
end

callbacks.Register("Draw", "CbDraw", MotionTrajectory);

-------------------------------------- Checkbox

local OriLua_LL_VISUALS_FULLBRIGHT = gui.Checkbox(OriLua_LL_VISUALS_GBOX, "fulbright", "Full Bright", false)
local OriLua_LL_VISUALS_EXPOSURE = gui.Slider(OriLua_LL_VISUALS_GBOX, "nex_bloom_exposure", "Night Mode", 100, 1, 100);

-------------------------------------- Description

OriLua_LL_VISUALS_EXPOSURE:SetDescription("100  Is  Lighter  Than  1")

-------------------------------------- All Code

----- FullBright (adrianobessa5682 -- https://aimware.net/forum/user-236354.html)

local client_SetConVar = client.SetConVar
function full_bright()
     if OriLua_LL_VISUALS_FULLBRIGHT:GetValue() then client_SetConVar("mat_fullbright", 1, true);
        else 
     client_SetConVar("mat_fullbright", 0, true);
     end 
    end
callbacks.Register('Draw', "OriLua_LL_VISUALS_FULLBRIGHT" ,full_bright);

----- NightMode (adrianobessa5682 -- https://aimware.net/forum/user-236354.html)

callbacks.Register("Draw", "Night Mode", function()
local controller = entities.FindByClass("CEnvTonemapController")[1];
if(controller) then
controller:SetProp("m_bUseCustomAutoExposureMin", 1);
controller:SetProp("m_bUseCustomAutoExposureMax", 1);
controller:SetProp("m_flCustomAutoExposureMin", OriLua_LL_VISUALS_EXPOSURE:GetValue()/100);
controller:SetProp("m_flCustomAutoExposureMax", OriLua_LL_VISUALS_EXPOSURE:GetValue()/100);
end
end)
