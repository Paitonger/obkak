-- t.me/urbanichka
DarkRP.createEntity("Рация", {
	ent = "entity_rachia",
	model = "models/props_c17/BriefCase001a.mdl",
	price = 15000,
	max = 10,
	sortOrder = 1,
	cmd = "rachia",
	allowed = {TEAM_GUN}
})

DarkRP.createEntity("Сундук для пожертвований", {
	ent = "donation_box",
	model = "models/props/CS_militia/footlocker01_open.mdl",
	price = 1000,
	max = 1,
	sortOrder = 1,
	cmd = "buydonationchest",
	allowed = {TEAM_HOBO, TEAM_AFHOBO}
})

DarkRP.createEntity("Радио", {
	ent = "radio",
	model = "models/props/cs_office/radio.mdl",
	price = 15000,
	max = 1,
	cmd = "radiomexannik",
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
})

DarkRP.createEntity("Игровой Автомат", {
	ent = "slot_machine",
	model = "models/props/slotmachine/slotmachinefinal.mdl",
	price = 50000,
	max = 5,
	cmd = "buyslot",
	category = "Other",
	allowed = {TEAM_BARMEN}
}) 

DarkRP.createEntity("Маленькая аптечка", {
	ent = "item_healthvial",
	model = "models/healthvial.mdl",
	price = 5000,
	max = 5,
	cmd = "buyhealth",
	category = "Other",
	allowed = {TEAM_VRACH}
})

DarkRP.createEntity("Большая аптечка", {
	ent = "item_healthkit",
	model = "models/items/healthkit.mdl",
	price = 15000,
	max = 5,
	cmd = "buyhealthbig",
	category = "Other",
	allowed = {TEAM_VRACH}
})

DarkRP.createCategory{
	name = "Bitminers 2",
	categorises = "entities",
	startExpanded = true,
	color = Color(120, 120, 255, 255),
	sortOrder = 1,
	allowed = {TEAM_MINERS}
}

DarkRP.createEntity("Bitminer S1", {
	ent = "bm2_bitminer_1",
	model = "models/bitminers2/bitminer_1.mdl",
	price = 5000,
	max = 4,
	cmd = "buybitminers1",
	category = "Bitminers 2",
	allowed = {TEAM_MINERS}
}) 

DarkRP.createEntity("Bitminer S2", {
	ent = "bm2_bitminer_2",
	model = "models/bitminers2/bitminer_3.mdl",
	price = 25000,
	max = 4,
	cmd = "buybitminers2",
	category = "Bitminers 2",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("Bitminer Server", {
	ent = "bm2_bitminer_server",
	model = "models/bitminers2/bitminer_2.mdl",
	price = 50000,
	max = 16,
	cmd = "buybitminerserver",
	category = "Bitminers 2",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("Bitminer Rack", {
	ent = "bm2_bitminer_rack",
	model = "models/bitminers2/bitminer_rack.mdl",
	price = 100000,
	max = 2,
	cmd = "buybitminerrack",
	category = "Bitminers 2",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("Extension Lead", {
	ent = "bm2_extention_lead",
	model = "models/bitminers2/bitminer_plug_3.mdl",
	price = 500,
	max = 8,
	cmd = "buybitminerextension",
	category = "Bitminers 2",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("Power Lead", {
	ent = "bm2_power_lead",
	model = "models/bitminers2/bitminer_plug_2.mdl",
	price = 500,
	max = 10,
	cmd = "buybitminerpowerlead",
	category = "Bitminers 2",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("Generator", {
	ent = "bm2_generator",
	model = "models/bitminers2/generator.mdl",
	price = 6000,
	max = 3,
	cmd = "buybitminergenerator",
	category = "Bitminers 2",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("Fuel", {
	ent = "bm2_fuel",
	model = "models/props_junk/gascan001a.mdl",
	price = 1000,
	max = 4,
	cmd = "buybitminerfuel",
	category = "Bitminers 2",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("Fuel Line", {
	ent = "bm2_extra_fuel_line",
	model = "models/bitminers2/bm2_extra_fuel_plug.mdl",
	price = 1500,
	max = 2,
	cmd = "buyfuelline",
	category = "Bitminers 2",
	allowed = {TEAM_MINERS}
}) 

DarkRP.createEntity("Large Fuel", {
	ent = "bm2_large_fuel",
	model = "models/props/de_train/barrel.mdl",
	price = 4000,
	max = 4,
	cmd = "buylargefuel",
	category = "Bitminers 2",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("Fuel Tank", {
	ent = "bm2_extra_fuel_tank",
	model = "models/bitminers2/bm2_extra_fueltank.mdl",
	price = 10000,
	max = 2,
	cmd = "buyfueltank",
	category = "Bitminers 2",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("Solar Cable", {
	ent = "bm2_solar_cable",
	model = "models/bitminers2/bm2_solar_plug.mdl",
	price = 500,
	max = 10,
	cmd = "buysolarcable",
	category = "Bitminers 2",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("Solar Converter", {
	ent = "bm2_solarconverter",
	model = "models/bitminers2/bm2_solar_converter.mdl",
	price = 20000,
	max = 1,
	cmd = "buysolarconverter",
	category = "Bitminers 2",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("Solar Panel", {
	ent = "bm2_solar_panel",
	model = "models/bitminers2/bm2_solar_panel.mdl",
	price = 15000,
	max = 10,
	cmd = "buysolarpanel",
	category = "Bitminers 2",
	allowed = {TEAM_MINERS}
})

-- метварщик

DarkRP.createEntity("Вода", {
	ent = "eml_water",
	model = "models/props_junk/garbage_plasticbottle003a.mdl",
	price = 1000,
	max = 2,
	cmd = "voda2",
	category = "Other",
	allowed = {TEAM_METH}
}) 

DarkRP.createEntity("Газ", {
	ent = "eml_gas",
	model = "models/props_c17/canister01a.mdl",
	price = 2000,
	max = 1,
	cmd = "balongas",
	category = "Other",
	allowed = {TEAM_METH}
}) 

DarkRP.createEntity("Жидкий йод", {
	ent = "eml_iodine",
	model = "models/props_lab/jar01b.mdl",
	price = 1000,
	max = 2,
	cmd = "jidkiyod",
	category = "Other",
	allowed = {TEAM_METH}
}) 

DarkRP.createEntity("Соляная кислота", {
	ent = "eml_macid",
	model = "models/props_junk/garbage_plasticbottle001a.mdl",
	price = 1500,
	max = 2,
	cmd = "acidsolyanka",
	category = "Other",
	allowed = {TEAM_METH}
}) 

DarkRP.createEntity("Жидкий Сульфур", {
	ent = "eml_sulfur",
	model = "models/props_lab/jar01b.mdl",
	price = 1500,
	max = 2,
	cmd = "sylfyr",
	category = "Other",
	allowed = {TEAM_METH}
}) 

DarkRP.createEntity("Печь", {
	ent = "eml_stove",
	model = "models/props_c17/furnitureStove001a.mdl",
	price = 10000,
	max = 1,
	cmd = "pechka",
	category = "Other",
	allowed = {TEAM_METH}
}) 

DarkRP.createEntity("Кастрюля для Красного фосфора", {
	ent = "eml_pot",
	model = "models/props_c17/metalPot001a.mdl",
	price = 1000,
	max = 2,
	cmd = "redfos",
	category = "Other",
	allowed = {TEAM_METH}
}) 

DarkRP.createEntity("Кастрюля для Метамфетамина", {
	ent = "eml_spot",
	model = "models/props_c17/metalPot001a.mdl",
	price = 1000,
	max = 2,
	cmd = "methhhh",
	category = "Other",
	allowed = {TEAM_METH}
}) 

DarkRP.createEntity("Бутылка", {
	ent = "eml_jar",
	model = "models/props_lab/jar01a.mdl",
	price = 1000,
	max = 1,
	cmd = "bytilka",
	category = "Other",
	allowed = {TEAM_METH}
})

-- Нарколог
DarkRP.createEntity("Метамфетамин", {
	ent = "durgz_meth",
	model = "models/katharsmodels/contraband/metasync/blue_sky.mdl",
	price = 5000,
	max = 10,
	cmd = "drugzmeth",
	allowed = {TEAM_MEDIC}, -- функция, которая переопределяет спаун для этой Энтити
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
})

DarkRP.createEntity("Марихуана", {
	ent = "durgz_weed",
	model = "models/katharsmodels/contraband/zak_wiet/zak_wiet.mdl",
	price = 6500,
	max = 10,
	cmd = "drugzmarix",
	allowed = {TEAM_MEDIC}, -- функция, которая переопределяет спаун для этой Энтити
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
})

DarkRP.createEntity("Аспирин", {
	ent = "durgz_aspirin",
	model = "models/jaanus/aspbtl.mdl",
	price = 4500,
	max = 10,
	cmd = "aspirin",
	allowed = {TEAM_MEDIC}, -- функция, которая переопределяет спаун для этой Энтити
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
})

DarkRP.createEntity("Кокаин", {
	ent = "durgz_cocaine",
	model = "models/cocn.mdl",
	price = 8000,
	max = 10,
	cmd = "drugzcoc",
	allowed = {TEAM_MEDIC}, -- функция, которая переопределяет спаун для этой Энтити
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
})

DarkRP.createEntity("Анитоксин", {
	ent = "durgz_water",
	model = "models/jaanus/aspbtl.mdl",
	price = 5000,
	max = 10,
	cmd = "drugzcocv",
	allowed = {TEAM_MEDIC}, -- функция, которая переопределяет спаун для этой Энтити
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
})

DarkRP.createEntity("Героин", {
	ent = "durgz_heroine",
	model = "models/katharsmodels/syringe_out/syringe_out.mdl",
	price = 10000,
	max = 10,
	cmd = "drugzcocvv",
	allowed = {TEAM_MEDIC}, -- функция, которая переопределяет спаун для этой Энтити
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
})

-- Продавец Оружия
-- Бармен
DarkRP.createEntity("RedBull", {
	ent = "durgz_alcohol",
	model = "models/drug_mod/alcohol_can.mdl",
	price = 20000,
	max = 5,
	cmd = "pivo",
	allowed = {TEAM_BARMEN}, -- функция, которая переопределяет спаун для этой Энтити
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
})

DarkRP.createEntity("Сигареты", {
	ent = "durgz_cigarette",
	model = "models/boxopencigshib.mdl",
	price = 20000,
	max = 5,
	cmd = "cigareta",
	allowed = {TEAM_BARMEN}, -- функция, которая переопределяет спаун для этой Энтити
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
})

DarkRP.createEntity("Вода", {
	ent = "durgz_water",
	model = "models/drug_mod/the_bottle_of_water.mdl",
	price = 300,
	max = 5,
	cmd = "voda",
	allowed = {TEAM_BARMEN}, -- функция, которая переопределяет спаун для этой Энтити
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
})

-- Нарколог
DarkRP.createEntity("PCP", {
	ent = "durgz_pcp",
	model = "models/cocn.mdl",
	price = 3000,
	max = 10,
	cmd = "drugzpcp",
	allowed = {TEAM_MEDIC}, -- функция, которая переопределяет спаун для этой Энтити
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
})

DarkRP.createEntity("ЛСД", {
	ent = "durgz_lsd",
	model = "models/cocn.mdl",
	price = 5000,
	max = 10,
	cmd = "drugzpcplsd",
	allowed = {TEAM_MEDIC}, -- функция, которая переопределяет спаун для этой Энтити  durgz_mushroom
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
})

DarkRP.createEntity("Наркоз", {
	ent = "durgz_mushroom",
	model = "models/cocn.mdl",
	price = 4500,
	max = 10,
	cmd = "drugznarcozz",
	allowed = {TEAM_MEDIC}, -- функция, которая переопределяет спаун для этой Энтити  durgz_mushroom
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
})

-- Разное
DarkRP.createEntity("VAPE Medical", {
	ent = "weapon_vape_medicinal",
	model = "models/swamponions/vape.mdl",
	price = 15000,
	max = 1,
	cmd = "vapemed",
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 100, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
customCheck = function(ply) return CLIENT or ply:GetUserGroup() ~= "user" end,
CustomCheckFailMsg = "Это только для VIP пользователей"
})

DarkRP.createEntity("VAPE", {
	ent = "weapon_vape",
	model = "models/swamponions/vape.mdl",
	price = 3000,
	max = 1,
	cmd = "vape",
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 100, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
customCheck = function(ply) return CLIENT or ply:GetUserGroup() ~= "user" end,
CustomCheckFailMsg = "Это только для VIP пользователей"
})

DarkRP.createEntity("VAPE Juicy", {
	ent = "weapon_vape_juicy",
	model = "models/swamponions/vape.mdl",
	price = 10000,
	max = 1,
	cmd = "vapejui",
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 100, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
customCheck = function(ply) return CLIENT or ply:GetUserGroup() ~= "user" end,
CustomCheckFailMsg = "Это только для VIP пользователей"
})

DarkRP.createEntity("VAPE Hallucinogenic", {
	ent = "weapon_vape_hallucinogenic",
	model = "models/swamponions/vape.mdl",
	price = 11200,
	max = 1,
	cmd = "vapehalium",
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 100, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
customCheck = function(ply) return CLIENT or ply:GetUserGroup() ~= "user" end,
CustomCheckFailMsg = "Это только для VIP пользователей"
})

DarkRP.createEntity("Броня", {
	ent = "item_battery",
	model = "models/Items/battery.mdl",
	price = 5000,
	max = 10,
	cmd = "bronaya",
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
customCheck = function(ply) return CLIENT or ply:GetUserGroup() ~= "user" end,
CustomCheckFailMsg = "Это только для VIP пользователей"
})

DarkRP.createEntity("Power Bank", {
	ent = "krede_wd_battery",
	model = "models/Items/battery.mdl",
	price = 25000,
	max = 5,
	cmd = "phonebat",
	allowed = {TEAM_HACKER}, -- функция, которая переопределяет спаун для этой Энтити  durgz_mushroom
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
})

DarkRP.createEntity("Гитара", {
	ent = "guitar",
	model = "models/props_phx/misc/fender.mdl",
	price = 10000,
	max = 2,
	cmd = "gitiaraaa",
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
	allowed = {TEAM_GUN},
})

DarkRP.createEntity("Бомба", {
	ent = "ent_timebomb",
	model = "models/weapons/w_c4.mdl",
	price = 35000,
	max = 1,
	cmd = "bombterror",
    category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
    sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
	allowed = {TEAM_BOMB},
})



// HALLOWEEN

DarkRP.createEntity("Фейерверк (CANDY PUFF)", {
    ent = "mortar_candypuff",
    model = "models/zerochain/props_firework/mortartube_retail_01.mdl",
    price = 15000,
    max = 4,
    cmd = "firehalloween",
  category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
  sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
})

DarkRP.createEntity("Фейерверк (DEMON FUZZ)", {
    ent = "mortar_demonfuzz",
    model = "models/zerochain/props_firework/mortartube_retail_01.mdl",
    price = 15000,
    max = 4,
    cmd = "firehalloweendemon",
  category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
  sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
})

DarkRP.createEntity("Фейерверк (PUMBKIN BLASTER)", {
    ent = "mortar_pumbkinblaster",
    model = "models/zerochain/props_firework/mortartube_retail_01.mdl",
    price = 15000,
    max = 4,
    cmd = "firehalloweenblaster",
  category = "Other", -- Название категории, в которой будет отображаться данный предмет. Учтите, что такая категория должна существовать!
  sortOrder = 1, -- Приоритет данного предмета; Чем ближе число к единице, тем выше предмет в списке
})

--[[You can add however many you want of these if you want different tiers of money clickers.
All of them should use entity "money_clicker"
Want to limit certain upgrades to certain jobs/groups? Check the ScriptFodder description
for some examples (Lua knowledge needed! However there is two examples that does this on the page)]]


--------------------------------
--       Example Setup        --
--------------------------------
-- Bronze, Silver, Gold Tiers --
--------------------------------

DarkRP.createEntity("Бронзовый Кликер", {
    ent = "money_clicker", -- Do not change this class
    model = "models/props_c17/consolebox01a.mdl", -- Do not change this model
    price = 5000,
    max = 2,
    cmd = "buymoneyclickerbronze",
    mClickerInfo = {
        pointsPerCycle = 20,
        moneyPerCycle = 130,
        maxPoints = 25000,
        maxMoney = 500000,
        health = 100,
        indestructible = false,
        repairHealthCost = 1500,
        maxCycles = 300,
        repairBrokenCost = 1500,

        upgrades = {
            autoClick = {
                name = "Авт.Кликер",
                stats = { 1, 2, 3, 4, 5 },
                prices = { 500, 1000, 2500, 3000 },
            },
            clickPower = {
                name = "Сила Клика",
                stats = { 3, 5, 7, 10},
                prices = { 500, 1000, 2500 },
            },
            cooling = {
                name = "Охлаждение",
                stats = { 1, 2, 4, 6 },
                prices = { 350, 500, 1000, 2500 },
            },
            storage = {
                name = "Объем",
                stats = { 1.3, 1.5, 2.5, 3 },
                prices = { 350, 500, 1000, 2500 },
            },
        },

        enableHeat = true,
        heatPerClick = 20,

    	colorPrimary = Color(185, 125, 0),
    	colorSecondary = Color(150, 100, 0),
        colorText = Color(255, 255, 255),
        colorHealth = Color(255, 255, 255),
    },
})

DarkRP.createEntity("Серебряный Кликер", {
    ent = "money_clicker", -- Do not change this class
    model = "models/props_c17/consolebox01a.mdl", -- Do not change this model
    price = 10000,
    max = 2,
    cmd = "buymoneyclickersilver",
    mClickerInfo = {
        pointsPerCycle = 25,
        moneyPerCycle = 150,
        maxPoints = 25000,
        maxMoney = 1000000,
        health = 100,
        indestructible = false,
        repairHealthCost = 100,
        maxCycles = 400,
        repairBrokenCost = 700,

        upgrades = {
            autoClick = {
                name = "Авт.кликер",
                stats = { 2, 3, 4, 5, 6 },
                prices = { 500, 1000, 2500, 3000 },
            },
            clickPower = {
                name = "Сила Клика",
                stats = { 6, 8, 10, 12 },
                prices = { 500, 1000, 2500 },
            },
            cooling = {
                name = "Охлаждение",
                stats = { 2, 3, 5, 6.5 },
                prices = { 350, 500, 1000, 2500 },
            },
            storage = {
                name = "Объем",
                stats = { 1, 2, 3, 4 },
                prices = { 350, 500, 1000, 2500 },
            },
        },

        enableHeat = true,
        heatPerClick = 20,

    	colorPrimary = Color(150, 150, 150),
    	colorSecondary = Color(100, 100, 100),
        colorText = Color(255, 255, 255),
        colorHealth = Color(255, 255, 255),
    },
})

DarkRP.createEntity("Алмазный Кликер", {
    ent = "money_clicker", -- Do not change this class
    model = "models/props_c17/consolebox01a.mdl", -- Do not change this model
    price = 35000,
    max = 2,
    cmd = "buyclickergold",
    mClickerInfo = {
        pointsPerCycle = 30,
        moneyPerCycle = 160,
        maxPoints = 40000,
        maxMoney = 1500000,
        health = 100,
        indestructible = false,
        repairHealthCost = 100,
        maxCycles = 500,
        repairBrokenCost = 900,

        upgrades = {
            autoClick = {
                name = "Авт.Кликер",
                stats = { 3, 4, 5, 6, 7 },
                prices = { 500, 1000, 2500, 3000 },
            },
            clickPower = {
                name = "Сила Клика",
                stats = { 8, 10, 12, 15 },
                prices = { 500, 1000, 2500 },
            },
            cooling = {
                name = "Охлаждение",
                stats = { 3, 4, 6, 12 },
                prices = { 350, 500, 1000, 2500 },
            },
            storage = {
                name = "Объем",
                stats = { 1, 2, 3, 4 },
                prices = { 350, 500, 1000, 2500 },
            },
        },

        enableHeat = true,
        heatPerClick = 20,

    	colorPrimary = Color(0, 220, 160),
    	colorSecondary = Color(0, 180, 140),
        colorText = Color(255, 255, 255),
        colorHealth = Color(255, 255, 255),
    },
})

DarkRP.createEntity("Сапфировый Кликер", {
    ent = "money_clicker", -- Do not change this class
    model = "models/props_c17/consolebox01a.mdl", -- Do not change this model
    price = 50000,
    max = 2,
    cmd = "buyklickerizy",
    mClickerInfo = {
        pointsPerCycle = 35,
        moneyPerCycle = 165,
        maxPoints = 70000,
        maxMoney = 2000000,
        health = 100,
        indestructible = false,
        repairHealthCost = 100,
        maxCycles = 600,
        repairBrokenCost = 900,

        upgrades = {
            autoClick = {
                name = "Авт.Кликер",
                stats = { 4, 5, 6, 7, 8 },
                prices = { 500, 1000, 2500, 3000 },
            },
            clickPower = {
                name = "Сила Клика",
                stats = { 10, 12, 14, 16 },
                prices = { 500, 1000, 2500 },
            },
            cooling = {
                name = "Охлаждение",
                stats = { 3.5, 5, 8, 15 },
                prices = { 350, 500, 1000, 2500 },
            },
            storage = {
                name = "Объем",
                stats = { 1.5, 2.5, 3.5, 4.5 },
                prices = { 350, 500, 1000, 2500 },
            },
        },

        enableHeat = true,
        heatPerClick = 20,

        colorPrimary = Color(140, 0, 255),
        colorSecondary = Color(100, 5, 180),
        colorText = Color(255, 255, 255),
        colorHealth = Color(255, 255, 255),
    },
})

DarkRP.createEntity("Рубиновый Кликер", {
    ent = "money_clicker", -- Do not change this class
    model = "models/props_c17/consolebox01a.mdl", -- Do not change this model
    price = 100000,
    max = 2,
    cmd = "buyklickervip",
    mClickerInfo = {
        pointsPerCycle = 45,
        moneyPerCycle = 180,
        maxPoints = 50000,
        maxMoney = 5000000,
        health = 500,
        indestructible = false,
        repairHealthCost = 100,
        maxCycles = 700,
        repairBrokenCost = 900,

        upgrades = {
            autoClick = {
                name = "Авт.Кликер",
                stats = { 5, 6, 7, 8, 9 },
                prices = { 500, 1000, 2500, 3000 },
            },
            clickPower = {
                name = "Сила Клика",
                stats = { 12, 14, 16, 20 },
                prices = { 500, 1000, 2500 },
            },
            cooling = {
                name = "Охлаждение",
                stats = { 5, 6, 10, 20 },
                prices = { 350, 500, 1000, 2500 },
            },
            storage = {
                name = "Объем",
                stats = { 3, 4, 5, 6 },
                prices = { 350, 500, 1000, 2500 },
            },
        },

        enableHeat = true,
        heatPerClick = 20,

        colorPrimary = Color(210, 0, 50),
        colorSecondary = Color(190, 0, 40),
        colorText = Color(255, 255, 255),
        colorHealth = Color(255, 255, 255),
    },
customCheck = function(ply) return CLIENT or ply:GetUserGroup() ~= "user" end,
CustomCheckFailMsg = "Это только для VIP пользователей"
})

DarkRP.createEntity("Компьютерный Корпус", {
	ent = "bit_case",
	model = "models/computer_updated/computer.mdl",
	price = 15000,
	max = 4,
	cmd = "buycomputercase",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("Cornet OS", {
	ent = "bit_cornet",
	model = "models/props_lab/binderredlabel.mdl",
	price = 1000,
	max = 4,
	cmd = "buycornetos",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("Windows OS", {
	ent = "bit_windows",
	model = "models/props_lab/bindergraylabel01b.mdl",
	price = 1500,
	max = 4,
	cmd = "buywindowsos",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("CPU", {
	ent = "bit_cpu",
	model = "models/props/cs_office/computer_caseb_p4a.mdl",
	price = 2050,
	max = 4,
	cmd = "buycpu",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("GPU", {
	ent = "bit_graphiccard",
	model = "models/props/cs_office/computer_caseb_p2a.mdl",
	price = 5200,
	max = 8,
	cmd = "buygpu",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("HDD", {
	ent = "bit_harddisk",
	model = "models/props/cs_office/computer_caseb_p6b.mdl",
	price = 750,
	max = 4,
	cmd = "buyhdd",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("Материнская Плата", {
	ent = "bit_motherboard",
	model = "models/props/cs_office/computer_caseb_p7a.mdl",
	price = 1500,
	max = 4,
	cmd = "buymobo",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("Блок Питания", {
	ent = "bit_powersupply",
	model = "models/props/cs_office/computer_caseb_p8a.mdl",
	price = 2500,
	max = 8,
	cmd = "buypowersupply",
	allowed = {TEAM_MINERS}
})

DarkRP.createEntity("RAM", {
	ent = "bit_ram",
	model = "models/props/cs_office/computer_caseb_p5b.mdl",
	price = 4500,
	max = 4,
	cmd = "buyram",
	allowed = {TEAM_MINERS}
})