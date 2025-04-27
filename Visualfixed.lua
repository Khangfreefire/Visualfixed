-- Final Blox Fruits Auto Farm Script for Sea 1

---------------------------
-- Tạo GUI Toggle Icon --
---------------------------
local ToggleIcon = Instance.new("TextButton")
ToggleIcon.Name = "ToggleIcon"
ToggleIcon.Size = UDim2.new(0, 40, 0, 40)
ToggleIcon.Position = UDim2.new(0, 10, 0.5, -20)
ToggleIcon.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleIcon.Text = "🍃"
ToggleIcon.TextScaled = true
ToggleIcon.Parent = game.CoreGui

-----------------------------------
-- Tạo GUI chính (ẩn mặc định) --
-----------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoFarmGUI"
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local function createButton(name, text, pos)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 280, 0, 40)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(100,100,100)
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Parent = MainFrame
    return btn
end

local btnAutoFarm    = createButton("AutoFarm", "Auto Farm OFF", UDim2.new(0, 10, 0, 10))
local btnAutoSkill   = createButton("AutoSkill", "Auto Skill OFF", UDim2.new(0, 10, 0, 60))
local btnAutoBuso    = createButton("AutoBuso", "Auto Buso OFF", UDim2.new(0, 10, 0, 110))
local btnFarmChest   = createButton("FarmChest", "Auto Farm Chest OFF", UDim2.new(0, 10, 0, 160))
local btnServerHop   = createButton("ServerHop", "Server Hop OFF", UDim2.new(0, 10, 0, 210))

local autoFarm   = false
local autoSkill  = false
local autoBuso   = false
local autoChest  = false
local serverHop  = false

btnAutoFarm.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    btnAutoFarm.Text = autoFarm and "Auto Farm ON" or "Auto Farm OFF"
end)

btnAutoSkill.MouseButton1Click:Connect(function()
    autoSkill = not autoSkill
    btnAutoSkill.Text = autoSkill and "Auto Skill ON" or "Auto Skill OFF"
end)

btnAutoBuso.MouseButton1Click:Connect(function()
    autoBuso = not autoBuso
    btnAutoBuso.Text = autoBuso and "Auto Buso ON" or "Auto Buso OFF"
end)

btnFarmChest.MouseButton1Click:Connect(function()
    autoChest = not autoChest
    btnFarmChest.Text = autoChest and "Auto Farm Chest ON" or "Auto Farm Chest OFF"
end)

btnServerHop.MouseButton1Click:Connect(function()
    serverHop = not serverHop
    btnServerHop.Text = serverHop and "Server Hop ON" or "Server Hop OFF"
end)

local guiVisible = false
ToggleIcon.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    MainFrame.Visible = guiVisible
end)

-------------------------------
-- Các vòng lặp chính (loops)
-------------------------------
spawn(function()
    while wait() do
        if autoFarm then
            pcall(function()
                local args = { [1] = "StartQuest", [2] = "Bandit", [3] = 1 }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end)
            for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                    pcall(function()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0,10,0)
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
                        wait(0.1)
                        game:GetService("VirtualUser"):Button1Up(Vector2.new(0,0))
                    end)
                end
            end
        end
    end
end)

spawn(function()
    while wait(0.2) do
        if autoSkill then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Z")
                game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("X")
                game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("C")
            end)
        end
    end
end)

spawn(function()
    while wait(1) do
        if autoBuso then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
            end)
        end
    end
end)

spawn(function()
    while wait() do
        if autoChest then
            for _, obj in pairs(game.Workspace:GetChildren()) do
                if obj.Name == "Chest" and obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") then
                    pcall(function()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.HumanoidRootPart.CFrame
                        wait(0.2)
                    end)
                end
            end
        end
    end
end)

spawn(function()
    while wait(5) do
        if serverHop then
            pcall(function()
                local TeleportService = game:GetService("TeleportService")
                TeleportService:Teleport(game.PlaceId, game.Players.LocalPlayer)
            end)
        end
    end
end)
