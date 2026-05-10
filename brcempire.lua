--[[
    BRC7 | Driving Empire
    Developed by: Fahz-dev
    Username: 7x7x7x7x900
--]]

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "BRC7 | Driving Empire", HidePremium = false, SaveConfig = true, ConfigFolder = "BRC7_Config"})

-- Variabel Global
_G.AutoArrest = false
_G.MinBounty = 0
_G.AutoRob = false
_G.AutoCashout = false
_G.AutoHeist = false
_G.MoneyEarned = 0
_G.TargetCash = 100000

-- Main Tab
local MainTab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

MainTab:AddLabel("Status: Aktif ✅")
local MoneyLabel = MainTab:AddLabel("Money Earned: $0")

MainTab:AddToggle({
	Name = "Auto Arrest",
	Default = false,
	Callback = function(Value)
		_G.AutoArrest = Value
		task.spawn(function()
			while _G.AutoArrest do
				task.wait(0.5)
				for _, v in pairs(game.Players:GetPlayers()) do
					if v.Team ~= game.Players.LocalPlayer.Team and v:FindFirstChild("leaderstats") and v.leaderstats.Bounty.Value >= _G.MinBounty then
						-- Logika Teleport & Arrest Event di sini
						-- game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
						print("Targeting: " .. v.Name)
					end
				end
			end
		end)
	end    
})

MainTab:AddSlider({
	Name = "Minimal Bounty",
	Min = 0,
	Max = 4000000,
	Default = 0,
	Color = Color3.fromRGB(255,255,255),
	Increment = 5000,
	ValueName = "Cash",
	Callback = function(Value)
		_G.MinBounty = Value
	end    
})

MainTab:AddToggle({
	Name = "Auto Rob (ATM)",
	Default = false,
	Callback = function(Value)
		_G.AutoRob = Value
		-- Logika Terbang ke ATM & Destruksi Otomatis
	end    
})

MainTab:AddToggle({
	Name = "Auto Cashout",
	Default = false,
	Callback = function(Value)
		_G.AutoCashout = Value
	end    
})

MainTab:AddToggle({
	Name = "Auto Heist (Bank/Jewelry)",
	Default = false,
	Callback = function(Value)
		_G.AutoHeist = Value
		-- Logika Heist Cycle
	end    
})

MainTab:AddDropdown({
	Name = "Metode Nyuri",
	Default = "Cashout",
	Options = {"Avoid", "Cashout"},
	Callback = function(Value)
		print("Metode: " .. Value)
	end
})

MainTab:AddSlider({
	Name = "Target Uang Dicuri",
	Min = 1000,
	Max = 1000000,
	Default = 100000,
	Increment = 10000,
	ValueName = "Target",
	Callback = function(Value)
		_G.TargetCash = Value
	end    
})

-- Misc Tab
local MiscTab = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4370345144",
	PremiumOnly = false
})

MiscTab:AddButton({
	Name = "Server Hop",
	Callback = function()
		OrionLib:MakeNotification({Name = "System", Content = "Mencari server...", Time = 3})
		local PlaceID = game.PlaceId
		local AllServers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..PlaceID.."/servers/Public?sortOrder=Asc&limit=100"))
		for _, v in pairs(AllServers.data) do
			if v.playing < v.maxPlayers then
				game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, v.id)
			end
		end
	end
})

-- Credit Tab
local CreditTab = Window:MakeTab({
	Name = "Credits",
	Icon = "rbxassetid://4335482575",
	PremiumOnly = false
})

CreditTab:AddLabel("Dev: Fahz-dev")
CreditTab:AddLabel("Region: ???")
CreditTab:AddLabel("Username: 7x7x7x7x900")

OrionLib:MakeNotification({
	Name = "Success!",
	Content = "BRC7 Success Load",
	Image = "rbxassetid://4483345998",
	Time = 5
})

OrionLib:Init()

