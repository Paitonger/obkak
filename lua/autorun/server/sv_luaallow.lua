-- t.me/urbanichka
hook.Add("Think", "sv_allowcslua_start", function()

	RunConsoleCommand("sv_allowcslua", "0")
	
	hook.Remove("Think", "sv_allowcslua_start")

end)