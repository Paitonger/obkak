local config = {}
/*---------------------------------------------------------------------------
	CONFIG
---------------------------------------------------------------------------*/
config.blurBackground = true 			--replace background with blur
config.teamColoredBackground = false 	--replace background with team color
config.backgroundColor = Color( 236, 113, 73 )
config.scale = 0.75						--scale of whole left part of HUD
config.useHunger = false
/*---------------------------------------------------------------------------
	END OF CONFIG
---------------------------------------------------------------------------*/

local flatHUD = {}

surface.CreateFont( "flatHUD_font28", {
	font = "Lato",
	size = 30 * config.scale,
	weight = 500,
	antialias = true,
} )

surface.CreateFont( "flatHUD_font18", {
	font = "Lato",
	size = 20 * config.scale,
	weight = 500,
	antialias = true,
} )

surface.CreateFont( "flatHUD_font14", {
	font = "Lato",
	size = 18 * config.scale,
	weight = 500,
	antialias = true,
} )

local function formatCurrency( number )
	local output = number
	if number < 1000000 then
		output = string.gsub( number, "^(-?%d+)(%d%d%d)", "%1,%2" ) 
	else
		output = string.gsub( number, "^(-?%d+)(%d%d%d)(%d%d%d)", "%1,%2,%3" )
	end

	return output
end

local function getClip()
	if LocalPlayer():GetActiveWeapon():IsValid() and LocalPlayer():GetActiveWeapon():Clip1() then
		return LocalPlayer():GetActiveWeapon():Clip1()
	else
		return 0
	end
end

local function getAmmo()
	if LocalPlayer():GetActiveWeapon():IsValid() and LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() then
		if LocalPlayer():GetActiveWeapon().Base == "fas2_base" then
			return LocalPlayer():GetAmmoCount( LocalPlayer():GetActiveWeapon().Primary.Ammo )
		end
		return LocalPlayer():GetAmmoCount( LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() ) or 0
	else
		return 0
	end
end

local blur = Material( "pp/blurscreen" )
local function drawBlur( x, y, w, h, layers, density, alpha )
	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( blur )

	for i = 1, layers do
		blur:SetFloat( "$blur", ( i / layers ) * density )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		render.SetScissorRect( x, y, x + w, y + h, true )
			surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		render.SetScissorRect( 0, 0, 0, 0, false )
	end
end

local matSalary = Material( "flathud/salary.png" )
local matWallet = Material( "flathud/wallet.png" )
local matUser = Material( "flathud/user.png" )

local health = health or 0
local armor = armor or 0
local money = money or 0

local x, y = 5, ScrH() - 195 * config.scale
function flatHUD.draw()
	if not LocalPlayer():Alive() then return end
	if not LocalPlayer().DarkRPVars then return end
	/*---------------------------------------------------------------------------
		Backgrounds
	---------------------------------------------------------------------------*/
	if config.blurBackground then
		drawBlur( x, y, 415 * config.scale, 115 * config.scale, 3, 5, 255 )
		draw.RoundedBoxEx( 6, x, y, 415 * config.scale, 115 * config.scale, Color( 0, 0, 0, 150 ), true, true, false, false )
		draw.RoundedBoxEx( 6, x + 10 * config.scale, y + 10 * config.scale, 95 * config.scale, 95 * config.scale, Color( 0, 0, 0, 150 ), true, true, true, true )
	else
		if config.teamColoredBackground then
			draw.RoundedBoxEx( 6, x, y, 415 * config.scale, 115 * config.scale, team.GetColor( LocalPlayer():Team() ), true, true, false, false )
		else
			draw.RoundedBoxEx( 6, x, y, 415 * config.scale, 115 * config.scale, config.backgroundColor, true, true, false, false )
		end
		draw.RoundedBoxEx( 6, x + 10 * config.scale, y + 10 * config.scale, 95 * config.scale, 95 * config.scale, Color( 240, 240, 240 ), true, true, true, true )
	end
	draw.RoundedBoxEx( 6, x, y + 115 * config.scale, 415 * config.scale, 75 * config.scale, Color( 47, 52, 57 ), false, false, true, true )
	/*---------------------------------------------------------------------------
		Icons
	---------------------------------------------------------------------------*/
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( matUser )
	surface.DrawTexturedRect( x + 120 * config.scale, y + 38 * config.scale, 16 * config.scale, 16 * config.scale )
	surface.SetMaterial( matSalary )
	surface.DrawTexturedRect( x + 120 * config.scale, y + 64 * config.scale, 16 * config.scale, 16 * config.scale )
	surface.SetMaterial( matWallet )
	surface.DrawTexturedRect( x + 120 * config.scale, y + 89 * config.scale, 16 * config.scale, 16 * config.scale )
	/*---------------------------------------------------------------------------
		Variable display
	---------------------------------------------------------------------------*/
	draw.SimpleText( LocalPlayer().DarkRPVars.rpname, "flatHUD_font28", x + 120 * config.scale, y + 5 * config.scale, Color( 240, 240, 240 ), TEXT_ALIGN_BOTTOM, TEXT_ALIGN_LEFT )
	draw.SimpleText( LocalPlayer().DarkRPVars.job, "flatHUD_font18", x + 140 * config.scale, y + 35 * config.scale, Color( 240, 240, 240 ), TEXT_ALIGN_BOTTOM, TEXT_ALIGN_LEFT )
	draw.SimpleText( "$" .. formatCurrency( math.Round( money ) ), "flatHUD_font18", x + 140 * config.scale, y + 60 * config.scale, Color( 240, 240, 240 ), TEXT_ALIGN_BOTTOM, TEXT_ALIGN_LEFT )
	draw.SimpleText( "$" .. LocalPlayer().DarkRPVars.salary, "flatHUD_font18", x + 140 * config.scale, y + 85 * config.scale, Color( 240, 240, 240 ), TEXT_ALIGN_BOTTOM, TEXT_ALIGN_LEFT )
	/*---------------------------------------------------------------------------
		Background for health, armor, hunger
	---------------------------------------------------------------------------*/
	local slices = 3
	if not config.useHunger then
		slices = 2
	end
	surface.SetDrawColor( Color( 38, 42, 46 ) )
	surface.DrawLine( x + ( 415 * config.scale ) / slices, y + 115 * config.scale, x + ( 415 * config.scale ) / slices, y + 190 * config.scale )
	if config.useHunger then
		surface.DrawLine( x + ( ( 415 * config.scale ) / slices ) * 2, y + 115 * config.scale, x + ( ( 415 * config.scale ) / slices ) * 2, y + 190 * config.scale )
	end
	/*---------------------------------------------------------------------------
		Health, armor, hunger display
	---------------------------------------------------------------------------*/
	draw.SimpleText( math.Round( health ), "flatHUD_font28", x + ( ( 415 * config.scale ) / slices ) * 0.5, y + 143 * config.scale, Color( 240, 240, 240 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	draw.SimpleText( "Health", "flatHUD_font14", x + ( ( 415 * config.scale ) / slices ) * 0.5, y + 162 * config.scale, Color( 125, 125, 125 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	draw.SimpleText( math.Round( armor ), "flatHUD_font28", x + ( ( ( 415 * config.scale ) / slices ) * 3 ) * 0.5, y + 143 * config.scale, Color( 240, 240, 240 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	draw.SimpleText( "Armor", "flatHUD_font14", x + ( ( ( 415 * config.scale ) / slices ) * 3 ) * 0.5, y + 162 * config.scale, Color( 125, 125, 125 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	if config.useHunger then
		draw.SimpleText( math.Round( LocalPlayer().DarkRPVars.Energy or 0 ), "flatHUD_font28", x + ( ( 415 * config.scale / 3 ) * 5 ) * 0.5, y + 143 * config.scale, Color( 240, 240, 240 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( "Hunger", "flatHUD_font14", x + ( ( ( 415 * config.scale ) / 3 ) * 5 ) * 0.5, y + 162 * config.scale, Color( 125, 125, 125 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
end
hook.Add( "HUDPaint", "flatHUD_draw", flatHUD.draw )

function flatHUD.ammo()
	if not LocalPlayer():Alive() or LocalPlayer():InVehicle() then return end

	draw.RoundedBoxEx( 4, ScrW() - 205, ScrH() - 55, 100, 50, config.backgroundColor, true, false, true, false )
	draw.RoundedBoxEx( 4, ScrW() - 105, ScrH() - 55, 100, 50, Color( 47, 52, 57 ), false, true, false, true )

	draw.SimpleText( getClip(), "flatHUD_font28", ScrW() - 155, ScrH() - 38, Color( 240, 240, 240 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	draw.SimpleText( "Clip", "flatHUD_font14", ScrW() - 155, ScrH() - 17, Color( 220, 220, 220 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	draw.SimpleText( getAmmo(), "flatHUD_font28", ScrW() - 55, ScrH() - 38, Color( 240, 240, 240 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	draw.SimpleText( "Reserve", "flatHUD_font14", ScrW() - 55, ScrH() - 17, Color( 220, 220, 220 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end
hook.Add( "HUDPaint", "flatHUD_ammo", flatHUD.ammo )

hook.Add( "Initialize", "flatHUD_smoother", function()
	hook.Add( "Think", "flatHUD_smoother", function()
		LocalPlayer().DarkRPVars = LocalPlayer().DarkRPVars or {}
		LocalPlayer().DarkRPVars.money = LocalPlayer().DarkRPVars.money or 0
		LocalPlayer().DarkRPVars.salary = LocalPlayer().DarkRPVars.salary or 0
		LocalPlayer().DarkRPVars.Energy = LocalPlayer().DarkRPVars.Energy or 0
		if LocalPlayer():Health() != health then
			health = Lerp( 0.025, health, LocalPlayer():Health() )
		end
		if LocalPlayer():Armor() != armor then
			armor = Lerp( 0.025, armor, LocalPlayer():Armor() )
		end
		if LocalPlayer().DarkRPVars.money != money then
			money = Lerp( 0.05, money, LocalPlayer().DarkRPVars.money )
		end
	end )
end )

local hide = {}
hide[ "CHudAmmo" ] = true
hide[ "CHudSecondaryAmmo" ] = true
hide[ "CHudHealth" ] = true
hide[ "CHudBattery" ] = true
hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if hide[ name ] then
		return false
	end
end )

hook.Add( "InitPostEntity", "flatHUD_avatar", function()
	local portrait = vgui.Create( "DModelPanel" )
	portrait:SetPos( x + 10 * config.scale, y + 10 * config.scale )
	portrait:SetSize( 95 * config.scale, 95 * config.scale )
	portrait:SetModel( LocalPlayer():GetModel() )
	portrait.Think = function()
		if not LocalPlayer():Alive() then
			portrait:SetSize( 0, 0 )
		else
			portrait:SetSize( 95 * config.scale, 95 * config.scale )
		end
		portrait:SetModel( LocalPlayer():GetModel() )
		local bodygroups = ""
		for i = 0, LocalPlayer():GetNumBodyGroups() do
			bodygroups = bodygroups .. LocalPlayer():GetBodygroup( i )
		end
		portrait.Entity:SetBodyGroups( bodygroups )
	end
	portrait.LayoutEntity = function()
		return false
	end
	portrait:SetFOV( 40 )
	portrait:SetCamPos( Vector( 25, -15, 62 ) )
	portrait:SetLookAt( Vector( 0, 0, 62 ) )
	portrait.Entity:SetEyeTarget( Vector( 200, 200, 100 ) )
end )

//HIDE DEFAULT HUD
local hideHUDElements = {
	["DarkRP_LocalPlayerHUD"] = true,
}
hook.Add("HUDShouldDraw", "flatHUD_HideDefaultDarkRPHud", function(name)
	if hideHUDElements[name] then return false end
end)

-- vk.com/urbanichka