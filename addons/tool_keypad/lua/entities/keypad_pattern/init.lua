-- t.me/urbanichka
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("keypad_pattern_com")
util.AddNetworkString('keypad_pattern_sendwhitelist')

function ENT:Initialize()
    self:InitializeShared()

    self:SetModel(self.Model)

	self:PhysicsInit(SOLID_VPHYSICS)

    self.whitelistIDs = {}
    self.whitelistJobs = {}

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
	end
end

function ENT:SendWhitelistData(ply)  
    net.Start('keypad_pattern_sendwhitelist')
    net.WriteEntity(self)
    net.WriteTable(self.whitelistIDs)
    net.WriteTable(self.whitelistJobs)
    if ply and IsValid(ply) then
        net.Send(ply)
    else
        net.Broadcast()
    end
end

concommand.Add('keypad_open', function(ply, cmd, args)
    local ent = ply:GetEyeTrace().Entity
    if not IsValid(ent) or ent:GetClass() ~= 'keypad_pattern' or ent:GetPos():DistToSqr(ply:GetPos()) > 100 * 100 then return DarkRP.notify(ply, 1, 3, 'Ты слишком далеко от кейпада') end

    if ent:GetStatus() ~= ent.STATUS_NONE then return end

    if ply.KeypadCooldown and ply.KeypadCooldown > CurTime() then return end
    ply.KeypadCooldown = CurTime() + 1

    if not ent:CanOpen(ply) then return DarkRP.notify(ply, 1, 3, 'Ты не можешь открыть этот кейпад') end

    ent:Process(true, ply)
end)

concommand.Add('keypad_pay', function(ply, cmd, args)
    local ent = ply:GetEyeTrace().Entity
    if not IsValid(ent) or ent:GetClass() ~= 'keypad_pattern' or ent:GetPos():DistToSqr(ply:GetPos()) > 100 * 100 then return DarkRP.notify(ply, 1, 3, 'Ты слишком далеко от кейпада') end

    if ent:GetStatus() ~= ent.STATUS_NONE then return end

    if ply.KeypadCooldown and ply.KeypadCooldown > CurTime() then return end
    ply.KeypadCooldown = CurTime() + 1

    local price = ent:GetPrice()

    if price == 0 then return DarkRP.notify(ply, 1, 3, 'Этот кейпад нельзя открыть за деньги') end
    if not ply:canAfford(price) then return DarkRP.notify(ply, 1, 3, 'Ты не можешь позволить себе это') end

    ply:addMoney(-price)
    DarkRP.notify(ply, 0, 3, 'Ты воспользовался кейпадом за '..DarkRP.formatMoney(price))
    
    local pl = FPP.entGetOwner(ent)
    if IsValid(pl) then
        pl:addMoney(price)
        DarkRP.notify(pl, 0, 3, ply:Name()..' воспользовался твоим кейпадом за '..DarkRP.formatMoney(price))
    end

    ent:Process(true, ply)
end)

function ENT:AddSteamID(id)
    if not IsValid(player.GetBySteamID(id)) then return end

    self.whitelistIDs[id] = true
    self:SendWhitelistData()
end

function ENT:AddJob(job)
    if not RPExtraTeams[job] then return end

    self.whitelistJobs[job] = true
    self:SendWhitelistData()
end

function ENT:RemoveSteamID(id)
    if not IsValid(player.GetBySteamID(id)) then return end

    self.whitelistIDs[id] = nil
    self:SendWhitelistData()
end

function ENT:RemoveJob(job)
    if not RPExtraTeams[job] then return end
    
    self.whitelistJobs[job] = nil
    self:SendWhitelistData()
end

concommand.Add('keypad_setprice', function(ply, cmd, args)
    local price = tonumber(args[1])
    if not price then return DarkRP.notify(ply, 1, 3, 'Ты ввел некорректную цену') end

    if ply.KeypadCooldown and ply.KeypadCooldown > CurTime() then return DarkRP.notify(ply, 1, 3, 'Не спеши') end

    ply.KeypadCooldown = CurTime() + 3

    local ent = ply:GetEyeTrace().Entity
    if not IsValid(ent) or ent:GetClass() ~= 'keypad_pattern' or ent:GetPos():DistToSqr(ply:GetPos()) > 100 * 100 then return DarkRP.notify(ply, 1, 3, 'Ты слишком далеко от кейпада') end

    if FPP.entGetOwner(ent) ~= ply then return DarkRP.notify(ply, 1, 3, 'Это не твой кейпад!') end

    if price < 0 then
        return DarkRP.notify(ply, 1, 3, 'Что-то маловато будет...')
    elseif price > 100000000 then
        return DarkRP.notify(ply, 1, 3, 'Не многовато ли для кейпада? 0_o')
    end

    ent:SetPrice(math.floor(price))

    DarkRP.notify(ply, 0, 3, 'Цена прохода успешно изменена')
end)

concommand.Add('keypad_add_steamid', function(ply, cmd, args)
    local ent = ply:GetEyeTrace().Entity
    if not IsValid(ent) or ent:GetPos():DistToSqr(ply:GetPos()) > 100 * 100 then return DarkRP.notify(ply, 1, 3, 'Ты слишком далеко от кейпада') end

    if ent:GetClass() ~= 'keypad_pattern' then return DarkRP.notify(ply, 1, 3, 'Это не кейпад...') end
    if FPP.entGetOwner(ent) ~= ply then return DarkRP.notify(ply, 1, 3, 'Это не твой кейпад!') end

    if ply.KeypadCooldown and ply.KeypadCooldown > CurTime() then return DarkRP.notify(ply, 1, 3, 'Не спеши') end
    ply.KeypadCooldown = CurTime() + 1

    ent:AddSteamID(args[1])

    DarkRP.notify(ply, 0, 3, 'Игроку был выдан доступ к кейпаду')
end)

concommand.Add('keypad_add_job', function(ply, cmd, args)
    local ent = ply:GetEyeTrace().Entity
    if not IsValid(ent) or ent:GetPos():DistToSqr(ply:GetPos()) > 100 * 100 then return DarkRP.notify(ply, 1, 3, 'Ты слишком далеко от кейпада') end

    if ent:GetClass() ~= 'keypad_pattern' then return DarkRP.notify(ply, 1, 3, 'Это не кейпад...') end
    if FPP.entGetOwner(ent) ~= ply then return DarkRP.notify(ply, 1, 3, 'Это не твой кейпад!') end

    if ply.KeypadCooldown and ply.KeypadCooldown > CurTime() then return DarkRP.notify(ply, 1, 3, 'Не спеши') end
    ply.KeypadCooldown = CurTime() + 1

    ent:AddJob(tonumber(args[1]))

    DarkRP.notify(ply, 0, 3, 'Профессии был выдан доступ к кейпаду')
end)

concommand.Add('keypad_remove_steamid', function(ply, cmd, args)
    local ent = ply:GetEyeTrace().Entity
    if not IsValid(ent) or ent:GetPos():DistToSqr(ply:GetPos()) > 100 * 100 then return DarkRP.notify(ply, 1, 3, 'Ты слишком далеко от кейпада') end

    if ent:GetClass() ~= 'keypad_pattern' then return DarkRP.notify(ply, 1, 3, 'Это не кейпад...') end
    if FPP.entGetOwner(ent) ~= ply then return DarkRP.notify(ply, 1, 3, 'Это не твой кейпад!') end

    if ply.KeypadCooldown and ply.KeypadCooldown > CurTime() then return DarkRP.notify(ply, 1, 3, 'Не спеши') end
    ply.KeypadCooldown = CurTime() + 1

    ent:RemoveSteamID(args[1])

    DarkRP.notify(ply, 0, 3, 'У игрока был забран доступ к кейпаду')
end)

concommand.Add('keypad_remove_job', function(ply, cmd, args)
    local ent = ply:GetEyeTrace().Entity
    if not IsValid(ent) or ent:GetPos():DistToSqr(ply:GetPos()) > 100 * 100 then return DarkRP.notify(ply, 1, 3, 'Ты слишком далеко от кейпада') end

    if ent:GetClass() ~= 'keypad_pattern' then return DarkRP.notify(ply, 1, 3, 'Это не кейпад...') end
    if FPP.entGetOwner(ent) ~= ply then return DarkRP.notify(ply, 1, 3, 'Это не твой кейпад!') end

    if ply.KeypadCooldown and ply.KeypadCooldown > CurTime() then return DarkRP.notify(ply, 1, 3, 'Не спеши') end
    ply.KeypadCooldown = CurTime() + 1

    ent:RemoveJob(tonumber(args[1]))

    DarkRP.notify(ply, 0, 3, 'У профессии был забран доступ к кейпаду')
end)

AccessorFunc(ENT, "m_Combination", "Combination")
AccessorFunc(ENT, "keypadData", "Data")

function ENT:SetData(data)
    self.keypadData = data

    self:SetCombination(data.combination)
    self:SetGridWidth(data.width)
    self:SetGridHeight(data.height)
end

function ENT:Reset()
    self:SetStatus(self.STATUS_NONE)
end

function ENT:CheckCombination(tbl)
    local combo = self:GetCombination()

    if #tbl ~= #combo then return false end
    for i = 1, #tbl do
        if tbl[i] ~= combo[i] then return false end
    end

    return true
end

function ENT:ProcessCombination(tbl, player)
    self:Process(self:CheckCombination(tbl), player)
end

function ENT:Process(granted, player)
    if self:GetStatus() ~= self.STATUS_NONE then return end

    if granted then
        self:EmitSound(PatternKeypad.soundAccessGranted)
        self:SetStatus(self.STATUS_GRANTED)
    else
        self:EmitSound(PatternKeypad.soundAccessDenied)
        self:SetStatus(self.STATUS_DENIED)

    local effectdata = EffectData()
    effectdata:SetStart(self:GetPos())
    effectdata:SetOrigin(self:GetPos())
    effectdata:SetScale(1)
    effectdata:SetMagnitude(1)
    effectdata:SetScale(3)
    effectdata:SetRadius(1)
    effectdata:SetEntity(self)
    local Zap = math.random(1,3)
    self:EmitSound("ambient/energy/zap" .. Zap .. ".wav")
    for i = 1, 5 do
        util.Effect("TeslaHitBoxes", effectdata, true, true)
    end
    if player:Health() > 20 then
    player:TakeDamage( 20, self, player )
    end

    end
    local prefix = granted and "granted" or "denied"

    local length = math.Clamp(tonumber(self.keypadData[prefix .. "Length"]), 0, 10)
    local repeats = math.Clamp(tonumber(self.keypadData[prefix .. "Repeats"]), 0, 10)
    local delay = math.Clamp(tonumber(self.keypadData[prefix .. "Delay"]), 0, 10)
    local initDelay = math.Clamp(tonumber(self.keypadData[prefix .. "InitDelay"]), 0, 5)

    local owner = self.keypadData.owner

    timer.Simple(math.max(initDelay + length * (repeats + 1) + delay * repeats + 0.25, 2), function()
        if IsValid(self) then
            self:Reset()
        end
    end)

    timer.Simple(initDelay, function()
        if not IsValid(self) then return end

        for i = 0, repeats do
            timer.Simple((length + delay) * i, function()
                if IsValid(self) and IsValid(owner) then
                    self:DoSignal(granted, true)
                end
            end)

            timer.Simple(length * (i + 1) + delay * i, function()
                if IsValid(self) and IsValid(owner) then
                    self:DoSignal(granted, false)
                end
            end)
        end
    end)
end

function ENT:DoSignal(granted, activated)
    local key = granted and self.keypadData.grantedKey or self.keypadData.deniedKey
    local owner = self.keypadData.owner

    if activated then
        numpad.Activate(owner, key, true)
    else
        numpad.Deactivate(owner, key, true)
    end
end

local function checkDistance(ent, ply)
    if not IsValid(ent) or not IsValid(ply) then return false end

    local trace = ply:GetEyeTrace()
    if trace.Entity ~= ent then return false end
    if trace.HitPos:Distance(ply:GetShootPos()) > PatternKeypad.clickRange then return false end

    return true
end

net.Receive("keypad_pattern_com", function(len, ply)
    local ent = net.ReadEntity()
    if not IsValid(ent) then return end
    if not IsValid(ply) then return end
    local dist = ply:GetPos():Distance(ent:GetPos())
    if dist > 200 then return end


    if not string.StartWith(ent:GetClass():lower(), "keypad_pattern") then return end
    if ent:GetStatus() ~= ent.STATUS_NONE then return end

    local combination = {}
    local count = net.ReadInt(8)
    local player = ply

    for i = 1, count do
        combination[#combination + 1] = net.ReadInt(8)
    end

    ent:ProcessCombination(combination, player)
end)

hook.Add('PlayerAuthed', 'keypads_pattern', function(ply)
    for _, v in ipairs(ents.FindByClass('keypad_pattern')) do
        v:SendWhitelistData()
    end
end)