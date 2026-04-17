-- 17.04
net.Receive("ManyakSound", function() 
   sound.PlayURL ( "http://www.wayzerroleplay.myarena.ru/1.mp3", "mono", function( station )
      if ( IsValid( station ) ) then
         station:Play()
      else
         LocalPlayer():ChatPrint( "Ты конечно пиздец злой, но трек почему-то не загрузился :c" )
      end
   end )
end)