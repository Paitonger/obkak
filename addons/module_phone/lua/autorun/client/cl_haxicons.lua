-- 17.04


function ICanSeeYou()
	
	local ply = LocalPlayer()
	
	if !ply:Alive() or ply == NULL or !IsValid(ply) then return end
	if ply:GetNWEntity("Hacker") != NULL then
		draw.RoundedBox(0, 5, ScrH()/2 - 2, 250, 70, Color(0,0,0,150))
		surface.SetDrawColor(255,255,255,255)
		surface.SetTexture( surface.GetTextureID("vgui/hax/exclam") );
		surface.DrawTexturedRect( 0, ScrH()/2, 50, 50 );
		surface.SetTextColor( 255, 0, 0, 255 )
		surface.SetFont( "TargetID" )
		surface.SetTextPos( 50, ScrH()/1.9 )
		surface.DrawText("Someone is hacking your data!")
		draw.RoundedBox(0, 12, ScrH()/1.75, 200, 16, Color(70,70,70,200))
		draw.RoundedBox(0, 14, ScrH()/1.75 + 2, ply:GetNWInt("HackProgress")*2-4, 12, Color(25,25,200,255))
	end
	if !ply:GetActiveWeapon() or !IsValid(ply:GetActiveWeapon()) or ply:GetActiveWeapon() == NULL then return end
	if ply:GetActiveWeapon():GetClass() != "krede_wd_phone" then return end
	
	draw.RoundedBox(0, ScrW()/2-130, 5, 250, 50, Color(0,0,0,230))
	surface.SetTexture( surface.GetTextureID("vgui/hax/hack") );
	surface.SetDrawColor(0,255,0,255)
	if ply:GetNWInt("CanHack") == 1 then surface.SetDrawColor(255,0,0,255) end
	surface.DrawTexturedRect( ScrW()/2-125, 10, 40, 40 );
	surface.SetFont( "Trebuchet24" )
	surface.SetTextPos( ScrW()/2-80, 15 )
	if ply:GetNWInt("CanHack") == 2 then
		surface.SetTextColor( 255, 255, 255, 255 )
		surface.DrawText("ctOS connected")
	else
		surface.SetTextColor( 255, 0, 0, 255 )
		surface.DrawText("ctOS not connected")
	end
	
	if LocalPlayer():GetActiveWeapon():GetNWBool("Camera") then
		
		local WHOTBackTab={
			["$pp_colour_addr"]=0,
			["$pp_colour_addg"]=0,
			["$pp_colour_addb"]=0,
			["$pp_colour_brightness"]=.1,
			["$pp_colour_contrast"]=.5,
			["$pp_colour_colour"]=0.5,
			["$pp_colour_mulr"]=0,
			["$pp_colour_mulg"]=0,
			["$pp_colour_mulb"]=0
		}
		
		DrawColorModify(WHOTBackTab)
		
		for i=1,ScrH() do
			surface.SetDrawColor(Color(127,127,127,math.random(1,50)))
			surface.DrawLine(0,i,ScrW(),i)
		end
		
	end
	
	if ply:InVehicle() then return end
	
	ent = ents.FindInSphere(ply:GetViewEntity():GetPos(),2000)
	
	if ply:GetViewEntity() == ply or !IsValid(ply:GetViewEntity()) then
		phoneScreenpos = ply:GetViewEntity():GetShootPos() + Vector(0,0,-1)
		phoneScreenpos = phoneScreenpos:ToScreen()
	else
		phoneScreenpos = ply:GetViewEntity():GetPos() + Vector(0,0,-1)
		phoneScreenpos = phoneScreenpos:ToScreen()
	end
	
	for i = 1, #ent do
		
		local target = ent[i]
		
		local pos = ply:GetShootPos()
		local td = {}
		td.start = pos
		td.endpos = target:GetPos()
		td.filter = ply
		trace = util.TraceLine(td)
		if trace.HitWorld then continue end
		if trace.Entity != NULL and IsValid(trace.Entity) and ( trace.Entity:GetClass() == "prop_door_rotating" ) then continue end
		
		local targetPos = target:GetPos() + Vector(0,0,70)
		local targetScreenpos = targetPos:ToScreen()
	
		for class,tbl in pairs(Krede_WD_HaxList) do
			if target:GetClass() == class and target != ply:GetViewEntity() and tbl.show(target, ply) or string.find(class, "*") and string.find(target:GetClass(), string.gsub(class,"*","")) and tbl.show(target, ply) then
				
				local targetPos = target:GetPos() + tbl.offset
			
				local targetDistance = math.floor((ply:GetPos():Distance( targetPos ))/40)
				
				local targetScreenpos = targetPos:ToScreen()
				
				surface.SetDrawColor(255,255,255,80)
				surface.DrawLine( phoneScreenpos.x, phoneScreenpos.y, targetScreenpos.x, targetScreenpos.y )
				
				surface.SetDrawColor(255,255,255,80)
				if WDGlowingEnt and IsValid(WDGlowingEnt) then
					randnum = math.random(-10,10)
				else
					randnum = math.random(-1,1)
				end
				
				surface.DrawLine( phoneScreenpos.x + randnum, phoneScreenpos.y, targetScreenpos.x + randnum, targetScreenpos.y )
				
				surface.SetTexture( surface.GetTextureID("vgui/hax/hack") );
				surface.SetDrawColor(255,255,255,255)
				if GetConVar("wd_needbattery"):GetBool() then
					if ply:GetActiveWeapon():GetNWInt("Battery") < tbl.cost or ply:GetNWInt("CanHack") == 1 then surface.SetDrawColor(255,0,0,255) end
				end
				surface.DrawTexturedRect( tonumber(targetScreenpos.x) - 15, tonumber(targetScreenpos.y), 40, 40 );
			end
		end
		
	end
	if ply:GetViewEntity() != ply then
		local pos = ply:GetViewEntity():GetPos()
		local ang = ply:GetViewEntity():GetForward()
		local td = {}
		td.start = pos
		td.endpos = pos+(ang*2000)
		td.filter = ply:GetViewEntity()
		trace = util.TraceLine(td)
		target = trace.Entity
	else
		local pos = ply:GetShootPos()
		local ang = ply:GetAimVector()
		local td = {}
		td.start = pos
		td.endpos = pos+(ang*2000)
		td.filter = ply
		trace = util.TraceLine(td)
		target = trace.Entity
	end
	
	if target != NULL and IsValid(target) then
	
		if target:GetClass() == "npc_citizen" then
			
			local targetPos = target:GetPos() + Vector(0,0,70)
		
			local targetDistance = math.floor((ply:GetPos():Distance( targetPos ))/40)
		
			local targetScreenpos = targetPos:ToScreen()
			
			if target:GetNWEntity("Hacker") != NULL and target:GetClass() == "npc_citizen" then
				draw.RoundedBox(0, tonumber(targetScreenpos.x) + 6, tonumber(targetScreenpos.y)-1, surface.GetTextSize(target:GetNWString("Name")) + 16, 20, Color(0,0,0,225))
				draw.RoundedBox(0, tonumber(targetScreenpos.x) + 21, tonumber(targetScreenpos.y), surface.GetTextSize(target:GetNWString("Name")), 18, Color(255,255,255,255))
				
				draw.RoundedBox(0, tonumber(targetScreenpos.x) + 21, tonumber(targetScreenpos.y)+20, 192, 17, Color(0,0,0,225))
				draw.RoundedBox(0, tonumber(targetScreenpos.x) + 22, tonumber(targetScreenpos.y)+21, 190, 15, Color(255,255,255,255))
				
				draw.RoundedBox(0, tonumber(targetScreenpos.x) + 21, tonumber(targetScreenpos.y)+38, 70, 16, Color(0,0,0,225))
				
				draw.RoundedBox(0, tonumber(targetScreenpos.x) + 21, tonumber(targetScreenpos.y)+55, 220, 100, Color(0,0,0,225))
				
				if target:GetNWInt("Crime") > 60 then
					surface.SetTextColor( 255, 0, 0, 255 )
				else
					surface.SetTextColor( 255, 255, 0, 255 )
				end
				
				surface.SetFont( "TargetID" )
				surface.SetTextPos( tonumber(targetScreenpos.x) + 24, tonumber(targetScreenpos.y) + 20 )
				surface.DrawText("Crime Probability: "..target:GetNWInt("Crime").."%")
				
				surface.SetTextColor( 200, 200, 200, 255 )
				surface.SetFont( "TargetIDSmall" )
				surface.SetTextPos( tonumber(targetScreenpos.x) + 25, tonumber(targetScreenpos.y) + 38 )
				surface.DrawText("Age: "..target:GetNWInt("Age"))
				
				surface.SetTextColor( 200, 200, 200, 255 )
				surface.SetFont( "TargetIDSmall" )
				words = {}
				nextSpace = 0
				for c = 1, string.len(target:GetNWString("Story")) do
					if string.len(string.sub(target:GetNWString("Story"), nextSpace, c)) == 30 then
						table.insert(words, string.sub(target:GetNWString("Story"), nextSpace, c - 1).."-")
						nextSpace = c
					elseif string.len(target:GetNWString("Story")) == c then
						table.insert(words, string.sub(target:GetNWString("Story"), nextSpace, c))
					end
				end
				for w = 1, #words do
					surface.SetTextPos( tonumber(targetScreenpos.x) + 25, w * 15 + tonumber(targetScreenpos.y) + 40 )
					if string.sub(words[w], 1, 1) == " " then
						surface.DrawText(string.sub(words[w], 2, string.len(words[w])))
					else
						surface.DrawText(words[w])
					end
				end
			else
				draw.RoundedBox(0, tonumber(targetScreenpos.x) + 6, tonumber(targetScreenpos.y)-1, surface.GetTextSize(target:GetNWString("Name")) + 16, 20, Color(0,0,0,225))
				draw.RoundedBox(0, tonumber(targetScreenpos.x) + 21, tonumber(targetScreenpos.y), surface.GetTextSize(target:GetNWString("Name")), 18, Color(255,255,255,255))
			end
			
			surface.SetTexture( surface.GetTextureID("vgui/hax/hack") );
			surface.SetDrawColor( 255, 255, 255, 255 )
			if ply:GetNWInt("CanHack") == 1 then surface.SetDrawColor( 255, 0, 0, 255 ) end
			surface.DrawTexturedRect( tonumber(targetScreenpos.x) - 15, tonumber(targetScreenpos.y), 40, 40 );
			
			surface.SetTextColor( 0, 0, 0, 255 )
			surface.SetFont( "TargetID" )
			surface.SetTextPos( tonumber(targetScreenpos.x) + 23, tonumber(targetScreenpos.y) )
			surface.DrawText(target:GetNWString("Name"))
			
			if ply:GetNWInt("CanHack") == 1 then return false end
			if target:GetClass() == "npc_citizen" then
				surface.SetTextColor( 255, 255, 0, 255 )
				surface.SetFont( "TargetID" )
				surface.SetTextPos( tonumber(targetScreenpos.x) - 15, tonumber(targetScreenpos.y) + 38 )
				if target:GetNWEntity("Hacker") == NULL or target:GetNWInt("Money") > 0 then
					surface.DrawText("HACK")
				end
			end
			surface.SetDrawColor(255,255,255,255)
			return true
		
		end
		
		for class,tbl in pairs(Krede_WD_HaxList) do
			if target:GetClass() == class and tbl.show(target, ply) or string.find(class, "*") and string.find(target:GetClass(), string.gsub(class,"*","")) and tbl.show(target, ply) then
				local targetPos = target:GetPos() + tbl.offset
			
				local targetDistance = math.floor((ply:GetPos():Distance( targetPos ))/40)
				
				local targetScreenpos = targetPos:ToScreen()
				
				draw.RoundedBox(0, tonumber(targetScreenpos.x) + 6, tonumber(targetScreenpos.y)-1, surface.GetTextSize(tbl.name) + 20, 20, Color(0,0,0,225))
				if tbl.cost > 0 and GetConVar("wd_needbattery"):GetBool() then
					draw.RoundedBox(0, tonumber(targetScreenpos.x) + 5, tonumber(targetScreenpos.y)+22, 50, 16, Color(0,0,0,225))
					surface.SetTextColor( 255, 255, 255, 255 )
					surface.SetFont( "TargetID" )
					surface.SetTextPos( tonumber(targetScreenpos.x) + 36, tonumber(targetScreenpos.y) + 21 )
					surface.DrawText(tbl.cost)
				end
				surface.SetTexture( surface.GetTextureID("vgui/hax/hack") );
				surface.SetDrawColor(255,255,255,255)
				if GetConVar("wd_needbattery"):GetBool() then
					if ply:GetActiveWeapon():GetNWInt("Battery") < tbl.cost or ply:GetNWInt("CanHack") == 1 then surface.SetDrawColor(255,0,0,255) end
				end
				surface.DrawTexturedRect( tonumber(targetScreenpos.x) - 15, tonumber(targetScreenpos.y), 40, 40 );
				surface.SetTextColor( 255, 255, 255, 255 )
				surface.SetFont( "TargetID" )
				surface.SetTextPos( tonumber(targetScreenpos.x) + 26, tonumber(targetScreenpos.y) + 1 )
				surface.DrawText(tbl.name)
				surface.SetTextColor( 255, 255, 0, 255 )
				surface.SetFont( "TargetID" )
				surface.SetTextPos( tonumber(targetScreenpos.x) - 15, tonumber(targetScreenpos.y) + 38 )
				if GetConVar("wd_needbattery"):GetBool() then
					if ply:GetActiveWeapon():GetNWInt("Battery") < tbl.cost or ply:GetNWInt("CanHack") == 1 then continue end
				end
				if target:GetNWEntity("Hacker") == NULL then
					surface.DrawText("HACK")
				elseif target:GetNWEntity("Hacker") != ply then
					surface.DrawText("HACKED BY: "..target:GetNWEntity("Hacker"):Nick())
				else
					surface.DrawText("HACKED")
				end
				return true
			end
		end
		
	else
		for num,ent in pairs(ents.FindInSphere(trace.HitPos, 200)) do
			for class,tbl in pairs(Krede_WD_HaxList) do
				if ent:GetClass() == class and tbl.show(ent, LocalPlayer()) and ply:GetViewEntity() != ent or string.find(class, "*") and string.find(ent:GetClass(), string.gsub(class,"*","")) and tbl.show(ent, LocalPlayer()) and ply:GetViewEntity() != ent then
					if target == NULL or !IsValid(target) or trace.HitPos:Distance( ent:GetPos() ) < trace.HitPos:Distance( target:GetPos() ) then
						target = ent
					end
				end
			end
		end
		if target != NULL and IsValid(target) then
			for class,tbl in pairs(Krede_WD_HaxList) do
				if target:GetClass() == class and tbl.show(target, LocalPlayer()) and ply:GetViewEntity() != target or string.find(class, "*") and string.find(target:GetClass(), string.gsub(class,"*","")) and tbl.show(target, LocalPlayer()) and ply:GetViewEntity() != ent then
					local targetPos = target:GetPos() + tbl.offset
				
					local targetDistance = math.floor((ply:GetPos():Distance( targetPos ))/40)
					
					local targetScreenpos = targetPos:ToScreen()
					
					draw.RoundedBox(0, tonumber(targetScreenpos.x) + 6, tonumber(targetScreenpos.y)-1, surface.GetTextSize(tbl.name) + 20, 20, Color(0,0,0,225))
					if tbl.cost > 0 and GetConVar("wd_needbattery"):GetBool() then
						draw.RoundedBox(0, tonumber(targetScreenpos.x) + 5, tonumber(targetScreenpos.y)+22, 50, 16, Color(0,0,0,225))
						surface.SetTextColor( 255, 255, 255, 255 )
						surface.SetFont( "TargetID" )
						surface.SetTextPos( tonumber(targetScreenpos.x) + 36, tonumber(targetScreenpos.y) + 21 )
						surface.DrawText(tbl.cost)
					end
					surface.SetTexture( surface.GetTextureID("vgui/hax/hack") );
					surface.SetDrawColor(255,255,255,255)
					if GetConVar("wd_needbattery"):GetBool() then
						if ply:GetActiveWeapon():GetNWInt("Battery") < tbl.cost or ply:GetNWInt("CanHack") == 1 then surface.SetDrawColor(255,0,0,255) end
					end
					surface.DrawTexturedRect( tonumber(targetScreenpos.x) - 15, tonumber(targetScreenpos.y), 40, 40 );
					surface.SetTextColor( 255, 255, 255, 255 )
					surface.SetFont( "TargetID" )
					surface.SetTextPos( tonumber(targetScreenpos.x) + 26, tonumber(targetScreenpos.y) + 1 )
					surface.DrawText(tbl.name)
					surface.SetTextColor( 255, 255, 0, 255 )
					surface.SetFont( "TargetID" )
					surface.SetTextPos( tonumber(targetScreenpos.x) - 15, tonumber(targetScreenpos.y) + 38 )
					if GetConVar("wd_needbattery"):GetBool() then
						if ply:GetActiveWeapon():GetNWInt("Battery") < tbl.cost or ply:GetNWInt("CanHack") == 1 then continue end
					end
					if target:GetNWEntity("Hacker") == NULL then
						surface.DrawText("HACK")
					elseif target:GetNWEntity("Hacker") != ply then
						surface.DrawText("HACKED BY: "..target:GetNWEntity("Hacker"):Nick())
					else
						surface.DrawText("HACKED")
					end
					return true
				end
			end
		end
	end
	
	surface.SetDrawColor(255,255,255,255)
	surface.SetTexture( surface.GetTextureID("vgui/hax/cross") );
	surface.DrawTexturedRect( ScrW()/2-11, ScrH()/2-10, 20, 20 );
	
end

hook.Add("HUDPaint","HoveringWatchDogIcons",ICanSeeYou)

net.Receive("ctOS-Box-Hack", function(len)
	local ctOSBox = net.ReadEntity()
	
	ctOSFrame = vgui.Create("DFrame")
	ctOSFrame:SetSize( ScrW(), ScrH() )
	ctOSFrame:SetPos( 0, 0 )
	ctOSFrame:SetTitle("")
	ctOSFrame:SetDraggable(false)
	ctOSFrame:ShowCloseButton(true)
	ctOSFrame:MakePopup()
	function ctOSFrame:Paint()
		draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 0, 0, 20 ) )
	end
	ctOSPanel = vgui.Create( "DPanel", ctOSFrame )
	ctOSPanel:SetPos( 0, 30 )
	ctOSPanel:SetSize( ctOSFrame:GetWide(), ctOSFrame:GetTall() - 30 )
	ctOSPanel:SetCursor("crosshair");
	function ctOSPanel:Paint()
		if Buttons and Buttons[1] then
			for i = 1, #Buttons do
				if !Buttons[i+1] then continue end
				bposx, bposy = Buttons[i]:GetPos()
				mposx, mposy = Buttons[i+1]:GetPos()
				bposx, bposy = bposx+16, bposy+16
				mposx, mposy = mposx+16, mposy+16
				
				if Buttons[i]:GetText() != tostring(i) then continue end
				if Buttons[i+1]:GetText() != tostring(i+1) then continue end
				
				surface.SetDrawColor( 0, 255, 255, 255 )
				surface.DrawLine( bposx, bposy, mposx, mposy )
			end
		end
	end
	ctOSPanel.Think = function()
		if Buttons and Buttons[1] then
			if #Buttons < ctOSBox:GetNWInt("Difficulty") then ctOSFrame:Remove() return end
			for i = 1, #Buttons do
				if Buttons[i]:GetText() != tostring(i) then return end
			end
			net.Start("ctOS-Box-Hacked")
				net.WriteEntity(ctOSBox)
			net.SendToServer()
			ctOSFrame:Remove()
		end
	end
	
	Buttons = {}
	lastx = 0
	lasty = 0
	
	maxbuts = ctOSBox:GetNWInt("Difficulty")
	unusedbuts = {}
	for d = 1, maxbuts do
		table.insert(unusedbuts, d)
	end
	
	for i = 1, maxbuts do
		local b = vgui.Create( "DButton", ctOSPanel )
		if lastx == 0 and lasty == 0 then
			b:SetPos( math.random(0, ctOSPanel:GetWide()-32), math.random(0, ctOSPanel:GetTall()-32) )
		else
			local poses = {
				{lastx + 200, lasty},
				{lastx - 200, lasty},
				{lastx, lasty + 200},
				{lastx, lasty - 200},
			}
			local possibleposes = {}
			
			for k = 1, #poses do
				if poses[k][1]+32 > ctOSPanel:GetWide() or poses[k][2]+32 > ctOSPanel:GetTall() then continue end
				if poses[k][1] < 0 or poses[k][2] < 0 then continue end
				for c = 1, #Buttons do
					bposx, bposy = Buttons[c]:GetPos()
					if bposx == poses[k][1] and bposy == poses[k][2] then overriden = true end
				end
				if overriden then overriden = nil continue end
				table.insert(possibleposes, poses[k])
			end
			local pos = table.Random(possibleposes)
			if !pos then b:Remove() return end
			b:SetPos( pos[1], pos[2] )
		end
		lastx, lasty = b:GetPos()
		b:SetSize( 32, 32 )
		local num = math.random(1, #unusedbuts)
		local name = unusedbuts[num]
		b:SetText(name)
		table.remove(unusedbuts, num)
		b:SetCursor("crosshair");
		b.DoClick = function()
			if !b.Clicked then
				for f = 1, #Buttons do
					if Buttons[f].Clicked then
						Buttons[f].Clicked = false
						selfnum = b:GetText()
						othernum = Buttons[f]:GetText()
						Buttons[f]:SetText( selfnum )
						b:SetText( othernum )
						return false
					end
				end
				b.Clicked = true
			else
				for f = 1, #Buttons do
					Buttons[f].Clicked = false
				end
			end
		end
		b.Paint = function()
			if b.Clicked then
				draw.RoundedBox( 4, 0, 0, b:GetWide(), b:GetTall(), Color( 0, 200, 200 ) )
			else
				draw.RoundedBox( 4, 0, 0, b:GetWide(), b:GetTall(), Color( 55, 55, 55 ) )
			end
		end
		table.insert(Buttons, b)
	end
	
end)

local function Hinder(default)
	local ply=LocalPlayer()
	if(ply:GetActiveWeapon())then
		if ply:GetActiveWeapon() != NULL and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "krede_wd_phone" and ply:GetActiveWeapon():GetNWBool("Camera") then
			return .001
		end
	end
end
hook.Add("AdjustMouseSensitivity","WatchPhoneSensi",Hinder)

function PreDrawHalos()
	if WDGlowingEnt and IsValid(WDGlowingEnt) then
		halo.Add({WDGlowingEnt}, Color(255, 255, 255), 0.1, 0.1, 0.1, true, false)
	end
end
hook.Add("PreDrawHalos","WatchPhoneSensi",PreDrawHalos)

net.Receive("WP_GlowingEnt", function(len)
	local GlowingEnt = net.ReadEntity()
	
	WDGlowingEnt = GlowingEnt
end)