-- 17.04
hook.Add('Think', 'taunts_start', function()
hook.Remove('Think', 'taunts_start')
if SERVER then
	hook.Add('PlayerShouldTaunt', 'default_taunts', function(ply, actid)
    	return true
	end)
end
end)