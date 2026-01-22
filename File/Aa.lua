-- [[ KEY SYSTEM STAND-ALONE - piTc0lelJ9IBEI8r3Bn0 ]] --
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- Konfigurasi
local CorrectKey = "piTc0lelJ9IBEI8r3Bn0"
local KeyLink = "https://pastebin.com/qMsg7pHY"
local Attempts = 0
local MaxAttempts = 5

-- [[ NORMAL NOTIFICATION ]] --
local function SendNormalNotify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5
    })
end

-- Notifikasi awal saat dijalankan
SendNormalNotify("Защита 5.0", "Пожалуйста, сначала возьмите ключ. ^^")

-- [[ KEY UI DESIGN ]] --
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "SilentKeySystem"
KeyGui.Parent = game.CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 320, 0, 240)
Main.Position = UDim2.new(0.5, -160, 0.5, -120)
Main.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
Main.Parent = KeyGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- Avatar Player
local Avatar = Instance.new("ImageLabel")
Avatar.Size = UDim2.new(0, 50, 0, 50)
Avatar.Position = UDim2.new(0.5, -25, 0, -25)
Avatar.Image = Players:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
Avatar.Parent = Main
Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)
local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 3
Stroke.Color = Color3.fromRGB(88, 101, 242)
Stroke.Parent = Avatar

local KTitle = Instance.new("TextLabel")
KTitle.Text = "СИСТЕМА КЛЮЧЕЙ"
KTitle.Size = UDim2.new(1, 0, 0, 50)
KTitle.Position = UDim2.new(0, 0, 0, 20)
KTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KTitle.Font = Enum.Font.Ubuntu
KTitle.TextSize = 20
KTitle.BackgroundTransparency = 1
KTitle.Parent = Main

local KeyInput = Instance.new("TextBox")
KeyInput.PlaceholderText = "Введите ключ..."
KeyInput.Size = UDim2.new(0.85, 0, 0, 40)
KeyInput.Position = UDim2.new(0.075, 0, 0.38, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(35, 37, 40)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Font = Enum.Font.Ubuntu
KeyInput.TextSize = 14
KeyInput.Parent = Main
Instance.new("UICorner", KeyInput)

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Text = "Проверить"
VerifyBtn.Size = UDim2.new(0.85, 0, 0, 40)
VerifyBtn.Position = UDim2.new(0.075, 0, 0.60, 0)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.Font = Enum.Font.Ubuntu
VerifyBtn.TextSize = 16
VerifyBtn.Parent = Main
Instance.new("UICorner", VerifyBtn)

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Text = "Получить ключ"
GetKeyBtn.Size = UDim2.new(0.85, 0, 0, 35)
GetKeyBtn.Position = UDim2.new(0.075, 0, 0.80, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
GetKeyBtn.TextColor3 = Color3.fromRGB(150, 152, 157)
GetKeyBtn.Font = Enum.Font.Ubuntu
GetKeyBtn.TextSize = 14
GetKeyBtn.Parent = Main
Instance.new("UICorner", GetKeyBtn)

-- [[ LOGIC ]] --

local function Success()
    KeyGui:Destroy()
    SendNormalNotify("Успех", "Доступ разрешен!")
    
    -- Eksekusi Script Utama secara otomatis
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://pastebin.com/raw/GXjjbPft"))()
    end)
    
    if not success then
        warn("Gagal memuat script utama: " .. err)
    end
end

VerifyBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CorrectKey then
        Success()
    else
        Attempts = Attempts + 1
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "Неверно! (" .. Attempts .. "/5)"
        
        if Attempts >= MaxAttempts then
            LP:Kick("Возьми сначала ключи, друг. ;1")
        end
    end
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(KeyLink)
    GetKeyBtn.Text = "Скопировано!"
    task.wait(1.5)
    GetKeyBtn.Text = "Получить ключ"
end)

-- Drag System
local dragToggle, dragStart, startPos
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function() dragToggle = false end)
