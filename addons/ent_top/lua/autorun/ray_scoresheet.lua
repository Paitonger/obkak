-- t.me/urbanichka
scoresheet = scoresheet or {}
scoresheet.data = {}

function scoresheet:register( tab )
	for k,v in pairs( scoresheet.data ) do
		if ( v.UniqueID == tab.UniqueID ) then
			scoresheet.data[ k ] = nil
		end
	end
	
	scoresheet.data[ #scoresheet.data + 1 ] = tab
	
	scoresheet:setup( tab )
end

function scoresheet:setup( tab )
	local ENT = {}
	
	ENT.Type = "anim"
	ENT.Base = "score_base"
	ENT.PrintName = "Score - "..tab.Name
	ENT.Author = "RayChamp"
	ENT.Category = "Разрешено"
	ENT.Spawnable = true
	
	if ( SERVER ) then
		ENT.Fetch = tab.Fetch
	else
		ENT.DrawFunc = tab.Draw
		ENT.TitleName = tab.Name
		ENT.HeaderColor = tab.HeaderColor
	end
	
	scripted_ents.Register( ENT, tab.EntName )
end

local files, folders = file.Find( "scoresheet/sheets/*", "LUA" )

for k,v in pairs( folders ) do
	if ( SERVER ) then
		AddCSLuaFile( "scoresheet/sheets/"..v.."/config.lua" )
		AddCSLuaFile( "scoresheet/sheets/"..v.."/shared.lua" )
	end
	
	include( "scoresheet/sheets/"..v.."/config.lua" )
	include( "scoresheet/sheets/"..v.."/shared.lua" )
end