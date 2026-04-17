-- 17.04
PatternKeypad = PatternKeypad or {}

if SERVER then
    AddCSLuaFile("pkeypad_config.lua")
    AddCSLuaFile("pkeypad/client/dpatterngrid.lua")
    AddCSLuaFile("pkeypad/client/dcolorselector.lua")
end

include("pkeypad_config.lua")

function PatternKeypad.parseCombination(str)
    local arr = string.Explode(":", str)
    local sizeArr = string.Explode(",", arr[1])
    local comboArr = string.Explode(",", arr[2] or "")

    local width = math.Clamp(tonumber(sizeArr[1]) or 2, 2, 4)
    local height = math.Clamp(tonumber(sizeArr[2]) or 2, 2, 4)
    local combination = {}
    local usedIds = {}

    if #comboArr > 1 then
        for i = 1, #comboArr do
            local num = tonumber(comboArr[i])
            if not num then break end

            local id = width + math.Clamp(num, 1, width * height)

            if usedIds[id] then
                combination = {}
                break
            end

            combination[i] = id
            usedIds[id] = true
        end
    end

    return width, height, combination
end

function PatternKeypad.parseColor(str)
	local arr = string.Explode(",", str)

	local r = math.Clamp(tonumber(arr[1]) or 0, 0, 255)
	local g = math.Clamp(tonumber(arr[2]) or 0, 0, 255)
	local b = math.Clamp(tonumber(arr[3]) or 0, 0, 255)
	local a = math.Clamp(tonumber(arr[4]) or 0, 0, 255)

    return Color(r, g, b, a)
end

function PatternKeypad.error(...)
    MsgC(Color(255, 150, 0), "[PKeypad-Error] ", ...)
    MsgC("\n")
end

function PatternKeypad.print(...)
    MsgC(Color(0, 255, 0), "[PKeypad] ", Color(255, 255, 255), ...)
    MsgC("\n")
end

if SERVER then
    include("pkeypad/version.lua")
end
