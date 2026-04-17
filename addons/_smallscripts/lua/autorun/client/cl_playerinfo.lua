-- t.me/urbanichka
local hideHUDElements = {
	["DarkRP_HUD"] = true,
	["DarkRP_EntityDisplay"] = true,
	["DarkRP_LocalPlayerHUD"] = true,
	["DarkRP_Hungermod"] = true,
	["DarkRP_Agenda"] = true,
	["DarkRP_LockdownHUD"] = true,
}

hook.Add("HUDShouldDraw", "DisableGovno", function(name)
	if hideHUDElements[name] then return false end
end)

local draw = draw
local surface = surface
local cam = cam
local math = math
local team = team
local localplayer = LocalPlayer
local eyepos
local Page = Material("icon16/page_white_text.png")

hook.Add("RenderScene", "3D2DNicksPosAng",function(pos)
	eyepos = pos
end)

local offset = -200
local red = 255
local green = 255
local blue = 255
timer.Create('colorchanger', 0.5, 0, function()
    red = math.random(0,255)
    green = math.random(0,255)
    blue = math.random(0,255)
end)

hook.Add("PostPlayerDraw", "3D2DNicks", function(ply)
    local dist = ply:GetPos():Distance(eyepos)
    if dist > 350 or !ply:Alive() then return end
    local bone = ply:LookupAttachment("eyes")
    local attach
    
    if bone == 0 then 
		attach = ply:GetPos()
	else
        attach = ply:GetAttachment(bone).Pos
    end
    
    local alpha = 255 * (1 - math.Clamp((dist - 250) / 100, 0, 1))
    local nick = Color(255,255,255, 255)
    local job = Color(213, 117, 71, 255)
    
    local patron = Color(red,green,blue,255)
    cam.Start3D2D(attach + Vector(0, 0, 30), Angle(0, (attach - eyepos):Angle().y - 90, 90), 0.06)
        if ply:GetUserGroup() == 'Patron' then
        draw.SimpleText(ply:Nick(), "Trebuchet48", 0, 220, patron, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
        draw.SimpleText(ply:Nick(), "Trebuchet48", 0, 220, nick, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        draw.SimpleText(ply:getDarkRPVar("job"), "Trebuchet48", 0, 255, job, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        if ply:GetNWInt('IGS.LVL') >= 18 then
        draw.SimpleText(ply:GetNWString("IGS.Name"), "Trebuchet24", 0, 295, patron, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    	elseif ply:GetNWInt('IGS.LVL') >= 10 then
        draw.SimpleText(ply:GetNWString("IGS.Name"), "Trebuchet24", 0, 295, job, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    	end
    	
        if ply:getDarkRPVar("HasGunlicense") then
            surface.SetMaterial(Page)
            surface.SetDrawColor(Color(255, 255, 255, alpha))
        	if ply:GetNWInt('IGS.LVL') >= 10 then
            surface.DrawTexturedRect(-20, 310, 40, 40)
        	else
        	surface.DrawTexturedRect(-20, 280, 40, 40)
        	end
        end        

        if ply:getDarkRPVar("wanted") then
            draw.SimpleText("Розыск: "..ply:getDarkRPVar("wantedReason"), "Trebuchet48", 0, 175, Color(255, 0, 0, alpha),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
    cam.End3D2D()
end)

local VoiceChatTexture = surface.GetTextureID("voice/icntlk_pl")

local function DrawVoiceChat()
    if LocalPlayer().DRPIsTalking then
        local _, chboxY = chat.GetChatBoxPos()

        local Rotating = math.sin(CurTime() * 3)
        local backwards = 0

        if Rotating < 0 then
            Rotating = 1 - (1 + Rotating)
            backwards = 180
        end

        surface.SetTexture(VoiceChatTexture)
        surface.SetDrawColor(255,0,0,255)
        surface.DrawTexturedRectRotated(ScrW() - 100, chboxY, Rotating * 96, 96, backwards)
    end
end

local Arrested = function() end

usermessage.Hook("GotArrested", function(msg)
    local StartArrested = CurTime()
    local ArrestedUntil = msg:ReadFloat()

    Arrested = function()
        if CurTime() - StartArrested <= ArrestedUntil and LocalPlayer():getDarkRPVar("Arrested") then
            local text = 'Ты арестован!'
    		local sec = 'Осталось сидеть '..math.ceil((ArrestedUntil - (CurTime() - StartArrested)) * 1 / game.GetTimeScale())..' сек'
	        draw.SimpleText( text, "chelog-ib-shadow", ScrW() / 2, ScrH() - 70, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( text, "chelog-ib", ScrW() / 2, ScrH() - 70, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		    draw.SimpleText( sec, "chelog-ib.small", ScrW() / 2, ScrH() - 40, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        elseif not LocalPlayer():getDarkRPVar("Arrested") then
            Arrested = function() end
        end
    end
end)


hook.Add('HUDPaint', 'infodor', function()
    DrawVoiceChat()
    Arrested()
    
    local tr = localplayer():GetEyeTrace()
    if IsValid(tr.Entity) and tr.Entity:isKeysOwnable() and tr.Entity:GetPos():DistToSqr(LocalPlayer():GetPos()) < 40000 then
        tr.Entity:drawOwnableInfo()
    end
end)

hook.Add("HUDDrawTargetID", 'HideSBoxInfo', function()
    return false
end)

local function DisplayNotify(msg)
    local txt = msg:ReadString()
    GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
end
usermessage.Hook("_Notify", DisplayNotify)