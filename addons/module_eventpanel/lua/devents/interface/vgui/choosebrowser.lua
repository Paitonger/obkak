-- t.me/urbanichka
local panel = {}

function panel:Init()
    self.acceptText = 'Принять'
    self.firstText = 'Доступно'
    self.secondText = 'Выбрано'

    self:SetBackgroundColor(dEvents.config.secondColor)

    self.topPanel = vgui.Create('DPanel', self)
    self.topPanel:Dock(TOP)
    self.topPanel.Paint = function (s,w,h)
        surface.SetDrawColor(dEvents.config.secondColor)
        surface.DrawRect(0,0,w,h)

        surface.SetFont('Trebuchet24')
        surface.SetTextColor(Color(255,255,255))

        local firstWide, firstHeight = surface.GetTextSize(self.firstText)
        local secondWide, secondHeight = surface.GetTextSize(self.secondText)
        surface.SetTextPos(self.leftList:GetWide()/2 - firstWide/2, (self.topPanel:GetTall() - firstHeight) / 2)
        surface.DrawText(self.firstText)

        surface.SetTextPos(self:GetWide()-self.rightList:GetWide()/2 - secondWide/2, (self.topPanel:GetTall() - secondHeight) / 2)
        surface.DrawText(self.secondText)
    end

    self.accept = vgui.Create('DButton', self)
    self.accept:Dock(BOTTOM)
    self.accept:SetTall(25)
    self.accept:SetText(self.acceptText)
    self.accept:SetIcon('icon16/accept.png')
    self.accept.DoClick = function ()
        self:Callback()
    end

    self.leftList = vgui.Create('DListView', self)
    self.leftList:Dock(LEFT)
    self.leftList:SetMultiSelect(false)

    self.rightList = vgui.Create('DListView', self)
    self.rightList:Dock(RIGHT)
    self.rightList:SetMultiSelect(false)

    self.moveBar = vgui.Create('DPanel', self)
    self.moveBar:Dock(FILL)
    self.moveBar.Paint = function() end

    self.moveRight = vgui.Create('DButton', self.moveBar)
    self.moveRight:Dock(TOP)
    self.moveRight:SetText('>')
    self.moveRight.DoClick = function (s)
        local lineId = self.leftList:GetSelectedLine()
        if not lineId then return end

        self:Choose(lineId)
    end

    self.moveLeft = vgui.Create('DButton', self.moveBar)
    self.moveLeft:Dock(TOP)
    self.moveLeft:SetText('<')
    self.moveLeft.DoClick = function (s)
        local lineId = self.rightList:GetSelectedLine()
        if not lineId then return end

        self:UnChoose(lineId)
    end

    self.data = {}
    self.columns = 0
    self.chosen = {}
end

function panel:PerformLayout()
    local p = self:GetParent()
    self.topPanel:SetTall(p:GetTall()*0.05)

    self.leftList:SetWide(p:GetWide()*0.45)
    self.rightList:SetWide(p:GetWide()*0.45)

    self.moveLeft:SetTall(p:GetWide()*0.08)
    self.moveRight:SetTall(p:GetWide()*0.08)
end

function panel:AddColumn(name, pos)
    self.leftList:AddColumn(name, pos)
    self.rightList:AddColumn(name, pos)
    self.columns = self.columns + 1
end

function panel:SetData(data)
    self.data = data

    self.leftList:Clear()
    self.rightList:Clear()
    for k, v in pairs (data) do
        local line = self.leftList:AddLine(unpack(v))
        line.id = k
    end
end

function panel:Choose(id)
    local line = self.leftList:GetLine(id)
    if not IsValid(line) then return end
    self.leftList:RemoveLine(id)

    local lineData = {}
    for i=1, self.columns do
        table.insert(lineData, line:GetColumnText(i))
    end

    local newLine = self.rightList:AddLine(unpack(lineData))
    newLine.id = table.insert(self.chosen, lineData)
end

function panel:UnChoose(id)
    local line = self.rightList:GetLine(id)
    if not IsValid(line) then return end
    self.rightList:RemoveLine(id)

    local lineData = {}
    for i=1, self.columns do
        table.insert(lineData, line:GetColumnText(i))
    end

    local newLine = self.leftList:AddLine(unpack(lineData))
    table.remove(self.chosen, newLine.id)
end

function panel:GetSelectedData()
    return self.chosen
end

function panel:Callback()
end

function panel:SetButtonText(text)
    self.accept:SetText(text)
end

vgui.Register('devents_choosebrowser', panel, 'DPanel')