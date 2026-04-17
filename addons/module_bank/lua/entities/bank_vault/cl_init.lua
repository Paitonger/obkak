-- 17.04
include('shared.lua')

surface.CreateFont('BankFont', {font = 'Coolvetica Rg', size = 100})
function ENT:Draw()
    self:DrawModel()

    if LocalPlayer():GetPos():DistToSqr(self:GetPos()) <= 360000 then --600^2
        if not self.DisplayText then
            self.DisplayText = {}
            self.DisplayText.Rotation = 0
            self.DisplayText.LastRotation = 0
        end

        local pos = self:GetPos() + self:GetForward() * 32
        local ang = self:GetAngles()
        local ang2 = self:GetAngles()
        local status = self:GetStatus()
        ang:RotateAroundAxis(ang:Forward(), 90)
        ang:RotateAroundAxis(ang:Right(), 270)

        cam.Start3D2D(pos, ang, 0.15) 
        --    draw.SimpleTextOutlined(DarkRP.formatMoney(self:GetReward()), 'BankFont', 0, -485, Color(20, 150, 20, 255), 1, 1, 5, color_black)
            draw.RoundedBox( 0,-195,-380,380,150, Color( 43, 49, 54, 255 ) ) -- Color( 43, 49, 54, 255 ) 
            draw.RoundedBox(0,-195,-380,380,28,Color(236, 113, 71, 255)) -- Color(236, 113, 71, 255)
            surface.SetDrawColor( 150, 150, 150, 100 )
            surface.SetMaterial( Material('data/wimages/wlogo.png') ) 
            surface.DrawTexturedRect( -50, -345, 100, 100 )    
            draw.SimpleText( " Хранилище Банка", "Trebuchet24", -195, -365, Color( 255, 255, 255, 255 ), 0, 1 )
            if status == 1 then
            draw.SimpleText( "Внутри: "..DarkRP.formatMoney(self:GetReward()), "Trebuchet24", -180, -330, Color( 255, 255, 255, 255 ), 0, 1 )
            draw.SimpleText( "До окончания ограбления: "..string.ToMinutesSeconds(math.Clamp(math.Round(self:GetNextAction() -CurTime()), 0, BANK_CONFIG.RobberyTime)), "Trebuchet24", -180, -300, Color( 255, 0, 0, 255 ), 0, 1)
            elseif status == 2 then
            draw.SimpleText( "Внутри: "..DarkRP.formatMoney(self:GetReward()), "Trebuchet24", -180, -330, Color( 255, 255, 255, 255 ), 0, 1 )
            draw.SimpleText( "Восстановление хранилища: "..string.ToMinutesSeconds(math.Clamp(math.Round(self:GetNextAction() -CurTime()), 0, BANK_CONFIG.CooldownTime)), "Trebuchet24", -180, -300, Color( 255, 0, 0, 255 ), 0, 1)
            else
            draw.SimpleText( DarkRP.formatMoney(self:GetReward()), "Trebuchet48", 0, -320, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
            draw.SimpleText( "Нажми E за криминальную профессию, чтобы начать ограбление", "Default", 0, -255, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
            end
            surface.SetDrawColor( Color(77, 75, 77 , 255) )
            surface.DrawOutlinedRect( -195,-380,380,150 )
        cam.End3D2D()
    end
end