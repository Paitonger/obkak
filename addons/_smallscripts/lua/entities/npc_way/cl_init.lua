-- t.me/urbanichka
include('shared.lua')

function ENT:Draw()
   self:DrawModel()
   
    if LocalPlayer():GetPos():Distance(self:GetPos()) > 300 then return end

    local leng = self:GetPos():Distance(EyePos())
    local clam = math.Clamp(leng, 0, 255 )
    local main = (255 - clam)
    local ang = LocalPlayer():EyeAngles()
    local pos = self:GetPos() + Vector(0,0,self:OBBMaxs().z + 15)

    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Right(), 90)

    cam.Start3D2D(pos, Angle(ang.x, ang.y, ang.z), 0.15)
      draw.RoundedBox(0,-130,10,260,60,Color(236, 113, 71, 70 + main))
      draw.RoundedBox( 0,-130,10,260,28, Color( 43, 49, 54, 200 + main ) )
      surface.SetDrawColor( 150, 150, 150, 70 + main )
      surface.SetMaterial( Material('data/wimages/wlogo.png') ) 
      surface.DrawTexturedRect( -125, 13, 23, 23 )  
      draw.SimpleText( " WayZer's Role Play", "Trebuchet24", -103, 23, Color( 255, 255, 255, 70 + main ), 0, 1 )
      draw.SimpleText( 'Проводник', "Trebuchet24", -120, 51, Color( 255, 255, 255, 70 + main ), 0, 1 )
      surface.SetDrawColor( Color(77, 75, 77 , 70 + main) )
      surface.DrawOutlinedRect( -130,10,260,60 )
    cam.End3D2D()
end

net.Receive( "derma", function()
    local servers = {
    	[1] = {'Riverton', '46.174.54.203:27015', 'Весь твой прогресс уже там!'},
    	[2] = {'Carlin', '37.230.228.180:27015', 'Для слабых ПК!'},
    	[3] = {'Brooks', '62.122.213.48:27015', 'Даунтаун с машинами!'},
    	[4] = {'Rockford', '46.174.49.242:27015', 'Рокфорд, все другое!'},
    }
    
    
    local main = vgui.Create('DFrame')
    main:SetSize(ScrW() / 4, ScrH() / 2)
    main:Center()
    main:MakePopup()
    main:SetTitle('Наши сервера!')
    main.Paint = function()
    	draw.RoundedBox(0,0,0,main:GetWide(), main:GetTall(), Color(54,57,62,255))	
    	draw.RoundedBox(0,0,0,main:GetWide(), main:GetTall() / 100 * 4.5, Color(236,113,71,255))
    end
    
    for i=1,4 do
    local box = vgui.Create('DPanel', main)
    box:Dock(TOP)
    box:DockMargin(0,5,0,5)
    box:SetTall(main:GetTall()/6)
    box.Paint = function()
    	draw.RoundedBox(5,0,0,box:GetWide(), box:GetTall(), Color(43,49,54,255))	
    	draw.SimpleText("WayZer's Role Play | "..servers[i][1], 'Trebuchet24', box:GetWide() / 2,0, Color(255,255,255,255), TEXT_ALIGN_CENTER)
    	draw.SimpleText("IP: "..servers[i][2], 'Trebuchet18', box:GetWide() / 4, box:GetTall() / 3, Color(255,255,255,255), TEXT_ALIGN_LEFT)
    	draw.SimpleText(servers[i][3], 'Trebuchet18', box:GetWide() / 4, box:GetTall() / 1.5, Color(255,255,255,255), TEXT_ALIGN_LEFT)
    	draw.SimpleText("Статус: онлайн", 'Trebuchet18', box:GetWide() / 4, box:GetTall() / 2, Color(255,255,255,255), TEXT_ALIGN_LEFT)
    end
    
    local image = vgui.Create('DImage', box)
    image:SetPos(3,3)
    image:SetSize(85,85)
    image:SetImage('data/wimages/wlogo.png')
    
    local connect = vgui.Create('DButton', box)
    connect:SetText('Играть')
    connect:SetPos(main:GetWide() / 1.2, box:GetTall() / 2)
    connect.DoClick = function()
    	LocalPlayer():ConCommand('connect '..servers[i][2])
    end
    
    end
end)