-- Visual 3.7 | Blade Ball Script
-- Made by ChatGPT Support
-- Không cần Key, Full chức năng Auto

-- Loading screen
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local LoadBar = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "LoadingScreen"

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.Position = UDim2.new(0.05, 0, 0.93, 0)
Frame.Size = UDim2.new(0.9, 0, 0.03, 0)

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Frame

LoadBar.Parent = Frame
LoadBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
LoadBar.Size = UDim2.new(0, 0, 1, 0)
LoadBar.BorderSizePixel = 0

TextLabel.Parent = Frame
TextLabel.Text = "Đang Tải Visual 3.7..."
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.BackgroundTransparency = 1
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.Font = Enum.Font.Gotham

-- Animate loading bar
task.spawn(function()
    for i = 0, 1, 0.01 do
        LoadBar.Size = UDim2.new(i, 0, 1, 0)
        task.wait(0.01)
    end
    ScreenGui:Destroy()
end)

-- Actual script
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Visual 3.7 | Blade Ball", "Ocean")

-- Main Tab
local Main = Window:NewTab("Main")
local MainSection = Main:NewSection("Auto Functions")

MainSection:NewToggle("Auto Parry", "Tự động đỡ bóng", function(state)
    getgenv().autoParry = state
end)

MainSection:NewToggle("Auto Skill", "Tự động dùng kỹ năng", function(state)
    getgenv().autoSkill = state
end)

MainSection:NewToggle("Auto Dash", "Tự động dash né", function(state)
    getgenv().autoDash = state
end)

MainSection:NewToggle("Auto Block", "Tự động chắn bóng", function(state)
    getgenv().autoBlock = state
end)

MainSection:NewToggle("Auto Dodge", "Tự động né bóng", function(state)
    getgenv().autoDodge = state
end)

MainSection:NewToggle("Auto Farm Chest", "Tự động nhặt rương", function(state)
    getgenv().autoChest = state
end)

MainSection:NewToggle("Auto Farm Win", "Tự động farm chiến thắng", function(state)
    getgenv().autoWin = state
end)

-- Functions
task.spawn(function()
    while task.wait() do
        if getgenv().autoParry then
            pcall(function()
                local args = {[1] = true}
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ParryButtonPress"):FireServer(unpack(args))
            end)
        end
        if getgenv().autoSkill then
            pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ActivateSkill"):FireServer()
            end)
        end
        if getgenv().autoDash then
            pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Dash"):FireServer()
            end)
        end
        if getgenv().autoBlock then
            pcall(function()
                local args = {[1] = true}
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("BlockButtonPress"):FireServer(unpack(args))
            end)
        end
        if getgenv().autoDodge then
            pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Dodge"):FireServer()
            end)
        end
        if getgenv().autoChest then
            pcall(function()
                for _, v in pairs(workspace:GetChildren()) do
                    if v.Name:lower():find("chest") and v:FindFirstChild("TouchInterest") then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
                        task.wait()
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
                    end
                end
            end)
        end
        if getgenv().autoWin then
            pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Win"):FireServer()
            end)
        end
    end
end)