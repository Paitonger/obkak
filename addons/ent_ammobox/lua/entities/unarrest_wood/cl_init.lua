-- 17.04
include("shared.lua")

function ENT:Draw()
    if LocalPlayer():GetPos():Distance(self:GetPos()) > 150 then return end
    self:DrawModel()
    
    local ang = self:GetAngles()
    local pos = LocalToWorld(Vector(19, 1, 7), Angle(0, 90, 90), self:GetPos(), self:GetAngles())

    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Right(), 180)

    cam.Start3D2D(pos, ang, 0.1) 
        draw.RoundedBox( 0,0,0,380,150, Color( 43, 49, 54, 255 ) ) -- Color( 43, 49, 54, 255 ) 
        draw.RoundedBox(0,0,0,380,28,Color(236, 113, 71, 255)) -- Color(236, 113, 71, 255)
        surface.SetDrawColor( 150, 150, 150, 100 )
        surface.SetMaterial( Material('data/wimages/wlogo.png') ) 
        surface.DrawTexturedRect( 140, 35, 100, 100 )    
        surface.SetDrawColor( Color(77, 75, 77 , 255) )
        surface.DrawOutlinedRect( 0,0,380,150 )
        draw.SimpleText( " Досрочное освобождение", "Trebuchet24", 0, 15, Color( 255, 255, 255, 255 ), 0, 1 )
        draw.SimpleText( " 350.000$", "Trebuchet48", 100, 85, Color( 255, 255, 255, 255 ), 0, 1 )
        draw.SimpleText( " Нажми Е для взаимодействия", "Trebuchet18", 85, 130, Color( 255, 255, 255, 255 ), 0, 1 )
        
    cam.End3D2D()
end

concommand.Add('unarrest_sell', function()
    local frame = vgui.Create('DFrame')
    frame:SetSize(ScrW() / 6, ScrH() / 8)
    frame:Center()
    frame:MakePopup()
    frame:SetTitle('Досрочное освобождение')
    frame.Paint = function()
    	draw.RoundedBox(0,0,0,frame:GetWide(), frame:GetTall(),Color(54,57,62,255))	
    end
    
    local cancel = vgui.Create('DButton', frame)
    cancel:Dock(BOTTOM)
    cancel:SetText('Отмена')
    cancel:SetIcon('icon16/cancel.png')
    cancel.DoClick = function()
    	frame:Close()
    end
    
    
    local accept = vgui.Create('DButton', frame)
    accept:Dock(BOTTOM)
    accept:SetText('Оплатить')
    accept:SetIcon('icon16/accept.png')
    accept.DoClick = function()
        if not LocalPlayer():getDarkRPVar("Arrested") then 
            notification.AddLegacy( "Ты не арестован", NOTIFY_ERROR, 2 )
            surface.PlaySound( "buttons/button15.wav" ) 
            frame:Close()
            return
        end
    	frame:Close()
    	net.Start('sell_unarrest')
    	net.SendToServer()
    end
    
    local form = vgui.Create('DPanel', frame)
    form:Dock(TOP)
    form:SetBackgroundColor( Color(47,49,54,255))
    
    local text = vgui.Create('DLabel', form)
    text:Dock(FILL)
    text:SetText('  Выйти из тюрьмы досрочно за 350.000$') 
end)