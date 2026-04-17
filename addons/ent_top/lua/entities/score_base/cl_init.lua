-- t.me/urbanichka
include("shared.lua")

surface.CreateFont( "score_title", {
	font = "Roboto",
	size = 21,
	weight = 400,
	antialias = true
} )

surface.CreateFont( "score_row_header", {
	font = "Roboto",
	size = 19,
	weight = 400,
	antialias = true
} )

surface.CreateFont( "score_row_text", {
	font = "Roboto",
	size = 16,
	weight = 400,
	antialias = true
} )

function ENT:Draw()
	if LocalPlayer():GetPos():Distance(self:GetPos()) > 1000 then return end
	self:DrawModel()
	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis( Ang:Forward(), 270)
	Ang:RotateAroundAxis( Ang:Up(), 180 )
	Ang:RotateAroundAxis( Ang:Right(), 90 )
	
	cam.Start3D2D(Pos - ( Ang:Forward() * 110 ) + ( Ang:Up() * 3 ) - ( Ang:Right() * 70 ), Ang, .5)
		draw.RoundedBox(0,-16,10,470,255,Color( 43, 49, 54, 255 )) 
		draw.RoundedBox( 0,-16,10,470,28, Color(236, 113, 71, 255) ) --Color( 43, 49, 54, 255 )
		surface.SetDrawColor( 150, 150, 150, 60 )
		surface.SetMaterial( Material('data/wimages/wlogo.png')	) 
		surface.DrawTexturedRect( 140, 70, 150, 150 )	
		surface.SetDrawColor( Color(77, 75, 77 , 255) )
		surface.DrawOutlinedRect( -16,10,470,255 )
		
		draw.SimpleText( self.TitleName, "Trebuchet24", 220, 25, color_white, 1, 1 )
	cam.End3D2D()
	
	cam.Start3D2D(Pos - ( Ang:Forward() * 110 ) + ( Ang:Up() * 3 ) - ( Ang:Right() * 60 ), Ang, .5)
		self:DrawFunc( self.score_data )
	cam.End3D2D()
end

function ENT:Initialize()
	self.score_data = {}

	net.Start( "get_score_data" )
		net.WriteEntity( self )
	net.SendToServer()
end

net.Receive( "stream_score", function()
	local sheet = net.ReadEntity()
	local tab = net.ReadTable()
	
	if ( IsValid( sheet ) ) then
		sheet.score_data = tab
	end
end )