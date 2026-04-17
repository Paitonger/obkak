-- t.me/urbanichka
-- weapon_vape_medicinal.lua
-- Defines a vape that heals the player

-- Vape SWEP by Swamp Onions - http://steamcommunity.com/id/swamponions/

if CLIENT then
	include('weapon_vape/cl_init.lua')
else
	include('weapon_vape/shared.lua')
end

SWEP.PrintName = "RyTra Vape"
SWEP.Category  = "Премиум"
SWEP.Instructions = "LMB: Rip Fat Clouds\n (Hold and release)\nRMB & Reload: Play Sounds\n\nThis healthy, organic juice has amazing healing abilities."

SWEP.VapeID = 11
local r = 127/200
local g = 254/200
local b = 255/200

SWEP.VapeAccentColor = Vector(r,g,b)
SWEP.VapeTankColor = Vector(r,g,b)

-- note: healing functionality is in weapon_vape/init.lua