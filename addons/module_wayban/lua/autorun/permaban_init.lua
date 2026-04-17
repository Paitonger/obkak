-- t.me/urbanichka
if SERVER then
    AddCSLuaFile('permaban/shared.lua')
    AddCSLuaFile('permaban/client.lua')

    include('permaban/shared.lua')

    include('permaban/server.lua')
else
    include('permaban/shared.lua')
    include('permaban/client.lua')
end