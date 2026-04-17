-- 17.04
AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Чекер кошелька"
	SWEP.Slot = 1
	SWEP.SlotPos = 9
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Instructions = "ЛКМ для проверки кошелька"

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "Запрещено"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
	self:SetHoldType("normal")
end

function SWEP:Deploy()
	return true
end

function SWEP:DrawWorldModel() end

function SWEP:PreDrawViewModel(vm)
	return true
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 0.4)

	self:GetOwner():LagCompensation(true)
	local trace = self:GetOwner():GetEyeTrace()
	self:GetOwner():LagCompensation(false)

	if not IsValid(trace.Entity) or not trace.Entity:IsPlayer() or trace.Entity:GetPos():Distance(self:GetOwner():GetPos()) > 100 then
		return
	end

	self:EmitSound("npc/combine_soldier/gear5.wav", 50, 100)

	if SERVER or not IsFirstTimePredicted() then return end

	local result = trace.Entity:getDarkRPVar("money")

	if result <= 300 then
		self:GetOwner():ChatPrint("Этот чел бомж. Побей его и отпусти. Убивать нельзя")
	else
		self:GetOwner():ChatPrint("У "..trace.Entity:Nick().." "..DarkRP.formatMoney(result).." валюты")
	end
end
