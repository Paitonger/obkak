-- 17.04
local panel = {}

function panel:Init()
    self._panel = vgui.Create('DPanel', self) -- Да кто вы такие, чтобы судить меня, принцессу?
    self._panel:Dock(FILL)

    self.sheet = vgui.Create('DPropertySheet', self._panel)
    self.sheet:Dock(FILL)

    self.refresh = vgui.Create('DButton', self)
    self.refresh:SetSize(60,30)
    self.refresh:SetText('Обновить')
    self.refresh.DoClick = function ()
        self:Refresh()
    end

    net.Receive('dEvents.getAllEvents', function ()
        if not IsValid(self) then return end
        local events = net.ReadTable()
        self:SetData(events)
    end)

    self:Refresh()
end

function panel:PerformLayout()
    self.refresh:SetPos(self:GetWide()-self.refresh:GetWide()-15, 30)
end

local function parseNode(tbl, node)
    for k, v in pairs (tbl) do
        if istable(v) then
            local newNode = node:AddNode(k)
            parseNode(v, newNode)
        else
            local newNode = node:AddNode(string.format('%s: %s', k, v))
        end
    end
end

function panel:SetData(data)
    for id, v in pairs (data) do
        local ply = player.GetBySteamID(id)
        if not IsValid(ply) then continue end
        
        local tree = vgui.Create('DTree', self.sheet)
        local node = tree:AddNode(id)
        node.DoRightClick = function()
            local menu = DermaMenu()

            menu:AddOption('Скопировать SteamID', function ()
                SetClipboardText(id)
            end)

            menu:AddOption('Завершить', function ()
                net.Start('dEvents.stopEvent')
                net.WriteString(id)
                net.SendToServer()

                timer.Simple(.5, function ()
                    self:Refresh()
                end)
            end):SetIcon('icon16/cancel.png')
        
            menu:Open()
        end
        parseNode(v, node)
        self.sheet:AddSheet(ply and ply:Name() or id, tree, 'icon16/user.png')
    end
end

function panel:Refresh()
    if IsValid(self.sheet) then self.sheet:Remove() end

    self.sheet = vgui.Create('DPropertySheet', self._panel)
    self.sheet:Dock(FILL)

    net.Start('dEvents.getAllEvents')
    net.SendToServer()
end

vgui.Register('devents_admin', panel, 'DPanel')

--[[
    local frame = vgui.Create('DFrame')
    frame:SetSize(600,600)
    frame:Center()

    local damn = vgui.Create('devents_admin', frame)
    damn:Dock(FILL)
]]