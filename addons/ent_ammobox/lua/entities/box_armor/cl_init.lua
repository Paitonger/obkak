-- 17.04
include("shared.lua")

function ENT:Draw()

	self:DrawModel()

	if self:GetPos():Distance(EyePos()) > 400 then return end
	
	local pos, ang = LocalToWorld(Vector(16, -15, 30), Angle(0, 90, 90), self:GetPos(), self:GetAngles())
	
	cam.Start3D2D(pos, ang, 0.3)	

	draw.RoundedBox(4,-3,-9,100,20,Color(50,50,50))
	draw.SimpleText("Снаряжение", "Trebuchet18", 0, 0, Color(255,255,255),0,1) 

	cam.End3D2D()	
end