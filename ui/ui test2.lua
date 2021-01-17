local wersja = "3.16.13" --
print("UI "..wersja.."   by ciabar9ck#8155")  -- se printuje wersje 

-- library:CreateToggle("testtog1", function(state)   -- nazwa zmienic _G.  zmienną 
	-- _G.test1 = state  
    -- while _G.test1 == true and wait(1) do
		-- print("test1", _G.test1) 		-- co robic 
    -- end
-- end)

--  library:CreateButton("Gay", function()  -- A1 button text
--  	print("yes") -- what to do on click 
--  end)
	
function addDrag(a)local b=game:GetService("Players").LocalPlayer:GetMouse()local c=game:GetService('UserInputService')local d=game:GetService("RunService").Heartbeat;local e,f=pcall(function()return a.MouseEnter end)if e then a.Active=true;f:connect(function()local g=a.InputBegan:connect(function(h)if h.UserInputType==Enum.UserInputType.MouseButton1 then local i=Vector2.new(b.X-a.AbsolutePosition.X,b.Y-a.AbsolutePosition.Y)while d:wait()and c:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do pcall(function()a:TweenPosition(UDim2.new(0,b.X-i.X,0,b.Y-i.Y),'Out','Linear',0.1,true)end)end end end)local j;j=a.MouseLeave:connect(function()g:disconnect()j:disconnect()end)end)end end

local library = {}
bordcol={120, 120,120}

function library:CreateWindow(nazwa, xpos, ypos) -- nazwa rozmiar pozycja
	local xposoff = 0
	local yposoff = 0
	
	x = x or 200
	y = y or 0
	if xpos ~= nil and xpos > 5 then -- pozycja x
			xposoff = xpos
			xpos = 0
	else
		xpos = xpos or 0.5
	end
	
	if ypos ~= nil and ypos > 5 then -- pozycja y
			yposoff = ypos
			ypos = 0
	else
		xpos = xpos or 0.15
	end

	
	local ScreenGui = Instance.new("ScreenGui")
	local body = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local topper = Instance.new("Frame")
	local nazwaa = Instance.new("TextLabel")
	local hider = Instance.new("TextButton")
	local deleter = Instance.new("TextButton")
	addDrag(topper)
	
	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.ResetOnSpawn = false
	ScreenGui.DisplayOrder = 100
	ScreenGui.Name = nazwa
	
	topper.Name = "topper"
	topper.Parent = ScreenGui
	topper.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
	topper.Position = UDim2.new(xpos, xposoff, ypos, yposoff)
	topper.Size = UDim2.new(0, x, 0, 20)
	topper.BorderColor3 = Color3.new(bordcol)
	topper.Transparency = 0.1
	
	body.Name = "body"
	body.Parent = topper
	body.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
	body.Position = UDim2.new(0, 0 ,0 ,21)
	body.Size = UDim2.new(0, x, 0, y)
	body.ClipsDescendants = true
	UIListLayout.Parent = body
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = "Top"

	nazwaa.Name = nazwa
	nazwaa.Parent = topper
	nazwaa.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
	nazwaa.BorderSizePixel=0
	nazwaa.BackgroundTransparency = 1
	nazwaa.Position = UDim2.new(0,0,0,0)
	nazwaa.Size = UDim2.new(0, x-40, 0, 20)
	nazwaa.Font = Enum.Font.SourceSans
	nazwaa.TextColor3 = Color3.fromRGB(255, 255, 255)
	nazwaa.TextSize = 14.000
	nazwaa.Text = nazwa
	
	deleter.Name = "deleter" -- deleter
	deleter.Parent = topper
	deleter.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
	deleter.Position = UDim2.new(0, x-40, 0, 0)
	deleter.Size = UDim2.new(0, 20, 0, 20)
	deleter.Font = Enum.Font.Highway
	deleter.Text = "X"
	deleter.TextColor3 = Color3.fromRGB(255, 255, 255)
	deleter.TextSize = 14.000
	deleter.BorderColor3 = Color3.new(bordcol)
	deleter.BackgroundTransparency = 0.1
	deleter.Visible = false
	
	deleter.MouseButton1Click:Connect(function()
		ScreenGui:Destroy()
	end)
	
	hider.Name = "hider"
	hider.Parent = topper
	hider.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
	hider.Position = UDim2.new(0, x-20, 0, 0)
	hider.Rotation = 90
	hider.Size = UDim2.new(0, 20, 0, 20)
	hider.Font = Enum.Font.Highway
	hider.Text = ">"
	hider.TextColor3 = Color3.fromRGB(255, 255, 255)
	hider.TextSize = 14.000
	hider.BorderColor3 = Color3.new(bordcol)
	hider.BackgroundTransparency = 0.1
	toggled = true
	hider.MouseButton1Up:Connect(function()
		if toggled == true then
			toggled = false
			body:TweenSize(UDim2.new(0, x,0, 0), "In", "Linear", 0.2)
			hider.Rotation = 270
			wait(2)
			if toggled == false then
				deleter.Visible = true
			end
		else
			toggled = true
			deleter.Visible = false
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
		
		body.Size = body.Size + UDim2.new(0,0,0,35)
		y = y + 35
		
		button.Name = nazwa
		button.Text = nazwa
		button.Parent = body
		button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		button.Size = UDim2.new(0, 200, 0, 35)
		button.Font = Enum.Font.SourceSans
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
		button.TextSize = 14.000
		button.BorderColor3 = Color3.new(bordcol)
		button.TextXAlignment = Enum.TextXAlignment.Left
		
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
	
		y = y + 35
		body.Size = body.Size + UDim2.new(0,0,0,35)
		
		ToggleButton.Name = "ToggleButton"
		ToggleButton.Parent = body
		ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		ToggleButton.Position = UDim2.new(0, 0, 0, 0)
		ToggleButton.Size = UDim2.new(0, 165, 0, 35)
		ToggleButton.Font = Enum.Font.SourceSans
		ToggleButton.Text = text
		ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		ToggleButton.TextSize = 14.000
		ToggleButton.TextWrapped = true
		ToggleButton.TextXAlignment = Enum.TextXAlignment.Left
		ToggleButton.BorderColor3 = Color3.new(bordcol)

		OnOffToggle.Name = "OnOffToggle"
		OnOffToggle.Parent = ToggleButton
		OnOffToggle.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
		OnOffToggle.Position = UDim2.new(0, 165, 0, 0)
		OnOffToggle.Size = UDim2.new(0, 35, 0, 35)
		OnOffToggle.Font = Enum.Font.SourceSans
		OnOffToggle.Text = "off"
		OnOffToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
		OnOffToggle.TextSize = 14.000
		OnOffToggle.BorderColor3 = Color3.new(bordcol)
		
		local function Fire()
			enabled = not enabled
			if enabled == true then 
				OnOffToggle.Text = "on" 
				OnOffToggle.BackgroundColor3 = Color3.fromRGB(0, 130, 0)
			else 
				OnOffToggle.Text = "off"
				OnOffToggle.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
			end
			pcall(callback, enabled)
		end
		
		OnOffToggle.MouseButton1Up:Connect(Fire)
	end
	
	function library:Createswitch(name, options, callback, default)
		callback = callback or function() end
		local default = default or "Choose"
		
		body.Size = body.Size + UDim2.new(0,0,0,35)
		
		local base = Instance.new("Frame")
		base.Name = "switchbase"
		base.Parent= body
		base.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		base.Size = UDim2.new(0, 165, 0, 35)
		
		local title = Instance.new("TextLabel")
		title.Parent = base
		title.Transparency = 1 
		title.Size = base.Size
		title.Text = name
		title.TextColor3 = Color3.fromRGB(255, 255, 255)
		title.Font = Enum.Font.SourceSans
		title.BorderSizePixel = 0
		
		local switch = Instance.new("Frame")
		switch.Position =  UDim2.new(0, 60, 0, 5)
		switch.Size = UDim2.new(0, 100, 0, 0)
		local openedswitchsize = UDim2.new(0, 100, 0, 0)
		switch.Transparency = 1
		switch.Parent = base
		switch.Name = "switchframe"
		switch.ZIndex = 101
		switch.ClipsDescendants = true
		
		local switchpositioner = Instance.new("UIListLayout")
		switchpositioner.Parent = switch
		
		local selected = Instance.new("TextButton")
		selected.Name = "openselectionbutton"
		selected.Parent = base
		selected.Position = UDim2.new(0, 60, 0, 5)
		selected.Size = UDim2.new(0, 100, 0, 25)
		selected.Text = default or "Choose"
		selected.Font = Enum.Font.SourceSans
		
		local openedswitchsize = UDim2.new(0, 0, 0, 0)
		
		local function callb()
			callback(selected.Text)
		end
		
		for i, v in pairs(options) do
			openedswitchsize = openedswitchsize + UDim2.new(0, 0, 0, 15)
			local case = Instance.new("TextButton")
			case.Font = Enum.Font.SourceSans
			case.Parent = switch
			case.Name = v.." swichcase"
			case.Text = v
			case.Size = UDim2.new(0, 100, 0, 15)
			
			local function choose()
				selected.Text = v
				case.Parent:TweenSize(UDim2.new(0, 100, 0, 0), "In", "Linear", 0.2)
				callb()
				print("SELECTED")
			end
			case.MouseButton1Click:Connect(choose)
		end
		
		local function openchoose()
			print("opening" , openedswitchsize)
			switchframe:TweenSize(UDim2.new(0, 100, 0, openedswitchsize), "Out", "Linear", 0.2)
		end
		
		selected.MouseButton1Click:Connect(openchoose)
		
		print("done")
	end
	
	return nooblib
end
print("UI "..wersja," loaded!")
return library
