-- t.me/urbanichka
BANK_CONFIG = {} 
BANK_CONFIG.MinGovernment = 3 -- Minimum number of teams considered cops by the Bank needed to start a robbery. (0 to disable)
BANK_CONFIG.MinBankers = 0 -- Minimum number of teams considered bankers by the Bank needed to start a robbery. (0 to disable)
BANK_CONFIG.MinPlayers = 5 -- Minimum of players needed to start a robbery. (0 to disable)
BANK_CONFIG.BaseReward = 100000 -- The amount of money that each vault starts with.
BANK_CONFIG.Interest = 30000 -- The amount to increase in each interest.
BANK_CONFIG.CooldownTime = 600 -- The amount of time that you need to wait before you can rob the bank again after a failed/sucessfull robbery.
BANK_CONFIG.RobberyTime = 300 --  The amount of time needed to finish a bank robbery.
BANK_CONFIG.MaxDistance = 300 -- The maximum distance that you can go from the vault during a robbery.
BANK_CONFIG.LoopSiren = true -- Should the siren sound loop?
BANK_CONFIG.MaxReward = 3000000 -- The maximum reward for a successful robbery.
BANK_CONFIG.InterestTime = 120 -- The delay between increasing the vault's reward.
BANK_CONFIG.SaviorReward = 150000 -- The reward for killing the robber.
BANK_CONFIG.Government = { -- The teams considered cops by the bank.
    ['Капитан полиции'] = true, -- uses the name displayed in the F4 menu. (Uses the name displayed in the F4 menu)
    ['Сержант Полиции'] = true,
    ['Снайпер Полиции'] = true,
    ['Рядовой Полиции'] = true,
    ['Отряд Молот'] = true,
    ['Джаггернаут'] = true,
    ['Полицейский Медик'] = true,
    ['Киберсолдат'] = true,
    ['Мэр'] = true,
    ['Детектив'] = true,
}
BANK_CONFIG.Bankers = { -- The teams considered bankers by the bank. (Uses the name displayed in the F4 menu)
    ['Банкир'] = true,
}
BANK_CONFIG.Robbers = { -- The teams that can rob the vault. (Uses the name displayed in the F4 menu)
    ['Скейтер'] = true, 
    ['Мафия'] = true,
    ['Бандит'] = true,
    ['Вор'] = true,
    ['Громила'] = true,
    ['Лекарь Мафии'] = true,
    ['Хакер'] = true,
    ['Профессиональный Вор'] = true,
    ['Террорист'] = true,
}