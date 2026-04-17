-- t.me/urbanichka
//This was originally written by Worshipper.
//Anything editted was to prevent conflicts between addons and some things I wanted to add to this script

/*---------------------------------------------------------
   Name: CrosshairOptions()
---------------------------------------------------------*/
local function PTPCrosshairOptions(panel)

	local PTPCrosshairOptions = {Options = {}, CVars = {}, Label = "#Presets", MenuButton = "1", Folder = "ptp_crosshair_convars"}

	PTPCrosshairOptions.Options["#Default"] = {	ptp_crosshair_r =	"255",
								ptp_crosshair_g =	"255",
								ptp_crosshair_b =	"255",
								ptp_crosshair_a =	"255",
								ptp_crosshair_l =	"0",
								ptp_crosshair_gap =	"0",
								ptp_crosshair_t =	"1",
								ptp_crosshair_out =	"0",
								ptp_crosshair_w =	"0",
								ptp_crosshair_hl2 =	"0",
								ptp_crosshair_static =	"0",
								ptp_crosshair_thin =	"0",
								ptp_viewmodel_flip =	"0",
								ptp_viewmodel_bob =	"1",
								ptp_viewmodel_sway =	"1",
								ptp_viewmodel_fov =	"0",
								ptp_viewmodel_css =	"0",
								ptp_flash_data =	"1"
							   }
									
	PTPCrosshairOptions.CVars = { 	"ptp_crosshair_r",
						"ptp_crosshair_g",
						"ptp_crosshair_b",
						"ptp_crosshair_a",
						"ptp_crosshair_l",
						"ptp_crosshair_t",
						"ptp_crosshair_w",
						"ptp_crosshair_out",
						"ptp_crosshair_gap",
						"ptp_crosshair_hl2",
						"ptp_crosshair_static",
						"ptp_crosshair_thin",
						"ptp_viewmodel_flip",
						"ptp_viewmodel_fov",
						"ptp_viewmodel_bob",
						"ptp_viewmodel_sway",
						"ptp_viewmodel_css",
						"ptp_flash_data"
					 }
						
	panel:AddControl("ComboBox", PTPCrosshairOptions)

	panel:AddControl("CheckBox", {
		Label = "Enable Crosshair",
		Command = "ptp_crosshair_t",
	})
	panel:AddControl("Color", {
		Label 	= "Crosshair Color",
		Red 		= "ptp_crosshair_r",
		Green 	= "ptp_crosshair_g",
		Blue 		= "ptp_crosshair_b",
		Alpha 	= "ptp_crosshair_a",
	})
	panel:AddControl("Slider", {
		Label 	= "Crosshair Length",
		Command 	= "ptp_crosshair_l",
		Type 		= "Integer",
		Min 		= "-30",
		Max 		= "30",
	})
	panel:AddControl("Slider", {
		Label 	= "Crosshair Gap",
		Command 	= "ptp_crosshair_gap",
		Type 		= "Integer",
		Min 		= "-30",
		Max 		= "30",
	})
	panel:AddControl("Slider", {
		Label 	= "Crosshair Width",
		Command 	= "ptp_crosshair_w",
		Type 		= "Integer",
		Min 		= "-2",
		Max 		= "2",
	})
	panel:AddControl("CheckBox", {
		Label = "Crosshair Outline",
		Command = "ptp_crosshair_out",
	})
	panel:AddControl("CheckBox", {
		Label = "Static Crosshair",
		Command = "ptp_crosshair_static",
	})
	panel:AddControl("CheckBox", {
		Label = "Thin Crosshair",
		Command = "ptp_crosshair_thin",
	})
	panel:AddControl("CheckBox", {
		Label = "Enable Half-Life 2 Crosshair",
		Command = "ptp_crosshair_hl2",
	})
	
	panel:AddControl("Label", {Text = "ViewModel Settings"})

	
	panel:AddControl("CheckBox", {
		Label = "Flip ViewModel",
		Command = "ptp_viewmodel_flip",
	})
	panel:AddControl("Slider", {
		Label 	= "ViewModel FOV",
		Command 	= "ptp_viewmodel_fov",
		Type 		= "Integer",
		Min 		= "-30",
		Max 		= "30",
	})
	panel:AddControl("Slider", {
		Label 	= "ViewModel Bob",
		Command 	= "ptp_viewmodel_bob",
		Type 		= "Integer",
		Min 		= "0",
		Max 		= "2",
	})
	panel:AddControl("Slider", {
		Label 	= "ViewModel Sway",
		Command 	= "ptp_viewmodel_sway",
		Type 		= "Integer",
		Min 		= "0",
		Max 		= "2",
	})
	
	

	local cbox = vgui.Create( "DComboBox", panel )
cbox:SetPos( 90, 725 )
cbox:SetSize( 120, 20 )

cbox:SetValue( "Default" )

-- Color choices
cbox:AddChoice( "1. Default", 1 )
cbox:AddChoice( "2. ActionFlash", 2 )
cbox:AddChoice( "3. MaxPayne", 3 )
cbox:AddChoice( "4. Over The Top", 4 )
cbox:AddChoice( "5. Boogaloo", 5 )

	 local DLabel = vgui.Create( "DLabel", panel )
DLabel:SetPos( 15, 725 )
DLabel:SetText( "Muzzle Flash:" )
DLabel:SetTextColor( Color(0, 0, 0, 255) )

function cbox:OnSelect( index, value, data )
	RunConsoleCommand( "ptp_flash_data", data )
end

end

/*---------------------------------------------------------
   Name: PTPToolMenu()
---------------------------------------------------------*/
function PTPToolMenu()

	spawnmenu.AddToolMenuOption("Options", "CS:S 13(PTP Base)", "Cross-hair Options", "Client-stuff", "", "", PTPCrosshairOptions, {SwitchConVar = 'ptp_crosshair_t'})
end
hook.Add("PopulateToolMenu", "PTPToolMenus", PTPToolMenu)

