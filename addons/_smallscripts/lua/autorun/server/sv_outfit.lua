-- t.me/urbanichka
hook.Add( "CanOutfit", "srp_donate.wsmodels", function( ply, mdl, wsid )

    if not ply:HasPurchase("skinworkshop") then
        DarkRP.notify(ply, NOTIFY_ERROR, 3, "Ты не купил эту плюшку!")
        return false
    end
    
    return true

end)

hook.Add("PlayerSay", "srp_donate.wsmodels", function(ply, text)

    text = string.Explode(" ", text)
    if text[1] == "!mymodel" then
        if not ply:HasPurchase("skinworkshop") then
                DarkRP.notify(ply, NOTIFY_ERROR, 3, "Ты не купил эту плюшку!")
                return false
        end

        ply:SendLua("outfitter.GUIOpen()")
        return ""
    end

end)