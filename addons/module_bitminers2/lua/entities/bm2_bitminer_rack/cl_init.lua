-- t.me/urbanichka
include("shared.lua")

local function __round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

//Animate fan(s)
function ENT:Think()
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 500 then
		if self:GetIsMining() then
			self.fanAng = self.fanAng + (FrameTime() * 400)
			for i = 0 , self:GetBoneCount() - 1 do
				if string.match( self:GetBoneName(i), "fan" ) ~= nil then
					self:ManipulateBoneAngles(i,Angle(self.fanAng,0,0))
				end
			end
		end 

		if self.prev ~= self:GetIsMining() then
			self:DestroyShadow()
			self:CreateShadow()
		end

		self.prev = self:GetIsMining()
	end
end 

//Yuck I know but its to much effort to re-write the entire system
function ENT:Initialize()
	self.fanAng = 0

	//So each bitminer can have its own set of unique instructions. This is how we will do that
	self.customInstructions = {
		status = { //Outputs usefull runtime infomation
			command = "STATUS",
			description = "Выводит полезную информацию о текущем устройстве.",
			action = function(arg1, arg2, instructionTable, ent, consoleDisplay)
				consoleDisplay.history = consoleDisplay.history.."\n------------------STATUS------------------\n"
				local firstPart = "Работает                                 "
				local secondPart = string.upper(tostring(ent:GetIsMining()))
				consoleDisplay.history = consoleDisplay.history..string.sub(firstPart, 1, string.len(firstPart) - string.len(secondPart))..secondPart.."\n"
				firstPart = "Питание подключено                                 "
				secondPart = string.upper(tostring(ent:GetHasPower()))
				consoleDisplay.history = consoleDisplay.history..string.sub(firstPart, 1, string.len(firstPart) - string.len(secondPart))..secondPart.."\n"
				consoleDisplay.history = consoleDisplay.history.."------------------------------------------\n\n"
			end
		},
		info = {
			command = "INFO",
			description = "Выводит дополнительную информацию о текущем устройстве.",
			action = function(arg1, arg2, instructionTable, ent, consoleDisplay)
				consoleDisplay.history = consoleDisplay.history.."\n-------------------INFO------------------\n"
				local serverTable = util.JSONToTable(self:GetConnectedServers())
				local serverCount = 0
				for i = 1 , 8 do
					if serverTable[i] == true then
						serverCount = serverCount + 1
					end
				end
				consoleDisplay.history = consoleDisplay.history.."СЕРВЕРНЫЙ СЧЕТЧИК                            "..serverCount.."\n"
				local firstPart = "ТАКТОВАЯ ЧАСТОТА                              "
				local secondPart = tostring(__round(ent:GetClockSpeed(), 3)).."Ghz"
				consoleDisplay.history = consoleDisplay.history..string.sub(firstPart, 1, string.len(firstPart) - string.len(secondPart))..secondPart.."\n"
				local firstPart = "ЯДРА                                    "
				local secondPart = ent:GetCoreCount()
				consoleDisplay.history = consoleDisplay.history..string.sub(firstPart, 1, string.len(firstPart) - string.len(secondPart))..secondPart.."\n"
				consoleDisplay.history = consoleDisplay.history.."ТРЕБУЕТ МОЩНОСТЬ          100-800W (MAX)\n"
				consoleDisplay.history = consoleDisplay.history.."НАЗВАНИЕ                 Bitminer Rack\n"
				local playerName = self:Getowning_ent()
				if playerName ~= NULL then playerName = playerName:Name() else playerName = "Unknown" end
				consoleDisplay.history = consoleDisplay.history..string.sub("ВЛАДЕЛЕЦ                                    ", 1, string.len("OWNER                                    ") - string.len(playerName))..playerName.."\n"
				consoleDisplay.history = consoleDisplay.history.."-----------------------------------------\n\n"
			end
		},
		mining = {
			command = "MINING",
			description = "Начинает или останавливает добычу.",
			action = function(arg1, arg2, instructionTable, ent, consoleDisplay)
				if arg1 == nil then 
					consoleDisplay.history = consoleDisplay.history.."Для использования этой команды, пожалуйста, введите один из следующих аргументов: 'mining start' или 'mining stop'\n"
				elseif arg1 == "start" then
					net.Start("BM2.Command.Mining")
						net.WriteEntity(ent)
						net.WriteBool(true)
					net.SendToServer()
				elseif arg1 == "stop" then
					net.Start("BM2.Command.Mining")
						net.WriteEntity(ent)
						net.WriteBool(false)
					net.SendToServer()
				else
					consoleDisplay.history = consoleDisplay.history.."Опция '"..arg1.."' не является допустимой опцией, введите 'mining start' или 'mining stop'\n"
				end
			end
		},
		bitcoin = { //Used for selling or getting info about bitcoins
			command = "BITCOIN",
			description = "Позволяет вам продавать или видеть информацию о сохраненных биткойнах.",
			action = function(arg1, arg2, instructionTable, ent, consoleDisplay)
				if arg1 == "info" then
					consoleDisplay.history = consoleDisplay.history.."\n-------------------BITCOIN------------------\n"
					local firstPart = "Количество Биткойнов                              "
					local secondPart = comma_value(__round(ent:GetBitcoinAmount(), 2)).."btc"
					consoleDisplay.history = consoleDisplay.history..string.sub(firstPart, 1, string.len(firstPart) - string.len(secondPart))..secondPart.."\n"
					firstPart =	"Значение Биткойнов ($)                           "
					secondPart = tostring(comma_value(__round(ent:GetBitcoinAmount() * BM2CONFIG.BitcoinValue, 2)))
					consoleDisplay.history = consoleDisplay.history..string.sub(firstPart, 1, string.len(firstPart) - string.len(secondPart))..secondPart.."\n"
					consoleDisplay.history = consoleDisplay.history.."--------------------------------------------\n\n"
				elseif arg1 == "sell" then
					net.Start("BM2.Command.SellBitcoins")
						net.WriteEntity(ent)
					net.SendToServer()
					local firstPart =	"Из                                        "
					local secondPart = tostring(comma_value(__round(ent:GetBitcoinAmount(), 2))).."btc"
					consoleDisplay.history = consoleDisplay.history.."\n-------------------RECEIPT------------------\n"
					consoleDisplay.history = consoleDisplay.history..string.sub(firstPart, 1, string.len(firstPart) - string.len(secondPart))..secondPart.."\n"
					firstPart =	"Конвертировано в                               "
					secondPart = "$"..tostring(comma_value(__round(ent:GetBitcoinAmount() * BM2CONFIG.BitcoinValue, 2)))
					consoleDisplay.history = consoleDisplay.history..string.sub(firstPart, 1, string.len(firstPart) - string.len(secondPart))..secondPart.."\n"
					consoleDisplay.history = consoleDisplay.history.."Деньги были переведены на ваш кошелек\n"
					consoleDisplay.history = consoleDisplay.history.."--------------------------------------------\n\n"
				else
					if arg1 == nil then
						consoleDisplay.history = consoleDisplay.history.."Чтобы использовать эту команду, пожалуйста, укажите один из следующих аргументов: 'bitcoin info' или 'bitcoin sell'\n"
					else
						consoleDisplay.history = consoleDisplay.history.."Опция '"..arg1.."' не является допустимой опцией, введите 'bitcoin info' или 'bticoin sell'\n"
					end
				end
			end
		},
		upgrade = { //Used for selling or getting info about bitcoins
			command = "UPGRADE",
			description = "Показывает доступные обновления и позволяет их приобрести.",
			action = function(arg1, arg2, instructionTable, ent, consoleDisplay)
				if arg1 == "1" then //CPU
					net.Start("BM2.Command.Upgrade")
					net.WriteEntity(ent)
					net.WriteBool(false)
					net.SendToServer()
				elseif arg1 == "2" then //Cores
					net.Start("BM2.Command.Upgrade")
					net.WriteEntity(ent)
					net.WriteBool(true)
					net.SendToServer()
				else
					if arg1 == nil then
						consoleDisplay.history = consoleDisplay.history.."\n-------------------UPGRADES------------------\n"
						local i = 0

						if self.upgrades.CPU.cost[self:GetCPUUpgrade() + 1] ~= nil then
							i = i + 1
							firstPart =	"[1] "..self.upgrades.CPU.name.."                                                              "
							secondPart = "                                             "
							thirdtPart = "$"..comma_value(self.upgrades.CPU.cost[self:GetCPUUpgrade() + 1])
							local str = string.sub(firstPart, 0, string.len(secondPart))
							consoleDisplay.history = consoleDisplay.history..string.sub(str, 1, string.len(str) - string.len(thirdtPart))..thirdtPart.."\n"
						end

						if self.upgrades.CORES.cost[self:GetCoreUpgrade() + 1] ~= nil then
							i = i + 1 
							firstPart =	"[2] "..self.upgrades.CORES.name.."                                                              "
							secondPart = "                                             "
							thirdtPart = "$"..comma_value(self.upgrades.CORES.cost[self:GetCoreUpgrade() + 1])
							local str = string.sub(firstPart, 0, string.len(secondPart))
							consoleDisplay.history = consoleDisplay.history..string.sub(str, 1, string.len(str) - string.len(thirdtPart))..thirdtPart.."\n"
						end

						if i == 0 then
							consoleDisplay.history = consoleDisplay.history.."Это устройство больше не нуждается в обновлениях\n"
						end

						consoleDisplay.history = consoleDisplay.history.."---------------------------------------------\nНаберите 'upgrade 1' или 'upgrade 2', чтобы выбрать обновление.\n"
					else
						consoleDisplay.history = consoleDisplay.history.."Опция '"..arg1.."' является не допустимой опцией, введите 'upgrade 1' или 'upgrade 2'\n"
					end
				end
			end
		},
		eject = {
			command = "EJECT",
			description = "Извлекает сервер из стойки",
			action = function(arg1, arg2, instructionTable, ent, consoleDisplay)
				if arg1 == nil then
					consoleDisplay.history = consoleDisplay.history.."Чтобы использовать эту команду, пожалуйста, поставьте сервер для извлечения, например, 'eject 4'\n"
				elseif isnumber(tonumber(arg1)) then
					net.Start("BM2.Command.Eject")
						net.WriteEntity(ent)
						net.WriteInt(tonumber(arg1), 8)
					net.SendToServer()
				else
					consoleDisplay.history = consoleDisplay.history.."Опция '"..arg1.."' является не допустимой опцией, введите: 'eject 1-8'\n"
				end
			end
		},
		servers = { 
			command = "SERVERS",
			description = "Выводит список серверов в стойке.",
			action = function(arg1, arg2, instructionTable, ent, consoleDisplay)
				local servers = util.JSONToTable(self:GetConnectedServers())
				consoleDisplay.history = consoleDisplay.history.."\n-------------------SERVERS------------------\n"
				for i = 1 , 8 do
					local firstPart =	"#"..i.."                                          "
					secondPart = "ПУСТО"
					if servers[i] then 
						secondPart = "ВСТАВЛЕН"
					end
					consoleDisplay.history = consoleDisplay.history..string.sub(firstPart, 1, string.len(firstPart) - string.len(secondPart))..secondPart.."\n"
				end
				consoleDisplay.history = consoleDisplay.history.."--------------------------------------------\n"
			end
		},
	}  
	--Only add if DLC is loaded
	if BITMINERS_2_EXTRAS_DLC then
		self.customInstructions.remote = {
			command = "REMOTE",
			description = "Позволяет вам устанавливать, удалять и изменять имя модуля удаленного доступа, который позволит вам получить удаленный доступ к битминеру, используя "..BM2EXTRACONFIG.RemoteAccessCommand..". Установка его стоит $"..string.Comma(BM2EXTRACONFIG.RemoteAccessPrice)..".",
			action = function(arg1, arg2, instructionTable, ent, consoleDisplay)
				if arg1 == "install" then
					net.Start("BM2.Command.RemoteInstall")
					net.WriteEntity(ent)
					net.WriteBool(true)
					net.SendToServer()
					ent.remoteName = math.random(10,99).."."..math.random(100,800).."."..math.random(10,99).."."..math.random(100,800)
				elseif arg1 == "remove" then
					net.Start("BM2.Command.RemoteInstall")
					net.WriteEntity(ent)
					net.WriteBool(false)
					net.SendToServer()
				elseif arg1 == "setname" then
					local _string = arg2 or math.random(10,99).."."..math.random(100,800).."."..math.random(10,99).."."..math.random(100,800)
					ent.remoteName = _string
					consoleDisplay.history = consoleDisplay.history.."Удаленное имя изменено на '".._string.."'\n"
				else
					if arg1 == nil then
						consoleDisplay.history = consoleDisplay.history.."---------------------------------------------\nВведите 'REMOTE INSTALL' для установки удаленного модуля. Установка стоит $"..string.Comma(BM2EXTRACONFIG.RemoteAccessPrice).." и позволяет работать с битмайнером по удаленному доступу используя "..BM2EXTRACONFIG.RemoteAccessCommand.."\nВведите 'REMOTE REMOVE' для удаления удаленного доступа.\nВведите 'REMOTE SETNAME ExampleName' чтобы изменить удаленное имя битмайнера. Имя не должно содержать пробелов!\n"
					else
						consoleDisplay.history = consoleDisplay.history.."Опция '"..arg1.."' не является допустимой, опциями являются 'install', 'setname' или 'remove'\n"
					end
				end
			end
		}
	end
end
function ENT:Draw()
	self:DrawModel()
end