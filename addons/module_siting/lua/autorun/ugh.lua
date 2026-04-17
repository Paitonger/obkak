-- t.me/urbanichka
if SERVER then
	AddCSLuaFile()
	return
end

hook.Remove("Think","Sitting_AltUse")