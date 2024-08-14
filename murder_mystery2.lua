local DevHubLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisPresent/ui/main/DevHub.lua"))()
local window = DevHubLibrary:Load("DevHub", "Default")
local tab1 = DevHubLibrary.newTab("Main", "rbxassetid://18705759640")
local tab2 = DevHubLibrary.newTab("Murderer", "rbxassetid://18705777810")
local tab3 = DevHubLibrary.newTab("Server", "rbxassetid://18705825393")

-- OP
local Part = Instance.new("Part", workspace)
   Part.Name = "Running Part"
   Part.Position = Vector3.new(0, 1000, 0)
   Part.Anchored = true
   Part.CanCollide = true
   Part.Size = Vector3.new(5, 1, 5)
   
local Plr = game:GetService("Players").LocalPlayer
local vim = game:GetService('VirtualInputManager');
   
   function GetMurderer()
    for i, v in game:GetService("Players"):GetChildren() do
     if v.Backpack:FindFirstChild"Knife" or v.Character and v.Character:FindFirstChild("Knife") then return v.Character end
    end
    return nil
   end


workspace.ChildAdded:Connect(function(child)
    if child.Name == "GunDrop" and ATG and GetMurderer() ~= Plr.Character then
      print("Gun dropped!")
      while child and task.wait() do
       if (GetMurderer().Head.Position-child.Position).magnitude < 10 then
        repeat task.wait() until (GetMurderer().Head.Position-child.Position).magnitude > 10
       end
       Grabbing = true
       Plr.Character.HumanoidRootPart.CFrame = child.CFrame + Vector3.new(0, .5, 0)
      end
      Grabbing = false
     end
   end)
   function GetMurd()
    return game:GetService("Players"):GetPlayerFromCharacter(GetMurderer())
   end
function MurdererLoop()
    if ASM and Plr.Character and GetMurderer() and Plr.Character:FindFirstChild("Gun") or Plr.Backpack:FindFirstChild("Gun") then
     if Plr.Backpack:FindFirstChild("Gun") then Plr.Backpack.Gun.Parent = Plr.Character end
     local Murd = GetMurderer()
     Plr.Character.HumanoidRootPart.CFrame = Murd.HumanoidRootPart.CFrame - Murd.Head.CFrame.LookVector*10
     Plr.Character.Gun.KnifeServer.ShootGun:InvokeServer(1, Murd.HumanoidRootPart.Position, "AH")
    end
    task.wait(.5)
   end
   function SecondLoop()
    if GetMurderer() == Plr.Character or GetMurderer() == nil or not AE then ImageLabel.Image = '' return end
    ImageLabel.Image = game:GetService('Players'):GetUserThumbnailAsync(GetMurd().UserId, Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size150x150)
    if (GetMurderer().HumanoidRootPart.Position-Plr.Character.HumanoidRootPart.Position).magnitude < 15 and not tpedtoPos and not Grabbing then
     tpedtoPos = Plr.Character.HumanoidRootPart.CFrame
     Plr.Character.HumanoidRootPart.CFrame = Part.CFrame + Vector3.new(0, 3, 0)
    elseif tpedtoPos and (GetMurderer().HumanoidRootPart.Position-Vector3.new(tpedtoPos.X, tpedtoPos.Y, tpedtoPos.Z)).magnitude > 10 and not Grabbing then 
     Plr.Character.HumanoidRootPart.CFrame = tpedtoPos
     tpedtoPos = nil
    end
   end
---- OP

-- Variables
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "ESP Holder"
ESPFolder.Parent = game.CoreGui

-- Functions
local function AddBillboard(player)
    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = player.Name .. "Billboard"
    Billboard.AlwaysOnTop = true
    Billboard.Size = UDim2.new(0, 200, 0, 50)
    Billboard.ExtentsOffset = Vector3.new(0, 3, 0)
    Billboard.Enabled = false
    Billboard.Parent = ESPFolder

    local TextLabel = Instance.new("TextLabel")
    TextLabel.TextSize = 20
    TextLabel.Text = player.Name
    TextLabel.Font = Enum.Font.FredokaOne
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.TextStrokeTransparency = 0
    TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    TextLabel.Parent = Billboard

    repeat
        wait()
        pcall(function()
            Billboard.Adornee = player.Character.Head
            if player.Character:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife") then
                TextLabel.TextColor3 = Color3.new(1, 0, 0)
                if getgenv().MurderEsp then
                    Billboard.Enabled = true
                end
            elseif player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun") then
                TextLabel.TextColor3 = Color3.new(0, 0, 1)
                if getgenv().SheriffEsp then
                    Billboard.Enabled = true
                end
            else
                TextLabel.TextColor3 = Color3.new(0, 1, 0)
                if getgenv().AllEsp then
                    Billboard.Enabled = true
                end
            end
        end)
    until not player.Parent
end

for _, player in pairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        coroutine.wrap(AddBillboard)(player)
    end
end

game.Players.PlayerAdded:Connect(function(player)
    if player ~= game.Players.LocalPlayer then
        coroutine.wrap(AddBillboard)(player)
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
    local billboard = ESPFolder:FindFirstChild(player.Name .. "Billboard")
    if billboard then
        billboard:Destroy()
    end
end)

-- tab 1

tab1.newButton("Teleport to murderer", "Click!", function()
    Plr.Character.HumanoidRootPart.CFrame = GetMurderer() ~= nil and GetMurderer().HumanoidRootPart.CFrame or Plr.Character.HumanoidRootPart.CFrame
end)

tab1.newToggle("Innocent ESP", "Toggle!", false, function(toggleInnocent)
     getgenv().AllEsp = toggleInnocent
        for _, billboard in ipairs(ESPFolder:GetChildren()) do
            if billboard:IsA("BillboardGui") then
                local playerName = billboard.Name:sub(1, -10)
                local player = game.Players:FindFirstChild(playerName)
                if player and player.Character then
                    local hasKnife = player.Character:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife")
                    local hasGun = player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun")
                    if not (hasKnife or hasGun) then
                        billboard.Enabled = toggleInnocent
                    end
                end
            end
        end
end)

tab1.newToggle("Murder ESP", "Toggle!", false, function(toggleMurder)
     getgenv().MurderEsp = toggleMurder
        for _, billboard in ipairs(ESPFolder:GetChildren()) do
            if billboard:IsA("BillboardGui") then
                local playerName = billboard.Name:sub(1, -10)
                local player = game.Players:FindFirstChild(playerName)
                if player and (player.Character:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife")) then
                    billboard.Enabled = toggleMurder
                end
            end
        end
end)

tab1.newToggle("sheriff ESP", "Toggle!", false, function(toggleSheriff)
     getgenv().SheriffEsp = toggleSheriff
        for _, billboard in ipairs(ESPFolder:GetChildren()) do
            if billboard:IsA("BillboardGui") then
                local playerName = billboard.Name:sub(1, -10)
                local player = game.Players:FindFirstChild(playerName)
                if player and (player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun")) then
                    billboard.Enabled = toggleSheriff
                end
            end
        end
end)

tab1.newToggle("Fullbright", "Toggle!", true, function(Fullbright)
    if Fullbright then
        game.Lighting.Brightness = 2
        game.Lighting.GlobalShadows = false
        game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    else
        game.Lighting.Brightness = 1
        game.Lighting.GlobalShadows = true
        game.Lighting.Ambient = Color3.fromRGB(127, 127, 127)
    end
end)

tab2.newButton("Auto Murderer kill all", "Click!", function()
	for i, v in game:GetService("Players"):GetChildren() do
     if Plr.Backpack:FindFirstChild("Knife") then Plr.Backpack.Knife.Parent = Plr.Character end
      Plr.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
      local args = {
       [1] = "Slash"
   }
   
      Plr.Character.Knife:WaitForChild("Stab"):FireServer(unpack(args))
      task.wait(.25)
     end
end)

tab2.newButton("Auto Unfreeze All", "Click!", function()
	for i, v in game:GetService("Players"):GetChildren() do
     if v ~= Plr and not v.Backpack:FindFirstChild("Knife") or v.Character and not v.Character:FindFirstChild("Knife") then
      Plr.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
      task.wait(.75)
     end
    end
end)

tab2.newButton("Auto Freeze All", "Click!", function()
	for i, v in game:GetService("Players"):GetChildren() do
     if v ~= Plr and not v.Backpack:FindFirstChild("Knife") or v.Character and not v.Character:FindFirstChild("Knife") then
     if Plr.Backpack:FindFirstChild("Knife") then Plr.Backpack.Knife.Parent = Plr.Character end
      Plr.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
      local args = {
       [1] = "Slash"
   }
   
      Plr.Character.Knife:WaitForChild("Stab"):FireServer(unpack(args))
      task.wait(.25)
     end
    end
end)

tab3.newButton("Rejoin", "Click!", function()
    game:GetService('TeleportService'):Teleport(game.PlaceId, Plr)
end)

tab3.newButton("ServerHop", "Click!", function()
    local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/GenesisPresent/Script/main/serverhop.lua")()
    module:Teleport(game.PlaceId)
end)