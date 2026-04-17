-- t.me/urbanichka
chiefDemote.actions = {}

--[[
	Формат даты:
		name - Название кнопки
		order - Номер кнопки
		icon - Иконка кнопки
		check (ply) - Функция проверки доступа к кнопке
		callback (ply) - Функция при нажатии на кнопку
]]

function chiefDemote.addAction(name, data)
	data.internalName = name

	table.insert(chiefDemote.actions, data)
end

-- Теперь пошли функции

chiefDemote.addAction('lottery', {
	name = 'Запустить лотерею',
	order = 10,
	icon = 'icon16/money.png',
	check = function (ply) return ply:Team() == TEAM_MAYOR end,
	callback = function (ply)
		Derma_StringRequest(
			'Запустить лотерею',
			'Введи ниже цену за билет (максимум 1.000.000$)',
			'',
			function (text)
				if not tonumber(text) then return notification.AddLegacy('Ты ввел некорректное число', 1, 4) end

				ply:ConCommand('say /lottery '..tonumber(text))
			end
		)
	end,
})

chiefDemote.addAction('lkd', {
	name = 'Включить ком. час',
	order = 20,
	icon = 'icon16/sound.png',
	check = function (ply) return ply:Team() == TEAM_MAYOR end,
	callback = function (ply)
		Derma_StringRequest(
			'Включить ком. час',
			'Введи ниже причину ком. часа (например, "Повышенная преступность")',
			'',
			function (text)
				if not tostring(text) then return notification.AddLegacy('Ты ввел некорректную причину', 1, 4) end

				ply:ConCommand('say /lkd '..tostring(text))
			end
		)
	end,
})

chiefDemote.addAction('unlkd', {
	name = 'Выключить ком. час',
	order = 30,
	icon = 'icon16/sound.png',
	check = function (ply) return ply:Team() == TEAM_MAYOR end,
	callback = function (ply)
		ply:ConCommand('say /unlkd')
	end,
})

chiefDemote.addAction('addlaw', {
	name = 'Добавить закон',
	order = 40,
	icon = 'icon16/page_add.png',
	check = function (ply) return ply:Team() == TEAM_MAYOR end,
	callback = function (ply)
		Derma_StringRequest(
			'Добавить закон',
			'Введи ниже закон',
			'',
			function (text)
				if not tostring(text) then return notification.AddLegacy('Ты ввел некорректный закон', 1, 4) end

				ply:ConCommand('say /addlaw '..tostring(text))
				timer.Simple(.5, function ()
					chiefDemote:refreshLaws()
				end)
			end
		)
	end,
})

chiefDemote.addAction('removelaw', {
	name = 'Удалить закон',
	order = 50,
	icon = 'icon16/page_delete.png',
	check = function (ply) return ply:Team() == TEAM_MAYOR end,
	callback = function (ply)
		Derma_StringRequest(
			'Удалить закон',
			'Введи номер закона',
			'',
			function (text)
				if not tonumber(text) then return notification.AddLegacy('Ты ввел некорректный номер', 1, 4) end

				ply:ConCommand('say /removelaw '..tonumber(text))
				timer.Simple(.5, function ()
					chiefDemote:refreshLaws()
				end)
			end
		)
	end,
})

chiefDemote.addAction('broadcast', {
	name = 'Оповещение городу',
	order = 60,
	icon = 'icon16/transmit.png',
	check = function (ply) return ply:Team() == TEAM_MAYOR end,
	callback = function (ply)
		Derma_StringRequest(
			'Оповещение городу',
			'Введи ниже текст оповещения',
			'',
			function (text)
				if not tostring(text) then return notification.AddLegacy('Ты ввел некорректный текст', 1, 4) end

				ply:ConCommand('say /broadcast '..tostring(text))
			end
		)
	end,
})

chiefDemote.addAction('callhelp', {
	name = 'Вызвать подкрепление',
	order = 70,
	icon = 'icon16/shield.png',
	check = function (ply) return ply:isCP() end,
	callback = function (ply)
		Derma_StringRequest(
			'Вызвать подкрепление',
			'Введи ниже текст вызова',
			'',
			function (text)
				if not tostring(text) then return notification.AddLegacy('Ты ввел некорректный текст', 1, 4) end

				ply:ConCommand('say /reinforcement '..tostring(text))
			end
		)
	end,
})

chiefDemote.addAction('callcops', {
	name = 'Вызвать полицию',
	order = 80,
	icon = 'icon16/shield.png',
	check = function (ply) return not ply:isCP() end,
	callback = function (ply)
		Derma_StringRequest(
			'Вызвать полицию',
			'Введи ниже текст вызова',
			'',
			function (text)
				if not tostring(text) then return notification.AddLegacy('Ты ввел некорректный текст', 1, 4) end

				ply:ConCommand('say /cr '..tostring(text))
			end
		)
	end,
})