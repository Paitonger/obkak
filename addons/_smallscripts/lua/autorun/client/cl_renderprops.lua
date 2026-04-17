-- t.me/urbanichka
hook.Add('Think', 'startrenderprops', function()
	timer.Create("setrenderprops", 10, 0, function()
		LocalPlayer():ConCommand("viewpropsdist "..globalFogDed)
	end)

	hook.Remove('Think', 'startrenderprops')
end)