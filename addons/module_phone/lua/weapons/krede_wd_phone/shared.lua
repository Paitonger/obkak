-- 17.04
SWEP.PrintName = "Watch_Phone"
SWEP.Author =	"Krede"
SWEP.Contact =	"Steam"
SWEP.Purpose =	"Left-click to hack entities. Right click to perform a blackout."

SWEP.Spawnable =	true
SWEP.Adminspawnable =	true
SWEP.Category = "Запрещено"

SWEP.Primary.Clipsize =	-1
SWEP.Primary.DefaultClip =	-1
SWEP.Primary.Automatic =	true
SWEP.Primary.Ammo =	"none"

SWEP.Secondary.Clipsize =	-1
SWEP.Secondary.DefaultClip =	-1
SWEP.Secondary.Automatic =	false
SWEP.Secondary.Ammo =	"none"

function SWEP:PrimaryAttack()
	if CLIENT then return false end
	if GetConVar("wd_adminonly"):GetBool() and !self.Owner:IsAdmin() then
		self.Weapon:SetNextPrimaryFire( CurTime() + 0.8 )
		self.Weapon:SetNextSecondaryFire( CurTime() + 0.8 )
		self.Owner:ChatPrint("Only admins can use this swep")
		return false
	end
	if self.Owner:GetNWInt("CanHack") == 1 then return false end
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.8 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 0.8 )
	timer.Simple(0.35, function()
		if self == NULL or !IsValid(self) then return false end
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_1 )
		if self.Owner:GetViewEntity() != self.Owner then
			local pos = self.Owner:GetViewEntity():GetPos()
			local ang = self.Owner:GetViewEntity():GetForward()
			local td = {}
			td.start = pos
			td.endpos = pos+(ang*2000)
			td.filter = self.Owner:GetViewEntity()
			trace = util.TraceLine(td)
			target = trace.Entity
		else
			local pos = self.Owner:GetShootPos()
			local ang = self.Owner:GetAimVector()
			local td = {}
			td.start = pos
			td.endpos = pos+(ang*2000)
			td.filter = self.Owner
			trace = util.TraceLine(td)
			target = trace.Entity
		end
		if target == NULL or !IsValid(target) then
			for num,ent in pairs(ents.FindInSphere(trace.HitPos, 200)) do
				for class,tbl in pairs(Krede_WD_HaxList) do
					if ent:GetClass() == class and self.Owner:GetViewEntity() != ent or string.find(class, "*") and string.find(ent:GetClass(), string.gsub(class,"*","")) and ent != self.Owner:GetViewEntity() then
						if target == NULL or !IsValid(target) or trace.HitPos:Distance( ent:GetPos() ) < trace.HitPos:Distance( target:GetPos() ) then
							target = ent
						end
					end
				end
			end
			if target != NULL and IsValid(target) then
				for class,tbl in pairs(Krede_WD_HaxList) do
					if target:GetClass() == class and self.Owner:GetViewEntity() != target or string.find(class, "*") and string.find(target:GetClass(), string.gsub(class,"*","")) and target != self.Owner:GetViewEntity() then
						if GetConVar("wd_needbattery"):GetBool() then
							if self:GetNWInt("Battery") < tbl.cost then return false end
							self:SetNWInt("Battery", self:GetNWInt("Battery") - tbl.cost)
						end
						net.Start("WP_GlowingEnt")
							net.WriteEntity(target)
						net.Send( self.Owner )
						timer.Simple(0.4, function()
							if self == NULL or !IsValid(self) then return false end
							if self.Owner == NULL or !IsValid(self.Owner) then return false end
							net.Start("WP_GlowingEnt")
								net.WriteEntity(NULL)
							net.Send( self.Owner )
						end)
						tbl.use(target, self.Owner)
					end
				end
			end
			return false
		end
		for class,ent in pairs(Krede_WD_HaxList) do
			if target:GetClass() == class or string.find(class, "*") and string.find(target:GetClass(), string.gsub(class,"*","")) then
				if GetConVar("wd_needbattery"):GetBool() then
					if self:GetNWInt("Battery") < ent.cost then return false end
					self:SetNWInt("Battery", self:GetNWInt("Battery") - ent.cost)
				end
				net.Start("WP_GlowingEnt")
					net.WriteEntity(target)
				net.Send( self.Owner )
				timer.Simple(0.4, function()
					if self == NULL or !IsValid(self) then return false end
					if self.Owner == NULL or !IsValid(self.Owner) then return false end
					net.Start("WP_GlowingEnt")
						net.WriteEntity(NULL)
					net.Send( self.Owner )
				end)
				ent.use(target, self.Owner)
				return true
			end
		end
	end)
end


function SWEP:SecondaryAttack()
	if CLIENT then return end
	if GetConVar("wd_adminonly"):GetBool() and !self.Owner:IsAdmin() then
		self.Weapon:SetNextPrimaryFire( CurTime() + 0.8 )
		self.Weapon:SetNextSecondaryFire( CurTime() + 0.8 )
		self.Owner:ChatPrint("Only admins can use this swep")
		return false
	end
	if GetConVar("wd_allowblackout"):GetBool() == false and !self.Owner:IsAdmin() then
		self.Weapon:SetNextPrimaryFire( CurTime() + 0.8 )
		self.Weapon:SetNextSecondaryFire( CurTime() + 0.8 )
		self.Owner:ChatPrint("Only admins can perform blackouts")
		return false
	end
	if self.Owner:GetNWInt("CanHack") == 1 then return false end
	if GetConVar("wd_needbattery"):GetBool() then
		if self:GetNWInt("Battery") < 3 then return false end
	end
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.8 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 30 )
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		timer.Simple(0.35, function()
		if self == NULL or !IsValid(self) then return false end
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_1 )
		local ent = ents.Create("krede_wd_blackout_thrown")
		ent.Owner = self.Owner
		ent:SetPos(self.Owner:GetPos()+Vector(0,0,20))
		ent:Spawn()
		if GetConVar("wd_needbattery"):GetBool() then
			self:SetNWInt("Battery", self:GetNWInt("Battery") - 3)
		end
	end)
end

function SWEP:Deploy()
	if SERVER then
		self:SetNWInt("CameraLength", 0)
		if self.Owner:GetNWInt("CanHack") == 0 then
			self.Owner:SetNWInt("CanHack", 2)
		end
		self:SetNWBool("Camera", false)
		self.Owner:SetViewEntity( self.Owner )
	end
	return true
end

function SWEP:Think()
	if self:GetNWInt("Battery") < 6 then
		if self.ChargeTime < CurTime() then
			self.ChargeTime = CurTime() + 15
			self:SetNWInt("Battery", self:GetNWInt("Battery") + 1)
		end
	else
		self.ChargeTime = CurTime() + 15
	end
	if self.Owner:GetNWInt("CanHack") == 1 then return false end
	if self:GetNWBool("Camera") then
		if self.Owner:KeyDown( IN_SPEED ) then
			Speed = 0.5
		else
			Speed = 0.3
		end
		if self.Owner:KeyDown( IN_BACK ) then
			self.Owner:GetViewEntity():SetAngles( self.Owner:GetViewEntity():GetAngles() + Angle(Speed,0,0))
		elseif self.Owner:KeyDown( IN_FORWARD ) then
			self.Owner:GetViewEntity():SetAngles( self.Owner:GetViewEntity():GetAngles() + Angle(-Speed,0,0))
		elseif self.Owner:KeyDown( IN_MOVERIGHT ) then
			self.Owner:GetViewEntity():SetAngles( self.Owner:GetViewEntity():GetAngles() + Angle(0,-Speed,0))
		elseif self.Owner:KeyDown( IN_MOVELEFT ) then
			self.Owner:GetViewEntity():SetAngles( self.Owner:GetViewEntity():GetAngles() + Angle(0,Speed,0))
		end
	end
	if self.HackedEnt and self.HackedEnt != NULL and IsValid(self.HackedEnt) and self.HackedEnt:Alive() then
		if self.HackedEnt:GetNWInt("HackProgress") < 100 then
			self.HackedEnt:SetNWInt("HackProgress", self.HackedEnt:GetNWInt("HackProgress") + 0.025)
		else
			self.HackedEnt:SetNWInt("Hacker", NULL)
			self.HackedEnt:SetNWInt("HackProgress", 0)
			self.HackedEnt = nil
			target.WDHackCoolDown = CurTime()+300
		end
	elseif self.HackedEnt and self.HackedEnt != NULL and IsValid(self.HackedEnt) then
		self.HackedEnt:SetNWInt("Hacker", NULL)
		self.HackedEnt:SetNWInt("HackProgress", 0)
		self.HackedEnt = nil
	end
end

function SWEP:Reload()
	if self:GetNWBool("Camera") then
		self:SetNWBool("Camera", false)
		self.Owner:SetViewEntity( self.Owner )
	end
end

function SWEP:DrawHUD()
	if GetConVar("wd_needbattery") and GetConVar("wd_needbattery"):GetBool() then
		draw.RoundedBox(8, ScrW()/4, ScrH()-60, 142, 30, Color(0,0,0,150))
		for i = 1, self:GetNWInt("Battery") do
			draw.RoundedBox(4, math.ceil(ScrW()/4+4)+math.ceil(i*22)-20, ScrH()-55, 20, 20, Color(255,255,255,255))
		end
	end
end

SWEP.ViewModelFOV = 55
SWEP.HoldType = "slam"
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_buddyfinder.mdl"
SWEP.WorldModel = "models/nitro/iphone4.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.DrawCrosshair = false
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_MobilePhone"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
SWEP.VElements = {
	["IPhone"] = { type = "Model", model = "models/nitro/iphone4.mdl", bone = "ValveBiped.Bip01_MobilePhone", rel = "", pos = Vector(1.728, 1.774, -1.912), angle = Angle(-2.198, -90.477, 180), size = Vector(1.11, 1.01, 1.11), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/nitro/haxphone", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["IPhone"] = { type = "Model", model = "models/nitro/iphone4.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.077, 2.717, -0.733), angle = Angle(-145.758, 21.754, -7.199), size = Vector(1.171, 1.171, 1.171), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/nitro/haxphone", skin = 0, bodygroup = {} }
}


function SWEP:Initialize()

	// other initialize code goes here
	
	self:SetWeaponHoldType( self.HoldType )
	self.ChargeTime = CurTime() + 15
	self:SetNWInt("Battery", 6)

	if CLIENT then
	
		// Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
		// init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				// Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					// we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					// ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					// however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")			
				end
			end
		end
		
	end

end

function SWEP:Holster()
	
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	if SERVER and self.Owner then
		if self:GetNWBool("Camera") then
			self:SetNWBool("Camera", false)
			self.Owner:SetViewEntity( self.Owner )
		end
	end
	
	return true
end

function SWEP:OnRemove()
	if self.HackedEnt and self.HackedEnt != NULL and IsValid(self.HackedEnt) then
		self.HackedEnt:SetNWInt("Hacker", NULL)
		self.HackedEnt:SetNWInt("HackProgress", 0)
		self.HackedEnt = nil
	end
	self:Holster()
end

if CLIENT then

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then
			
			// we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}

			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			// when the weapon is dropped
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			// Technically, if there exists an element with the same name as a bone
			// you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r // Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		// Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				// make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			// !! WORKAROUND !! //
			// We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			// !! ----------- !! //
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				// !! ----------- !! //
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	/**************************
		Global utility code
	**************************/

	// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	// Does not copy entities of course, only copies their reference.
	// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end