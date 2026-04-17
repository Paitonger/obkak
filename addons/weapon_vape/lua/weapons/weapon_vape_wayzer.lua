-- t.me/urbanichka
-- weapon_vape_medicinal.lua
-- Defines a vape that heals the player

-- Vape SWEP by Swamp Onions - http://steamcommunity.com/id/swamponions/

if CLIENT then
	include('weapon_vape/cl_init.lua')
else
	include('weapon_vape/shared.lua')
end

SWEP.PrintName = "WayZer Vape"
SWEP.Category  = "Премиум"
SWEP.Instructions = "LMB: Rip Fat Clouds\n (Hold and release)\nRMB & Reload: Play Sounds\n\nThis healthy, organic juice has amazing healing abilities."

SWEP.VapeID = 2

SWEP.VapeAccentColor = Vector(255,255,255)
SWEP.VapeTankColor = Vector(255,0,0)

-- note: healing functionality is in weapon_vape/init.lua