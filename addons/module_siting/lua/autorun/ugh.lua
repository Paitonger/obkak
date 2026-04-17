-- 17.04
if SERVER then
	AddCSLuaFile()
	return
end

hook.Remove("Think","Sitting_AltUse")