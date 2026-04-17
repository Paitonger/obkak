-- 17.04
AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')

include('shared.lua')

util.AddNetworkString('MuzonMenu')
util.AddNetworkString('RadioFreeze')

function ENT:Initialize()
    self:SetModel('models/props/cs_office/radio.mdl')
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:PhysWake()
end

function ENT:OnTakeDamage(dmg)
    self:Remove()
end

function ENT:Use(activator, caller)
    net.Start('MuzonMenu')
    net.Send(activator)
end

net.Receive('MuzonMenu', function(_, ply)
    local url = net.ReadString()
    if ply:IsValid() then
        local radio = ply:GetEyeTrace().Entity
        if radio and radio:GetClass() == 'radio' then 
            radio:SetURL(url)
            radio:SetStartTime(CurTime())
            
            if url and url ~= '' then
                radio:SetLoop(net.ReadBool())
                DarkRP.talkToRange(ply, ply:Nick()..' включил трек на радио', '', 250)
            else
                DarkRP.talkToRange(ply, ply:Nick()..' выключил радио', '', 250)
            end
        end
    end
end)

net.Receive('RadioFreeze', function(_, ply)
    if ply.nextRadioFreeze and ply.nextRadioFreeze > CurTime() then return DarkRP.notify(ply, 1, 2, 'Подожди немного') end

    local radio = ply:GetEyeTrace().Entity
    if radio and radio:GetClass() == 'radio' then
        if radio.SID and radio.SID ~= ply.SID then return DarkRP.notify(ply, 1, 4, 'Это не твое радио') end

        if radio:GetMoveType() == 0 then
            radio:SetMoveType(MOVETYPE_VPHYSICS)
            DarkRP.notify(ply, 0, 4, 'Радио разморожено')
        else
            radio:SetMoveType(MOVETYPE_NONE)
            DarkRP.notify(ply, 0, 4, 'Радио заморожено')
        end
        ply.nextRadioFreeze = CurTime() + 3
    end
end)   