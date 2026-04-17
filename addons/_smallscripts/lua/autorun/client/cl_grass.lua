-- t.me/urbanichka
hook.Add("Think", "grassss", function()
	hook.Remove("Think", "grassss")

--	local mat = Material("maps/rp_bangclaw_test22222/nature/blendsandgrass008a_wvt_patch")
--	mat:SetTexture("$basetexture", "nature/grassfloor002a")
--	local mat = Material("nature/blendrocksand008d")
--	mat:SetTexture("$basetexture", "nature/grassfloor002a")

	local mat = nil
	
    RunConsoleCommand("chat_pm_disable", 1)

	timer.Create('check_flashlight', 1, 0, function()
		if LocalPlayer():FlashlightIsOn() and GetConVarNumber('r_shadows') == 0 then
			LocalPlayer():ConCommand('r_shadows 1')
		elseif not LocalPlayer():FlashlightIsOn() and GetConVarNumber('r_shadows') == 1 then
			LocalPlayer():ConCommand('r_shadows 0')
		end
		
        LocalPlayer():ConCommand('chat_pm_disable 1')
	end )
end)

hook.Add("InitPostEntity", "RateState", function()
    hook.Remove("InitPostEntity", "RateState")
    
    local localplayer = LocalPlayer()

    local interp = engine.TickInterval()
    local interp_min = interp
    local interp_max = interp * 6

    localplayer:ConCommand("cl_cmdrate " .. 1 / interp)
    localplayer:ConCommand("cl_updaterate " .. 1 / interp)
    localplayer:ConCommand("cl_interp_ratio 0")
    localplayer:ConCommand("rate 2097152")

    hook.Add("Tick", "dynlerp", function()
        local sv = engine.ServerFrameTime()
        interp = Lerp(.01, interp, math.Clamp(sv, interp_min, interp_max) + 0.100)
        localplayer:ConCommand("cl_interp " .. interp)
    end)
    
end)

-- NEW YEAR

local mats = {
    ['maps/rp_bangclaw_test22222/concrete/concretefloor033k_c17_3224_-2651_560'] = 0,
    ['maps/rp_bangclaw_test22222/concrete/concretefloor033o_3224_-2651_560'] = 0,
    ['building_template/roof_template001a'] = 0,
    ['maps/rp_bangclaw_test22222/metal/metalroof008a_3224_-2651_560'] = 0,
    ['tile/infroofb'] = 0,
    ['concrete/concretefloor023a'] = 0,
    ['maps/rp_bangclaw_test22222/concrete/concretefloor033a_3224_-2651_560'] = 0,
    ['nature/blenddirtgrass006a'] = 0,
    ['cs_italy/tileroof01'] = 0,
    ['maps/rp_bangclaw_test22222/metal/metalroof006a_3224_-2651_560'] = 0,
    ['props/tarpaperroof002a'] = 0,
    ['nature/grassfloor002a'] = 0,
    ['maps/rp_bangclaw_test22222/nature/blendsandsand008a_wvt_patch'] = 0,
    ['maps/rp_bangclaw_test22222/metal/metalroof004a_3208_509_-488'] = 0,
    ['maps/rp_bangclaw_test22222/metal/metalroof004a_3224_-2651_560'] = 0,
    ['maps/rp_bangclaw_test22222/metal/metalroof004a_1048_1799_-864'] = 0,
    ['maps/rp_bangclaw_test22222/concrete/concretefloor005a_3224_-2651_560'] = 0,
    ['concrete/concretewall001a'] = 0,
    ['concrete/concretefloor027a'] = 0,
    ['cs_havana/concretefloor011a'] = 0,
    ['maps/rp_bangclaw_test22222/concrete/concretefloor033k_c17_3208_509_-488'] = 0,
    ['concrete/concretefloor008a'] = 0,
    ['maps/rp_bangclaw_test22222/nature/blendsandgrass008a_wvt_patch'] = 0,
    ['concrete/concretefloor015a_c17'] = 0,
    ['metal/metalfloor007a'] = 0,
    ['concrete/concretefloor031a'] = 0,
    ['nature/blendrocksand008d'] = 0,
    ['maps/rp_bangclaw_test22222/metal/metalroof006a_3044_1624_-865'] = 0,

}

hook.Add("Think", "snow_run", function()

    for mat, mode in pairs(mats) do
        local mat = Material(mat)
        --mat:SetString('$surfaceprop', 'snow')
        mat:SetTexture('$basetexture', 'NATURE/SNOWFLOOR001A')
        if mat:GetTexture("$basetexture2") then -- hey maxmol :wink: wanna steal it?
            mat:SetTexture("$basetexture2","NATURE/SNOWFLOOR001A")
        end
        mat:SetVector('$color', Vector(0.5,0.5,0.5))
    end

    hook.Remove("Think", "snow_run")

end)

local snowmat = Material('nature/snowfloor001a')

local function setSnow(mat)
	Material(mat):SetTexture('$basetexture', snowmat:GetTexture('$basetexture'))
end

timer.Simple(5, function()
	setSnow('models/weapons/v_bugbait/bugbait_inside')
	setSnow('models/weapons/v_bugbait/bugbait_sheet')
	setSnow('models/weapons/w_bugbait/wbugbait_sheet')

	Material('decals/beersplash_subrect'):SetTexture('$basetexture', Material('decals/snow01'):GetTexture('$basetexture'))
end)