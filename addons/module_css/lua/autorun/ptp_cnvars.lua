-- t.me/urbanichka
if GetConVar("sv_ptp_dashing_disable") == nil then
	CreateConVar("sv_ptp_dashing_disable", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE })
end
sound.Add({
	name = 			"pap.Single",
	channel = 		CHAN_ITEM,
	volume = 		1,
	sound = 			"weapons/universal/pap.wav"
})
