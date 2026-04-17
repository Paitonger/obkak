-- t.me/urbanichka
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

util.AddNetworkString("sendMenu")
util.AddNetworkString("acceptSetting")

function ENT:Initialize()
  self:SetModel( "models/weapons/w_c4_planted.mdl" )
  self:PhysicsInit(SOLID_VPHYSICS)
  self:SetMoveType(MOVETYPE_VPHYSICS)
  self:SetSolid(SOLID_VPHYSICS)
  self:SetUseType(SIMPLE_USE)
  self:SetStartBomb(false)

  local phys = self.Entity:GetPhysicsObject()
  if (phys:IsValid()) then
      phys:Wake()
  end
end

function ENT:Use(activator,caller)
  if activator:IsPlayer() and activator:Team() == TEAM_BOMB then
  	net.Start("sendMenu")
  	 net.WriteEntity(self)
  	net.Send(activator)
  end
end

net.Receive("acceptSetting", function(len, ply)
  local bomb = net.ReadEntity()
  local time = net.ReadFloat()
  local freeze = net.ReadBool()

  if not IsValid(bomb) then return end
  if bomb:GetClass() ~= "ent_timebomb" then return end
  if ply:Team() ~= TEAM_BOMB then return end
  if time < 300 then return end
  
  if freeze then
  	bomb:SetMoveType(MOVETYPE_NONE)
  end
	
  ply:wanted(nil, 'АКТИВАЦИЯ БОМБЫ', time)
  bomb:SetNWFloat("ExplodeTime", time + CurTime())
  bomb:SetStartBomb(true)
  bomb:EmitSound("buttons/blip1.wav")
  
  DarkRP.notifyAll(0, 30, 'Террорист где-то запустил бомбу. Будьте осторожны!')
  
  for _, v in ipairs(player.GetAll()) do
    if v:isCP() then
        dMarkers.create(v, {title = "ТЕРРАКТ",text = "В этом месте была активирована бомба!",color = Color(200, 0, 0),icon = 'icon16/bomb.png',pos = bomb:GetPos(), time = time, type = 'police'}, 'npc/overwatch/radiovoice/riot404.wav')
    end
  end

  timer.Simple(time, function()
  	if IsValid(bomb) then
  		local getpos = bomb:GetPos()
  		local data = EffectData()
  		data:SetOrigin(getpos)
  		util.BlastDamage(ply,bomb,getpos,750,750)
    	util.Effect("Explosion", data)

    	bomb:Remove()
  	end
  end)

end)