-- 17.04
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()

	self.Owner = self.Entity.Owner
	
	self.Usetime = CurTime() + 30
	self:EmitSound("npc/scanner/scanner_electric1.wav", 300, 100)
	for k,ent in pairs(ents.FindByClass("krede_wd_blackout_thrown")) do
		if ent.Owner == self.Owner and ent != self then
			ent:Remove()
		end
	end
end

function ENT:Think()
	if !self.Usetime then return false end
	if self.Usetime <= CurTime() then
		self:Remove()
		for i = 1, #player.GetAll() do
			player.GetAll()[i]:AllowFlashlight( true )
			player.GetAll()[i]:SetNWInt("CanHack", 2)
		end
		return false
	end
	for i = 1, #player.GetAll() do
		if player.GetAll()[i]:GetPos():Distance(self:GetPos()) > 3000 and !player.GetAll()[i].WDHackCoolDown then
			player.GetAll()[i]:AllowFlashlight( true )
			player.GetAll()[i]:SetNWInt("CanHack", 2)
		end
	end
	for k,ent in pairs(ents.FindInSphere(self:GetPos(), 3000)) do
		if ent != NULL then
			if ent:GetClass() == "gmod_light" then
				ent:SetOn( false )
			elseif ent:GetClass() == "gmod_lamp" then
				ent:Switch( false )
			elseif string.find(ent:GetClass(),"sent_sakarias_car_") then
				ent:TurnOffCar()
			elseif ent:IsPlayer() then
				ent:SetNWInt("CanHack", 1)
				if ent:GetActiveWeapon() != NULL and IsValid(ent:GetActiveWeapon()) and ent:GetActiveWeapon():GetClass() == "krede_wd_phone" then
					ent:GetActiveWeapon():Reload()
				end
				if ent:FlashlightIsOn() then
					ent:Flashlight( false )
				end
				if ent:CanUseFlashlight() then
					ent:AllowFlashlight( false )
				end
			end
		end
	end
end

function ENT:OnRemove()
	for i = 1, #player.GetAll() do
		player.GetAll()[i]:AllowFlashlight( true )
		player.GetAll()[i]:SetNWInt("CanHack", 2)
	end
end

/*---------------------------------------------------------
OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage( dmginfo )
end


/*---------------------------------------------------------
Use
---------------------------------------------------------*/
function ENT:Use( activator, caller, type, value )
	return false
end


/*---------------------------------------------------------
StartTouch
---------------------------------------------------------*/
function ENT:StartTouch( entity )
end


/*---------------------------------------------------------
EndTouch
---------------------------------------------------------*/
function ENT:EndTouch( entity )
end


/*---------------------------------------------------------
Touch
---------------------------------------------------------*/
function ENT:Touch( entity )
end