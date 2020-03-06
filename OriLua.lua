-- OriLua
-- Made By LunarLuzog Aka ShiinaChan#5523

-------------------------------------- Print

print("Successfully Loaded OriLua")

-------------------------------------- Auto Update

local CURRENTVERSION = "0.1"
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
-- local OriLua_LL_MISCS_GBOX = gui.Groupbox(OriLua_TAB, "Miscs", 10, 350, 470, 0) -- Miscs-GBOX
local OriLua_LL_CURRENTVERSION = gui.Text(OriLua_LL_UPDATER_GBOX, "Current version: v" .. CURRENTVERSION)
local OriLua_LL_LATESTVERSION = gui.Text(OriLua_LL_UPDATER_GBOX, "Latest version: v" .. LATESTVERSION)
local OriLua_LL_UPDATE = gui.Button(OriLua_LL_UPDATER_GBOX, "Update", Update)
local OriLua_LL_CHANGELOG_TEXT = gui.Text(OriLua_LL_CHANGELOG_GBOX, http.Get("https://raw.githubusercontent.com/LunarLuzogSM/OriLua/master/changelog.txt"))

-------------------------------------- Checkbox + Sliders

local OriLua_LL_VISUALS_FULLBRIGHT = gui.Checkbox(OriLua_LL_VISUALS_GBOX, "fulbright", "Full Bright", false)
local OriLua_LL_VISUALS_ASPECT_RATIO = gui.Checkbox(OriLua_LL_VISUALS_GBOX, "OriLua_LL_VISUALS_ASPECT_RATIO", "Aspect Ratio", false);  
local OriLua_LL_VISUALS_EXPOSURE = gui.Slider(OriLua_LL_VISUALS_GBOX, "nex_bloom_exposure", "Night Mode", 100, 1, 100);
local OriLua_LL_VISUALS_ASPECT_RATIO_SLIDER = gui.Slider(OriLua_LL_VISUALS_GBOX, "OriLua_LL_VISUALS_ASPECT_RATIO_SLIDER", "Aspect Ratio", 100, 1, 199)

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
controller:SetProp("m_bUseCustomAutoExposureMax", 1);a
controller:SetProp("m_flCustomAutoExposureMin", OriLua_LL_VISUALS_EXPOSURE:GetValue()/100);
controller:SetProp("m_flCustomAutoExposureMax", OriLua_LL_VISUALS_EXPOSURE:GetValue()/100);
end
end)

----- AspectRatio (adrianobessa5682 -- https://aimware.net/forum/user-236354.html)

local aspect_ratio_table = {};    
local function gcd(m, n)    while m ~= 0 do   m, n = math.fmod(n, m), m;   
end    
return n 
end
local function set_aspect_ratio(aspect_ratio_multiplier)
local screen_width, screen_height = draw.GetScreenSize();   local aspectratio_value = (screen_width*aspect_ratio_multiplier)/screen_height;   
    if aspect_ratio_multiplier == 1 or not OriLua_LL_VISUALS_ASPECT_RATIO:GetValue() then  aspectratio_value = 0;   end
        client.SetConVar( "r_aspectratio", tonumber(aspectratio_value), true);   end
local function on_aspect_ratio_changed()
 local screen_width, screen_height = draw.GetScreenSize();
 for i=1, 200 do   local i2=i*0.01;    i2 = 2 - i2;   local divisor = gcd(screen_width*i2, screen_height);    if screen_width*i2/divisor < 100 or i2 == 1 then   aspect_ratio_table[i] = screen_width*i2/divisor .. ":" .. screen_height/divisor;  end  end
local aspect_ratio = OriLua_LL_VISUALS_ASPECT_RATIO_SLIDER:GetValue()*0.01;  aspect_ratio = 2 - aspect_ratio;   set_aspect_ratio(aspect_ratio);   end
callbacks.Register('Draw', "Aspect Ratio" ,on_aspect_ratio_changed)
