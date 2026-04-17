-- -- t.me/urbanichka
-- local mat

-- if not file.IsDir('wimages', 'DATA') then
-- 	file.CreateDir('wimages')
-- end
-- if not file.Exists('wimages/wlogo.png', 'DATA') then
-- 	http.Fetch("https://i.imgur.com/DHENhL4.png", function(b)
-- 		file.Write("wimages/wlogo.png", b)
-- 		mat = Material("data/wimages/wlogo.png")
-- 	end)
-- else
--     mat = Material("data/wimages/wlogo.png")
-- end

-- if not file.Exists('wimages/micvol.png', 'DATA') then
-- 	http.Fetch("https://i.imgur.com/FTLPriV.png", function(b)
-- 		file.Write("wimages/micvol.png", b)
-- 	end)
-- end

-- if not file.Exists('wimages/rytra.png', 'DATA') then
-- 	http.Fetch("https://i.imgur.com/Jzg2auB.png", function(b)
-- 		file.Write("wimages/rytra.png", b)
-- 	end)
-- end

-- if not file.Exists('wimages/wskin.png', 'DATA') then
-- 	http.Fetch("http://www.wayzerroleplay.myarena.ru/wayzer.png", function(b)
-- 		file.Write("wimages/wskin.png", b)
-- 	end)
-- end

-- hook.Add('HUDPaint', 'Logo', function()
-- 	local min = math.floor(LocalPlayer():GetUTimeSessionTime() / 60)
-- 	if min >= 10 then hook.Remove('HUDPaint', 'Logo') end
-- 	if #player.GetAll() < 5 then return end
-- 	local glow = math.abs(math.sin(CurTime() * 0.4) * 255)
-- 	surface.SetDrawColor(Color(255,255,255,glow))
-- 	surface.SetMaterial( mat )
-- 	surface.DrawTexturedRect(10, 10, 95, 95)
-- 	draw.SimpleText("WayZer's Role Play", "Trebuchet24", 120,20, Color(253, 161,4, glow))
-- 	draw.SimpleText("Minton", "Trebuchet18", 120,40, Color(255,255,255,glow))
-- end)
