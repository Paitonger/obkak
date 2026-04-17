-- 17.04
if SERVER then
    CreateConVar("sbox_maxpattern_keypads", 10)
end

TOOL.Category = "WayZer's Role Play"
TOOL.Name = PatternKeypad.language.toolName -- Change this in the config file
TOOL.Command = nil

TOOL.ClientConVar["combination"] = "3,3:1,2,3"
TOOL.ClientConVar["weld"] = "1"
TOOL.ClientConVar["freeze"] = "1"

TOOL.ClientConVar["key_granted"] = "0"
TOOL.ClientConVar["key_denied"] = "0"

TOOL.ClientConVar["repeats_granted"] = "0"
TOOL.ClientConVar["repeats_denied"] = "0"

TOOL.ClientConVar["length_granted"] = "0.1"
TOOL.ClientConVar["length_denied"] = "0.1"

TOOL.ClientConVar["delay_granted"] = "0"
TOOL.ClientConVar["delay_denied"] = "0"

TOOL.ClientConVar["init_delay_granted"] = "0"
TOOL.ClientConVar["init_delay_denied"] = "0"

TOOL.ClientConVar["color_primary"] = "59,73,84"
TOOL.ClientConVar["color_secondary"] = "211,47,47"
TOOL.ClientConVar["color_granted"] = "100,255,50"
TOOL.ClientConVar["color_denied"] = "255,40,20"

if CLIENT then
    language.Add("tool.keypad_pattern.name", PatternKeypad.language.toolName)
    language.Add("tool.keypad_pattern.0", PatternKeypad.language.toolInstruction)
    language.Add("tool.keypad_pattern.desc", PatternKeypad.language.toolDescription)

    language.Add("Undone_pattern_keypad", PatternKeypad.language.undo)
    language.Add("Cleanup_pattern_keypads", PatternKeypad.language.cleanName)
    language.Add("Cleaned_pattern_keypads", PatternKeypad.language.cleanedUp)

    language.Add("SBoxLimit_pattern_keypads", PatternKeypad.language.limitReached)
end

cleanup.Register("pattern_keypads")

function TOOL:SetupKeypad(ent, width, height, combination)
    ent:SetData({
        combination = combination,
        width = width,
        height = height,

        grantedRepeats   = self:GetClientNumber("repeats_granted"),
        grantedLength    = self:GetClientNumber("length_granted"),
        grantedDelay     = self:GetClientNumber("delay_granted"),
        grantedInitDelay = self:GetClientInfo("init_delay_granted"),
        grantedKey       = self:GetClientInfo("key_granted"),

        deniedRepeats   = self:GetClientNumber("repeats_denied"),
        deniedLength    = self:GetClientNumber("length_denied"),
        deniedDelay     = self:GetClientNumber("delay_denied"),
        deniedInitDelay = self:GetClientInfo("init_delay_denied"),
        deniedKey       = self:GetClientInfo("key_denied"),

        owner = self:GetOwner()
    })
end

function TOOL:LeftClick(tr)
    if IsValid(tr.Entity) and tr.Entity:IsPlayer() then return false end

    if CLIENT then return true end

    local ply = self:GetOwner()
    local width, height, combination = PatternKeypad.parseCombination(self:GetClientInfo("combination"))

	if #combination <= 1 then
		ply:PrintMessage(3, PatternKeypad.language.errorNoPattern)
		return false
	end

    local ent
    if IsValid(tr.Entity) and tr.Entity:GetClass():lower() == "keypad_pattern" then
        ent = tr.Entity
    else
        if not self:GetWeapon():CheckLimit("pattern_keypads") then return false end

        ent = ents.Create("keypad_pattern")
        ent:SetAngles(tr.HitNormal:Angle())
        ent:Spawn()
        ent:SetPos(tr.HitPos + tr.HitNormal / 2)

        local freeze = util.tobool(self:GetClientNumber("freeze"))
        local weld = util.tobool(self:GetClientNumber("weld"))

        if freeze or weld then
            local phys = ent:GetPhysicsObject()
            if IsValid(phys) then
                phys:EnableMotion(false)
            end

            if weld then constraint.Weld(ent, tr.Entity, 0, 0, 0, true, false) end
        end

        ply:AddCount("pattern_keypads", ent)
        ply:AddCleanup("pattern_keypads", ent)

        undo.Create("pattern_keypad")
            undo.AddEntity(ent)
            undo.SetPlayer(ply)
        undo.Finish()
    end

    ent:SetColors(self:GetClientInfo("color_primary") .. "-" .. self:GetClientInfo("color_secondary") .. "-" .. self:GetClientInfo("color_granted") .. "-" .. self:GetClientInfo("color_denied"))

    self:SetupKeypad(ent, width, height, combination)

    return true
end

function TOOL:RightClick(tr)

end

if CLIENT then

    concommand.Add("keypad_pattern_reset", function(ply)
        ply:ConCommand("keypad_pattern_repeats_granted 0")
        ply:ConCommand("keypad_pattern_repeats_denied 0")
        ply:ConCommand("keypad_pattern_length_granted 0.1")
        ply:ConCommand("keypad_pattern_length_denied 0.1")
        ply:ConCommand("keypad_pattern_delay_granted 0")
        ply:ConCommand("keypad_pattern_delay_denied 0")
        ply:ConCommand("keypad_pattern_init_delay_granted 0")
        ply:ConCommand("keypad_pattern_init_delay_denied 0")
    end)

    function TOOL.BuildCPanel(CPanel)
        local panel = vgui.Create("DPatternKeypadGrid")
        panel:SetConVar("keypad_pattern_combination")
        CPanel:AddItem(panel)

        local colorPanel = vgui.Create("DPanel")
        colorPanel:SetTall(64)
        colorPanel:SetPaintBackground(false)
        CPanel:AddItem(colorPanel)

        local colors = PatternKeypad.availableColors

        local colorSwitchPrimary = vgui.Create("DPatternKeypadColorSelector", colorPanel)
        colorSwitchPrimary:SetConVar("keypad_pattern_color_primary")
        colorSwitchPrimary:SetSize(32, 32)
        colorSwitchPrimary:SetColors(colors)

        local labelPrimary = vgui.Create("DLabel", colorPanel)
        labelPrimary:SetText(PatternKeypad.language.toolColorPrimary)
        labelPrimary:SizeToContents()
        labelPrimary:SetTextColor(Color(0, 0, 0))

        local colorSwitchSecondary = vgui.Create("DPatternKeypadColorSelector", colorPanel)
        colorSwitchSecondary:SetConVar("keypad_pattern_color_secondary")
        colorSwitchSecondary:SetSize(32, 32)
        colorSwitchSecondary:SetColors(colors)

        local labelSecondary = vgui.Create("DLabel", colorPanel)
        labelSecondary:SetText(PatternKeypad.language.toolColorSecondary)
        labelSecondary:SizeToContents()
        labelSecondary:SetTextColor(Color(0, 0, 0))

        local colorSwitchGranted = vgui.Create("DPatternKeypadColorSelector", colorPanel)
        colorSwitchGranted:SetConVar("keypad_pattern_color_granted")
        colorSwitchGranted:SetSize(32, 32)
        colorSwitchGranted:SetColors(colors)

        local labelGranted = vgui.Create("DLabel", colorPanel)
        labelGranted:SetText(PatternKeypad.language.toolColorGranted)
        labelGranted:SizeToContents()
        labelGranted:SetTextColor(Color(0, 0, 0))

        local colorSwitchDenied = vgui.Create("DPatternKeypadColorSelector", colorPanel)
        colorSwitchDenied:SetConVar("keypad_pattern_color_denied")
        colorSwitchDenied:SetSize(32, 32)
        colorSwitchDenied:SetColors(colors)

        local labelDenied = vgui.Create("DLabel", colorPanel)
        labelDenied:SetText(PatternKeypad.language.toolColorDenied)
        labelDenied:SizeToContents()
        labelDenied:SetTextColor(Color(0, 0, 0))

        function colorPanel:PerformLayout(w, h)
            local offset = w / 10
            local areaW = w - 32 - offset * 2

            colorSwitchPrimary:SetPos(offset, 16)
            labelPrimary:SetPos(offset + 16 - labelPrimary:GetWide() / 2, 0)

            colorSwitchSecondary:SetPos(offset + areaW / 3, 16)
            labelSecondary:SetPos(offset + areaW / 3 + 16 - labelSecondary:GetWide() / 2, 0)

            colorSwitchGranted:SetPos(offset + areaW / 3 * 2, 16)
            labelGranted:SetPos(offset + areaW / 3 * 2 + 16 - labelGranted:GetWide() / 2, 0)

            colorSwitchDenied:SetPos(offset + areaW, 16)
            labelDenied:SetPos(offset + areaW + 16 - labelDenied:GetWide() / 2, 0)
        end

        CPanel:CheckBox(PatternKeypad.language.toolWeld, "keypad_pattern_weld")
        CPanel:CheckBox(PatternKeypad.language.toolFreeze, "keypad_pattern_freeze")

        local ctrl = vgui.Create("CtrlNumPad")
        ctrl:SetConVar1("keypad_pattern_key_granted")
        ctrl:SetConVar2("keypad_pattern_key_denied")
        ctrl:SetLabel1("Access Granted Key")
        ctrl:SetLabel2("Access Denied Key")
        CPanel:AddItem(ctrl)

        local granted = vgui.Create("DForm")
        granted:SetName(PatternKeypad.language.toolGrantedSettings)

        granted:NumSlider(PatternKeypad.language.toolHoldLength, "keypad_pattern_length_granted", 0.1, 10, 2)
        granted:NumSlider(PatternKeypad.language.toolInitialDelay, "keypad_pattern_init_delay_granted", 0, 10, 2)
        granted:NumSlider(PatternKeypad.language.toolMultiplePressDelay, "keypad_pattern_delay_granted", 0, 10, 2)
        granted:NumSlider(PatternKeypad.language.toolAdditionalRepeats, "keypad_pattern_repeats_granted", 0, 5, 0)
        CPanel:AddItem(granted)

        local denied = vgui.Create("DForm")
        denied:SetName(PatternKeypad.language.toolDeniedSettings)

        denied:NumSlider(PatternKeypad.language.toolHoldLength, "keypad_pattern_length_denied", 0.1, 10, 2)
        denied:NumSlider(PatternKeypad.language.toolInitialDelay, "keypad_pattern_init_delay_denied", 0, 10, 2)
        denied:NumSlider(PatternKeypad.language.toolMultiplePressDelay, "keypad_pattern_delay_denied", 0, 10, 2)
        denied:NumSlider(PatternKeypad.language.toolAdditionalRepeats, "keypad_pattern_repeats_denied", 0, 5, 0)
        CPanel:AddItem(denied)

        CPanel:Button(PatternKeypad.language.toolDefaults, "keypad_pattern_reset")
    end
end
