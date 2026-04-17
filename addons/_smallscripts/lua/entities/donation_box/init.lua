-- t.me/urbanichka
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
if SERVER then
function ENT:Initialize()
   if CLIENT then return end
   self:SetModel("models/props/CS_militia/footlocker01_open.mdl")
   self:PhysicsInit(SOLID_VPHYSICS)
   self:SetMoveType(MOVETYPE_VPHYSICS)
   self:SetSolid(SOLID_VPHYSICS)
   self:SetUseType(SIMPLE_USE)

   local phys = self:GetPhysicsObject()

   if phys:IsValid() then
   	  
      phys:Wake()

   end
end

function ENT:Think()
   if not IsValid(self:Getowning_ent()) then
      self:Remove()
   end
end

function ENT:Use( activator, caller )
   local MValue = self:GetMoney()
   local fixedValue = DarkRP.formatMoney(self:GetMoney())
   if caller == self:Getowning_ent() and MValue > 0 and IsValid( caller ) and caller:IsPlayer() then
      caller:addMoney(MValue)
      self:SetMoney("0")
      DarkRP.notify(caller, 0, 3, "Ты собрал  "..fixedValue.." из сундука")
   elseif caller == self:Getowning_ent() and MValue == 0 and IsValid( caller ) and caller:IsPlayer() then
      DarkRP.notify(caller, 1, 3, "Сундук пустой" )
   else
      if caller:canAfford(5000) then
         caller:addMoney(-5000)
         self:SetMoney(self:GetMoney() + 5000)
         DarkRP.notify(caller, 1, 3, "Ты пожертвовал 5000$ для "..self:Getowning_ent():Nick() )
      end
   end
end


hook.Add('Think', 'sykarunblyad', function()
hook.Remove('Think', 'sykarunblyad')

hook.Add( "PhysgunPickup", "donationbboxpick", function( ply, ent )
   if ent:GetClass() == "donation_box" and ply == ent:Getowning_ent() then
      APG.entGhost( ent, true, false )
      return true
   end
end)

end)

end