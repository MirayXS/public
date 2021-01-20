local wersja = "3.17.41"
print("UI "..wersja.."   by ciabar9ck#8155")  -- se printuje wersje

--[[
library:CreateWindow(nazwa, winPosition)  -- string UDIm2

 library:CreateToggle("testtog1", function(state)   -- nazwa zmienic _G.  zmienną
	_G.test1 = state
    while _G.test1 == true and wait(1) do
		print("test1", _G.test1) 		-- co robic
    end
 end)

 library:CreateButton("Gay", function()  -- string function
	 	print("yes") -- what to do on click
 end)

 library:Createswitch("switch", {"option1", "option2", "option3", "option4", "option5"}, function(selection)  -- string, list, function that fires on change of button
    print("yes ", selection)
end,"default :)")

function library:CreateTextbox(name, function() --string, function(return string)
	
end, textpos, sizex, sizey, transp) --, poisiton UDim2, sizex number, sizey number, transparency number



--]]

function addDrag(a)local b=game:GetService("Players").LocalPlayer:GetMouse()local c=game:GetService('UserInputService')local d=game:GetService("RunService").Heartbeat;local e,f=pcall(function()return a.MouseEnter end)if e then a.Active=true;f:connect(function()local g=a.InputBegan:connect(function(h)if h.UserInputType==Enum.UserInputType.MouseButton1 then local i=Vector2.new(b.X-a.AbsolutePosition.X,b.Y-a.AbsolutePosition.Y)while d:wait()and c:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do pcall(function()a:TweenPosition(UDim2.new(0,b.X-i.X,0,b.Y-i.Y),'Out','Linear',0.1,true)end)end end end)local j;j=a.MouseLeave:connect(function()g:disconnect()j:disconnect()end)end)end end

local library = {}
bordcol={120, 120,120}

function library:CreateWindow(nazwa, winPosition) -- nazwa rozmiar pozycja
	
	x = x or 200 --wymiary
	y = y or 0 -- wymiary

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
	topper.Position = winPosition
	topper.Size = UDim2.new(0, x, 0, 20)
	topper.BorderColor3 = Color3.new(bordcol)
	topper.Transparency = 0.1

	body.Name = "body"
	body.Parent = topper
	body.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
	body.Position = UDim2.new(0,0,0,20)
	body.Size = UDim2.new(0, x, 0, y)
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
	deleter.Position = UDim2.new(0, x-41, 0, 0)
	deleter.Size = UDim2.new(0, 20, 0, 20)
	deleter.Font = Enum.Font.Highway
	deleter.TextXAlignment = Enum.TextXAlignment.Center
	deleter.TextYAlignment = Enum.TextYAlignment.Center
	deleter.Text = "x"
	deleter.TextColor3 = Color3.fromRGB(255, 255, 255)
	deleter.TextSize = 14.000
	deleter.BorderColor3 = Color3.new(bordcol)
	deleter.BackgroundTransparency = 0.1
	deleter.Visible = false

	deleter.MouseButton1Click:Connect(function()
		topper:Destroy()
	end)

	hider.Name = "hider"
	hider.Parent = topper
	hider.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
	hider.Position = UDim2.new(0, x-20, 0, 0)
	hider.Rotation = 90
	hider.Size = UDim2.new(0, 20, 0, 20)
	hider.Font = Enum.Font.ArialBold
	hider.Text = ">"
	hider.TextColor3 = Color3.fromRGB(255, 255, 255)
	hider.TextSize = 14.000
	hider.BorderColor3 = Color3.new(bordcol)
	hider.BackgroundTransparency = 0.1
	local toggled = true
	hider.MouseButton1Up:Connect(function()
		if toggled == true then
			toggled = false
			body.ClipsDescendants = true
			body:TweenSize(UDim2.new(0, x,0, 0), "In", "Linear", 0.2)
			hider.Rotation = 270
			wait(2)
			if toggled == false then
				deleter.Visible = true
			end
		else
			toggled = true
			deleter.Visible = false
			local function nclip()
				body.ClipsDescendants = false
			end
			body:TweenSize(UDim2.new(0, x,0, y), "Out", "Linear", 0.2, false, nclip)
			hider.Rotation = 90
		end
	end)

	local nooblib={}
		-- classese ?
		function library:CreateButton(nazwa, callback)
			local callback = callback or function() end

			--print("dodaje przycisk "..nazwa)
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

		function library:Createswitch(sname, options, callback, default)
			sname = sname or "switchname"
			callback = callback or function() end
			local default = default or "Choose"

			y = y + 35
			body.Size = body.Size + UDim2.new(0,0,0,35)

			local base = Instance.new("Frame")
			base.Name = "switchbase"
			base.Parent= body
			base.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			base.Size = UDim2.new(0, 200, 0, 35)
			base.BorderColor3 = Color3.new(bordcol)

			local title = Instance.new("TextLabel")
			title.Name = "switchtitle"
			title.Parent = base
			title.BackgroundTransparency = 1
			title.Size = base.Size
			title.TextColor3 = Color3.fromRGB(255, 255, 255)
			title.TextXAlignment = Enum.TextXAlignment.Left
			title.Font = Enum.Font.SourceSans
			title.BorderSizePixel = 0
			title.TextSize = 14.000
			title.Text = sname

			local switch = Instance.new("Frame")
			switch.Position =  UDim2.new(0, 90, 0, 5)
			switch.Size = UDim2.new(0, 100, 0, 0)
			switch.Transparency = 1
			switch.Parent = base
			switch.Name = "switchframe"
			switch.ZIndex = 101
			switch.ClipsDescendants = true
			switch.BorderColor3 = Color3.new(bordcol)

			local switchpositioner = Instance.new("UIListLayout")
			switchpositioner.Parent = switch

			local selected = Instance.new("TextButton")
			selected.Name = "openselectionbutton"
			selected.Parent = base
			selected.Position = UDim2.new(0, 90, 0, 5)
			selected.Size = UDim2.new(0, 101, 0, 25)
			selected.Text = default or "Choose"
			selected.Font = Enum.Font.SourceSans
			selected.TextSize = 14.000
			selected.BorderColor3 = Color3.new(bordcol)


			local openedswitchsize = UDim2.new(100, 0, 0, 1)
			for i = 1, #options do
				openedswitchsize = openedswitchsize + UDim2.new(0, 0, 0, 25)
			end

			local function callb()
				pcall(callback, selected.Text)
			end

			local function openchoose()
				base.ClipsDescendants = false
				local function clipf()
					switch.ClipsDescendants = false
				end
				--print("opening ", switch.Size, " to ", openedswitchsize)
				base.ZIndex = base.ZIndex + 1
				switch:TweenSize(openedswitchsize, "Out", "Linear", 0.2, false, clipf)
			end

			selected.MouseButton1Click:Connect(openchoose)

			for i, v in pairs(options) do
				local case = Instance.new("TextButton")
				case.Font = Enum.Font.SourceSans
				case.Parent = switch
				case.Name = v.." swichcase"
				case.Text = v
				case.Size = UDim2.new(0, 100, 0, 25)
				case.TextSize = 14.000
				case.BorderColor3 = Color3.new(bordcol)

				local function choosef()
					selected.Text = case.Text
					local function clip()
						base.ClipsDescendants = true
						base.ZIndex = base.ZIndex - 1
					end
					switch.ClipsDescendants = true
					switch:TweenSize(UDim2.new(0, 100, 0, 0), "In", "Linear", 0.2, false, clip)
					callb()
					--print("SELECTED"..case.Text)
				end
				case.MouseButton1Click:Connect(choosef)
			end
			callb()
		end
		function library:CreateTextbox(name, gettextfunc, textpos, sizex, sizey, transp)
			xpos = xpos or 0.4
			ypos = ypos or 0.8
			sizex = sizex or 200
			sizey = sizey or 300
			transp = transp or 0
			local xposoff = 0
			local yposoff = 0
			textpos = textpos or UDim2.new(0,0,0,0)

			local titileboxframe = Instance.new("Frame")
			titileboxframe.Parent = topper.Parent
			titileboxframe.Position = textpos
			titileboxframe.Size = UDim2.new(0, sizex, 0 , 20)
			titileboxframe.Name = "titileboxframe Frame"..name
			titileboxframe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			titileboxframe.BackgroundTransparency = 1
			titileboxframe.BorderColor3 = Color3.new(bordcol)
			local function addDrag(a)local b=game:GetService("Players").LocalPlayer:GetMouse()local c=game:GetService('UserInputService')local d=game:GetService("RunService").Heartbeat;local e,f=pcall(function()return a.MouseEnter end)if e then a.Active=true;f:connect(function()local g=a.InputBegan:connect(function(h)if h.UserInputType==Enum.UserInputType.MouseButton1 then local i=Vector2.new(b.X-a.AbsolutePosition.X,b.Y-a.AbsolutePosition.Y)while d:wait()and c:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do pcall(function()a:TweenPosition(UDim2.new(0,b.X-i.X,0,b.Y-i.Y),'Out','Linear',0.1,true)end)end end end)local j;j=a.MouseLeave:connect(function()g:disconnect()j:disconnect()end)end)end end
			addDrag(titileboxframe)

			local boxframe = Instance.new("Frame")
			boxframe.Parent = titileboxframe
			boxframe.Position = UDim2.new(0,0,0,21)
			boxframe.Size = UDim2.new(0, sizex, 0 , sizey)
			boxframe.Name = "textboxframe"..name
			boxframe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			boxframe.BackgroundTransparency = 1
			boxframe.BorderColor3 = Color3.new(bordcol)

			local titlebox = Instance.new("TextLabel")
			titlebox.TextColor3 = Color3.fromRGB(255, 255, 255)
			titlebox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			titlebox.Size = UDim2.new(0, sizex, 0, 20)
			titlebox.Parent = titileboxframe
			titlebox.Name = "titlebox"..name
			titlebox.Position= UDim2.new(0,0,0,0)
			titlebox.BackgroundTransparency = transp
			titlebox.Text = name or "nodata"
			titlebox.BorderColor3 = Color3.new(bordcol)

			local textbox = Instance.new("TextLabel")
			textbox.Parent = boxframe
			textbox.Name = "databox"..name
			textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
			textbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			textbox.Position = UDim2.new(0,0,0,0)
			textbox.Size =  UDim2.new(0, sizex, 0, sizey)
			textbox.BackgroundTransparency = transp
			textbox.BorderColor3 = Color3.new(bordcol)
			textbox.TextXAlignment = Enum.TextXAlignment.Left
			textbox.TextYAlignment = Enum.TextYAlignment.Top

			local textboxdeleter = Instance.new("TextButton")
			textboxdeleter.Name = "deleter"..name -- deleter
			textboxdeleter.Parent = titileboxframe
			textboxdeleter.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
			textboxdeleter.Position = UDim2.new(0, x-41, 0, 0)
			textboxdeleter.Size = UDim2.new(0, 20, 0, 20)
			textboxdeleter.Font = Enum.Font.ArialBold
			textboxdeleter.Text = "x"
			textboxdeleter.TextColor3 = Color3.fromRGB(255, 255, 255)
			textboxdeleter.TextSize = 14.000
			textboxdeleter.BorderColor3 = Color3.new(bordcol)
			textboxdeleter.BackgroundTransparency = 0.1
			textboxdeleter.Visible = false

			textboxdeleter.MouseButton1Click:Connect(function()
				titileboxframe:Destroy()
			end)

			local textboxhider = Instance.new("TextButton")
			textboxhider.Name = "textboxhider"..name
			textboxhider.Parent = titileboxframe
			textboxhider.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
			textboxhider.Position = UDim2.new(0, x-20, 0, 0)
			textboxhider.Rotation = 90
			textboxhider.Size = UDim2.new(0, 20, 0, 20)
			textboxhider.Font = Enum.Font.Highway
			textboxhider.Text = ">"
			textboxhider.TextColor3 = Color3.fromRGB(255, 255, 255)
			textboxhider.TextSize = 14.000
			textboxhider.BorderColor3 = Color3.new(bordcol)
			textboxhider.BackgroundTransparency = 0.1
			local toggled = true
			
			textboxhider.MouseButton1Up:Connect(function()
				if toggled == true then
					toggled = false
					textbox.ClipsDescendants = true
					textbox:TweenSize(UDim2.new(0, sizex,0, 0), "In", "Linear", 0.2)
					textboxhider.Rotation = 270
					wait(2)
					if toggled == false then
						textboxdeleter.Visible = true
					end
				else
					toggled = true
					textboxdeleter.Visible = false
					local function nclip()
						titileboxframe.ClipsDescendants = false
					end
					textbox:TweenSize(UDim2.new(0, sizex,0, sizey), "Out", "Linear", 0.2, false, nclip)
					textboxhider.Rotation = 90
				end
			end)

			local function issting(gettextfunc)
				local issting = pcall(function()
					gettextfunc = gettextfunc..""
					return true
				end, gettextfunc)
				return issting
			end

			while wait() do
				if isstring(gettextfunc) then
					textbox.Text = gettextfunc
					wait(5)
				else
					local succes, result = pcall(gettextfunc)
					if succes then
						textbox.Text = result
					else
						print("DATA FUNCTION ERROR!")
					end
				end
			end


		end

		--print("done")
	return nooblib
end
print("UI "..wersja," loaded!")
return library
