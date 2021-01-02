local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/rafal11ck/github-repo/cos1/ui/ui%20lib%20test.lua"))() 
local Main = library:CreateWindow("Gui Name" , 500,300)  -- tworzy glowne okno gui

library:CreateToggle("testtog1", function(state) 
	_G.test1 = state
    while _G.test1 == true and wait(1) do
		print("test1", _G.test1)
    end
end)

library:CreateToggle("testtog2", function(state)
	_G.test2 = state
    while _G.test2 == true and wait(1) do
		print("test2", _G.test2)
    end
end)

library:CreateButton("Gay", function()
    print("yes")
    end)

