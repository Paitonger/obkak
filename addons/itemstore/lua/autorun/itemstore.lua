hook.Add( "PostGamemodeLoaded", "ItemStoreInitialize", function()
	itemstore = {}

	if SERVER then
		include( "itemstore/sv_init.lua" )
	else
		include( "itemstore/cl_init.lua" )
	end
end )
--leak from smorganyu with love ❤
