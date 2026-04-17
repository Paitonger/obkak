-- 17.04
Krede_WD_HaxList = {}

Krede_WD_HaxList["npc_manhack"] = {
									name = "Manhack",
									cost = 1,
									offset = Vector(0,0,10),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										ent:AddEntityRelationship(ply, D_LI, 99)
										ent:SetNWEntity("Hacker", ply)
									end,
}
Krede_WD_HaxList["npc_turret_floor"] = {
									name = "Turret",
									cost = 1,
									offset = Vector(0,0,40),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply, mode)
										ent:Fire("Toggle", "")
									end,
}
Krede_WD_HaxList["npc_rollermine"] = {
									name = "Rollermine",
									cost = 1,
									offset = Vector(0,0,10),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										local effectdata = EffectData()
										effectdata:SetOrigin(ent:GetPos())
										util.Effect("HelicopterMegaBomb", effectdata)
										util.Effect("Explosion", effectdata)
										util.BlastDamage(ent, ply, ent:GetPos(), 250, 80)
										ent:Remove()
									end,
}
Krede_WD_HaxList["combine_mine"] = {
									name = "Combine Mine",
									cost = 1,
									offset = Vector(0,0,10),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										local effectdata = EffectData()
										effectdata:SetOrigin(ent:GetPos())
										util.Effect("HelicopterMegaBomb", effectdata)
										util.Effect("Explosion", effectdata)
										util.BlastDamage(ent, ply, ent:GetPos(), 200, 100)
										ent:Remove()
									end,
}
Krede_WD_HaxList["wac_hc_*"] = {
									name = "Helicopter",
									cost = 2,
									offset = Vector(0,0,50),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										local effectdata = EffectData()
										effectdata:SetOrigin(ent:GetPos()+Vector(0,0,50))
										util.Effect("HelicopterMegaBomb", effectdata)
										util.Effect("Explosion", effectdata)
										util.BlastDamage(ent, ply, ent:GetPos(), 300, 300)
									end,
}
Krede_WD_HaxList["npc_helicopter"] = {
									name = "Helicopter",
									cost = 2,
									offset = Vector(0,0,50),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										ent:Fire("SelfDestruct")
									end,
}
Krede_WD_HaxList["npc_citizen"] = {
									name = "Citizen",
									cost = 0,
									offset = Vector(0,0,70),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										if IsValid(ent:GetNWEntity("Hacker")) then
											ent:SetNWEntity("Hacker", NULL)
										else
											ent:SetNWEntity("Hacker", ply)
										end
									end,
}
Krede_WD_HaxList["ent_jack_turret_*"] = {
									name = "Turret",
									cost = 1,
									offset = Vector(0,0,40),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										ent:HardShutDown()
									end,
}
Krede_WD_HaxList["gmod_cameraprop"] = {
									name = "Security Camera",
									cost = 0,
									offset = Vector(0,0,2),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										ply:SetViewEntity( ent )
										ply:GetActiveWeapon():SetNWBool("Camera", true)
									end,
}
Krede_WD_HaxList["gmod_button"] = {
									name = "Button",
									cost = 0,
									offset = Vector(0,0,5),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										ent:Toggle( !ent:GetOn(), ply )
									end,
}
Krede_WD_HaxList["gmod_wire_button"] = {
									name = "Button",
									cost = 0,
									offset = Vector(0,0,5),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										ent:Switch( !ent:GetOn() )
									end,
}
Krede_WD_HaxList["gmod_light"] = {
									name = "Button",
									cost = 0,
									offset = Vector(0,0,0),
									show = function(ent, ply)
										return false
									end,
									use = function(ent, ply, box)
										if box then
											ent:Toggle()
										end
									end,
}
Krede_WD_HaxList["func_button"] = {
									name = "Button",
									cost = 0,
									offset = Vector(0,0,5),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										ent:Input("Press",ply,ply)
									end,
}
Krede_WD_HaxList["sent_sakarias_car_*"] = {
									name = "SCar",
									cost = 0,
									offset = Vector(0,0,40),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										if ent.CarIsLocked then
											ent.CarIsLocked = false
											ent:EmitSound("car/CarUnLock.wav")
										else
											ent.CarIsLocked = true
											ent:EmitSound("car/CarLock.wav")
										end
									end,
}
Krede_WD_HaxList["gmod_dynamite"] = {
									name = "Dynamite",
									cost = 1,
									offset = Vector(0,0,10),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										ent:Explode( 0, ply )
										ent:Remove()
									end,
}
Krede_WD_HaxList["krede_wd_decoy_thrown"] = {
									name = "Decoy",
									cost = 0,
									offset = Vector(0,0,2),
									show = function(ent, ply)
										if !ent:GetNWBool("Useless") then return true end
									end,
									use = function(ent, ply)
										ent:Attract()
									end,
}
Krede_WD_HaxList["krede_wd_ctos_box"] = {
									name = "ctOS-Box",
									cost = 0,
									offset = Vector(0,0,10),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										ent:Start(ply)
									end,
}
Krede_WD_HaxList["keypad"] = {
									name = "Keypad",
									cost = 2,
									offset = Vector(0,0,10),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										ent:Process(true)
									end,
}
Krede_WD_HaxList["keypad_wire"] = {
									name = "Keypad",
									cost = 2,
									offset = Vector(0,0,10),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										ent:Process(true)
									end,
}
Krede_WD_HaxList["prop_door"] = {
									name = "Door",
									cost = 1,
									offset = Vector(0,0,10),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										if ent:GetSaveTable( ).m_bLocked then
											ent:Fire("Unlock")
											ent:Fire("Open")
										else
											ent:Fire("Lock")
											ent:Fire("Close")
										end
									end,
}
Krede_WD_HaxList["prop_door_rotating"] = {
									name = "Door",
									cost = 1,
									offset = Vector(0,0,10),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										if ent:GetSaveTable( ).m_bLocked then
											ent:Fire("Unlock")
											ent:Fire("Open")
										else
											ent:Fire("Lock")
											ent:Fire("Close")
										end
									end,
}

Krede_WD_HaxList["keypad_pattern"] = {
									name = "KeypadPattern",
									cost = 2,
									offset = Vector(0,0,10),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
										ent:Process(true)
									end,
}

local reasons = {
	[1] = "Убийство",
	[2] = "Кража",
	[3] = "Нелегальное оружие",
	[4] = "ERROR",
	[5] = "&SERROR*#"
}

Krede_WD_HaxList["player"] = {
									name = "Player",
									cost = 2,
									offset = Vector(0,0,70),
									show = function(ent, ply)
										if ent:Alive() and ent != ply then
											return true
										end
									end,
									use = function(ent, ply)
										if ent:Alive() then
											ent:wanted(ply, reasons[math.random(1,5)], 120)
										end
									end,
}

Krede_WD_HaxList["zhits_phone"] = {
									name = "Exploit Phone",
									cost = 4,
									offset = Vector(0,0,70),
									show = function(ent, ply)
										return true
									end,
									use = function(ent, ply)
									    for k,v in pairs(player.GetAll()) do
    									    if v:GetPos():Distance(ent:GetPos()) < 250 then
                                          		local getpos = v:GetPos()
                                          		local data = EffectData()
                                          		data:SetOrigin(getpos + Vector(0, 0, 60))
                                          		data:SetScale(5)
                                          		ent:EmitSound('ambient/energy/zap'..math.random(1,9)..'.wav')
                                          		util.BlastDamage(v,ply,getpos,150,30)
                                            	util.Effect("Sparks", data)
                                    	    end
                                	    end
									end,
}

if GetConVar("wd_adminonly") == nil then
	CreateConVar("wd_adminonly", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Should watch_phone be admin only? 0 = all users, 1 = admin only")
	print("Watch_Phone Admin Convar created")
end
if GetConVar("wd_allowblackout") == nil then
	CreateConVar("wd_allowblackout", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Should blackout be available to users? 0 = admin only, 1 = all users")
	print("Watch_Phone Blackout Convar created")
end
if GetConVar("wd_needbattery") == nil then
	CreateConVar("wd_needbattery", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Should users need battery when hacking? 0 = no, 1 = yes")
	print("Watch_Phone Battery Convar created")
end