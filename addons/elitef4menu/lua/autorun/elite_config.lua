
ELITE = {}

ELITE.StaffListRanks = { "superadmin", "admin", "founder", "root"} 
ELITE.ShowFoodTab = true 

ELITE.VIPJobCheckbox = true 

ELITE.OpenWebsiteInOverlay = true 

ELITE.WebsiteURL = "http://vk.com/urbanichka"

timer.Simple( 1, function()
    ELITE.AccessToCPCmds = { TEAM_CHIEF, TEAM_POLICE }
    
    ELITE.AccessToMayorCmds = { TEAM_MAYOR }
end)

MONEYCMD_BUTTONS = {}
RPCMD_BUTTONS = {}
CPCMD_BUTTONS = {}
MAYORCMD_BUTTONS = {}
OTHERCMD_BUTTONS = {}

local function MenuAddMButton( n, f ) 
    table.insert(WEB_BUTTONS, { Title = n, Func = f } )
end
 
local function MenuAddMButton( n, f )
    table.insert(MONEYCMD_BUTTONS, { NAME = n, FUNC = f } )
end

local function MenuAddRPButton( n, f )
    table.insert(RPCMD_BUTTONS, { NAME = n, FUNC = f } )
end

local function MenuAddCPButton( n, f )
    table.insert(CPCMD_BUTTONS, { NAME = n, FUNC = f } )
end

local function MenuAddMayorButton( n, f )
    table.insert(MAYORCMD_BUTTONS, { NAME = n, FUNC = f } )
end

local function MenuAddOtherButton( n, f )
    table.insert(OTHERCMD_BUTTONS, { NAME = n, FUNC = f } )
end

MenuAddMButton( "Передать деньги игроку, смотрите на него", function() OpenTextBox( "Передача денег игроку", "Сколько вы хотите дать денег?", "/give" ) end )
MenuAddMButton( "Выбросить деньги", function() OpenTextBox( "Выбросить деньги", "Сколько вы хотите выбросить денег", "/moneydrop" ) end )

MenuAddRPButton( "Изменить РП имя", function() OpenTextBox( "Смена RP имени", "Какое ваше новое имя?", "/rpname" ) end )
MenuAddRPButton( "Выкинуть текущее оружие", function() RunConsoleCommand( "say", "/drop" ) end )
MenuAddRPButton( "Запросить лицензию на оружие", function() RunConsoleCommand( "say", "/requestlicense" ) end )
MenuAddRPButton( "Уволить игрока", function() OpenPlyReasonBox( "Demote система", "Выберите игрока из списка ниже и напишите причину увольнения", "", "/demote" ) end )
MenuAddRPButton( "Продать все вами купленные двери", function() RunConsoleCommand( "say", "/unownalldoors" ) end )

MenuAddCPButton( "Объявить в розыск", function() OpenPlyReasonBox( "Объявление игрока в розыск", "Выберите из списка нарушиля и укажите причину розыска.", "", "/wanted" ) end )
MenuAddCPButton( "Снять розыск", function() OpenPlyBox( "Убрать розыск ", "С кого снять розыск?", "/unwanted" ) end )
MenuAddCPButton( "Взять ордер на обыск", function() OpenPlyReasonBox( "Обыск", "Выберите игрока из списка ниже и напишите причину обыска", "", "/warrant" ) end )

MenuAddMayorButton( "Объявить в розыск", function() OpenPlyReasonBox( "Wanted someone", "Who?", "Why?", "/wanted" ) end )
MenuAddMayorButton( "Снять розыск", function() OpenPlyBox( "Unwanted ", "Who?", "/unwanted" ) end )
MenuAddMayorButton( "Выдать ордер на обыск", function() OpenPlyReasonBox( "Warrant", "Who?", "Why?", "/warrant" ) end )
MenuAddMayorButton( "Запустить ком.час", function() RunConsoleCommand( "say", "/lockdown" ) end )
MenuAddMayorButton( "Закончить ком.час", function() RunConsoleCommand( "say", "/unlockdown" ) end )

-- vk.com/urbanichka