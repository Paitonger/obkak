-- 17.04

SWEP.DrawWeaponInfoBox = true
SWEP.Author			= 'doxzter'
SWEP.Purpose		= 'Почувствуй себя настоящим героем своих любимых гачи-фильмов.'
SWEP.Instructions	= "ЛКМ: Ушатать чувака\nПКМ: Просто показать свою силу\nR: Кинуть какую-нибудь смешную фразу"

SWEP.Category = "Запрещено"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.IconLetter				= "C"

SWEP.Primary.Sound			= Sound( "vo/novaprospekt/al_holdon.wav" )
SWEP.Primary.Recoil			= 0
SWEP.Primary.Damage			= 0
SWEP.Primary.NumShots		= -1
SWEP.Primary.Delay			= 50
SWEP.Primary.Distance		= 75

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.Delay		= 3

SWEP.ViewModel = Model("models/weapons/v_hands.mdl")
--SWEP.WorldModel = ""

local InProgress = false
SWEP.RapeLength = 20

SWEP.SoundDelay = 1.5


local sounds2 = {
	"bot/where_are_you_hiding.wav",
}

function SWEP:Initialize()
	--self:SetWeaponHoldType( self.HoldType )
end

function SWEP:DrawWorldModel()
end

function SWEP:Think()
end


function SWEP:DrawHUD()
end

function SWEP:PrimaryAttack()
	local tr = self.Owner:GetEyeTrace().Entity
	if not tr:IsValid() then return end
	if not tr:IsNPC() and not tr:IsPlayer() and not ( tr:GetClass() == 'prop_ragdoll' ) then return end

	RunConsoleCommand('RAPEDEMBITCHEZ', 'true')
end

function SWEP:SecondaryAttack()
	local tr = self.Owner:GetEyeTrace().Entity
	if not tr:IsValid() then return end
	if not tr:IsNPC() and not tr:IsPlayer() and not ( tr:GetClass() == 'prop_ragdoll' ) then return end

	RunConsoleCommand('RAPEDEMBITCHEZ')
end

function SWEP:Reload()
	if self.soundCooldown and self.soundCooldown > CurTime() then return end

	local sounds = {
		"iznas1.wav",
		"iznas2.wav",
	}

	if SERVER then
		self.Owner:EmitSound(sounds[math.random(1, #sounds)])
	end

	self.soundCooldown = CurTime() + 10
end