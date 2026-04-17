-- t.me/urbanichka
timer.Simple( .1, function()
	weapons.GetStored( 'gmod_tool' ).ShootSound = Sound( 'ambient/weather/rain_drip4.wav' )
	DarkRP.removeChatCommand("makeshipment")
end)

