local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/magbux/BorealisUiLib/refs/heads/main/Library.Lua"))()
local Alurt = loadstring(game:HttpGet("https://raw.githubusercontent.com/azir-py/project/refs/heads/main/Zwolf/AlurtUI.lua"))()

local Window = Library.new("CubeWare (ROBBER PUMP EDITION) (V1.0.0)")

local shouldNotify = false

local SettingsTab = Window:MakeTab("Settings")
local BlatantTab = Window:MakeTab("BLATANT")
local keybind_cooldown = false

local Settings = {
  ["KillAura"] = {
    ["Enabled"] = false,
    ["Reach"] = 0,
	["WallCheck"] = false;
	["Angle"] = 180,
	["Cooldown"] = 0
  },

  ["SpinBot"] = {
	  ["Enabled"] = false
  }
}

SettingsTab:AddToggle({
	Name = "Spawn Notifications?",
	Callback = function(Value)
		shouldNotify = Value
		print(shouldNotify)
	end
})

BlatantTab:AddKeybind("KillAura", Enum.KeyCode.K, function()
	if keybind_cooldown == true then return end
	
	Settings["KillAura"]["Enabled"] = not Settings["KillAura"]["Enabled"]

	if shouldNotify == true and keybind_cooldown == false then
		local notif1 = Alurt.CreateNode({
   				Title = "Cubeware | KillAura",
   		 		Content = "Kill Aura has been "..(Settings["KillAura"]["Enabled"] == true and "Enabled" or "Disabled").."!",
   		 		Audio = "rbxassetid://0",
    			Length = 3,
   				Image = "rbxassetid://0", 
    			BarColor = Color3.fromRGB(75, 75, 75)
		})
	end

	keybind_cooldown = true
	task.wait(0.35)
	keybind_cooldown = false
end)

BlatantTab:AddKeybind("Spin Bot", Enum.KeyCode.R, function()
	if keybind_cooldown == true then return end
	
	Settings["SpinBot"]["Enabled"] = not Settings["SpinBot"]["Enabled"]

	if shouldNotify == true and keybind_cooldown == false then
		local notif1 = Alurt.CreateNode({
   				Title = "Cubeware | Spin Bot",
   		 		Content = "Spin Bot has been "..(Settings["SpinBot"]["Enabled"] == true and "Enabled" or "Disabled").."!",
   		 		Audio = "rbxassetid://0",
    			Length = 3,
   				Image = "rbxassetid://0", 
    			BarColor = Color3.fromRGB(75, 75, 75)
		})
	end

	keybind_cooldown = true
	task.wait(0.35)
	keybind_cooldown = false
end)

local function Hit()
    game:GetService("ReplicatedStorage").Remote.Attack.AttackOnceRE:FireServer()
end

pcall(function()
	task.spawn(function()
    	while task.wait(Settings["KillAura"]["Cooldown"]) do
        	if Settings["SpinBot"]["Enabled"] == true then
				game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 40
				game.Players.LocalPlayer.Character.PrimaryPart.CFrame *= CFrame.Angles(0, math.rad(40), 0)
			end

			if Settings["KillAura"]["Enabled"] == false then continue end
       		
			Hit()

       	 	task.wait(Settings["KillAura"]["Cooldown"])
    	end
	end)
end)
