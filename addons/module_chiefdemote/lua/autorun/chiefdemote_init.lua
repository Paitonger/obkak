-- t.me/urbanichka
chiefDemote = {}

if SERVER then
	AddCSLuaFile('chiefdemote/cl_vgui.lua')
	AddCSLuaFile('chiefdemote/cl_actions.lua')
	AddCSLuaFile('chiefdemote/sh_config.lua')

	include('chiefdemote/sh_config.lua')
	include('chiefdemote/sv_init.lua')
else
	include('chiefdemote/sh_config.lua')
	include('chiefdemote/cl_actions.lua')
	include('chiefdemote/cl_vgui.lua')
end