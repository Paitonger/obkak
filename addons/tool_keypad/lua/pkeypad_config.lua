-- t.me/urbanichka
----------------------------------------------------------------------------
----------------------------------------------------------------------------
--  ____       _   _                    _  __                          _  --
-- |  _ \ __ _| |_| |_ ___ _ __ _ __   | |/ /___ _   _ _ __   __ _  __| | --
-- | |_) / _` | __| __/ _ \ '__| '_ \  | ' // _ \ | | | '_ \ / _` |/ _` | --
-- |  __/ (_| | |_| ||  __/ |  | | | | | . \  __/ |_| | |_) | (_| | (_| | --
-- |_|   \__,_|\__|\__\___|_|  |_| |_| |_|\_\___|\__, | .__/ \__,_|\__,_| --
--                                               |___/|_|                 --
--                       ____             __ _                            --
--                      / ___|___  _ __  / _(_) __ _                      --
--                     | |   / _ \| '_ \| |_| |/ _` |                     --
--                     | |__| (_) | | | |  _| | (_| |                     --
--                      \____\___/|_| |_|_| |_|\__, |                     --
--                                             |___/                      --
----------------------------------------------------------------------------
----------------------------------------------------------------------------

PatternKeypad.clickRange         = 80 -- Max range a user can interact with the keypad

PatternKeypad.availableColors    = { -- Can either be in format Color(r, g, b) or "#RRGGBB"
    Color(59, 73, 84),
    Color(100, 255, 50),
    Color(255, 40, 20),
    "#D32F2F",
    "#C2185B",
    "#7B1FA2",
    "#512DA8",
    "#303F9F",
    "#1976D2",
    "#0288D1",
    "#0097A7",
    "#00796B",
    "#388E3C",
    "#689F38",
    "#AFB42B",
    "#FBC02D",
    "#FFA000",
    "#F57C00",
    "#E64A19",
    "#5D4037",
}

PatternKeypad.soundHover         = "garrysmod/ui_hover.wav" -- Sound when hovering ui elements
PatternKeypad.soundClick         = "buttons/button15.wav"   -- Sound when clicking ui elements
PatternKeypad.soundAccessGranted = "buttons/button9.wav"    -- Sound when access is granted
PatternKeypad.soundAccessDenied  = "buttons/button11.wav"   -- Sound when access is denied


----------------------------
-- Language configuration --
----------------------------

PatternKeypad.language = {
    toolName               = "Keypad",
    toolWireName           = "Keypad",
    toolInstruction        = "Левый клик: Создать/Обновить",
    toolDescription        = "Создает кейпады",

    toolGridColumns        = "Grid columns",
    toolGridRows           = "Grid rows",

    toolColorPrimary       = "Primary",
    toolColorSecondary     = "Secondary",
    toolColorGranted       = "Granted",
    toolColorDenied        = "Denied",

    toolWeld               = "Weld",
    toolFreeze             = "Freeze",
    toolOutputOn           = "Output On:",
    toolOutputOff          = "Output Off:",
    toolGrantedSettings    = "Access Granted Settings",
    toolDeniedSettings     = "Access Denied Settings",
    toolHoldLength         = "Hold Length:",
    toolInitialDelay       = "Initial Delay:",
    toolMultiplePressDelay = "Multiple Press Delay:",
    toolAdditionalRepeats  = "Additional Repeats:",
    toolDefaults           = "Default Settings",

    undo                   = "Undone Pattern Keypad",
    cleanName              = "Pattern Keypads",
    cleanedUp              = "Cleaned up all Pattern Keypads",
    limitReached           = "You've hit the Pattern Keypad limit!",

    textGranted            = "GRANTED",
    textDenied             = "DENIED",

    errorNoPattern         = "There is no pattern set!",
}
