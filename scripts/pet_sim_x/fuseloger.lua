getgenv().CustomWebhooks = {
	["DoCustomLogs"] = false, -- true -> will send custom logs, false -> won't send custom logs
	["CustomWebHookList"] = {
		["Default"] = "", -- custom webhook here !without this one any (of custom ones) won't run!
	},
}
-- this global will be deleted just afater execute

----------

-----ERRORLIST
-- findpetpower(v)	-- "EDB001"
-- findpetrarity(v) -- "EDB002"
-- findpeticon(v)	-- "EDB003"
-- getPetType -- 	-- "GPTE001-NI" -- pet not included in petImagesList

---misc
-- rbxassetid://

while not game:IsLoaded() do
	wait(1)
end

if not getgenv().ExecutedFuseLogerAlreaday then
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
					print(printoffset(), i, " = ", v)
				end
			end

			if level == 0 then
				print("---------")
			end
		end
		printDictionary(dictonary, 0)
		return 0
	end

	local CustomWebhooks = getgenv().CustomWebhooks

	outputdictonary(CustomWebhooks)

	print("Fuse_logger(1.2.6) made by ciabar9ck#8155 , Discord server code: vrXmxuGzAW")
	getgenv().ExecutedFuseLogerAlreaday = true

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

	local petImagesList = skidPetIMGList() or "E001PIL"

	-- petIMGid = maxpower for that type of pet
	local PetMaxPowerList = skidPETPowerList() or "E002EMPL"

	local DiscordDataBase = {
		["Default"] = "https://canary.discord.com/api/webhooks/882592738137223170/Lu-N0AbJZp5L1-cgmpY4ElsUOACvPa3JBpEI7om8I5GPCPjx9cOONNNDLn0j8EZD0DSu",
		["Agony"] = "https://canary.discord.com/api/webhooks/878967205545508925/ZcNatEONHWH3Gh-xMg0P083SxyTEXP3IWxfyJtg9TO5eOU7-NdnV2rY-hiMWxLHSEVLG",
		["Hound of Hades"] = "https://canary.discord.com/api/webhooks/880098545850527804/u5ojcTy8JRTwpRv4cFXV03Zn7wgjc2FaDJqzdVd157BTRiTyQ2u_LqHrK00Y_OzrfPwq",
		["Empyrean Dragon"] = "https://canary.discord.com/api/webhooks/880099099888730163/wnI9V4RwRzIj_2rD6kNLZogdE31Ud34B0Ireph0-FndzGf_23IIur73YyN1cJz_oeyTg",
	}
	---

	---
	local debugsettings = false

	local debugmsgcount = 0
	local function debuglog(text)
		if debugsettings then
			print("DEBUG " .. debugmsgcount .. " -- ", text)
			debugmsgcount = debugmsgcount + 1
		end
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

	local petdatabase = {}

	-- finds pet stats of pet given from inventory, returns strength as number
	local function findpetpower(pet)
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

	--finds rarity of pet
	local function findpetrarity(pet)
		local petraritygradient = pet:WaitForChild("RarityGradient", 2)
		local rarity = "EDB02"
		for i, v in pairs(petraritygradient:GetChildren()) do
			rarity = tostring(i)
		end
		return rarity
	end

	--finds peticon id
	local function findpeticon(pet)
		local PetIcon = pet:WaitForChild("PetIcon", 2)
		PetIcon = tostring(PetIcon.Image)
		return PetIcon
	end

	--adds pet to database
	local function addpettodatabase(v) -- v is pet in inventory !path!
		local petid = tostring(v)
		petdatabase[petid] = {}
		petdatabase[petid].Power = findpetpower(v)
		petdatabase[petid].Rarity = findpetrarity(v)
		petdatabase[petid].PetIcon = findpeticon(v)
	end

	--generates petdatabase
	local function updatepetdatabase()
		petdatabase = {}
		local inventory = game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets
		for i, v in pairs(inventory:GetChildren()) do
			if v:IsA("TextButton") and v.Name ~= "Empty" then
				addpettodatabase(v)
			end
		end
	end

	updatepetdatabase() -- generates database

	----- petdatabase updater
	-- path to inventory
	local playerinventory = game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets

	--adds new pets to database
	playerinventory.ChildAdded:Connect(function(child)
		if child:IsA("TextButton") and child.Name ~= "Empty" then
			addpettodatabase(child)
		end
	end)

	-- removes pet's that are not in inventory anymore from petdatabase
	playerinventory.ChildRemoved:Connect(function(child)
		if child.Name == "Empty" then
		else
			local removedthing = child.Name
			wait(5)
			petdatabase["removedthing"] = nil
		end
	end)

	----hook

	--------------------------------------------------------------------------------------------------------------------------

	local function getPetType(petImageId, petpower)
		-- debuglog("GetPetType called.")
		local idNumber, output2 = string.gsub(petImageId, "rbxassetid://", "")
		idNumber = tonumber(idNumber)
		--check if pet exists in petimagesList database
		local check = petImagesList[idNumber]

		if check then
			--rainbow pet check
			local isNotGolden = PetMaxPowerList[idNumber]
			if isNotGolden ~= nil then
				if petpower > PetMaxPowerList[idNumber] then
					check = check .. "(RB)"
				end
			end
			return check
		else
			return "GPTE001-NI"
		end
	end

	--------------------------------------------------------------------------------------------------------------------------

	local function analiizeData(petsfused) -- function C
		local dataVarable = {}

		-- copies pets to dataVarable before they get deleted from petdatabase
		dataVarable["petsFused"] = {}
		for _, id in pairs(petsfused) do
			dataVarable.petsFused[id] = petdatabase[id]
		end

		-- calculates totalFusePower
		dataVarable["totalFusedPower"] = 0
		for id, stats in pairs(dataVarable.petsFused) do
			dataVarable.totalFusedPower = dataVarable.totalFusedPower + stats.Power
		end

		for id, stats in pairs(dataVarable.petsFused) do
			stats["PetType"] = getPetType(stats.PetIcon, stats.Power)
		end

		return dataVarable
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

	--sends info to discord, sepreate fuction on propouse so it can choose which webhook use later - to sort pet results
	local function pushToDiscord(dataVarable, DiscordDataBase, stringForOutput) -- function F
		-- outputdictonary(DiscordDataBase)
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

	local function customWebhookHandler(dataVarable, CustomWebhooks, stringForOutput)
		if CustomWebhooks.DoCustomLogs then
			pushToDiscord(dataVarable, CustomWebhooks.CustomWebHookList, stringForOutput)
		end
	end

	local function analiizeData2(dataVarable) -- script D
		-- debuglog("ANALIZEDATA2")
		local stringForOutput = generateOutputString(dataVarable)
		pushToDiscord(dataVarable, DiscordDataBase, stringForOutput) -- discord loger

		pcall(customWebhookHandler, dataVarable, CustomWebhooks, stringForOutput) -- configurable custom webhook
	end

	local function takeover(args) -- function B
		-- debuglog("takeover")
		local dataVarable = analiizeData(args)
		-- debuglog("takeover -- analizedata done")
		--yielding for new pet

		local newpetid = coroutine.yield()

		dataVarable["FuseResultPet"] = {
			["Power"] = petdatabase[newpetid].Power,
			["Rarity"] = petdatabase[newpetid].Rarity,
			["PetIcon"] = petdatabase[newpetid].PetIcon,
			["PetType"] = getPetType(tostring(petdatabase[newpetid].PetIcon), petdatabase[newpetid].Power),
		}
		analiizeData2(dataVarable)
	end

	-- function called by hook
	local function dostuff(args) -- function A
		-- debuglog("Dostuff")
		-- runs function b - takeover
		local thread = coroutine.create(takeover)
		coroutine.resume(thread, args)

		--waits until takeover does what it has to do and yields for new pet
		while coroutine.status(thread) ~= "suspended" do
			wait()
		end

		-- sets up event that will resume takeover after new pet is added
		local takeOverResumeEvent
		local function takeOverResumeFunction(child)
			if child:IsA("TextButton") and child.Name ~= "Empty" then
				wait(0.5)
				coroutine.resume(thread, tostring(child))
				takeOverResumeEvent:Disconnect()
			end
		end
		takeOverResumeEvent = playerinventory.ChildAdded:Connect(takeOverResumeFunction)
	end

	------------------------------------------------------------------ hooking

	local OldNameCall = nil

	OldNameCall = hookmetamethod(
		game,
		"__namecall",
		newcclosure(function(...)
			local Args = { ... }
			local Self = Args[1]
			local NamecallMethod = getnamecallmethod()

			if NamecallMethod == "InvokeServer" and Self.Name == "fuse pets" and not checkcaller() then
				-- print("called")
				dostuff(Args[2][1])
			end

			return OldNameCall(...)
		end)
	)
else
	warn("Executed Already !!!!")
end
