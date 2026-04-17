-- t.me/urbanichka
local SHEET = {}

SHEET.UniqueID = "top_10_moneys"

SHEET.Name = scoresheet.money_header_text
SHEET.EntName = "score_money"
SHEET.HeaderColor = scoresheet.money_header_text_color

SHEET.Fetch = function(callback)
	MySQLite.query('SELECT * FROM darkrp_player ORDER BY wallet DESC LIMIT '..scoresheet.time_max_count*2, function(d)
        local data = {}
        local usedPlayers = {}
        for _, v in pairs(d) do
        	if not v.rpname then continue end
            if usedPlayers[v.rpname] then continue end

            table.insert(data, v)
            usedPlayers[v.rpname] = true
        end
        callback(data)
    end)
end

SHEET.Draw = function( ent, data )
	if ( !DarkRP ) then return end
	
	local y_pos = 20
	
	local x_pos = 0
	local cnt = 0
	
	for place, row in pairs( data ) do
		local row_header = "#"..place.." - "..row.rpname
		local row_text = DarkRP.formatMoney( tonumber( row.wallet ) )
		
		if ( place == 1 ) then
			surface.SetFont( scoresheet.money_font_header )
			local textW = surface.GetTextSize( row_header )
			
			surface.SetDrawColor( 255, 255, 255 )
			surface.SetMaterial( scoresheet.money_first_place_icon )
			surface.DrawTexturedRect( x_pos + textW + 5, y_pos, 16, 16 )
		end
		
		draw.SimpleText( row_header, scoresheet.money_font_header, x_pos, y_pos, color_white )
		y_pos = y_pos + 20
		
		draw.SimpleText( row_text, scoresheet.money_font_text, x_pos, y_pos, color_white )
		y_pos = y_pos + 25
		
		cnt = cnt + 1
		
		if ( cnt >= scoresheet.money_cut_at_row_count ) then
			x_pos = 250
			y_pos = 20
			cnt = 0
		end
	end
end 

scoresheet:register( SHEET )