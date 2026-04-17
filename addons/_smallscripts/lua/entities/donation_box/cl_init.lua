-- 17.04
include("shared.lua")


function ENT:Draw()

   self:DrawModel()

   if self.Entity:GetPos():Distance(LocalPlayer():GetPos()) > 150 then return end

   local owner = self:Getowning_ent():Nick() --self:GetOwner():Nick() 
   local revalue = DarkRP.formatMoney(self:GetMoney())
   local MValue = self:GetMoney()
   local dx = Vector(-19,-10,30) -- position offset
   local da = Angle(0,90,75) -- angle offset
   local scale = 0.1 -- scale

   cam.Start3D2D(self:LocalToWorld(dx), self:LocalToWorldAngles(da), scale)
   
    draw.RoundedBox(0,-130,10,460,215,Color(236, 113, 71, 255))
    draw.RoundedBox( 0,-130,10,460,28, Color( 43, 49, 54, 255 ) )
    surface.SetDrawColor( Color(77, 75, 77 , 70) )
    surface.DrawOutlinedRect( -130,10,460,215 )
    draw.SimpleText( "Пожертвование для "..owner, "Trebuchet24", -125, 23, Color( 255, 255, 255, 255 ), 0, 1 )
    draw.SimpleText( 'Нажми E для внесения 5000$ в ящик', "Trebuchet24", 100, 180, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
    draw.SimpleText( "Собрано:", "Trebuchet48", 100, 50, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
    draw.SimpleText( revalue, "Trebuchet48", 100, 100, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
--   draw.SimpleText("Holding "..revalue,"HoboboxFont",0,-15,Color(255,255,255,255), 1,1)
--   draw.SimpleText(owner,"HoboboxFont",0,-50,Color(255,255,255,255), 1,1)

   cam.End3D2D()

end