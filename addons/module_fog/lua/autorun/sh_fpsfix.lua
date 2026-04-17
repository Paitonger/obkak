-- 17.04
globalFogDed = 3000

timer.Create( "fpsoptdix", 2, 0, function()  
	if #player.GetAll()>60 then
		globalFogDed = 2000
	elseif #player.GetAll()<60 then
		globalFogDed = 3000
	end
	if SERVER then 
		SetFpsFix(globalFogDed)
	end 
end )
