-- 17.04
function showlawlist()
    local cvar = GetConVar('wayskin_enable')
	local laws = ""
	for k, v in pairs(DarkRP.getLaws()) do
		laws = laws .. "\n" .. k .. ". " .. v
	end

	local frame = vgui.Create("DFrame")
	frame:SetSize(ScrW() / 2, ScrH() / 2)
	frame:Center()
	frame:SetTitle("Законы города")
	frame:MakePopup()
	frame:SetKeyboardInputEnabled(false)
	frame:SetSizable(true)
	frame:DockPadding(2, 26, 2, 2)
	frame.Paint = function()
	     draw.RoundedBox(0,0,0,ScrW() / 2,ScrH() / 2,Color(54,57,62,255))	
	end
	frame:ShowCloseButton(false)

    local panel = vgui.Create("DPanel", frame)
    panel:Dock(FILL)
    
    if cvar:GetInt() == 0 then
        panel:SetBackgroundColor( Color(47,49,54,255))
    end

	local label = frame:Add("RichText")
	function label:Paint()
		self:SetFontInternal("DermaDefault")
		self.Paint = nil
	end
	
	label:Dock(FILL)
	label:SetWrap(true)
	label:InsertColorChange(255, 255, 255, 255)
	label:AppendText(laws:sub(2))

	local close = frame:Add("DButton")
	close:MoveBelow(label, 2)
	close:Dock(BOTTOM)
	close:SetText("Закрыть")
	close:SetImage("icon16/cancel.png")

	function close:DoClick()
		frame:Remove()
	end
end

concommand.Add("lawlist", showlawlist)