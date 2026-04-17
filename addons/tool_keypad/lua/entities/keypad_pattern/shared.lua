-- t.me/urbanichka
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Pattern Keypad"
ENT.Author = "Metamist"
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = Model("models/props_lab/keypad.mdl")
ENT.IsKeypad = true

ENT.STATUS_NONE = 0
ENT.STATUS_GRANTED = 1
ENT.STATUS_DENIED = 2

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "Status")
    self:NetworkVar("Int", 1, "GridWidth")
    self:NetworkVar("Int", 2, "GridHeight")
    self:NetworkVar("Int", 3, "Price")

    self:NetworkVar("String", 0, "Colors")

    if SERVER then
        self:SetGridWidth(3)
        self:SetGridHeight(3)
    end
end

function ENT:CanOpen(ply)
    if FPP.entGetOwner(self) == ply then return true end
    if (self.whitelistIDs and self.whitelistIDs[ply:SteamID()]) or (self.whitelistJobs and self.whitelistJobs[ply:Team()]) then return true end

    return false
end

function ENT:InitializeShared()
    self.boxMax = self:OBBMaxs() * Vector(1, 1.25, 1)
    self.boxMin = self:OBBMins() * Vector(1, 1.25, 1)
end
