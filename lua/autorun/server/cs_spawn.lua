-- t.me/urbanichka
---------------------- Resources For Guns ------------------------------------

resource.AddFile( "materials/vgui/entities/cs_glock18.vmt" );
resource.AddFile( "materials/vgui/entities/cs_glock18.vtf" );
resource.AddFile( "materials/vgui/entities/cs_ak47.vmt" );
resource.AddFile( "materials/vgui/entities/cs_ak47.vtf" );
resource.AddFile( "materials/vgui/entities/cs_deagle.vmt" );
resource.AddFile( "materials/vgui/entities/cs_deagle.vtf" );
resource.AddFile( "materials/vgui/entities/cs_mac10.vmt" );
resource.AddFile( "materials/vgui/entities/cs_mac10.vtf" );
resource.AddFile( "materials/vgui/entities/cs_fiveseven.vmt" );
resource.AddFile( "materials/vgui/entities/cs_fiveseven.vtf" );
resource.AddFile( "materials/vgui/entities/cs_p228.vmt" );
resource.AddFile( "materials/vgui/entities/cs_p228.vtf" );
resource.AddFile( "materials/vgui/entities/cs_galil.vmt" );
resource.AddFile( "materials/vgui/entities/cs_galil.vtf" );
resource.AddFile( "materials/vgui/entities/cs_mp5.vmt" );
resource.AddFile( "materials/vgui/entities/cs_mp5.vtf" );
resource.AddFile( "materials/vgui/entities/cs_mac10.vmt" );
resource.AddFile( "materials/vgui/entities/cs_mac10.vtf" );
resource.AddFile( "materials/vgui/entities/cs_galil.vmt" );
resource.AddFile( "materials/vgui/entities/cs_galil.vtf" );
resource.AddFile( "materials/vgui/entities/cs_famas.vmt" );
resource.AddFile( "materials/vgui/entities/cs_famas.vtf" );
resource.AddFile( "materials/vgui/entities/cs_p90.vmt" );
resource.AddFile( "materials/vgui/entities/cs_p90.vtf" );
resource.AddFile( "materials/vgui/entities/cs_aug.vmt" );
resource.AddFile( "materials/vgui/entities/cs_aug.vtf" );
resource.AddFile( "materials/vgui/entities/cs_ump.vmt" );
resource.AddFile( "materials/vgui/entities/cs_ump.vtf" );
resource.AddFile( "materials/vgui/entities/cs_m249.vmt" );
resource.AddFile( "materials/vgui/entities/cs_m249.vtf" );
resource.AddFile( "materials/vgui/entities/cs_tmp.vmt" );
resource.AddFile( "materials/vgui/entities/cs_tmp.vtf" );
resource.AddFile( "materials/vgui/entities/cs_usp.vmt" );
resource.AddFile( "materials/vgui/entities/cs_usp.vtf" );

---------------------- Selection Screen ------------------------------------

resource.AddFile( "materials/cs_selection/cs_glock18.png" );
resource.AddFile( "materials/cs_selection/cs_p228.png" );
resource.AddFile( "materials/cs_selection/cs_deagle.png" );
resource.AddFile( "materials/cs_selection/cs_fiveseven.png" );
resource.AddFile( "materials/cs_selection/cs_ak47.png" );
resource.AddFile( "materials/cs_selection/cs_aug.png" );
resource.AddFile( "materials/cs_selection/cs_m249.png" );
resource.AddFile( "materials/cs_selection/cs_famas.png" );
resource.AddFile( "materials/cs_selection/cs_tmp.png" );
resource.AddFile( "materials/cs_selection/cs_ump45.png" );
resource.AddFile( "materials/cs_selection/cs_usp.png" );
resource.AddFile( "materials/cs_selection/cs_galil.png" );
resource.AddFile( "materials/cs_selection/cs_mac10.png" );
resource.AddFile( "materials/cs_selection/cs_mp5.png" );
resource.AddFile( "materials/cs_selection/cs_m4.png" );
resource.AddFile( "materials/cs_selection/cs_xm1014.png" );
resource.AddFile( "materials/cs_selection/cs_p90.png" );


------ List upwards was made in the order the files were created. --------------

------ Initial Stuff -----------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
//ak47
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
sound.Add({
	name = 						"Weapon_AK47.Single",
	channel = 					CHAN_WEAPON,
	volume = 					1.0,
	pitch =						{ 100, 100 },
	sound = 					"weapons/ak47/ak47-1.wav"
})

sound.Add({
	name = 						"Weapon_AK47.Boltpull",
	channel = 					CHAN_ITEM,
	volume = 					1.0,
	pitch =						{ 95,105 },
	sound = 					"weapons/ak47/ak47_boltpull.wav"
})

sound.Add({
	name = 						"Weapon_AK47.Clipin",
	channel = 					CHAN_ITEM,
	volume = 					1.0,
	pitch =						{ 95,105 },
	sound = 					"weapons/ak47/ak47_clipin.wav"
})

sound.Add({
	name = 						"Weapon_AK47.Clipout",
	channel = 					CHAN_ITEM,
	volume = 					1.0,
	pitch =						{ 95,105 },
	sound = 					"weapons/ak47/ak47_clipout.wav"
})
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
//AUG
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
sound.Add({
	name = 						"Weapon_AUG.Single",
	channel = 					CHAN_WEAPON,
	volume = 					1.0,
	pitch =						{ 100, 100 },
	sound = 					"weapons/aug/aug-1.wav"
})

sound.Add({
	name = 						"Weapon_AUG.Boltpull",
	channel = 					CHAN_ITEM,
	volume = 					1.0,
	pitch =						{ 100, 100 },
	sound = 					"weapons/aug/aug_boltpull.wav"
})

sound.Add({
	name = 						"Weapon_AUG.Clipin",
	channel = 					CHAN_ITEM,
	volume = 					1.0,
	pitch =						{ 100, 100 },
	sound = 					"weapons/aug/aug_clipin.wav"
})

sound.Add({
	name = 						"Weapon_AUG.Clipout",
	channel = 					CHAN_ITEM,
	volume = 					1.0,
	pitch =						{ 100, 100 },
	sound = 					"weapons/aug/aug_clipout.wav"
})

sound.Add({
	name = 						"Weapon_AUG.Boltslap",
	channel = 					CHAN_ITEM,
	volume = 					1.0,
	pitch =						{ 100, 100 },
	sound = 					"weapons/aug/aug_boltslap.wav"
})

sound.Add({
	name = 						"Weapon_AUG.Forearm",
	channel = 					CHAN_ITEM,
	volume = 					1.0,
	pitch =						{ 100, 100 },
	sound = 					"weapons/aug/aug_forearm.wav"
})