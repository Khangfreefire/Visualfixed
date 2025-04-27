-- Script tự động nhấn phím F và click liên tục với cooldown 0.1s

local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Thời gian cooldown giữa mỗi lần nhấn và click
local cooldown = 0.1
local clickCount = 10000  -- Số lần nhấn và click

-- Hàm để tự động nhấn phím F
function pressF()
    -- Tạo sự kiện nhấn phím F
    local inputObject = Instance.new("InputObject", player)
    inputObject.KeyCode = Enum.KeyCode.F
    UserInputService.InputBegan:Fire(inputObject)
    wait(cooldown)
    UserInputService.InputEnded:Fire(inputObject)
end

-- Hàm để tự động click chuột
function clickMouse()
    -- Tạo sự kiện click chuột
    local inputObject = Instance.new("InputObject", player)
    inputObject.UserInputType = Enum.UserInputType.MouseButton1
    inputObject.Position = mouse.Hit.Position
    UserInputService.InputBegan:Fire(inputObject)
    wait(cooldown)
    UserInputService.InputEnded:Fire(inputObject)
end

-- Chạy liên tục 10000 lần nhấn F và click chuột
for i = 1, clickCount do
    pressF()  -- Nhấn phím F
    clickMouse()  -- Click chuột
end
