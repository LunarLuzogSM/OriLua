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

-------------------------------------- Gui ( ShiinaChan#5523 (Me))

local OriLua_TAB = gui.Tab(gui.Reference("Settings"), "orilua.LL", "OriLua LL")
local OriLua_LL_UPDATER_GBOX = gui.Groupbox(OriLua_TAB, "Updater", 10, 10, 160, 0) -- Updater-GBOX
local OriLua_LL_CHANGELOG_GBOX = gui.Groupbox(OriLua_TAB, "Changelog", 190, 10, 290, 0) -- Changelog-GBOX
local OriLua_LL_VISUALS_GBOX = gui.Groupbox(OriLua_TAB, "Visuals", 10, 190, 470, 0) -- Visuals-GBOX
local OriLua_LL_RAINBOW_GBOX = gui.Groupbox(OriLua_TAB, "Rainbow", 10, 435, 470, 0) -- Rainbow-GBOX
local OriLua_LL_MISCS_GBOX = gui.Groupbox(OriLua_TAB, "Miscs", 10, 675, 470, 0) -- Miscs-GBOX

-------------------------------------- Auto Update + Changelog ( ShiinaChan#5523 (Me))

local OriLua_LL_CURRENTVERSION = gui.Text(OriLua_LL_UPDATER_GBOX, "Current version: v" .. CURRENTVERSION)
local OriLua_LL_LATESTVERSION = gui.Text(OriLua_LL_UPDATER_GBOX, "Latest version: v" .. LATESTVERSION)
local OriLua_LL_UPDATE = gui.Button(OriLua_LL_UPDATER_GBOX, "Update", Update)
local OriLua_LL_CHANGELOG_TEXT = gui.Text(OriLua_LL_CHANGELOG_GBOX, http.Get("https://raw.githubusercontent.com/LunarLuzogSM/OriLua/master/changelog.txt"))

-------------------------------------- Checkbox + Sliders / Visuals ( ShiinaChan#5523 (Me))

local OriLua_LL_VISUALS_FULLBRIGHT = gui.Checkbox(OriLua_LL_VISUALS_GBOX, "OriLua_LL_VISUALS_FULLBRIGHT", "Full Bright", false)
local OriLua_LL_VISUALS_ASPECT_RATIO = gui.Checkbox(OriLua_LL_VISUALS_GBOX, "OriLua_LL_VISUALS_ASPECT_RATIO", "Aspect Ratio", false);  
local OriLua_LL_VISUALS_EXPOSURE_SLIDER = gui.Slider(OriLua_LL_VISUALS_GBOX, "OriLua_LL_VISUALS_BLOOM_EXPOSURE", "Night Mode", 100, 1, 100);
local OriLua_LL_VISUALS_ASPECT_RATIO_SLIDER = gui.Slider(OriLua_LL_VISUALS_GBOX, "OriLua_LL_VISUALS_ASPECT_RATIO_SLIDER", "Aspect Ratio", 100, 1, 199)

-------------------------------------- Checkbox + Sliders / Rainbow ( ShiinaChan#5523 (Me))

local OriLua_LL_RAINBOWEN_VIS_CHECKBOX = gui.Checkbox(OriLua_LL_RAINBOW_GBOX,"RainbowEnOvCh", "Enemy Visible", false);
local OriLua_LL_RAINBOWEN_OCC_CHECKBOX = gui.Checkbox(OriLua_LL_RAINBOW_GBOX,"RainbowEnOvCh", "Enemy Occluded", false);
local OriLua_LL_RRAINBOWCR_CHECKBOX = gui.Checkbox(OriLua_LL_RAINBOW_GBOX,"RainbowCr", "Crosshair", false);
local OriLua_LL_RAINBOW_TEXT = gui.Text(OriLua_LL_RAINBOW_GBOX, http.Get("https://raw.githubusercontent.com/LunarLuzogSM/OriLua/master/rainbow.txt"))
-- local OriLua_LL_RAINBOW_SPEED = gui.Slider(OriLua_LL_RAINBOW_GBOX, "RainbowSp", "Rainbow Speed", 50, 0, 100)

-------------------------------------- Checkbox + Sliders / Miscs ( ShiinaChan#5523 (Me))

local OriLua_LL_MISCS_ERADAR = gui.Checkbox(OriLua_LL_MISCS_GBOX, "OriLua_LL_MISCS_ERADAR", "Engine Radar", false)
local OriLua_LL_MISCS_MULTI = gui.Multibox(OriLua_LL_MISCS_GBOX, "Antiaim lines")
local OriLua_LL_MISCS_NETWORKED = gui.Checkbox(OriLua_LL_MISCS_MULTI, "vis.local.aalines.networked", "Networked Angle", false)
local OriLua_LL_MISCS_LBY = gui.Checkbox(OriLua_LL_MISCS_MULTI, "vis.local.aalines.lby", "LBY", false)
local OriLua_LL_MISCS_LOCALANG = gui.Checkbox(OriLua_LL_MISCS_MULTI, "vis.local.aalines.networked", "Local Angle", false)
local OriLua_LL_MISCS_LASTCHOKEDANG = gui.Checkbox(OriLua_LL_MISCS_MULTI, "vis.local.aalines.lby", "Last Choked", false)

-------------------------------------- Description ( ShiinaChan#5523 (Me))

OriLua_LL_VISUALS_EXPOSURE_SLIDER:SetDescription("100  Is  Lighter  Than  1")

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
controller:SetProp("m_flCustomAutoExposureMin", OriLua_LL_VISUALS_EXPOSURE_SLIDER:GetValue()/100);
controller:SetProp("m_flCustomAutoExposureMax", OriLua_LL_VISUALS_EXPOSURE_SLIDER:GetValue()/100);
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

----- Rainbow (adrianobessa5682 -- https://aimware.net/forum/user-236354.html)

RAINBOW_SPEED = 5;

function rainbowesp()
    RED = math.sin((globals.RealTime() / RAINBOW_SPEED) * 4) * 127 + 128;
    GREEN = math.sin((globals.RealTime() / RAINBOW_SPEED) * 4 + 2) * 127 + 128;
    BLUE = math.sin((globals.RealTime() / RAINBOW_SPEED) * 4 + 4) * 127 + 128;
if OriLua_LL_RAINBOWEN_VIS_CHECKBOX:GetValue() then
    gui.SetValue( "esp.chams.enemy.visible.clr", math.floor(RED), math.floor(GREEN), math.floor(BLUE), 255)
    end
	if OriLua_LL_RAINBOWEN_OCC_CHECKBOX:GetValue() then
    gui.SetValue( "esp.chams.enemy.occluded.clr", math.floor(RED), math.floor(GREEN), math.floor(BLUE), 255)
    end
	if OriLua_LL_RRAINBOWCR_CHECKBOX:GetValue() then
    gui.SetValue( "esp.other.crosshair.clr", math.floor(RED), math.floor(GREEN), math.floor(BLUE), 255)
    end
end
callbacks.Register( "Draw", "rainbowesp", rainbowesp);
    
----- Engine Radar ( KriZz87#5317 )

local function engine_radar_draw()
for index, Player in pairs(entities.FindByClass("CCSPlayer")) do
if not OriLua_LL_MISCS_ERADAR:GetValue() then        
Player:SetProp("m_bSpotted", 0);
else
Player:SetProp("m_bSpotted", 1);
end
end
end
callbacks.Register("Draw", "engine_radar_draw", engine_radar_draw);

-----  Anti-Aim Angle Lines ( Superyu'#7167 )

local lastChoked = nil;
local fake = nil;
local localAngle = nil;
local lby = nil;
local pLocal = entities.GetLocalPlayer();
local choking;
local lastChoke;
local function AngleVectors(angles)
    local sp, sy, cp, cy;
    local forward = { }
    sy = math.sin(math.rad(angles[2]));
	cy = math.cos(math.rad(angles[2]));
	sp = math.sin(math.rad(angles[1]));
	cp = math.cos(math.rad(angles[1]));
	forward[1] = cp*cy;
	forward[2] = cp*sy;
    forward[3] = -sp;
    return forward;
end
local function doShit(t1, t2, m)
    local t3 ={};
    for i,v in ipairs(t1) do
        t3[i] = v + (t2[i] * m);
    end
    return t3;
end
local function iHateMyself(value, color, text)
    local forward = {};
    local origin = pLocal:GetAbsOrigin();
    forward = AngleVectors({0, value, 0});
    local end3D = doShit({origin.x, origin.y, origin.z}, forward, 25);
    local w2sX1, w2sY1 = client.WorldToScreen(origin);
    local w2sX2, w2sY2 = client.WorldToScreen(Vector3(end3D[1], end3D[2], end3D[3]));
    draw.Color(color[1], color[2], color[3], color[4])
    if w2sX1 and w2sY1 and w2sX2 and w2sY2 then
        draw.Line(w2sX1, w2sY1, w2sX2, w2sY2)
        local textW, textH = draw.GetTextSize(text);
        draw.TextShadow( w2sX2-(textW/2), w2sY2-(textH/2), text)
    end
end
callbacks.Register("Draw", function()
    pLocal = entities.GetLocalPlayer();
    lby = pLocal:GetProp("m_flLowerBodyYawTarget");
    fake = pLocal:GetProp("m_angEyeAngles");
    if lastChoke and lastChoke <= globals.CurTime() - 1 then
        choking = false;
    end
    if pLocal and pLocal:IsAlive() then
        if lastChoked and choking and OriLua_LL_MISCS_LASTCHOKEDANG:GetValue() then iHateMyself(lastChoked.y, {25, 255, 25, 255}, "Last Choked") end
        if fake and OriLua_LL_MISCS_NETWORKED:GetValue() then iHateMyself(fake.y, {255, 25, 25, 255}, "Networked") end
        if localAngle and OriLua_LL_MISCS_LOCALANG:GetValue() then iHateMyself(localAngle.y, {25, 25, 255, 255}, "Local Angle") end
        if lby and OriLua_LL_MISCS_LBY:GetValue() then iHateMyself(lby, {255, 255, 255, 255}, "LBY") end
    end
end)
callbacks.Register("CreateMove", function(pCmd)
    if pLocal and pLocal:IsAlive() then
        if not pCmd.sendpacket then
            lastChoked = pCmd.viewangles
            choking = true;
            lastChoke = globals.CurTime();
        else
            localAngle = pCmd.viewangles
        end
    end
end)
