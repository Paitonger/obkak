-- 17.04
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")



function ENT:Initialize()
	self:SetModel("models/items/ammocrate_smg1.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if phys:IsValid() then 
		phys:Wake()
	end
end

local ammo = {
  [1] = "pistol",
  [2] = "buckshot",
  [3] = "smg1",
}

function ENT:Use(activator)
    if activator:isCP() then
      for i = 1, 3 do
       activator:GiveAmmo(60,ammo[i],false)
      end
    else
        if activator:canAfford(6500) then
          for i = 1, 3 do
           activator:GiveAmmo(60,ammo[i],false)
          end
           DarkRP.notify(activator, 0, 3, 'Боеприпасы пополнены. Списано: 6500$')
           activator:addMoney(-6500)
        else
            DarkRP.notify(activator, 1, 3, 'Недостаточно средств')
        end
    end
end