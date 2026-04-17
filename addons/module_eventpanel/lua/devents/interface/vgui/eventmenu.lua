-- 17.04
local panel = {}

function panel:Init()
    self.players = {}
    self.options = {}

    self:SetBackgroundColor(dEvents.config.secondColor)

    self.optionPanel = vgui.Create('DPanel', self)
    self.optionPanel:Dock(RIGHT)
    self.optionPanel:SetWide(self:GetParent():GetWide()*0.3)

    self.stopEvent = vgui.Create('DButton', self.optionPanel)
    self.stopEvent:Dock(BOTTOM)
    self.stopEvent:SetTall(25)
    self.stopEvent:SetText(dEvents.actions.stop.name or '')
    self.stopEvent:SetIcon(dEvents.actions.stop.icon or 'icon16/wand.png')
    self.stopEvent.DoClick = function ()
        RunConsoleCommand('devents', 'stop')
    end

    self.optionScroll = vgui.Create('DScrollPanel', self.optionPanel)
    self.optionScroll:Dock(FILL)
    self.optionScroll.Paint = function (s,w,h)
        surface.SetDrawColor(dEvents.config.secondColor)
        surface.DrawRect(0,0,w,h)
    end

    self.playerList = vgui.Create('DListView', self)
    self.playerList:Dock(FILL)
    self.playerList:AddColumn('Ник')
    self.playerList:AddColumn('SteamID')
    self.playerList:SetMultiSelect(false)

    local actions = dEvents.getSortedActions()

    function self.playerList:OnRowRightClick(id, line)
        local sid = self:GetLine(self:GetSelectedLine()):GetColumnText(2)
        local menu = DermaMenu()

        menu:AddOption(dEvents.getPhrase('vgui_spectate'), function ()
            RunConsoleCommand('fspectate', sid)
        end):SetIcon('icon16/camera.png')

        menu:AddOption(dEvents.getPhrase('vgui_bring'), function ()
            RunConsoleCommand('fadmin', 'bring', sid)
        end):SetIcon('icon16/user_go.png')

        menu:AddOption(dEvents.getPhrase('vgui_goto'), function ()
            RunConsoleCommand('fadmin', 'goto', sid)
        end):SetIcon('icon16/arrow_right.png')

        menu:AddSpacer()

        for _, action in pairs (actions) do
            if action.noButton then continue end
            menu:AddOption(action.name, function ()
                if action.panel then
                    action.panel(action.command, sid)
                else
                    RunConsoleCommand('devents', action.command, sid)
                end
            end):SetIcon(action.icon or 'icon16/wand.png')
        end
        menu:Open()
    end

    for _, action in pairs (actions) do
        if action.noButton then continue end
        if action.onePlayer then continue end

        local btn = vgui.Create('DButton', self.optionScroll)
        btn:Dock(TOP)
        btn:SetTall(25)
        btn:SetText(action.name or '')
        btn:SetIcon(action.icon or 'icon16/wand.png')
        btn.DoClick = function ()
            if action.panel then
                action.panel(action.command, '*')
            else
                RunConsoleCommand('devents', action.command, '*')
            end
        end
        self.optionScroll:Add(btn)
    end
end

function panel:PerformLayout()
    --self.optionPanel:SetWide(self:GetParent():GetWide()*0.3)
end

function panel:AddPlayer(ply)
    if not IsValid(ply) then return end
    table.insert(self.players, ply)
    self.playerList:AddLine(ply:Name(), ply:SteamID())
end

function panel:RemovePlayer(id)
    local line = self.playerList:GetLine(id)
    if not IsValid(line) then return end

    self.playerList:RemoveLine(id)
    table.remove(self.players, id)
end

function panel:RefreshPlayers()
    local oldPlayers = self.players
    self.players = {}

    for _, v in pairs (oldPlayers) do
        self:AddPlayer(v)
    end
end

function panel:Clear()
    self.players = {}
    self.playerList:Clear()
end

vgui.Register('devents_main', panel, 'DPanel')