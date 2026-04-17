-- t.me/urbanichka
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

SWEP.Weight = 5
SWEP.AutoSwitchTo    = false
SWEP.AutoSwitchFrom    = false

local flags = {FCVAR_REPLICATED, FCVAR_ARCHIVE}
CreateConVar("climbswep2_necksnaps", "0", flags)
CreateConVar("climbswep2_wallrun_minheight", "250", flags)
CreateConVar("climbswep2_roll_allweps", "0", flags)
CreateConVar("climbswep2_slide_allweps", "0", flags)
CreateConVar("climbswep2_maxjumps", "5", flags)

local function GetWeaponClass(ply)
    if not IsValid(ply) or not IsValid(ply:GetActiveWeapon()) then return "" end
    return ply:GetActiveWeapon():GetClass()
end
hook.Add("OnPlayerHitGround", "ClimbRoll", function(ply, inWater, idc, fallSpeed)
    if not IsValid(ply) or ply:Health() <= 0 then return end
	if (GetWeaponClass(ply) == "climb_swep2" or GetConVarNumber("climbswep2_roll_allweps") > 0) and not ply:GetNWBool("ClimbFalling") and not inWater and fallSpeed > 300 and ply:Crouching() then
		ply:EmitSound("physics/cardboard/cardboard_box_break1.wav", 100, 100)
		ply:SetVelocity(ply:GetVelocity() + ply:GetForward() *  (100 + fallSpeed))
	end
end)
hook.Add("PlayerSpawn", "ClimbPlayerSpawn", function(ply)
    ply.ClimbLastVel = Vector(0, 0, 0)
	ply:SetNWBool("ClimbSlide", false)
	ply.ClimbSlideSound = CreateSound(ply, Sound("physics/body/body_medium_scrape_smooth_loop1.wav"))
end)