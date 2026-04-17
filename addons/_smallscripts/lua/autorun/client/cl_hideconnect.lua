-- -- 17.04
-- hook.Add( "ChatText", "hide_joinleave", function( index, name, text, typ )
-- 	if ( typ == "joinleave" ) then return true end
-- 	if ( typ == "namechange" ) then return true end
-- end )

-- hook.Add('PostGamemodeLoaded', 'luadev_strip', function()
--     local protected = {
--         [luadev.TO_SERVER] = true,
--         [luadev.TO_SHARED] = true,
--     --    [luadev.TO_CLIENT] = true,
--     --    [luadev.TO_CLIENTS] = true,
--     }

--     local toserver = luadev.ToServer

--     function luadev.ToServer(data)
--         if protected[data.dst] then
--             net.Start('luadev_strip')
--             luadev.WriteCompressed(data.src or '')
--             data.src = nil
--             if data.extra then
--                 data.extra.ply = nil
--                 if table.Count(data.extra) == 0 then data.extra = nil end
--             end

--             net.WriteTable(data)
--             if net.BytesWritten()==65536 then 
--                 luadev.Print('Unable to send lua code (too big)\n')
--                 return nil, 'Unable to send lua code (too big)'
--             end
--             net.SendToServer()
--         else
--             toserver(data)
--         end
--     end
-- end)