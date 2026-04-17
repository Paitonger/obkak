-- t.me/urbanichka
include('shared.lua')
local lw, lh = 700, 100
function ENT:Draw()
    self:DrawModel()
end

function ENT:OnRemove()
    local muz = self.sound
    if IsValid(muz) then muz:Stop() end
end

function ENT:Think()
    if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > 1500000 then return end
    local muz = self.sound
    if muz and IsValid(muz) then
        muz:SetPos(self:GetPos())
    end
end

timer.Create('RadioCheck', 5, 0, function()
    for k, v in pairs(ents.FindByClass('radio') or {}) do
        if not v.GetURL then continue end

        if v:GetPos():DistToSqr(LocalPlayer():GetPos()) > 1500000 and IsValid(v.sound) then
            v.sound:SetVolume(0)
        elseif IsValid(v.sound) then
            v.sound:SetVolume(1)
        end

        local url = v:GetURL()
        if url and url ~= '' then
            local muzlo = v.sound
            if not muzlo or not IsValid(muzlo) then
                sound.PlayURL(url, '3d noblock', function(s)
                    if IsValid(s) and IsValid(v) then
                        s:SetPos(v:GetPos())
                        s:Play()
                        s:SetVolume(1)
                        s:Set3DFadeDistance(200, 1500000)
                        if not s:IsBlockStreamed() then
                            s:SetTime(CurTime() - v:GetStartTime())
                            if v:GetLoop() then s:EnableLooping(true) end
                        end
                        v.sound = s
                    end
                end)
            elseif muzlo:GetFileName() == url then
                muzlo:SetPos(v:GetPos())
                if not muzlo:IsBlockStreamed() and not v:GetLoop() then muzlo:SetTime(CurTime() - v:GetStartTime()) end
            else
                muzlo:Stop()
                v.sound = nil
                sound.PlayURL(url, '3d noblock', function(s)
                    if IsValid(s) and IsValid(v) then
                        s:SetPos(v:GetPos())
                        s:Play()
                        s:SetVolume(1)
                        s:Set3DFadeDistance(200, 1500000)
                        if not s:IsBlockStreamed() then
                            s:SetTime(CurTime() - v:GetStartTime())
                            if v:GetLoop() then s:EnableLooping(true) end
                        end
                        v.sound = s
                    end
                end)
            end
        elseif v.sound then
            if IsValid(v.sound) then v.sound:Stop() end
            v.sound = nil
        end
    end
end)

concommand.Add('wayradio_refresh', function()
    for k, v in pairs(ents.FindByClass('radio') or {}) do
        if v.sound and IsValid(v.sound) then
            v.sound:Stop()
            v.sound = nil
            v:SetURL('')
            v:SetLoop(false)
        end
    end
end)

local function setmusic(url, loop)
    net.Start('MuzonMenu')
    if url then
        net.WriteString(url)
        net.WriteBool(loop)
    end
    net.SendToServer()
end

local char_to_hex = function(c)
    return string.format('%%%02X', string.byte(c))
end

local function urlencode(url)
    url = url:gsub('\n', '\r\n')
    url = url:gsub('([^%w ])', char_to_hex)
    url = url:gsub(' ', '+')
    return url
end

net.Receive('MuzonMenu', function()
    local radio = LocalPlayer():GetEyeTrace().Entity
    if not radio or radio:GetClass() ~= 'radio' then return end

    local menu = vgui.Create('DFrame')
    menu:SetSize(500, 0)
    menu:SetTitle('Радио')
    menu:MakePopup()
    menu.Paint = function(s,w,h)
        draw.RoundedBox(4,0,0,w,h,Color(54,57,62))
    end

    local guide = vgui.Create('DLabel', menu)
    guide:SetText('Если радио перестало работать, то введи команду wayradio_refresh в консоль')
    guide:SetWrap(true)
    guide:Dock(TOP)

    local entry = vgui.Create('DTextEntry', menu)
    entry:SetSize(0, 25)
    entry:SetPlaceholderText('Вставь прямую ссылку [http://xxxxxxx.mp3]')
    entry:SizeToContents()
    entry:Dock(TOP)

    local stop = vgui.Create('DButton', entry)
    stop:SetSize(30, 25)
    stop:SetText('■')
    stop:Dock(RIGHT)
    stop.DoClick = function() setmusic() end

    local play = vgui.Create('DButton', entry)
    play:SetSize(30, 25)
    play:SetText('►')
    play:Dock(RIGHT)

    local help = vgui.Create('DImageButton', entry)
    help:SetSize(entry:GetTall()-4, entry:GetTall()-4)
    help:Dock(RIGHT)
    help:DockMargin(2,2,2,2)
    help:SetImage('icon16/help.png')
    help:SetTooltip('Как правильно вставить ссылку?')
    help.DoClick = function()
        gui.OpenURL('https://docs.google.com/document/d/1d0AmjNMJngDdBLrNms7X9K82JcpAvSl-OVT7TJfj54w/edit?usp=sharing')
    end

    local loop = vgui.Create('DCheckBoxLabel', menu)
    loop:SetTall(25)
    loop:Dock(TOP)
    loop:DockMargin(0,10,0,0)
    loop:SetText('Включить повторение')

    local freeze = vgui.Create('DButton', menu)
    freeze:SetText('Заморозить / Разморозить')
    freeze:Dock(TOP)
    freeze:DockMargin(0,10,0,0)
    freeze.DoClick = function()
        net.Start('RadioFreeze')
        net.SendToServer()
    end

    play.DoClick = function()
        if not entry:GetValue() or entry:GetValue() == '' then return notification.AddLegacy('Ты не вставил ссылку', 1, 2) end
        setmusic(entry:GetValue(), loop:GetChecked())
    end

    menu:InvalidateLayout(true)
    menu:SizeToChildren(false, true)
    menu:Center()
end)