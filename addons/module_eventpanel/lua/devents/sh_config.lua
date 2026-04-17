-- 17.04
dEvents.config = {
    adminGroups = {
        ['Patron'] = true,
        ['Curator'] = true,
        ['Eventer'] = true,
        ['+Eventer'] = true,
        ['Helper'] = true,
        ['+Helper'] = true,
        ['moder'] = true,
        ['admin'] = true,
        ['Trusted'] = true,
        ['WayZer Team'] = true,
        ['superadmin'] = true,
    },

    superAdminGroups = {
        ['Trusted'] = true,
        ['WayZer Team'] = true,
        ['superadmin'] = true,
    },

    maxPositions = 4,
    minEventMembers = 4,

    startTime = {min = 10, max = 60, default = 20},
    maxMembers = {min = 6, max = 30, default = 10},

    hp = {min = 1, max = 1000000, default = 100},
    armor = {min = 0, max = 1000000, default = 0},
    speedScale = {min = 0.5, max = 3, default = 1},
    jumpScale = {min = 0, max = 3, default = 1},
    modelScale = {min = 0.5, max = 1.5, default = 1},

    mainColor = Color(54,57,62),
    secondColor = Color(47,49,54),

    startMenuSize = {w = 0.2, h = 0.4},
    eventMenuSize = {w = 0.4, h = 0.3},
    giveWeaponSize = {w = 0.3, h = 0.5},
    adminMenuSize = {w = 0.3, h = 0.7},

    permittedCategories = {
        ['Разрешено'] = true,
        ['Counter-Strike: PTP'] = true,
    },
    permittedWeapons = {
        weapon_physgun = 'PhysGun',
        weapon_physcannon = 'GravityGun',
        weapon_fists = 'Кулаки',
        keys = 'Ключи',
        gmod_camera = 'Камера',
        gmod_tool = 'Тулган',
    },
    weaponPresets = {
        {
            name = 'Ничего не делать'
            -- Реально ничего не делает :flushed:
        },
        {
            name = 'Забрать все',
            weapons = {}, -- Да, это заберет все
        },
    }
}

dEvents.lang = {
    error_notEventer = 'Ты не являешься Ивентером',
    error_eventFounder = 'Ты уже проводишь ивент',
    error_noMembers = 'К ивенту никто не подключился :c',
    error_lowMembers = 'Ивент был отменен из-за недостатка участников',
    error_inEvent = 'Ты уже участвуешь в ивенте',
    error_eventNotExist = 'Ивент не существует',
    error_eventFull = 'Достигнуто максимальное количество участников',
    error_unknownCommand = 'Неизвестная команда',
    error_noEvent = 'Ты не проводишь ивент',
    error_arrested = 'Ты не можешь участвовать в ивенте из-за своего ареста',
    error_noEvents = 'Сейчас нет начинающихся ивентов',
    error_notInEvent = 'Ты сейчас не на ивенте',
    error_presetNameSize = 'Название пресета должно быть больше %s и меньше %s',
    error_eventPreparing = 'Сейчас начинается другой ивент. Попробуй позже',
    error_joining = 'Ты уже подключаешься к ивенту',
    error_notSAdmin = 'Ты не являешься Высшим Администратором',

    error_maxPositions = 'Достигнут лимит позиций',
    error_stripNotChosen = 'Ты не выбрал выдачу оружия',
    error_noPositions = 'Ты не установил позиции для ивента',

    hint_teleported = 'Ты был телепортирован на ивент, приятной игры! Если ты захочешь покинуть его, то используй команду /leave',
    hint_respawned = 'Ты был возвращен на ивент',
    hint_kicked = 'Ты был исключен из ивента',
    hint_died = 'Ты был исключен из ивента из-за смерти',
    hint_eventEnded = 'Ивент был завершен',
    hint_arrested = 'Ты был исключен из ивента из-за ареста',
    hint_joined = 'Ты зарегистрировался на ивент и скоро будешь телепортирован',
    hint_eventStarted = 'Ивент запущен',
    hint_left = 'Ты покинул ивент',

    hint_positionAdded = 'Позиция №%s установлена',

    vgui_preEvent = 'Начало ивента',
    vgui_preEvent_startTime = 'Существование команды',
    vgui_preEventPanelGuide = 'В этом меню ты можешь установить основные настройки для ивента.', --После его начала, тебе будут доступны более точные функции',
    vgui_preEvent_maxMembers = 'Максимум участников',
    vgui_preEvent_strip = 'Что с оружием?',
    vgui_preEvent_respawn = 'Включить возрождения',
    vgui_preEvent_positions = 'Установить точки телепорта',
    vgui_preEvent_start = 'Начать ивент',
    vgui_preEvent_posGuide = 'Устанавливай позиции в тех местах, где много свободного места, иначе игроки могут застревать в стенах или вовсе не телепортироваться',
    
    vgui_presetRemove = 'Выбери пресет, который ты хочешь удалить ниже',
    
    vgui_spectate = 'Наблюдать',
    vgui_goto = 'К нему',
    vgui_bring = 'К себе',

    event = 'Ивент',
    presetCreate = 'Создание пресета',
    giveWeapon = 'Выдача оружия',
    presetRemove = 'Удаление пресета',
    cooldown = 'Эй, не спеши так',

    log_usedCMD = 'Eventer %s(%s) used command %s on %s with args %s',
    log_eventStart = 'Eventer %s(%s) started event',
    log_eventEnd = 'Event from %s(%s) ended',
}