-- t.me/urbanichka
dEvents = {}

if SERVER then
    for _, v in pairs (file.Find('devents/interface/*', 'LUA')) do
        AddCSLuaFile('devents/interface/'..v)
    end
    for _, v in pairs (file.Find('devents/interface/vgui/*', 'LUA')) do
        AddCSLuaFile('devents/interface/vgui/'..v)
    end
    AddCSLuaFile('devents/cl_data.lua')

    AddCSLuaFile('devents/sh_config.lua')
    AddCSLuaFile('devents/sh_util.lua')
    AddCSLuaFile('devents/sh_actions.lua')
    include('devents/sh_config.lua')
    include('devents/sh_util.lua')
    include('devents/sh_actions.lua')

    include('devents/sv_core.lua')
    include('devents/sv_actions.lua')
    include('devents/sv_net.lua')
else
    include('devents/sh_config.lua')
    include('devents/sh_util.lua')
    include('devents/sh_actions.lua')
    
    include('devents/cl_data.lua')

    for _, v in pairs (file.Find('devents/interface/*', 'LUA')) do
        include('devents/interface/'..v)
    end
    for _, v in pairs (file.Find('devents/interface/vgui/*', 'LUA')) do
        include('devents/interface/vgui/'..v)
    end
end