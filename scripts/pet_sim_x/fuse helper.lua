local petscontainer = game:GetService("Players").LocalPlayer.PlayerGui.FusePets.Frame.Container.Holder
_G.FuseHelper = true
print(
	"fuse helper 1.1 made by ciabar9ck#8155 \n",
	"changelog: -removed useless prints\n",
	"-added discord server( https://discord.gg/vrXmxuGzAW ) \n",
	"-made fuse loger(seperate script) available at discord"
)

local function ispetselected(pet)
	local petequiped = pet:FindFirstChild("Equipped")
	if petequiped then
		if petequiped.Visible then
			return true
		end
	end
	return false
end

local function findpetstats(pet)
	local petlevel = pet:FindFirstChild("Level")
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
		--print(petlevelnumber)
		return petlevelnumber
	end
end

local function updatetextbutton(power)
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
	local newstring = numbertoshit(power)
	game:GetService("Players").LocalPlayer.PlayerGui.FusePets.Frame.Side.Fuse.TextLabel.Text = newstring
end

while _G.FuseHelper and wait() do
	local fusepower = 0
	for i, v in pairs(petscontainer:GetChildren()) do
		if v:IsA("TextButton") then
			-- if it's a pet check if it's selected
			if ispetselected(v) then
				fusepower = fusepower + findpetstats(v)
				--t(fusepower)
			end
		end
	end
	updatetextbutton(fusepower)
end
