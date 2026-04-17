-- t.me/urbanichka
antiAvoid = {}

if SERVER then
    AddCSLuaFile('antiavoid/cl_core.lua')
    AddCSLuaFile('antiavoid/sh_config.lua')

    include('antiavoid/sh_config.lua')
    include('antiavoid/sv_core.lua')

    for _, v in pairs (file.Find('antiavoid/detects/*', 'LUA') or {}) do
        include('antiavoid/detects/'..v)
    end
else
    include('antiavoid/sh_config.lua')
    include('antiavoid/cl_core.lua')
end