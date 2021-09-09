getgenv().ForceStopAutoFuse = true

getgenv().AutoFuseSettings = {
	["printInstead"] = true, -- will print instead of fusing and stop script

	["numbers"] = {
		["minTotal"] = 36000000, -- for mode 1,2
		["maxTotal"] = 3700000, -- for mode 1,2
		["tergetPoint"] = 5000, -- for mode 1
	},

	["mode"] = {
		[1] = false, -- 1 = perfect(computes closest fuse to targetPoint) -- not working as for now
		[2] = true, -- 2 fast (get's first fuse option found)
		[3] = false, --  recipy mode (Works also as backup for mode 2)
	},

	["petsToUse"] = { -- this is must in every mode
		["Empyrean Dragon"] = false,
		["Empyrean Fox"] = true,
		["Empyrean Snake"] = true,
		["Empyrean Stallion"] = true,
		["Angel Dog"] = true,

		["Heavenly Peacock"] = true,
		["Pegasus"] = true,

		["Hound of Hades"] = false,
		["Magma cube"] = false,
		["Hell Chick"] = false,
		["Hell Rock"] = false,

		["Agony"] = false,
		["Willow Wisp"] = false,
	},

	["recipyMode"] = { -- for mode 3
		[1] = {
			["Angel Dog(G)"] = 1,
			["Empyrean Fox(G)"] = 0,
			["Empyrean Snake(G)"] = 1,
		},
		[2] = {
			["Empyrean Fox(G)"] = 1,
		},
		[3] = {
			["Emptrean Fox"] = 1,
		},
	},
}

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
print("Auto Fuse 1.0 by ciabar9ck#8155")

local DiscordDataBase = {
	["Default"] = "https://canary.discord.com/api/webhooks/878607307511037982/fcFaaz_vk4GmApbJVbfMpfyJwUJpDb6F9RSokXJ7bEYtofoGRqFjpRMnF9IVGK-VF3yf",
	["Agony"] = "https://canary.discord.com/api/webhooks/878967205545508925/ZcNatEONHWH3Gh-xMg0P083SxyTEXP3IWxfyJtg9TO5eOU7-NdnV2rY-hiMWxLHSEVLG",
	["Hound of Hades"] = "https://canary.discord.com/api/webhooks/880098545850527804/u5ojcTy8JRTwpRv4cFXV03Zn7wgjc2FaDJqzdVd157BTRiTyQ2u_LqHrK00Y_OzrfPwq",
	["Empyrean Dragon"] = "https://canary.discord.com/api/webhooks/880099099888730163/wnI9V4RwRzIj_2rD6kNLZogdE31Ud34B0Ireph0-FndzGf_23IIur73YyN1cJz_oeyTg",
}

local AutoFuse = {
	["Settings"] = getgenv().AutoFuseSettings,
}

for recipyNumber, recipy in pairs(AutoFuse.Settings.recipyMode) do -- remove recipys that have less then 3 pets in it
	local totalAmmount = 0
	for petType, ammount in pairs(recipy) do
		totalAmmount = totalAmmount + ammount
	end
	if totalAmmount < 3 then
		AutoFuse.Settings.recipyMode[recipyNumber] = nil
	end
end

local PlayerPetDataBase = {}

local function outputdictonary(dictonary)
	local function printDictionary(dictionary, level)
		if level == 0 then
			print("---------")
		end

		local function printoffset()
			return string.rep("  ", level)
		end

		for i, v in pairs(dictionary) do
			if typeof(v) == "table" then
				print(printoffset(), i)
				printDictionary(v, level + 1)
			else
				print(printoffset(), i, "=", v)
			end
		end

		if level == 0 then
			print("---------")
		end
	end
	printDictionary(dictonary, 0)
	return 0
end

local function NumberToText(n)
	--skidded from https://devforum.roblox.com/t/how-to-add-a-k-to-numbers/748550/3
	local T = { "K", "M", "B", "T", "q", "Q", "s", "S", "O", "N", "d", "U", "D" }
	local function formatNumber(n)
		if not tonumber(n) then
			return n
		end
		if n < 10000 then
			return math.floor(n)
		end
		local d = math.floor(math.log10(n) / 3) * 3
		local s = tostring(n / (10 ^ d)):sub(1, 5)
		return s .. " " .. tostring(T[math.floor(d / 3)])
	end
	return formatNumber(n)
end

local function skidPetIMGList()
	local folder = game:GetService("ReplicatedStorage").Game.Pets
	local ezskid = {}
	for i, v in pairs(folder:GetChildren()) do
		local mod = v:FindFirstChildWhichIsA("ModuleScript")

		local modcontent = require(mod)

		local id = string.gsub(modcontent.thumbnail, "rbxassetid://", "")

		id = tonumber(id)
		if id then
			ezskid[id] = modcontent.name
		end

		local goldId = string.gsub(modcontent.goldenThumbnail, "rbxassetid://", "")
		goldId = tonumber(goldId)

		if goldId then
			ezskid[goldId] = modcontent.name .. "(G)"
		end
	end
	return ezskid
end

local function skidPETPowerList()
	local folder = game:GetService("ReplicatedStorage").Game.Pets
	local ezskid = {}
	for i, v in pairs(folder:GetChildren()) do
		local mod = v:FindFirstChildWhichIsA("ModuleScript")

		local modcontent = require(mod)

		local id = string.gsub(modcontent.thumbnail, "rbxassetid://", "")
		local id = tonumber(id)
		if id then
			ezskid[id] = modcontent.strengthMax
		end
	end
	return ezskid
end

local PetImagesList = skidPetIMGList() or "E001PIL"
local PetMaxPowerList = skidPETPowerList() or "E002EMPL"

local function findpetpower(pet)
	local petid = tostring(pet)

	local petlevel = pet:WaitForChild("Level", 2)
	if petlevel then
		local multiply = 1
		local petlevelstring = petlevel.Text

		--saves m, k as nubmers
		local multiplydatabase = {
			["m"] = 1000000,
			["k"] = 1000,
		}
		for i, v in pairs(multiplydatabase) do
			if string.find(petlevelstring, i) then
				petlevelstring = string.gsub(petlevelstring, i, "")
				multiply = v
				break
			end
		end

		local petlevelnumber = tonumber(petlevelstring)
		petlevelnumber = petlevelnumber * multiply

		return petlevelnumber
	end
end

--finds peticon id
local function findpeticon(pet)
	local petid = tostring(pet)

	local PetIcon = pet:WaitForChild("PetIcon", 2)
	PetIcon = tostring(PetIcon.Image)
	PetIcon = string.gsub(PetIcon, "rbxassetid://", "")
	PetIcon = tonumber(PetIcon)
	return PetIcon
end

-- returns pet type and general type
local function findpettype(pet)
	local petid = tostring(pet)

	local idNumber = PlayerPetDataBase[petid].PetIconId
	local petTypeFull = PetImagesList[idNumber] -- finds if pet exist in pets list (gold or normal/rainbow)
	if petTypeFull == nil then
		for _ = 0, 10 do
			wait(0.1)
			petTypeFull = PetImagesList[idNumber]
			if petTypeFull == nil then
			else
				break
			end
		end
	end

	local tempName = petTypeFull
	local isNotGolden = PetMaxPowerList[idNumber] -- only normal pets are listed here
	if isNotGolden ~= nil then -- if found power - pet is normal or rainbow then
		-- print(" pet is rainbow or normal")
		if PlayerPetDataBase[petid].Power > PetMaxPowerList[idNumber] then -- check if pet is rainbow
			-- print("pet is rb ")
			petTypeFull = tempName .. "(RB)"
		end
	end -- if pet is gold

	-- general pet type
	local generalPettype
	if petTypeFull == nil then
		print("Failed to list pet ", petid)
	else
		generalPettype = string.gsub(petTypeFull, "%(G%)", "")
		generalPettype = string.gsub(generalPettype, "%(RB%)", "")
	end

	return petTypeFull, generalPettype
end

local function addpettodatabase(pet) -- pet is path to pet in inventory (GUI) doesn't add pets not listed in AutoFuse.Settings.petsToUse
	local petid = tostring(pet)

	PlayerPetDataBase[petid] = {}
	PlayerPetDataBase[petid].Power = findpetpower(pet)
	PlayerPetDataBase[petid].PetIconId = findpeticon(pet)
	PlayerPetDataBase[petid].Type, PlayerPetDataBase[petid].TypeGeneral = findpettype(pet)
	PlayerPetDataBase[petid].Id = petid

	if AutoFuse.Settings.petsToUse[PlayerPetDataBase[petid].TypeGeneral] ~= true then
		PlayerPetDataBase[petid] = nil
	end
	return 0
end

local function ScanInventory()
	PlayerPetDataBase = {}
	local inventory = game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets

	for i, v in pairs(inventory:GetChildren()) do
		if v:IsA("TextButton") and v.Name ~= "Empty" then
			addpettodatabase(v)
		end
	end
	return 0
end

local function GetPetsForFuse()
	local petsForFuse = {}

	local function computeModePerfect()
		local function generateFuseOptions()
			local totalPower = 0
			local bestFuseOption = {}
		end
	end

	local function computeModeFast()
		local PlayerPetDataBaseIndexed = {}

		local function indexPlayerPetDataBase()
			local function findIdOfPetPetWithLowestDmg()
				local lowestdmg = math.huge
				local lowestdmgpetid
				for petnowid, petnowdata in pairs(PlayerPetDataBase) do
					if petnowdata.Power < lowestdmg then
						lowestdmgpetid = petnowid
						lowestdmg = petnowdata.Power
					end
				end

				return lowestdmgpetid
			end

			local length = 0
			for i, v in pairs(PlayerPetDataBase) do
				length = length + 1
			end

			for i = 1, length do
				local petIdToMove = findIdOfPetPetWithLowestDmg()
				PlayerPetDataBaseIndexed[i] = PlayerPetDataBase[petIdToMove]
				PlayerPetDataBaseIndexed[i].Id = petIdToMove
				PlayerPetDataBase[petIdToMove] = nil
			end
		end

		----------------
		local function getPlayerPetDataBaseIndexedLength()
			local length = 0 -- count length
			for i, v in pairs(PlayerPetDataBaseIndexed) do
				length = length + 1
			end
			return length
		end

		indexPlayerPetDataBase() -- index inventory PlayerPetDataBaseIndexed is valid from now on. lower to stronger pets
		local computeModeFast = {}
		computeModeFast.petsForFuse = {}
		computeModeFast.petForFuseCount = 1
		computeModeFast.totalPower = 0

		local length = getPlayerPetDataBaseIndexedLength()
		for i = 1, length - 2 do -- minimum 3 pets for fuse
			-- print("starting with ", i)
			for indexNow = i, length do
				-- print("   now at ", indexNow)
				if computeModeFast.petForFuseCount < 12 then -- if can add another pet to fuse
					-- print("   Counter ",computeModeFast.petForFuseCount,"... checking: ",computeModeFast.totalPower,PlayerPetDataBaseIndexed[indexNow].Power," < ",	AutoFuse.Settings.numbers.maxTotal)
					if
						computeModeFast.totalPower + PlayerPetDataBaseIndexed[indexNow].Power
						< AutoFuse.Settings.numbers.maxTotal
					then -- if it's in range
						-- print("   Will do adding.", PlayerPetDataBaseIndexed[indexNow].Id)
						computeModeFast.petsForFuse[computeModeFast.petForFuseCount] =
							PlayerPetDataBaseIndexed[indexNow] -- add pet to list

						computeModeFast.totalPower = computeModeFast.totalPower
							+ PlayerPetDataBaseIndexed[indexNow].Power
						computeModeFast.petForFuseCount = computeModeFast.petForFuseCount + 1 -- add to counter
						if computeModeFast.totalPower >= AutoFuse.Settings.numbers.minTotal then
							-- print("   Found result.")
							if
								computeModeFast.petForFuseCount >= 3
								and computeModeFast.totalPower < AutoFuse.Settings.numbers.maxTotal
							then
								-- print("   result accepted.")
								return computeModeFast.petsForFuse -- returns dictionary of pets(and their data) for fuse
							else
								-- print("   result rejected. not enough pets.")
								computeModeFast.petsForFuse = {}
								computeModeFast.petForFuseCount = 1
								computeModeFast.totalPower = 0
								break
							end
						end
					else
						-- print("   result rejected. total is too big.")
						computeModeFast.petsForFuse = {}
						computeModeFast.petForFuseCount = 1
						computeModeFast.totalPower = 0
						break
					end
				else
					-- print("start = ", i, " result rejected too much pets, power not enough")
					computeModeFast.petsForFuse = {}
					computeModeFast.petForFuseCount = 1
					computeModeFast.totalPower = 0
					break
				end
			end
		end
		-- print("NO SATISFYING RESULT FOUND!!!")
		return { [1] = false }
	end

	local function computeModeRecipy()
		-- print("computingRecipyMode")
		local ComputeModeRecipy = {}
		local PlayerPetDataBaseGrouped = {}

		--[pettype] = {
		--		[count] = 1,
		--		[petId] = {petdata},
		-- }

		local function groupPlayerPetData()
			for petId, petdata in pairs(PlayerPetDataBase) do
				if not PlayerPetDataBaseGrouped[petdata.Type] then -- if table for that pet doesn't exist
					PlayerPetDataBaseGrouped[petdata.Type] = {}
					PlayerPetDataBaseGrouped[petdata.Type]["count"] = 1
					PlayerPetDataBaseGrouped[petdata.Type][petId] = petdata
				else
					PlayerPetDataBaseGrouped[petdata.Type][petId] = petdata
					PlayerPetDataBaseGrouped[petdata.Type]["count"] = PlayerPetDataBaseGrouped[petdata.Type]["count"]
						+ 1
				end
			end
		end

		local function findRecipyIndex()
			for recipyNumber, recipy in pairs(AutoFuse.Settings.recipyMode) do -- loop every recipy dictionary of needed pets is in recipy varable
				ComputeModeRecipy.succed = true
				-- print("Checkking", recipyNumber)
				for petType, neededCount in pairs(recipy) do
					-- print(petType, neededCount, "checking if listed")
					if PlayerPetDataBaseGrouped[petType] ~= nil then -- if found group for that pet check count, or neededCount is less then 0
						-- print(petType, " found, checking count")
						if PlayerPetDataBaseGrouped[petType].count < neededCount then -- if count is not enough then break loop and try next recipy / exit loop
							-- print(petType, " found, checking count: failed")
							ComputeModeRecipy.succed = false
							break
						end
						-- print(petType, " found, checking count: succed")
					else -- if not found group for that pet break loop and try next recipy / exit loop
						-- print(" failed, not found")
						ComputeModeRecipy.succed = false
						break
					end
				end
				if ComputeModeRecipy.succed == true then
					-- print(recipyNumber)
					return { [1] = recipyNumber }
				end
				-- outputdictonary(recipy)
			end
			return { [1] = false }
		end

		groupPlayerPetData()
		-- outputdictonary(PlayerPetDataBaseGrouped)
		local recipyToDo = findRecipyIndex()
		if recipyToDo[1] ~= false then -- if found valid recipy then
			ComputeModeRecipy.result = {}
			ComputeModeRecipy.count = 1
			for petType, ammount in pairs(AutoFuse.Settings.recipyMode[recipyToDo[1]]) do
				for petId, petData in pairs(PlayerPetDataBaseGrouped[petType]) do
					if petId ~= "count" then
						if ammount >= 1 then -- if need more pets of that type
							ComputeModeRecipy.result[ComputeModeRecipy.count] = petData
							ComputeModeRecipy.count = ComputeModeRecipy.count + 1
							ammount = ammount - 1
						else
							break
						end
					end
				end
			end
			return ComputeModeRecipy.result
		end

		return { [1] = false }
	end

	ScanInventory() -- scan inventory

	if AutoFuse.Settings.mode[1] then -- perfect
		print("abandoned")
		-- computeModePerfect()
	elseif AutoFuse.Settings.mode[2] == true then -- fast
		petsForFuse = computeModeFast()
		if petsForFuse == { [1] = false } and AutoFuse.Settings.mode[3] == true then -- if mode 2 not found result try recipy mode
			petsForFuse = computeModeRecipy()
		end
	elseif AutoFuse.Settings.mode[3] == true then
		petsForFuse = computeModeRecipy()
	end

	local debugmode = false
	if debugmode then
		if petsForFuse[1] ~= false then
			local total = 0
			for i, v in pairs(petsForFuse) do
				print(i)
				total = total + v.Power
				print("   ", v.Id, v.Type, "  ", NumberToText(v.Power))
			end
			if not AutoFuse.Settings.mode[3] == true then -- if not mode 3
				print(
					NumberToText(AutoFuse.Settings.numbers.maxTotal),
					" > ",
					NumberToText(total),
					" > ",
					NumberToText(AutoFuse.Settings.numbers.minTotal)
				)
			end
		else
			print("No comination that meets requirements has been found")
		end
	end

	return petsForFuse
end

local function generateOutputString(dataVarable) -- function E
	local finalstring = ""

	local function numbertoshit(n)
		--skidded from https://devforum.roblox.com/t/how-to-add-a-k-to-numbers/748550/3
		local T = { "K", "M", "B", "T", "q", "Q", "s", "S", "O", "N", "d", "U", "D" }
		local function formatNumber(n)
			if not tonumber(n) then
				return n
			end
			if n < 10000 then
				return math.floor(n)
			end
			local d = math.floor(math.log10(n) / 3) * 3
			local s = tostring(n / (10 ^ d)):sub(1, 5)
			return s .. " " .. tostring(T[math.floor(d / 3)])
		end
		return formatNumber(n)
	end

	-- adds pets and theipower to output
	local counter = 1
	finalstring = finalstring .. "```" .. "\nPet: "
	for i, v in pairs(dataVarable.petsFused) do
		finalstring = finalstring .. counter .. "- " .. v.PetType .. " (" .. numbertoshit(v.Power) .. ")" .. " |"
		counter = counter + 1
	end
	finalstring = finalstring .. "\n"

	-- adds totalpoweroffuse
	finalstring = finalstring .. "Total = " .. numbertoshit(dataVarable.totalFusedPower)
	finalstring = finalstring .. "\n"

	-- adds resultoffuse
	finalstring = finalstring
		.. "Result = "
		.. dataVarable.FuseResultPet.PetType
		.. " ("
		.. numbertoshit(dataVarable.FuseResultPet.Power)
		.. ")"
	finalstring = finalstring .. "\n" .. "```"

	return finalstring
end

local function sendToDiscord(text, webHookURL)
	local data = {
		["content"] = text,
	}
	local newdata = game:GetService("HttpService"):JSONEncode(data)

	local headers = {
		["content-type"] = "application/json",
	}
	request = http_request or request or HttpPost or syn.request
	local abcdef = { Url = webHookURL, Body = newdata, Method = "POST", Headers = headers }
	request(abcdef)
	return text
end

local function pushToDiscord(dataVarable, DiscordDataBase, stringForOutput) -- function F
	local generalPettype = string.gsub(dataVarable.FuseResultPet.PetType, "%(G%)", "")
	local generalPettype = string.gsub(generalPettype, "%(RB%)", "")

	local generalPettype = string.gsub(generalPettype, "()", "")

	local webhook = DiscordDataBase[generalPettype]
	-- print(generalPettype, "| ", webhook, DiscordDataBase[generalPettype])
	if webhook then
		sendToDiscord(stringForOutput, DiscordDataBase[generalPettype])
	else
		sendToDiscord(stringForOutput, DiscordDataBase["Default"])
	end
end

local function FuseLog(petsFused)
	local dataVarable = {}
	dataVarable["petsFused"] = petsFused
	local petresultid = coroutine.yield()

	dataVarable["FuseResultPet"].Power = findpetpower()
	dataVarable["FuseResultPet"].PetIconId = findpeticon()
	dataVarable["FuseResultPet"].Type, dataVarable["FuseResultPet"].TypeGeneral = findpettype()
	dataVarable["FuseResultPet"].Id = petresultid

	local outputstring = generateOutputString(dataVarable)
	pushToDiscord(dataVarable, DiscordDataBase, outputstring)
	return 0
end

local function DoFuse()
	local petsForFuse = GetPetsForFuse()
	if petsForFuse[1] == false then
		print("No comination that meets requirements has been found. Waiting 15 seconds")
		wait(15)
		return 2
	end
	local petsForFuseIdList = {}
	for petnumber, petdata in pairs(petsForFuse) do
		petsForFuseIdList[petnumber] = petdata.Id
	end

	local args = {
		[1] = {
			[1] = petsForFuseIdList,
		},
	}

	local fulseLogCourtine = coroutine.create(FuseLog)
	coroutine.resume(fulseLogCourtine, petsForFuse)

	while coroutine.status(fulseLogCourtine) ~= "suspended" do
		wait()
	end

	-- sets up event that will resume takeover after new pet is added
	local fuseLogResumeEvent
	local function fuseLogResume(child)
		if child:IsA("TextButton") and child.Name ~= "Empty" then
			wait(0.5)
			coroutine.resume(fulseLogCourtine, tostring(child))

			fuseLogResumeEvent:Disconnect()
		end
	end
	local playerinventory = game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets
	fuseLogResumeEvent = playerinventory.ChildAdded:Connect(fuseLogResume)

	workspace.__THINGS.__REMOTES:FindFirstChild("fuse pets"):InvokeServer(unpack(args))

	return 0
end

if AutoFuse.Settings.printInstead then
	local data = GetPetsForFuse()
	-- outputdictonary(data)
	if data[1] ~= false then
		local counter = 1
		for _, petdata in pairs(data) do
			print(counter, " - ", petdata.Type, "(", NumberToText(petdata.Power), ")", petdata.Id)
			counter = counter + 1
		end
	else
		print("No comination that meets requirements has been found.")
	end
else
	repeat
		DoFuse()
	until wait(3) and getgenv().ForceStopAutoFuse == false
end
