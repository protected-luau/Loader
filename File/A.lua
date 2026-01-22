-- [[ OP BLADE - ELEGANT CUSTOM UI ]] --
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- Global Settings (Toggles)
_G.GodMode = false
_G.AutoHeal = false

-- [[ NOTIFICATION SYSTEM ]] --
local function SendNotification(title, text)
    local NotificationGui = Instance.new("ScreenGui")
    NotificationGui.Parent = game.CoreGui
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 250, 0, 80)
    Frame.Position = UDim2.new(1, 5, 0.8, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
    Frame.Parent = NotificationGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Frame
    
    local TTitle = Instance.new("TextLabel")
    TTitle.Text = title
    TTitle.Size = UDim2.new(1, -20, 0, 30)
    TTitle.Position = UDim2.new(0, 10, 0, 5)
    TTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    TTitle.Font = Enum.Font.Ubuntu
    TTitle.TextSize = 18
    TTitle.BackgroundTransparency = 1
    TTitle.Parent = Frame
    
    local TText = Instance.new("TextLabel")
    TText.Text = text
    TText.Size = UDim2.new(1, -20, 0, 30)
    TText.Position = UDim2.new(0, 10, 0, 35)
    TText.TextColor3 = Color3.fromRGB(180, 180, 180)
    TText.Font = Enum.Font.Ubuntu
    TText.TextSize = 14
    TText.BackgroundTransparency = 1
    TText.Parent = Frame

    -- Animation
    Frame:TweenPosition(UDim2.new(1, -260, 0.8, 0), "Out", "Quart", 0.5)
    task.wait(4)
    Frame:TweenPosition(UDim2.new(1, 5, 0.8, 0), "In", "Quart", 0.5)
    task.wait(0.5)
    NotificationGui:Destroy()
end

SendNotification("SilentExecute", "Enjoy This Script ;D")

-- [[ UI CORE ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OPBlade_Elegant"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(54, 57, 63) -- Discord Dark Color
Main.Position = UDim2.new(0.5, -160, 0.5, -130)
Main.Size = UDim2.new(0, 320, 0, 340)
Main.ClipsDescendants = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Main

-- [[ TOPBAR (Title Integrated) ]] --
local Topbar = Instance.new("Frame")
Topbar.Name = "Topbar"
Topbar.Parent = Main
Topbar.BackgroundColor3 = Color3.fromRGB(54, 57, 63) -- Same as Main (Seamless)
Topbar.Size = UDim2.new(1, 0, 0, 50)

local AvFrame = Instance.new("ImageLabel")
AvFrame.Parent = Topbar
AvFrame.Position = UDim2.new(0, 12, 0, 7)
AvFrame.Size = UDim2.new(0, 35, 0, 35)
AvFrame.Image = Players:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
local AvCorner = Instance.new("UICorner")
AvCorner.CornerRadius = UDim.new(1, 0)
AvCorner.Parent = AvFrame

local Title = Instance.new("TextLabel")
Title.Parent = Topbar
Title.Text = "⚔️ OP BLADE"
Title.Font = Enum.Font.Ubuntu
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Position = UDim2.new(0, 55, 0, 0)
Title.Size = UDim2.new(0, 150, 1, 0)
Title.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "✕"
CloseBtn.Parent = Topbar
CloseBtn.Position = UDim2.new(1, -35, 0, 12)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.TextSize = 18

local MiniBtn = Instance.new("TextButton")
MiniBtn.Text = "—"
MiniBtn.Parent = Topbar
MiniBtn.Position = UDim2.new(1, -65, 0, 12)
MiniBtn.Size = UDim2.new(0, 25, 0, 25)
MiniBtn.BackgroundTransparency = 1
MiniBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MiniBtn.TextSize = 18

-- [[ CONTENT CONTAINER ]] --
local Container = Instance.new("ScrollingFrame")
Container.Parent = Main
Container.Position = UDim2.new(0, 10, 0, 55)
Container.Size = UDim2.new(1, -20, 1, -65)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 0

local UIList = Instance.new("UIListLayout")
UIList.Parent = Container
UIList.Padding = UDim.new(0, 8)

-- [[ UI FUNCTIONS ]] --
local function CreateToggle(name, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = Container
    btn.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(230, 230, 230)
    btn.Font = Enum.Font.Ubuntu
    btn.TextSize = 14
    btn.AutoButtonColor = false
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        local targetColor = active and Color3.fromRGB(88, 101, 242) or Color3.fromRGB(47, 49, 54)
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = targetColor}):Play()
        callback(active)
    end)
end

local function CreateButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = Container
    btn.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Ubuntu
    btn.TextSize = 14
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn

    btn.MouseButton1Click:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(60, 65, 75)
        task.wait(0.1)
        btn.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
        callback()
    end)
end

-- [[ FEATURE LOGICS ]] --

-- God Mode Loop
task.spawn(function()
    while task.wait(0.1) do
        if _G.GodMode and LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.Health = LP.Character.Humanoid.MaxHealth
        end
    end
end)

-- Auto Heal Loop
task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoHeal and LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.Health = LP.Character.Humanoid.Health + 10
        end
    end
end)

-- [[ CREATE UI ELEMENTS ]] --
CreateToggle("God Mode", function(v) _G.GodMode = v end)
CreateToggle("Auto Heal Mode", function(v) _G.AutoHeal = v end)

CreateButton("Equip Best Knife", function()
    game:GetService("ReplicatedStorage").InventoryComm.RF.EquipBestWeapons:InvokeServer()
end)

CreateButton("Rebirth", function()
    game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net["RE/Rebirth_Request"]:FireServer()
end)

CreateButton("Continue Dungeon", function()
    game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net["RE/Dungeon_ContinueDungeon"]:FireServer()
end)

CreateButton("Stop Dungeon", function()
    game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net["RE/Dungeon_TakeLoot"]:FireServer()
end)

-- [[ DRAG, MINIMIZE, CLOSE ]] --
local dragToggle, dragStart, startPos
Topbar.InputBegan:Connect(function(input)
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
UserInputService.InputEnded:Connect(function(input) dragToggle = false end)

CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local mini = false
MiniBtn.MouseButton1Click:Connect(function()
    mini = not mini
    local targetSize = mini and UDim2.new(0, 320, 0, 50) or UDim2.new(0, 320, 0, 340)
    TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Size = targetSize}):Play()
    Container.Visible = not mini
end)
