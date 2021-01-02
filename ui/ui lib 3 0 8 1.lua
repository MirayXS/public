local wersja = "3.0.8.1"  -- backup version
print("UI "..wersja)  -- se printuje wersje 

-- library:CreateToggle("cos", function(state)   -- args, name of toggle, state(true/false)
    -- while state == true and wait() do
        -- -- what to do 
    -- end
-- end)

local library = {}

function library:CreateWindow(nazwa)
	local ScreenGui = Instance.new("ScreenGui")
	local body = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local topper = Instance.new("Frame")
	local nazwaa = Instance.new("TextLabel")
	local hider = Instance.new("TextButton")
	
	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	
	body.Name = "body"
	body.Parent = ScreenGui
	body.BackgroundColor3 = Color3.fromRGB(0, 13, 75)
	body.Position = UDim2.new(0.5, 0, 0.05, 0)
	body.Size = UDim2.new(0, 300, 0, 200)
	body.ClipsDescendants = true
	UIListLayout.Parent = body
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = "Bottom"
	
	topper.Name = "topper"
	topper.Parent = ScreenGui
	topper.BackgroundColor3 = Color3.fromRGB(0, 81, 144)
	topper.Position = UDim2.new(0.5, 0, 0.05, 0)
	topper.Size = UDim2.new(0, 300, 0, 20)

	nazwaa.Name = nazwa
	nazwaa.Parent = topper
	nazwaa.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	nazwaa.BackgroundTransparency = 0.800
	nazwaa.Position = UDim2.new(0.24333334, 0, 0, 0)
	nazwaa.Size = UDim2.new(0, 153, 0, 20)
	nazwaa.Font = Enum.Font.SourceSans
	nazwaa.TextColor3 = Color3.fromRGB(255, 255, 255)
	nazwaa.TextSize = 14.000
	nazwaa.Text = nazwa
	
	hider.Name = "hider"
	hider.Parent = topper
	hider.BackgroundColor3 = Color3.fromRGB(8, 0, 103)
	hider.Position = UDim2.new(0.933333337, 0, 0, 0)
	hider.Rotation = 90
	hider.Size = UDim2.new(0, 20, 0, 20)
	hider.Font = Enum.Font.SourceSans
	hider.Text = ">"
	hider.TextColor3 = Color3.fromRGB(255, 255, 255)
	hider.TextSize = 14.000
	hider.MouseButton1Up:Connect(function()
		if toggled == true then
			toggled = false
			body:TweenSize(UDim2.new(0, 300,0, 0), "In", "Linear", 0.2)
			hider.Rotation = 270		
		else
			toggled = true
			body:TweenSize(UDim2.new(0, 300,0, 160), "Out", "Linear", 0.2)
			hider.Rotation = 90
		end	
	end)

	local nooblib={}
	
	
	-- classese ?
	function library:CreateButton(nazwa, callback)
		local callback = callback or function() end
		
		print("dodaje przycisk "..nazwa)
		local button = Instance.new("TextButton")

		button.Name = nazwa
		button.Text = nazwa
		button.Parent = body
		button.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
		button.Size = UDim2.new(0, 90, 0, 35)
		button.Font = Enum.Font.SourceSans
		button.TextColor3 = Color3.fromRGB(0, 0, 0)
		button.TextSize = 14.000
		
		button.MouseButton1Up:Connect(function()
			pcall(callback)
		end)
	end
	
	function library:CreateToggle(text, callback)
		local actions = {}
		local enabled = false
		
		text = text or "New Toggle"
		callback = callback or function() end
		
		local ToggleButton = Instance.new("TextLabel")
		local Background = Instance.new("TextButton")
		local OnOffToggle = Instance.new("TextButton")
	
		ToggleButton.Name = "ToggleButton"
		ToggleButton.Parent = body
		ToggleButton.BackgroundColor3 = Color3.fromRGB(136, 25, 117)
		ToggleButton.Position = UDim2.new(0.300000012, 0, 0.0500000007, 0)
		ToggleButton.Size = UDim2.new(0, 100, 0, 35)
		ToggleButton.Font = Enum.Font.SourceSans
		ToggleButton.Text = text
		ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		ToggleButton.TextSize = 14.000
		ToggleButton.TextWrapped = true
		ToggleButton.TextXAlignment = Enum.TextXAlignment.Left

		Background.Name = "Background"
		Background.Parent = ToggleButton
		Background.BackgroundColor3 = Color3.fromRGB(0, 170, 11)
		Background.Position = UDim2.new(0.74000001, 0, 0.200000435, 0)
		Background.Size = UDim2.new(0, 20, 0, 20)
		Background.SizeConstraint = Enum.SizeConstraint.RelativeXX
		Background.Font = Enum.Font.SourceSans
		Background.Text = ""
		Background.TextColor3 = Color3.fromRGB(255, 255, 255)
		Background.TextSize = 14.000

		OnOffToggle.Name = "OnOffToggle"
		OnOffToggle.Parent = Background
		OnOffToggle.BackgroundColor3 = Color3.fromRGB(0, 13, 75)
		OnOffToggle.Position = UDim2.new(-0.00999999046, 0, 0, 0)
		OnOffToggle.Size = UDim2.new(0, 20, 0, 20)
		OnOffToggle.Font = Enum.Font.SourceSans
		OnOffToggle.Text = ""
		OnOffToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
		OnOffToggle.TextSize = 14.000
		
		local function Fire()
			enabled = not enabled
			if enabled == true then OnOffToggle.Text = "on" else OnOffToggle.Text = "off" end
			pcall(callback, enabled)
		end
		OnOffToggle.MouseButton1Up:Connect(Fire)
		
	end
	
	

	
	return nooblib
end
print("UI "..wersja," loaded!")
return library


