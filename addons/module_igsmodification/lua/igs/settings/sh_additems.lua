-- -- 17.04
-- local STORE_ITEM = FindMetaTable("IGSItem")
-- function STORE_ITEM:SetGlob()
-- 	self.Global = true
-- 	return self
-- end

-- local GIFT = IGS.NewGroup("Подарочные сертификаты"):SetIcon("https://i.imgur.com/5UnrIgQ.png")

--  GIFT:AddItem(
--  	IGS("Сертификат на 50 руб", "50rub")
--  	:SetPrice(55) -- 1000руб
--  	:SetIcon("https://i.imgur.com/5UnrIgQ.png")
--  	:SetTerm(0)
--  	:SetCategory('Подарок')
--  	:SetDescription("Подарочный сертификат на сумму 50 рублей! \n\nНе активируй его после покупки, подари кому-нибудь :)" )
--  	:SetOnActivate(function(pl) 
--         pl:AddIGSFunds(50, 'Подарочный сертификат на 50 руб')
--         IGS.NotifyAll(pl:Nick()..' активировал подарочный сертификат на сумму 50 руб')
--     end)
--  )

--  GIFT:AddItem(
--  	IGS("Сертификат на 100 руб", "100rub")
--  	:SetPrice(105) -- 1000руб
--  	:SetIcon("https://i.imgur.com/5UnrIgQ.png")
--  	:SetTerm(0)
--  	:SetCategory('Подарок')
--  	:SetDescription("Подарочный сертификат на сумму 100 рублей! \n\nНе активируй его после покупки, подари кому-нибудь :)" )
--  	:SetOnActivate(function(pl) 
--         pl:AddIGSFunds(100, 'Подарочный сертификат на 100 руб')
--         IGS.NotifyAll(pl:Nick()..' активировал подарочный сертификат на сумму 100 руб')
--     end)
--  )

--  GIFT:AddItem(
--  	IGS("Сертификат на 500 руб", "500rub")
--  	:SetPrice(505) -- 1000руб
--  	:SetIcon("https://i.imgur.com/5UnrIgQ.png")
--  	:SetTerm(0)
--  	:SetCategory('Подарок')
--  	:SetDescription("Подарочный сертификат на сумму 500 рублей! \n\nНе активируй его после покупки, подари кому-нибудь :)" )
--  	:SetOnActivate(function(pl) 
--         pl:AddIGSFunds(500, 'Подарочный сертификат на 500 руб')
--         IGS.NotifyAll(pl:Nick()..' активировал подарочный сертификат на сумму 500 руб')
--     end)
--  )

--  GIFT:AddItem(
--  	IGS("Сертификат на 1000 руб", "1000rub")
--  	:SetPrice(1005) -- 1000руб
--  	:SetIcon("https://i.imgur.com/5UnrIgQ.png")
--  	:SetTerm(0)
--  	:SetCategory('Подарок')
--  	:SetDescription("Подарочный сертификат на сумму 1000 рублей! \n\nНе активируй его после покупки, подари кому-нибудь :)" )
--  	:SetOnActivate(function(pl) 
--         pl:AddIGSFunds(1000, 'Подарочный сертификат на 1000 руб')
--         IGS.NotifyAll(pl:Nick()..' активировал подарочный сертификат на сумму 1000 руб')
--     end)
--  )


-- local GROUP = IGS.NewGroup("Игровая валюта"):SetIcon("https://i.imgur.com/QUHg2Bw.png")

--  GROUP:AddItem(
--  	IGS("10,000,000$", "10kk_deneg")
--  	:SetPrice(399) -- 1000руб
--  	:SetDarkRPMoney(10000000)
--  	:SetIcon("https://i.imgur.com/QUHg2Bw.png")
--  	:SetTerm(0)
--  )

--  GROUP:AddItem(
--  	IGS("5,000,000$", "5kk_deneg")
--  	:SetPrice(199) -- 500 руб
--  	:SetDarkRPMoney(5000000)
--   	:SetIcon("https://i.imgur.com/QUHg2Bw.png")
--  	:SetTerm(0)
--  )

--  GROUP:AddItem(
--  	IGS("1,000,000$", "1kk_deneg")
--  	:SetPrice(39) -- 100руб
--  	:SetDarkRPMoney(1000000)
--   	:SetIcon("https://i.imgur.com/QUHg2Bw.png")
--    	:SetTerm(0)
--  )
 
--  GROUP:AddItem(
--  	IGS("500,000$", "500k_deneg")
--  	:SetPrice(19) -- 50 руб
--  	:SetDarkRPMoney(500000)
--   	:SetIcon("https://i.imgur.com/QUHg2Bw.png")
--  	:SetTerm(0)
--  )
 
--   GROUP:AddItem(
--  	IGS("100,000$", "100k_deneg")
--  	:SetPrice(4) -- 10руб
--  	:SetDarkRPMoney(100000)
--   	:SetIcon("https://i.imgur.com/QUHg2Bw.png")
--  	:SetTerm(0)
--  )

-- IGS("VIP на 1 день", "vip_1d")
-- 	:SetPrice(5) -- 100 руб
-- 	:SetTerm(2)
-- 	:SetIcon("https://i.imgur.com/Id3p9o7.png")
-- 	:SetCategory("Привилегии")
-- 	:SetDescription(" - Имеет доступ ко всем вип профессиям \n - Имеет доступ ко всем VIP предметам \n - Дополнительный кликер" )
-- 	:SetFAdminGroup("VIP", 1)

-- IGS("VIP на 15 дней", "vip_15d")
-- 	:SetPrice(29) -- 100 руб
-- 	:SetTerm(15)
-- 	:SetIcon("https://i.imgur.com/Id3p9o7.png")
-- 	:SetCategory("Привилегии")
-- 	:SetDescription(" - Имеет доступ ко всем вип профессиям \n - Имеет доступ ко всем VIP предметам \n - Дополнительный кликер" )
-- 	:SetFAdminGroup("VIP", 1)

-- IGS("VIP на месяц", "vip_1m")
-- 	:SetPrice(49) -- 100 руб
-- 	:SetTerm(30)
-- 	:SetIcon("https://i.imgur.com/Id3p9o7.png")
-- 	:SetCategory("Привилегии")
-- 	:SetDescription(" - Имеет доступ ко всем вип профессиям \n - Имеет доступ ко всем VIP предметам \n - Дополнительный кликер" )
-- 	:SetFAdminGroup("VIP", 1)
	
-- IGS("VIP на 3 месяца", "vip_3m")
-- 	:SetPrice(129) -- 300р
-- 	:SetIcon("https://i.imgur.com/Id3p9o7.png")
-- 	:SetTerm(90) -- навсегда
-- 	:SetCategory("Привилегии")
-- 	:SetDescription(" - Имеет доступ ко всем вип профессиям \n - Имеет доступ ко всем VIP предметам \n - Дополнительный кликер")
-- 	:SetFAdminGroup("VIP", 2)

-- IGS("VIP навсегда", "vip_navsegda")
-- 	:SetPrice(299) -- 100 руб
-- 	:SetPerma()
-- 	:SetIcon("https://i.imgur.com/Id3p9o7.png")
-- 	:SetCategory("Привилегии")
-- 	:SetDescription(" - Имеет доступ ко всем вип профессиям \n - Имеет доступ ко всем VIP предметам \n - Дополнительный кликер" )
-- 	:SetFAdminGroup("VIP", 3)

-- IGS("DModerator на месяц", "dmoderator_1m")
-- 	:SetPrice(149) -- 250р
-- 	:SetIcon("https://i.imgur.com/VnesX87.png")
-- 	:SetTerm(30) -- навсегда
-- 	:SetCategory("Привилегии")
-- 	:SetDescription("- Имеет все привилегии VIP \n - Имеет доступ к функции бана/кика \n - Имеет доступ к функциям джайла \n - Может дать мут/гаг игроку \n - Имеет доступ к функции полета/бессмертия/невидимости \n - Имеет функцию бана/выдачи профессии \n - Имеет доступ к функции телепортирования")
-- 	:SetFAdminGroup("DModerator", 4)

-- IGS("DModerator на 3 месяца", "dmoderator_3m")
-- 	:SetPrice(299) -- 500р
-- 	:SetIcon("https://i.imgur.com/VnesX87.png")
-- 	:SetTerm(90) -- навсегда
-- 	:SetCategory("Привилегии")
-- 	:SetDescription("- Имеет все привилегии VIP \n - Имеет доступ к функции бана/кика \n - Имеет доступ к функциям джайла \n - Может дать мут/гаг игроку \n - Имеет доступ к функции полета/бессмертия/невидимости \n - Имеет функцию бана/выдачи профессии \n - Имеет доступ к функции телепортирования")
-- 	:SetFAdminGroup("DModerator", 5)

-- IGS("DModerator навсегда", "dmoderator_navsegda")
-- 	:SetPrice(599) -- 250р
-- 	:SetIcon("https://i.imgur.com/VnesX87.png")
-- 	:SetPerma() -- навсегда
-- 	:SetCategory("Привилегии")
-- 	:SetDescription("- Имеет все привилегии VIP \n - Имеет доступ к функции бана/кика \n - Имеет доступ к функциям джайла \n - Может дать мут/гаг игроку \n - Имеет доступ к функции полета/бессмертия/невидимости \n - Имеет функцию бана/выдачи профессии \n - Имеет доступ к функции телепортирования")
-- 	:SetFAdminGroup("DModerator", 6)
	
-- IGS("DAdmin на месяц", "dadmin_1m")
-- 	:SetPrice(299) -- 350р
-- 	:SetIcon("https://i.imgur.com/mXbzQ9M.png")
-- 	:SetTerm(30) -- навсегда
	
-- 	:SetCategory("Привилегии")
-- 	:SetDescription("- Имеет все привилегии VIP \n - Имеет все привилегии DModerator \n - Имеет доступ к функции бана/кика \n - Имеет доступ к функциям джайла \n - Может дать мут/гаг игроку \n - Имеет доступ к функции полета/бессмертия/невидимости \n - Имеет функцию бана/выдачи профессии \n - Имеет доступ к функции телепортирования \n - Может заморозить игрока \n - Может выдавать оружие \n - Может поджечь игрока \n - Может дать регдолл игроку")
-- 	:SetFAdminGroup("DAdmin", 7)
	
-- IGS("DAdmin на 3 месяца", "dadmin_3m")
-- 	:SetPrice(599) --  1000р
-- 	:SetIcon("https://i.imgur.com/mXbzQ9M.png")
-- 	:SetTerm(90) -- навсегда
-- 	:SetCategory("Привилегии")
	
-- 	:SetDescription("- Имеет все привилегии VIP \n - Имеет все привилегии DModerator \n - Имеет доступ к функции бана/кика \n - Имеет доступ к функциям джайла \n - Может дать мут/гаг игроку \n - Имеет доступ к функции полета/бессмертия/невидимости \n - Имеет функцию бана/выдачи профессии \n - Имеет доступ к функции телепортирования \n - Может заморозить игрока \n - Может выдавать оружие \n - Может поджечь игрока \n - Может дать регдолл игроку")
-- 	:SetFAdminGroup("DAdmin", 8)

-- IGS("DAdmin навсегда", "dadmin_navsegda")
-- 	:SetPrice(999) -- 350р
-- 	:SetIcon("https://i.imgur.com/mXbzQ9M.png")
-- 	:SetPerma() -- навсегда
-- 	:SetCategory("Привилегии")
-- 	:SetDescription("- Имеет все привилегии VIP \n - Имеет все привилегии DModerator \n - Имеет доступ к функции бана/кика \n - Имеет доступ к функциям джайла \n - Может дать мут/гаг игроку \n - Имеет доступ к функции полета/бессмертия/невидимости \n - Имеет функцию бана/выдачи профессии \n - Имеет доступ к функции телепортирования \n - Может заморозить игрока \n - Может выдавать оружие \n - Может поджечь игрока \n - Может дать регдолл игроку")
-- 	:SetFAdminGroup("DAdmin", 9)

-- IGS("DSAdmin на месяц", "dsadmin_1m")
-- 	:SetPrice(499) -- 1000р
-- 	:SetIcon("https://i.imgur.com/twA5nzp.png")
-- 	:SetTerm(30) -- навсегда
-- 	:SetCategory("Привилегии")
	
-- 	:SetDescription("- Имеет все привилегии VIP \n - Имеет все привилегии DModerator \n - Имеет все привилегии DAdmin \n Доступ к спавну через Q меню, оружия, энтити, транспорта, но только из категории Разрешено \n - При наличии доната 'Workshop модель' может менять её без ограничений!")
-- 	:SetFAdminGroup("DSAdmin", 10)
	
-- IGS("DSAdmin на 3 месяца", "dsadmin")
-- 	:SetPrice(999) -- 3000
-- 	:SetIcon("https://i.imgur.com/twA5nzp.png")
-- 	:SetTerm(90) -- навсегда
	
-- 	:SetCategory("Привилегии")
-- 	:SetDescription("- Имеет все привилегии VIP \n - Имеет все привилегии DModerator \n - Имеет все привилегии DAdmin \n Доступ к спавну через Q меню, оружия, энтити, транспорта, но только из категории Разрешено \n - При наличии доната 'Workshop модель' может менять её без ограничений!")
-- 	:SetFAdminGroup("DSAdmin", 11)

-- IGS("DSAdmin навсегда", "dsadmin_navsegda")
-- 	:SetPrice(1999) -- 1000р
-- 	:SetIcon("https://i.imgur.com/twA5nzp.png")
-- 	:SetPerma() -- навсегда
-- 	:SetCategory("Премиум")
	
-- 	:SetDescription("- Имеет все привилегии VIP \n - Имеет все привилегии DModerator \n - Имеет все привилегии DAdmin \n Доступ к спавну через Q меню, оружия, энтити, транспорта, но только из категории Разрешено \n - При наличии доната 'Workshop модель' может менять её без ограничений!")
-- 	:SetFAdminGroup("DSAdmin", 12)

-- IGS("Curator на 1 месяц", "curator_1m")
-- 	:SetPrice(999) -- 3000
-- 	:SetIcon("https://i.imgur.com/A7iqh76.png")
-- 	:SetTerm(30) -- навсегда
	
-- 	:SetCategory("Привилегии")
-- 	:SetDescription("- Имеет все привилегии VIP\n- Имеет все привилегии DModerator\n- Имеет все привилегии DAdmin\n- Имеет все привилегии DSAdmin\n-Имеет доступ к наборной системе жалоб\n- Иммунитет от хелперов\n- Имеет доступ к админ меню наборной администрации\n- Может установить себе размер\n- Может установить себе модель любого предмета\n- Имеет доступ к ивент меню \n- Может скринить экраны игроков \n- При наличии доната 'Workshop модель' может менять её без ограничений!")
-- 	:SetFAdminGroup("Curator", 13)
	
-- IGS("Curator на 3 месяца", "curator_6m")
-- 	:SetPrice(1999) -- 3000
-- 	:SetIcon("https://i.imgur.com/A7iqh76.png")
-- 	:SetTerm(90) -- навсегда
	
-- 	:SetCategory("Привилегии")
-- 	:SetDescription("- Имеет все привилегии VIP\n- Имеет все привилегии DModerator\n- Имеет все привилегии DAdmin\n- Имеет все привилегии DSAdmin\n-Имеет доступ к наборной системе жалоб\n- Иммунитет от хелперов\n- Имеет доступ к админ меню наборной администрации\n- Может установить себе размер\n- Может установить себе модель любого предмета\n- Имеет доступ к ивент меню \n- Может скринить экраны игроков \n- При наличии доната 'Workshop модель' может менять её без ограничений!")
-- 	:SetFAdminGroup("Curator", 14)

-- IGS("Curator навсегда", "curator_navsegda")
-- 	:SetPrice(4999) -- 3000
-- 	:SetIcon("https://i.imgur.com/A7iqh76.png")
-- 	:SetPerma() -- навсегда

-- 	:SetCategory("Премиум")
-- 	:SetDescription("- Имеет все привилегии VIP\n- Имеет все привилегии DModerator\n- Имеет все привилегии DAdmin\n- Имеет все привилегии DSAdmin\n-Имеет доступ к наборной системе жалоб\n- Иммунитет от хелперов\n- Имеет доступ к админ меню наборной администрации\n- Может установить себе размер\n- Может установить себе модель любого предмета\n- Имеет доступ к ивент меню \n- Может скринить экраны игроков \n- При наличии доната 'Workshop модель' может менять её без ограничений!")
-- 	:SetFAdminGroup("Curator", 15)

-- IGS("Patron", "patron_navsegda")
-- 	:SetPrice(44990) -- 3000
-- 	:SetIcon("https://i.imgur.com/maZxPns.png")
-- 	:SetPerma() -- навсегда
-- 	:SetCategory("Премиум")
-- 	:SetHighlightColor(Color(255,0,0,255))
-- 	:SetDescription("*Особая привилегия*\n**Возможна выдача роли в Discord сервере**\n\n- Весь функционал наборного администратора\n- Весь функционал донатных администраторов\n- Увеличенный инвентарь до размера хранилища\n- Переливающийся ник над головой\n- Переливающийся разноцветный скин\n - Переливающийся physgun\n- Наборная модель администратора за профессию Администратор\n- Неограниченая возможность изменения личной модели из Workshop\n- Доступ ко всему запрещенному оружию, включая RPG и все остальное\n- Все вопросы касаемо нарушений рассматриваются высшей администрацией")
-- 	:SetFAdminGroup("Patron", 16)

-- IGS("Сделать всех 2D", "2dplayer")
--     :SetPrice(49)
--     :SetIcon("https://i.imgur.com/NVEXZ6b.png")
--     :SetOnActivate(function(ply) 
--         PrintMessage(3, ply:Nick() .. " активировал событие 2D!") 
--         net.Start("Set2DPlayer")
--         net.Broadcast()
--     end)
--     :SetDescription("Установи всем игрокам 2D модели.")
--     :SetTerm(0)

-- IGS("Вовозелка", "wowozela")
-- 	:SetPrice(149) -- 3000
-- 	:SetIcon("https://i.imgur.com/NVEXZ6b.png")
-- 	:SetTerm(30) -- навсегда
--     :SetWeapon("wowozela")
--     :SetCategory("Оружие")
-- 	:SetDescription("Вовозелка\n- Позволяет издавать различные звуки с разноцветным эффектом\n- Еще ты можешь загрузить любые звуки из интернета в вовозелку\n- Даже свой голос с определенными фразами ;)")

-- IGS("Вовозелка навсегда", "wowozela_navsegda")
-- 	:SetPrice(999) -- 3000
-- 	:SetIcon("https://i.imgur.com/NVEXZ6b.png")
-- 	:SetPerma() -- навсегда
--     :SetWeapon("wowozela")
--     :SetCategory("Премиум")
-- 	:SetDescription("Вовозелка\n- Позволяет издавать различные звуки с разноцветным эффектом\n- Еще ты можешь загрузить любые звуки из интернета в вовозелку\n- Даже свой голос с определенными фразами ;)")

-- IGS("Говорилка", "govorilka")
-- 	:SetPrice(49) -- 3000
-- 	:SetIcon("https://i.imgur.com/NVEXZ6b.png")
-- 	:SetTerm(30) -- навсегда
-- 	:SetDescription("ГОВОРИЛКА\n- Озвучивает весь написаный текст вслух!\n- Используется голос из гугл переводчика")
	
-- IGS("Говорилка навсегда", "govorilka_navsegda")
-- 	:SetPrice(499) -- 3000
-- 	:SetIcon("https://i.imgur.com/NVEXZ6b.png")
-- 	:SetPerma() -- навсегда
--     :SetCategory("Премиум")
-- 	:SetDescription("ГОВОРИЛКА\n- Озвучивает весь написаный текст вслух!\n- Используется голос из гугл переводчика")

-- IGS("Разбан", "unban")
--     :SetPrice(99)
--     :SetIcon("https://i.imgur.com/scTFlOq.png")
--     :SetOnActivate(function(ply) FAdmin.UnBan( Entity(0), "", {ply:SteamID()} ) end)
--     :SetDescription("Ты забанен? Не хочешь ждать? Заплати и выйди из бана досрочно!")
--     :SetTerm(0)

-- IGS("HL2 Станстик", "wep_palka")
-- 	:SetPrice(19)
-- 	:SetTerm(30)
-- 	:SetWeapon("weapon_stunstick")
-- 	:SetDescription("Разрешает спавнить это оружие через спавн меню в любое время. Запрещено выдавать другим игрокам.")
-- 	:SetIcon("models/weapons/w_stunbaton.mdl", true) -- true значит, что указана моделька, а не ссылка

-- IGS("Магнум с бесконечными патронами", "magnun_hl2")
-- 	:SetPrice(19)
-- 	:SetTerm(30)
-- 	:SetWeapon("weapon_357")
-- 	:SetDescription("Разрешает спавнить это оружие через спавн меню в любое время.")
-- 	:SetIcon("models/weapons/w_357.mdl", true)

-- if SERVER then
--     hook.Add( "PlayerSwitchWeapon", "357_GiveAmmo", function( ply, oldWeapon, newWeapon )
--     	if (newWeapon:GetClass() == "weapon_357") and (ply:GetAmmoCount("357") < 100) then
--     		ply:GiveAmmo(100, "357", true)
--     	end
--     end )
-- end

-- IGS("Своя модель на месяц", "skinworkshop")
--     :SetPrice(179)
--     :SetTerm(30)
--     :SetIcon("https://i.imgur.com/scTFlOq.png")
--     :SetImage("https://i.imgur.com/GqtUvQK.png")
--     :SetDescription("Позволяет выбрать любую модель из Workshop до 11 мегабайт \n**МОДЕЛЬ МОЖНО НАДЕТЬ 1 РАЗ В ДЕНЬ**\n**DSAdmin и выше могут менять без ограничений!**")

-- IGS("CYBER PACK", "cyberitem")
--     :SetWeapon('laserjetpack')
--     :SetIcon("https://i.imgur.com/1zj0o5j.png")
--     :SetImage("https://i.imgur.com/JNz9Zcn.jpg")
--     :SetPrice(449)
--     :SetTerm(30)
--     :SetDescription("Набор из двух Кибер предметов, включая Ховерборды из вкладки 'Киберпонедельник' и оружие Laser Gun с помощью которого можно летать.\nЭтот донат можно купить только сегодня, завтра возможность приобрести эти предметы перестанет быть доступна.\nНикто включая администрацию не способен выдать эти предметы, они не выпадают после вашей смерти.")
--     :SetCategory("Оружие")

-- IGS("CYBER PACK навсегда", "cyberitem_navsegda")
--     :SetWeapon('laserjetpack')
--     :SetIcon("https://i.imgur.com/1zj0o5j.png")
--     :SetImage("https://i.imgur.com/JNz9Zcn.jpg")
--     :SetPrice(1999)
-- 	:SetHighlightColor(Color(0,0,255,255))
--     :SetPerma()
--     :SetDescription("Набор из двух Кибер предметов, включая Ховерборды из вкладки 'Киберпонедельник' и оружие Laser Gun с помощью которого можно летать.\nЭтот донат можно купить только сегодня, завтра возможность приобрести эти предметы перестанет быть доступна.\nНикто включая администрацию не способен выдать эти предметы, они не выпадают после вашей смерти.")
--     :SetCategory("Премиум")

-- IGS("Smart Pistol", "smartpistol")
--     :SetPrice(549)
--     :SetWeapon("mp_weapon_smart_pistol")
--     :SetIcon("https://i.imgur.com/g6FRIYH.jpg")
--     :SetTerm(30)
--     :SetDescription("Легендарный смарт пистолет из прекрасной игры под названием Titanfall \nПозволяет мгновенно нейтрализовать врагов.")
--     :SetCategory("Оружие")
    
-- IGS("Smart Pistol навсегда", "smartpistol_navsegda")
--     :SetPrice(1999)
--     :SetWeapon("mp_weapon_smart_pistol")
--     :SetIcon("https://i.imgur.com/g6FRIYH.jpg")
-- 	:SetHighlightColor(Color(0,0,255,255))
--     :SetPerma()
--     :SetDescription("Легендарный смарт пистолет из прекрасной игры под названием Titanfall \nПозволяет мгновенно нейтрализовать врагов.")
--     :SetCategory("Премиум")

-- IGS("Спавн оружия через Q меню", "weapon_spawn")
--     :SetIcon("https://i.imgur.com/NVEXZ6b.png")
--     :SetImage("https://i.imgur.com/8SrnJdd.png")
--     :SetPrice(99)
--     :SetTerm(30)
--     :SetDescription("Ты получаешь возможность спавнить оружия из Q меню, ТОЛЬКО из вкладки РАЗРЕШЕНОЕ")
--     :SetCategory("Оружие")

-- IGS("Спавн Entity через Q меню", "entity_spawn")
--     :SetIcon("https://i.imgur.com/NVEXZ6b.png")
--     :SetImage("https://i.imgur.com/N6mMFnf.jpg")
--     :SetPrice(99)
--     :SetTerm(30)
--     :SetDescription("Ты получаешь возможность спавнить энтити из вкладки Разрешено и Half-Life 2 ( не все предметы )")
--     :SetCategory("Разное")

-- IGS("+10 брони при спавне","ar_boost")
-- 	:SetPrice(49)
-- 	:SetStackable()
-- 	:SetMaxPlayerPurchases(10)
-- 	:SetPerma()
-- 	:SetDescription("Добавляет +10 брони при спавне")
--     :SetIcon("https://i.imgur.com/NVEXZ6b.png")
--     :SetCategory("Разное")
    
-- IGS("+10 к лимиту пропов","addprops")
-- 	:SetPrice(49)
-- 	:SetStackable()
-- 	:SetMaxPlayerPurchases(20)
-- 	:SetPerma()
-- 	:SetDescription("Добавляет +10 к лимиту пропов")
--     :SetIcon("https://i.imgur.com/NVEXZ6b.png")
--     :SetCategory("Разное")
    
-- IGS("WayZer Vape", "wayvape")
--     :SetPrice(49)
--     :SetWeapon("weapon_vape_wayzer")
--     :SetIcon("https://i.imgur.com/VaLWJ0L.jpg")
--     :SetPerma()
--     :SetDescription("Вейп с жижкой из логотипов сервера, ускоренно восстанавливает HP и Броню")
--     :SetCategory("Оружие")

-- IGS("Micvol Vape", "micvolvape")
--     :SetPrice(49)
--     :SetWeapon("weapon_vape_micvol")
--     :SetIcon("https://i.imgur.com/AoKKD8r.jpg")
--     :SetPerma()
--     :SetDescription("Вейп с жижкой из логотипов Micvol, медленно восстанавливает HP плюсуя сверху +10 хп. Очень быстро восстанавливает Броню")
--     :SetCategory("Оружие")

-- IGS("RyTra Vape", "rytravape")
--     :SetPrice(49)
--     :SetWeapon("weapon_vape_rytra")
--     :SetIcon("https://i.imgur.com/kq2owqZ.jpg")
--     :SetPerma()
--     :SetDescription("Вейп с жижкой из логотипов RyTra, медленно восстанавливает Броню обходя лимит 100 брони до 110. Зато очень быстро восстанавливает HP")
--     :SetCategory("Оружие")

-- IGS("Двойной прыжок", "doublejump")
--     :SetIcon("https://i.imgur.com/NVEXZ6b.png")
--     :SetPrice(49)
--     :SetTerm(30)
--     :SetDescription("Ты получаешь возможность совершить двойной прыжок за любую профессию на 30 дней")
--     :SetCategory("Разное")

-- IGS("Двойной прыжок навсегда", "doublejump_navsegda")
--     :SetIcon("https://i.imgur.com/NVEXZ6b.png")
--     :SetPrice(499)
--     :SetPerma()
--     :SetDescription("Ты получаешь возможность совершить двойной прыжок за любую профессию навсегда")
--     :SetCategory("Премиум")

-- hook.Add("PlayerLoadout", "IGS.SpawnArmor", function( ply )
-- 	local ar_boost = ply:HasPurchase('ar_boost')
-- 	if ar_boost then
-- 		timer.Simple(5,function()
-- 			local ar = ply:Armor()
-- 			ply:SetArmor(ar + (ar_boost*10))
-- 		end)
-- 	end
-- end)


-- local nodiscount = {}
-- nodiscount["Премиум"] = true

-- for _,ITEM in ipairs(IGS.GetItems()) do

-- if nodiscount[ITEM.category] then 
    
-- ITEM:SetDiscountedFrom( ITEM:Price() )
-- local percent = ITEM:Price() * 0.50
-- local cena = ITEM:Price() - percent
-- ITEM:SetPrice(math.floor(cena))
-- ITEM:SetHighlightColor(Color(math.random(0,255), math.random(0,255), math.random(0,255),255))
    
-- elseif (ITEM.category == 'Подарок') then 
--     continue
-- else

-- ITEM:SetDiscountedFrom( ITEM:Price() )

-- local percent = ITEM:Price() * 0.65
-- local cena = ITEM:Price() - percent
-- ITEM:SetPrice(math.floor(cena))
-- ITEM:SetHighlightColor(Color(math.random(0,255), math.random(0,255), math.random(0,255),255))
-- end
-- end