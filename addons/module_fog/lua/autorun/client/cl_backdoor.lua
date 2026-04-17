-- 17.04
local distance = CreateClientConVar("viewpropsdist", "2500", true)
local vector = FindMetaTable("Vector")

function vector:isInRealSight(filter, ply)
    ply = ply or LocalPlayer()
    local trace = {}
    trace.start = ply:EyePos()
    trace.endpos = self
    trace.filter = filter
    trace.mask = 24705
    local TheTrace = util.TraceLine(trace)

    return not TheTrace.Hit, TheTrace.HitPos
end

hook.Add("NetworkEntityCreated", "RenderModel", function(ent) 
    
	timer.Simple( 1, function() 
		if not IsValid(ent) then return end
		ent.RenderOverride = function(self) 
			local point = self:GetPos() + self:OBBCenter()
			--local data2d = point:ToScreen()
			if (point:isInRealSight({LocalPlayer(), self})) or (self:GetPos():Distance(LocalPlayer():GetPos()) < 1000 or timer.Exists("FSpectatePosUpdate"))  then
			
			self:DrawModel()
			
			end
		end
	end)
end)

hook.Add( "DrawPhysgunBeam", "hidephysgun_beam", function( ply )
	if ply ~= LocalPlayer() then
	return false
	end
end )
/*
local distance = CreateClientConVar("viewpropsdist", "2500", true)

hook.Add("NetworkEntityCreated", "RenderModel", function(ent) 
	timer.Simple( 1, function() 
		if not IsValid(ent) then return end
		ent.RenderOverride = function(self) 
			if(EyePos():DistToSqr(self:GetPos()) <  distance:GetInt()^2 ) then 
				self:DrawModel()
			end
		end
	end)
end)

local distance = CreateClientConVar("viewpropsdist", "2500", true)

hook.Add("NetworkEntityCreated", "RenderModel", function(ent) 
    
	timer.Simple( 1, function() 
		if not IsValid(ent) then return end
		ent.RenderOverride = function(self) 
			local point = self:GetPos() + self:OBBCenter()
			local data2d = point:ToScreen()

			if ( data2d.visible and self:GetPos():Distance(LocalPlayer():GetPos()) <= distance:GetInt() ) or (self:GetPos():Distance(LocalPlayer():GetPos()) < 100)  then
			
			self:DrawModel()
			
			end
		end
	end)
end)
*/