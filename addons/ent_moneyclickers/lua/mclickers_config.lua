-- 17.04
------------------------------------------------------------------------
------------------------------------------------------------------------
--  __  __                           ____ _ _      _                  --
-- |  \/  | ___  _ __   ___ _   _   / ___| (_) ___| | _____ _ __ ___  --
-- | |\/| |/ _ \| '_ \ / _ \ | | | | |   | | |/ __| |/ / _ \ '__/ __| --
-- | |  | | (_) | | | |  __/ |_| | | |___| | | (__|   <  __/ |  \__ \ --
-- |_|  |_|\___/|_| |_|\___|\__, |  \____|_|_|\___|_|\_\___|_|  |___/ --
--                          |___/                                     --
--                     ____             __ _                          --
--                    / ___|___  _ __  / _(_) __ _                    --
--                   | |   / _ \| '_ \| |_| |/ _` |                   --
--                   | |__| (_) | | | |  _| | (_| |                   --
--                    \____\___/|_| |_|_| |_|\__, |                   --
--                                           |___/                    --
------------------------------------------------------------------------
------------------------------------------------------------------------

MCLICKERS.clickDelay = 0.1       -- 0.1 seconds delay before being able to click again. This is to prevent auto-clickers.
MCLICKERS.clickRange = 80        -- Range in units that people can click.
MCLICKERS.wireUserEnabled = true -- Can the Wire User be used to withdraw money?
MCLICKERS.antiAutoClick = true   -- After a random amount of clicks, force the user to look away from the clicker.
MCLICKERS.useWorkshop = true    -- Use workshop downloading instead of FastDL for textures
MCLICKERS.stealing = true       -- Enable stealing mechanic, players are required to own (steal) to interact with someone's clicker
MCLICKERS.stealHoldTime = 10     -- How long to hold down in order to steal a clicker

MCLICKERS.SOUND_UI_HOVER = "garrysmod/ui_hover.wav"
MCLICKERS.SOUND_UI_CLICK = "garrysmod/ui_click.wav"
MCLICKERS.SOUND_CLICK    = "buttons/lightswitch2.wav"
MCLICKERS.SOUND_CYCLE    = "garrysmod/content_downloaded.wav"

MCLICKERS.MESSAGE_BREAK = "Один из ваших кликеров сломался!"
MCLICKERS.MESSAGE_UPGRADE_INSUFFICIENT = "Недостаточно средств для обновления"
MCLICKERS.MESSAGE_REPAIR_INSUFFICIENT = "Недостаточно средств для починки"
MCLICKERS.MESSAGE_WITHDRAW = "Ты получил %s."
MCLICKERS.MESSAGE_DEFAULT_UPGRADE_ALLOWED = "Ты не можешь обновить!"
MCLICKERS.MESSAGE_STOLEN = "Ты украл кликер!"
MCLICKERS.MESSAGE_NOT_OWNED = "Этот кликер должен быть ваш!"


MCLICKERS.language = {
    unitAutoClick    = "clicks/s",
    unitClickPower   = "power/click",
    unitCooling      = "heat/0.25s",
    unitStorage      = "storage",

    textWithdraw     = "Снять деньги",
    textRepair       = "Починить",
    textRepairWait   = "Подождите %is",
    textUpgrades     = "Обновления",

    textUpgradeMaxed = "МАКС",
    textPointsAmount = "%i Поинты",
    textMoney        = "Деньги",
    textPoints       = "Поинты",
    textSteal        = "Украсть",
    textStealHold    = "Удерживайте %is чтобы\nукрасть этот кликер",
}

--[[

----------------------------------------
-- How to add your own Money Clickers --
----------------------------------------

To add custom Money Clicker entities, you write the code below in
    darkrpmodification/lua/darkrp_customthings/entities.lua
The code below includes all configuration that is available, some are optional though.
Take a look at the examples further down for 3 tiers of Money Clickers!

To change the colors I recommend going to the following websites
    http://color.adobe.com/
    http://www.materialpalette.com/  -->  http://hex.colorrrs.com/  <--  Need to convert hex to RGB
Make sure the color format looks like this, Color(R, G, B) - example: Color(255, 150, 0) ]]

--[[DarkRP.createEntity("Кликер", { -- The name of the money clicker
    ent = "money_clicker", -- Do not change this class
    model = "models/props_c17/consolebox01a.mdl", -- Do not change this model
    price = 2500,
    max = 1,
    cmd = "buymoneyclicker1", -- This has to be a unique command for each Money Clicker
    mClickerInfo = {
        pointsPerCycle = 5,     -- How many points you get per cycle
        moneyPerCycle = 15,       -- How much money you get per cycle
        maxPoints = 1000,        -- The base points capacity
        maxMoney = 1500,         -- The base money capacity
        health = 100,            -- How much health it has, a crowbar deals 25 damage
        indestructible = false,  -- Can not be destroyed
        repairHealthCost = 100,  -- Repair health price in points
        maxCycles = 100,         -- Amount of cycles before it breaks, set to 0 to disable
        repairBrokenCost = 300, -- Repair price in money for when the clicker breaks down

        -- The stats the clickers have per upgrade level, each starts at level 1
        -- For example, when you first spawn in a clicker, it will auto click at
        -- a rate of 0 clicks/s which means no auto clicking at all.
        -- With no upgrades to click power, it will increase the progress by 10
        -- each click.
        -- The first entry for the prices is for the second upgrade, as the first
        -- upgrade is the one you have when the clicker is spawned.
        upgrades = {
            autoClick = {
                name = "Авт.Кликер",     -- The display name of the upgrade
                stats = { 0, 1, 2, 3, 4 },       -- Clicks per second, set per upgrade level
                prices = { 450, 550, 650, 750 }, -- Prices for the second upgrade and up (starts with first upgrade)

                -- OPTIONAL: Lua function to check if a player is allowed to purchase the next upgrade
                --           Check examples below for job and group whitelist
                --           Remove if you want all upgrade levels to be available to everyone
                customCheck = function(ply, upgrade, data, current, max)
                    -- Custom check, return true to prevent purchasing upgrade
                    return true, "Optional custom message"
                end,
            },
            clickPower = {
                name = "Сила Клика",         -- The display name of the upgrade
                stats = { 10, 12, 14, 16 },     -- Progress per click, set per upgrade level
                prices = { 430, 560, 730 },     -- Prices for the second upgrade and up (starts with first upgrade)
            },
            cooling = {
                name = "Охлаждение",         -- The display name of the upgrade
                stats = { 1.7, 2.2, 3.5, 5 },   -- Cooling per 0.25 seconds. For reference, max heat is 100
                prices = { 455, 570, 650 },     -- Prices for the second upgrade and up (starts with first upgrade)
            },
            storage = {
                name = "Объем",      -- The display name of the upgrade
                stats = { 1, 2, 3, 4 },         -- Storage modifier, starts at 1x storage
                prices = { 500, 650, 735 },     -- Prices for the second upgrade and up (starts with first upgrade)
            },
        },

        enableHeat = true, -- Make the clicker heat up when clicking it too much, will not blow it up but will disable it for a while
        heatPerClick = 20, -- Max heat is 100

    	colorPrimary = Color(139, 195, 74),  -- The primary color that is used for the entire model
    	colorSecondary = Color(255, 87, 34), -- The secondary color, AKA accent color, used for details
        colorText = Color(255, 255, 255),    -- The color of the text
        colorHealth = Color(255, 100, 100),  -- The color of the health icon
    },
})
]]
--[[You can add however many you want of these if you want different tiers of money clickers.
All of them should use entity "money_clicker"
Want to limit certain upgrades to certain jobs/groups? Check the ScriptFodder description
for some examples (Lua knowledge needed! However there is two examples that does this on the page)]]


--------------------------------
--       Example Setup        --
--------------------------------
-- Bronze, Silver, Gold Tiers --
--------------------------------
--[[
DarkRP.createEntity("Бронзовый Кликер", {
    ent = "money_clicker", -- Do not change this class
    model = "models/props_c17/consolebox01a.mdl", -- Do not change this model
    price = 5000,
    max = 1,
    cmd = "buymoneyclickerbronze",
    mClickerInfo = {
        pointsPerCycle = 5,
        moneyPerCycle = 45,
        maxPoints = 1000,
        maxMoney = 1500,
        health = 100,
        indestructible = false,
        repairHealthCost = 100,
        maxCycles = 100,
        repairBrokenCost = 450,

        upgrades = {
            autoClick = {
                name = "Авт.Кликер",
                stats = { 0, 1, 2, 3, 4 },
                prices = { 455, 550, 650, 765 },
            },
            clickPower = {
                name = "Сила Клика",
                stats = { 10, 12, 14, 16 },
                prices = { 440, 520, 650 },
            },
            cooling = {
                name = "Охлаждение",
                stats = { 1.7, 2.2, 3.5, 5 },
                prices = { 450, 550, 650 },
            },
            storage = {
                name = "Объем",
                stats = { 1, 2, 3, 4 },
                prices = { 530, 600, 720 },
            },
        },

        enableHeat = true,
        heatPerClick = 20,

    	colorPrimary = Color(139, 195, 74),
    	colorSecondary = Color(255, 87, 34),
        colorText = Color(255, 255, 255),
        colorHealth = Color(255, 100, 100),
    },
})

DarkRP.createEntity("Серебряный Кликер", {
    ent = "money_clicker", -- Do not change this class
    model = "models/props_c17/consolebox01a.mdl", -- Do not change this model
    price = 10000,
    max = 1,
    cmd = "buymoneyclickersilver",
    mClickerInfo = {
        pointsPerCycle = 5,
        moneyPerCycle = 55,
        maxPoints = 2000,
        maxMoney = 3500,
        health = 2000,
        indestructible = false,
        repairHealthCost = 100,
        maxCycles = 100,
        repairBrokenCost = 700,

        upgrades = {
            autoClick = {
                name = "Авт.кликер",
                stats = { 1, 2, 3, 4, 5 },
                prices = { 470, 555, 625, 750 },
            },
            clickPower = {
                name = "Сила Клика",
                stats = { 15, 17, 19, 21 },
                prices = { 450, 675, 800 },
            },
            cooling = {
                name = "Охлаждение",
                stats = { 1.8, 2.3, 3.6, 5.2 },
                prices = { 450, 575, 725 },
            },
            storage = {
                name = "Объем",
                stats = { 1, 2.5, 4, 6 },
                prices = { 450, 575, 625 },
            },
        },

        enableHeat = true,
        heatPerClick = 20,

    	colorPrimary = Color(139, 195, 74),
    	colorSecondary = Color(255, 87, 34),
        colorText = Color(255, 255, 255),
        colorHealth = Color(255, 100, 100),
    },
})

DarkRP.createEntity("Золотой Кликер", {
    ent = "money_clicker", -- Do not change this class
    model = "models/props_c17/consolebox01a.mdl", -- Do not change this model
    price = 17000,
    max = 1,
    cmd = "buymoneyclickergold",
    mClickerInfo = {
        pointsPerCycle = 7,
        moneyPerCycle = 65,
        maxPoints = 4000,
        maxMoney = 6000,
        health = 100,
        indestructible = true,
        repairHealthCost = 100,
        maxCycles = 100,
        repairBrokenCost = 900,

        upgrades = {
            autoClick = {
                name = "Авт.Кликер",
                stats = { 2, 3, 4, 5, 6 },
                prices = { 450, 565, 755, 870 },
            },
            clickPower = {
                name = "Сила Клика",
                stats = { 20, 22, 24, 26 },
                prices = { 450, 665, 875 },
            },
            cooling = {
                name = "Охлаждение",
                stats = { 2, 2.5, 4, 6 },
                prices = { 460, 625, 875 },
            },
            storage = {
                name = "Объем",
                stats = { 1, 3, 5, 8 },
                prices = { 450, 525, 775 },
            },
        },

        enableHeat = true,
        heatPerClick = 20,

    	colorPrimary = Color(139, 195, 74),
    	colorSecondary = Color(255, 87, 34),
        colorText = Color(255, 255, 255),
        colorHealth = Color(255, 100, 100),
    },
})
]]
