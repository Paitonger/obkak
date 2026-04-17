-- t.me/urbanichka
local SHEET = {}

SHEET.UniqueID = "top_timeplay"

SHEET.Name = scoresheet.time_header_text
SHEET.EntName = "score_timeplay"
SHEET.HeaderColor = scoresheet.time_header_text_color

SHEET.Fetch = function(cb)
    local data = {}
	MySQLite.query("SELECT * FROM utime ORDER BY totaltime DESC LIMIT "..scoresheet.time_max_count, function(d)
        for count, v in pairs(d or {}) do
            -- Получаем рп имена
            DarkRP.offlinePlayerData(v.player, function(pd)
                pd = pd and pd[1]
                if not pd then return end

                table.insert(data, {
                    name = pd.rpname or 'Unknown',
                    online = v.totaltime
                })

                -- Вызываем callback потому что ебучая асинхронность
                if count >= #d then
                    cb(data)
                end
            end)
        end
    end)
end

local function niceTime( seconds )
	seconds = tonumber( seconds )

	local days = math.floor( seconds / 86400 )
	local str = ""
	
	if ( days > 0 ) then
		seconds = seconds - ( days * 86400 )
		str = str..days.." дней, "
	end
	
	local hours = math.floor( seconds / 3600 )
	
	if ( hours > 0 ) then
		seconds = seconds - ( hours * 3600 )
		str = str..hours.." часа, "
	end
	
	local minutes = math.floor( seconds / 60 )
	
	if ( minutes > 0 ) then
		seconds = seconds - ( minutes * 60 )
		str = str..minutes.." минут"
	end
	
	if ( str == "" ) then
		str = seconds.." секунд"
	end
	
	return str
end

SHEET.Draw = function( ent, data )
	local y_pos = 20
	
	local x_pos = 0
	local cnt = 0
	
	for place, row in pairs( data ) do
		local row_header = "#"..place.." - "..row.name
		local row_text = niceTime( row.online )
		
		if ( place == 1 ) then
			surface.SetFont( scoresheet.time_font_header )
			local textW = surface.GetTextSize( row_header )
			
			surface.SetDrawColor( 255, 255, 255 )
			surface.SetMaterial( scoresheet.time_first_place_icon )
			surface.DrawTexturedRect( x_pos + textW + 5, y_pos, 16, 16 )
		end
		
		draw.SimpleText( row_header, scoresheet.time_font_header, x_pos, y_pos, color_white )
		y_pos = y_pos + 20
		
		draw.SimpleText( row_text, scoresheet.time_font_text, x_pos, y_pos, color_white )
		y_pos = y_pos + 25
		
		cnt = cnt + 1
		
		if ( cnt >= scoresheet.time_cut_at_row_count ) then
			x_pos = 250
			y_pos = 20
			cnt = 0
		end
	end
end 

scoresheet:register( SHEET )