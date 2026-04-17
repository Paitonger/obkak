-- 17.04
net.Receive('crashsaver.confirm',function()
	Derma_Query('Хочешь восстановить свою игровую сессию после краша?', 'Восстановление сессии',
		'Да', function()
			net.Start('crashsaver.yes')
			net.SendToServer()
		end,
		'Нет', function()
			net.Start('crashsaver.no')
			net.SendToServer()
		end)
end)
return