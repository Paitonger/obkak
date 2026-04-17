-- t.me/urbanichka
hook.Add("KeyPress", "DoubleJump", function(pl, k)
    if not pl or not pl:IsValid() or k~=2 then
        return
    end
        
    if not pl.Jumps or pl:IsOnGround() then
        pl.Jumps=0
    end
    
    if pl.Jumps==2 then return end
    if not (pl:HasPurchase("doublejump") or pl:HasPurchase("doublejump_navsegda")) then return end
    
    pl.Jumps = pl.Jumps + 1
    if pl.Jumps==2 then
        local ang = pl:GetAngles()
        local forward, right = ang:Forward(), ang:Right()
        
        local vel = -1 * pl:GetVelocity() -- Nullify current velocity
        vel = vel + Vector(0, 0, 300) -- Add vertical force
        
        local spd = pl:GetMaxSpeed()
        
        if pl:KeyDown(IN_FORWARD) then
            vel = vel + forward * spd
        elseif pl:KeyDown(IN_BACK) then
            vel = vel - forward * spd
        end
        
        if pl:KeyDown(IN_MOVERIGHT) then
            vel = vel + right * spd
        elseif pl:KeyDown(IN_MOVELEFT) then
            vel = vel - right * spd
        end
        
        pl:SetVelocity(vel)
    end
end)