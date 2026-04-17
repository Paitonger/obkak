-- 17.04
AddCSLuaFile()

ENT.Type                = 'anim'
ENT.Base                = 'base_gmodentity'

if CLIENT then
      ENT.PrintName           = 'ZHits - Hit Phone'
      ENT.Category            = 'Разрешено'
end

ENT.Spawnable           = true

local function cfg(var)
      return (not var and zhits.cfg or zhits.cfg[var].value)
end

local function translate(var)
      return (not var and zhits.language or zhits.language[var])
end

if SERVER then
      function ENT:Initialize()
            self:SetModel 'models/props_trainstation/payphone001a.mdl'
            self:PhysicsInit(SOLID_VPHYSICS)
            self:SetMoveType(MOVETYPE_VPHYSICS)
            self:SetSolid(SOLID_VPHYSICS)
            self:SetUseType(SIMPLE_USE)

            local phys = self:GetPhysicsObject()

            if IsValid(phys) then
                  phys:Wake()
            end
      end

      function ENT:Use(cal)
            if IsValid(cal) then
                  if not cfg 'noHitmanHits' then
                        if cal:IsHitman() then
                              zhits.notifyPlayer(cal, translate 'noHitmanHits')
                              return
                        end
                  end

                  net.Start 'zhits.openHitMenu'
                  net.Send(cal)

                  cal.currentHitPhone = self
            end
      end
end

if CLIENT then
      surface.CreateFont("WayZFont", {
        size = 48,
        weight = 500,
        antialias = true,
        shadow = false,
        font = "Arial",
    })
      local LocalPlayer = LocalPlayer
      local Vector = Vector
      local Angle = Angle
      local math = math
      local cam = cam

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
          draw.SimpleText( 'Телефон', "Trebuchet24", -120, 51, Color( 255, 255, 255, 70 + main ), 0, 1 )
          surface.SetDrawColor( Color(77, 75, 77 , 70 + main) )
          surface.DrawOutlinedRect( -130,10,260,60 )
        cam.End3D2D()
      end
end