local wersja = "3.13.1"
print("UI "..wersja.."   by rafal9ck#8155")  -- se printuje wersje 

-- library:CreateToggle("testtog1", function(state)   -- nazwa zmienic _G.  zmienną 
	-- _G.test1 = state  
    -- while _G.test1 == true and wait(1) do
		-- print("test1", _G.test1) 		-- co robic 
    -- end
-- end)

--  library:CreateButton("Gay", function()  -- A1 button text
--  	print("yes") -- what to do on click 
--  end)
	
	
local library = {}

function library:CreateWindow(nazwa, x, y)
	local ScreenGui = Instance.new("ScreenGui")
	local body = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local topper = Instance.new("Frame")
	local nazwaa = Instance.new("TextLabel")
	local hider = Instance.new("TextButton")
	
	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.ResetOnSpawn = false
	
	body.Name = "body"
	body.Parent = ScreenGui
	body.BackgroundColor3 = Color3.fromRGB(0, 13, 75)
	body.Position = UDim2.new(0.5, 0, 0, 0)
	body.Size = UDim2.new(0, x, 0, y)
	body.ClipsDescendants = true
	UIListLayout.Parent = body
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = "Top"
	
	topper.Name = "topper"
	topper.Parent = ScreenGui
	topper.BackgroundColor3 = Color3.fromRGB(0, 81, 144)
	topper.Position = UDim2.new(0.5, 0, 0, -20)
	topper.Size = UDim2.new(0, x, 0, 20)

	nazwaa.Name = nazwa
	nazwaa.Parent = topper
	nazwaa.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	nazwaa.BorderSizePixel=0
	nazwaa.BackgroundTransparency = 0.800
	nazwaa.Position = UDim2.new(0,0,0,0)
	nazwaa.Size = UDim2.new(0, x, 0, 20)
	nazwaa.Font = Enum.Font.SourceSans
	nazwaa.TextColor3 = Color3.fromRGB(255, 255, 255)
	nazwaa.TextSize = 14.000
	nazwaa.Text = nazwa
	
	hider.Name = "hider"
	hider.Parent = topper
	hider.BackgroundColor3 = Color3.fromRGB(8, 0, 103)
	hider.Position = UDim2.new(0, x-20, 0, 0)
	hider.Rotation = 90
	hider.Size = UDim2.new(0, 20, 0, 20)
	hider.Font = Enum.Font.SourceSans
	hider.Text = ">"
	hider.TextColor3 = Color3.fromRGB(255, 255, 255)
	hider.TextSize = 14.000
	toggled = true
	hider.MouseButton1Up:Connect(function()
		if toggled == true then
			toggled = false
			body:TweenSize(UDim2.new(0, x,0, 0), "In", "Linear", 0.2)
			hider.Rotation = 270		
		else
			toggled = true
			body:TweenSize(UDim2.new(0, x,0, y), "Out", "Linear", 0.2)
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
		button.Size = UDim2.new(0, 200, 0, 35)
		button.Font = Enum.Font.SourceSans
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
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
		local OnOffToggle = Instance.new("TextButton")
	
		ToggleButton.Name = "ToggleButton"
		ToggleButton.Parent = body
		ToggleButton.BackgroundColor3 = Color3.fromRGB(136, 25, 117)
		ToggleButton.Position = UDim2.new(0, 0, 0, 0)
		ToggleButton.Size = UDim2.new(0, 165, 0, 35)
		ToggleButton.Font = Enum.Font.SourceSans
		ToggleButton.Text = text
		ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		ToggleButton.TextSize = 14.000
		ToggleButton.TextWrapped = true
		ToggleButton.TextXAlignment = Enum.TextXAlignment.Left

		OnOffToggle.Name = "OnOffToggle"
		OnOffToggle.Parent = ToggleButton
		OnOffToggle.BackgroundColor3 = Color3.fromRGB(0, 13, 75)
		OnOffToggle.Position = UDim2.new(0, 165, 0, 0)
		OnOffToggle.Size = UDim2.new(0, 35, 0, 35)
		OnOffToggle.Font = Enum.Font.SourceSans
		OnOffToggle.Text = "off"
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

