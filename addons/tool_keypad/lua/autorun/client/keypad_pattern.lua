-- t.me/urbanichka
local surface_SetDrawColor = surface.SetDrawColor
local rad = math.rad
local sin = math.sin
local cos = math.cos

function PatternKeypad.drawCircle(x, y, radius, seg, color)
    local cir = {}

    cir[#cir + 1] = { x = x, y = y, u = 0.5, v = 0.5 }
    for i = 0, 360, seg do
        local a = rad(-i)
        cir[#cir + 1] = { x = x + sin(a) * radius, y = y + cos(a) * radius, u = sin(a) / 2 + 0.5, v = cos(a) / 2 + 0.5 }
    end

    cir[#cir + 1] = { x = x + sin(0) * radius, y = y + cos(0) * radius, u = sin(0) / 2 + 0.5, v = cos(0) / 2 + 0.5 }

    surface_SetDrawColor(color)
    surface.DrawPoly(cir)
end

function PatternKeypad.lerpColor(a, b, x)
    a.r = a.r + (b.r - a.r) * x
    a.g = a.g + (b.g - a.g) * x
    a.b = a.b + (b.b - a.b) * x
    a.a = a.a + (b.a - a.a) * x

    return a
end

function PatternKeypad.hex2rgb(hex)
    hex = hex:gsub("#", "")

    return Color(
        tonumber("0x" .. hex:sub(1, 2)),
        tonumber("0x" .. hex:sub(3, 4)),
        tonumber("0x" .. hex:sub(5, 6)))
end


include("pkeypad/client/dpatterngrid.lua")
include("pkeypad/client/dcolorselector.lua")
