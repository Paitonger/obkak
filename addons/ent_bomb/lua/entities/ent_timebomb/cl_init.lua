-- t.me/urbanichka
include("shared.lua")

net.Receive("sendMenu", function()
  local bomb = net.ReadEntity()

  if bomb:GetStartBomb() then 
    LocalPlayer():ChatPrint("Бомба запущена!") 
    return 
  end

  local frame = vgui.Create("DFrame")
  frame:SetSize(ScrW() / 6, ScrH() / 6)
  frame:SetTitle("Бомбук c:")
  frame:Center()
  frame:SetIcon("icon16/bomb.png")
  frame:MakePopup()
  frame:ShowCloseButton(false)
  frame.Paint = function()
    draw.RoundedBox(0,0,0,frame:GetWide(),frame:GetTall(),Color(54,57,62,255))  
  end
  
  local slider = vgui.Create("DNumSlider", frame)
  slider:Dock(TOP)
  slider:SetText("Время (сек)")
  slider:SetMinMax(300, 600)
  slider:SetValue(300)
  slider:SetDecimals(0)

  local check = vgui.Create("DCheckBoxLabel", frame)
  check:Dock(TOP)
  check:SetText("Заморозить бомбу")
  check:SetValue(false)

  local close = vgui.Create("DButton", frame)
  close:Dock(BOTTOM)
  close:SetText("Закрыть")
  close:SetIcon("icon16/cancel.png")
  close.DoClick = function()
    frame:Remove()
  end

  local save = vgui.Create("DButton", frame)
  save:Dock(BOTTOM)
  save:SetText("Применить и запустить")
  save:SetIcon("icon16/accept.png")
  save.DoClick = function()
    local time = slider:GetValue()
    local freeze = check:GetChecked()

    net.Start("acceptSetting")
      net.WriteEntity(bomb)
      net.WriteFloat(time)
      net.WriteBool(freeze)
    net.SendToServer()
    
    frame:Remove()
  end
end)



function ENT:Draw()
  local endTime = self:GetNWFloat("ExplodeTime") - CurTime()
  
  self:DrawModel()

  local pos = self:GetPos() + self:GetUp()*9 + self:GetForward()*4 + self:GetRight()*4.7
  local ang = self:GetAngles()
  
  ang:RotateAroundAxis(ang:Up(), -90)

  cam.Start3D2D(pos,ang, 0.1)
  if endTime <= 0 then
    draw.SimpleText("DISABLE", "Default", 0,0,Color(0,255,0,255), TEXT_ALIGN_CENTER)
  else
    draw.SimpleText("Время: "..math.floor(endTime), "Default", 0,0,Color(255,0,0,255), TEXT_ALIGN_CENTER)
  end
  
  cam.End3D2D()

  if LocalPlayer():GetPos():Distance(self:GetPos()) > 300 then return end

  local pos, ang = LocalToWorld(Vector(0, 17, 20), Angle(0, 90, 90), self:GetPos(), self:GetAngles())

  cam.Start3D2D(pos,ang, 0.1)
    if LocalPlayer():isCP() then
      draw.SimpleText('Нажми Е для разминирования', 'Trebuchet48', -170,-40,Color(255,255,255), TEXT_ALIGN_CENTER) 
    end
  cam.End3D2D()

  local pos, ang = LocalToWorld(Vector(0, -17, 20), Angle(0, -90, 90), self:GetPos(), self:GetAngles())
  cam.Start3D2D(pos,ang, 0.1)
    if LocalPlayer():isCP() then
      draw.SimpleText('Нажми Е для разминирования', 'Trebuchet48', -170,-40,Color(255,255,255), TEXT_ALIGN_CENTER) 
    end
  cam.End3D2D()
end