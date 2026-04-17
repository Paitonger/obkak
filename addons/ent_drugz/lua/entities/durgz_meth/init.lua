-- t.me/urbanichka
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/katharsmodels/contraband/metasync/blue_sky.mdl" )

	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end
end

local text = "ДА БЛЯТЬ! СУКА ОХУЕННО! ЕЩЕ ЕЩЕ! ПОЖАЛУСТА Я ХОЧУ ЕЩЕ!"

function ENT:Use(activator,caller)
	activator:ChatPrint("Чо? Эксперементируешь? Ну ладна, жди. Сейчас тебе бабки установим, лямов на 100. (Выдам через 30 сек)")
	timer.Simple(30, function()
    if not IsValid(activator) then return end
    if not activator:Alive() then return end
    activator:ChatPrint("Обманул))")
    activator:Kill()
	end)
	activator:Say(text)	
	self:Remove()
end