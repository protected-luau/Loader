-- [[ OP BLADE - PREMIUM ELEGANT UI ]] --
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- Global Settings
_G.GodMode = false
_G.MagnetLoot = false

-- [[ UI CORE ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OPBlade_Premium"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BackgroundTransparency = 0.1
Main.Position = UDim2.new(0.5, -160, 0.5, -130)
Main.Size = UDim2.new(0, 320, 0, 360)
Main.ClipsDescendants = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Main

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(45, 45, 45)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = Main

-- [[ TOPBAR ]] --
local Topbar = Instance.new("Frame")
Topbar.Name = "Topbar"
Topbar.Parent = Main
Topbar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Topbar.Size = UDim2.new(1, 0, 0, 50)

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 15)
TopCorner.Parent = Topbar

local Title = Instance.new("TextLabel")
Title.Parent = Topbar
Title.Text = "⚔️ OP BLADE"
Title.Font = Enum.Font.Ubuntu
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Position = UDim2.new(0, 65, 0, 5)
Title.Size = UDim2.new(0, 150, 0, 25)

local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = Topbar
SubTitle.Text = "Made by @SilentExecute"
SubTitle.Font = Enum.Font.Ubuntu
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.TextSize = 11
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Position = UDim2.new(0, 65, 0, 22)
SubTitle.Size = UDim2.new(0, 150, 0, 20)

-- [[ AVATAR SYSTEM ]] --
local AvFrame = Instance.new("ImageLabel")
AvFrame.Parent = Topbar
AvFrame.Position = UDim2.new(0, 12, 0, 7)
AvFrame.Size = UDim2.new(0, 35, 0, 35)
AvFrame.Image = Players:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
local AvCorner = Instance.new("UICorner")
AvCorner.CornerRadius = UDim.new(1, 0)
AvCorner.Parent = AvFrame

-- [[ BUTTONS CONTROL ]] --
local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "✕"
CloseBtn.Parent = Topbar
CloseBtn.Position = UDim2.new(1, -35, 0, 10)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.TextSize = 18

local MiniBtn = Instance.new("TextButton")
MiniBtn.Text = "—"
MiniBtn.Parent = Topbar
MiniBtn.Position = UDim2.new(1, -65, 0, 10)
MiniBtn.Size = UDim2.new(0, 25, 0, 25)
MiniBtn.BackgroundTransparency = 1
MiniBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MiniBtn.TextSize = 18

-- [[ CONTAINER ]] --
local Container = Instance.new("ScrollingFrame")
Container.Parent = Main
Container.Position = UDim2.new(0, 10, 0, 60)
Container.Size = UDim2.new(1, -20, 1, -70)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 0

local UIList = Instance.new("UIListLayout")
UIList.Parent = Container
UIList.Padding = UDim.new(0, 8)

-- [[ FUNCTIONS ]] --
local function CreateButton(name, isToggle, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = Container
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(230, 230, 230)
    btn.Font = Enum.Font.Ubuntu
    btn.TextSize = 14
    btn.AutoButtonColor = false
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = btn

    local state = false
    btn.MouseButton1Click:Connect(function()
        if isToggle then
            state = not state
            local targetColor = state and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(40, 40, 40)
            TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = targetColor}):Play()
            callback(state)
        else
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            task.wait(0.1)
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            callback()
        end
    end)
end

-- [[ LOGIC: MAGNET LOOT (FIXED) ]] --
task.spawn(function()
    while task.wait(0.1) do
        if _G.MagnetLoot then
            pcall(function()
                local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    -- Scan Workspace for loot
                    for _, v in pairs(workspace:GetChildren()) do
                        if v:IsA("BasePart") and (v.Name:lower():find("coin") or v.Name:lower():find("loot") or v:FindFirstChild("TouchInterest")) then
                            v.CanCollide = false
                            v.CFrame = hrp.CFrame -- Tarik ke posisi badan
                        end
                    end
                    -- Kirim Remote Batch agar server memproses koleksi
                    local lootIDs = {}
                    for _, v in pairs(workspace:GetChildren()) do
                        if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then
                            local id = v:GetAttribute("LootId") or tonumber(v.Name)
                            if id then table.insert(lootIDs, id) end
                        end
                    end
                    if #lootIDs > 0 then
                        game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net["RF/Loot_CollectBatch"]:InvokeServer(lootIDs)
                    end
                end
            end)
        end
    end
end)

-- [[ LOGIC: GOD MODE ]] --
task.spawn(function()
    while task.wait(0.1) do
        if _G.GodMode and LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.Health = LP.Character.Humanoid.MaxHealth
        end
    end
end)

-- [[ UI BUTTONS ]] --
CreateButton("God Mode", true, function(v) _G.GodMode = v end)
CreateButton("Magnet Auto Collect", true, function(v) _G.MagnetLoot = v end)
CreateButton("Heal Mode (+10 HP)", false, function()
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.Health = LP.Character.Humanoid.Health + 10
    end
end)
CreateButton("Equip Best Knife", false, function()
    game:GetService("ReplicatedStorage").InventoryComm.RF.EquipBestWeapons:InvokeServer()
end)
CreateButton("Rebirth", false, function()
    game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net["RE/Rebirth_Request"]:FireServer()
end)
CreateButton("Continue Dungeon", false, function()
    game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net["RE/Dungeon_ContinueDungeon"]:FireServer()
end)
CreateButton("Stop Dungeon", false, function()
    game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net["RE/Dungeon_TakeLoot"]:FireServer()
end)

-- [[ DRAG & MINIMIZE ]] --
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
UserInputService.InputEnded:Connect(function(input)
    dragToggle = false
end)

CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local minimized = false
MiniBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    local targetSize = minimized and UDim2.new(0, 320, 0, 50) or UDim2.new(0, 320, 0, 360)
    TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = targetSize}):Play()
    Container.Visible = not minimized
end)
