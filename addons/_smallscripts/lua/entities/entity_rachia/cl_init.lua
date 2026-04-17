-- t.me/urbanichka
include("shared.lua")

function ENT:Draw()
	if self:GetPos():Distance(EyePos()) > 400 then return end
    self:DrawModel()
end
