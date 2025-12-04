-- Check if script already running and destroy old instance
if _G.CombatArenaV1 then
    if _G.CombatArenaV1.GUI then
        _G.CombatArenaV1.GUI:Destroy()
    end
    if _G.CombatArenaV1.Connections then
        for _, conn in pairs(_G.CombatArenaV1.Connections) do
            conn:Disconnect()
        end
    end
end

_G.CombatArenaV1 = {
    Connections = {},
    ESPObjects = {},
    GUI = nil
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Configuration
local config = {
    espCharms = false,
    espHealth = false,
    espBone = false,
    espLine = false,
    espName = false,
    espHighlight = false,
    aimBullet = false,
    aimbot = false,
    magnetPlayer = false,
    fastReload = false,
    unlimitedAmmo = false,
    speedHack = false,
    noclip = false,
    xray = false,
    rapidFire = false,
    ignoreWallShoot = false,
    
    -- Settings
    espTeams = false,
    espEnemy = false,
    espAll = true,
    magnetEnemy = false,
    magnetTeams = false,
    magnetAll = true,
    aimBulletFOV = 100,
    aimBulletUnlimited = false,
    aimBulletIgnoreWall = false,
    aimbotFOV = 80,
    speedHackValue = 16,
    xrayOpacity = 0.5,
    fastReloadSpeed = 0.5,
    magnetRange = 50
}

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CombatArenaV1"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
_G.CombatArenaV1.GUI = ScreenGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 580)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -290)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Add Shadow Effect
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(0, -15, 0, -15)
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.ZIndex = -1
Shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.5
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
Shadow.Parent = MainFrame

-- Title Bar with Gradient
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 55)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 50, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 30, 30))
}
TitleGradient.Rotation = 45
TitleGradient.Parent = TitleBar

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -90, 0, 30)
Title.Position = UDim2.new(0, 15, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "⚔️ COMBAT ARENA"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -90, 0, 15)
Subtitle.Position = UDim2.new(0, 15, 0, 35)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Ultimate Combat Enhancement Hub"
Subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 11
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = TitleBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -45, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- Minimize Button
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 35, 0, 35)
MinimizeBtn.Position = UDim2.new(1, -85, 0, 10)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 50)
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 18
MinimizeBtn.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = MinimizeBtn

-- Tab Container
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 45)
TabContainer.Position = UDim2.new(0, 10, 0, 65)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

-- Content Frame with ScrollingFrame
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -20, 1, -130)
ContentFrame.Position = UDim2.new(0, 10, 0, 120)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 8
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(220, 50, 50)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentFrame.Parent = MainFrame

-- Tab System
local tabs = {}
local currentTab = nil

local function createTab(name, icon, index)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0.31, 0, 1, 0)
    TabButton.Position = UDim2.new((index-1) * 0.345, 0, 0, 0)
    TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    TabButton.Text = icon .. " " .. name
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabButton.Font = Enum.Font.GothamBold
    TabButton.TextSize = 13
    TabButton.Parent = TabContainer
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabButton
    
    local TabContent = Instance.new("Frame")
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.Visible = false
    TabContent.Parent = ContentFrame
    
    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 10)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = TabContent
    
    tabs[name] = {button = TabButton, content = TabContent}
    
    TabButton.MouseButton1Click:Connect(function()
        for _, tab in pairs(tabs) do
            tab.button.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
            tab.button.TextColor3 = Color3.fromRGB(200, 200, 200)
            tab.content.Visible = false
        end
        
        local tween = TweenService:Create(TabButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        })
        tween:Play()
        
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabContent.Visible = true
        currentTab = name
    end)
    
    return TabContent
end

-- Create Tabs
local MainTab = createTab("Main", "⚡", 1)
local SettingsTab = createTab("Settings", "⚙️", 2)
local CreditTab = createTab("Credit", "ℹ️", 3)

-- Helper Functions
local function createToggle(parent, text, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 45)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -70, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 50, 0, 28)
    ToggleButton.Position = UDim2.new(1, -60, 0.5, -14)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    ToggleButton.Text = ""
    ToggleButton.Parent = ToggleFrame
    
    local ToggleBtnCorner = Instance.new("UICorner")
    ToggleBtnCorner.CornerRadius = UDim.new(1, 0)
    ToggleBtnCorner.Parent = ToggleButton
    
    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 22, 0, 22)
    Circle.Position = UDim2.new(0, 3, 0.5, -11)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.Parent = ToggleButton
    
    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = Circle
    
    local enabled = false
    ToggleButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        callback(enabled)
        
        if enabled then
            TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -25, 0.5, -11)}):Play()
        else
            TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 80)}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -11)}):Play()
        end
    end)
end

local function createSlider(parent, text, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 65)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = parent
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 8)
    SliderCorner.Parent = SliderFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 22)
    Label.Position = UDim2.new(0, 12, 0, 8)
    Label.BackgroundTransparency = 1
    Label.Text = text .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame
    
    local SliderBack = Instance.new("Frame")
    SliderBack.Size = UDim2.new(1, -24, 0, 8)
    SliderBack.Position = UDim2.new(0, 12, 0, 40)
    SliderBack.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    SliderBack.BorderSizePixel = 0
    SliderBack.Parent = SliderFrame
    
    local SliderBackCorner = Instance.new("UICorner")
    SliderBackCorner.CornerRadius = UDim.new(1, 0)
    SliderBackCorner.Parent = SliderBack
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new(default/max, 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBack
    
    local SliderFillCorner = Instance.new("UICorner")
    SliderFillCorner.CornerRadius = UDim.new(1, 0)
    SliderFillCorner.Parent = SliderFill
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Size = UDim2.new(1, 0, 1, 20)
    SliderButton.Position = UDim2.new(0, 0, 0, -10)
    SliderButton.BackgroundTransparency = 1
    SliderButton.Text = ""
    SliderButton.Parent = SliderBack
    
    local dragging = false
    
    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    local conn1 = UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    table.insert(_G.CombatArenaV1.Connections, conn1)
    
    SliderButton.MouseMoved:Connect(function(x, y)
        if dragging then
            local pos = math.clamp((x - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
            local value = math.floor(pos * max)
            SliderFill.Size = UDim2.new(pos, 0, 1, 0)
            Label.Text = text .. ": " .. value
            callback(value)
        end
    end)
end

local function createDropdown(parent, text, options, default, callback)
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Size = UDim2.new(1, 0, 0, 45)
    DropdownFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    DropdownFrame.BorderSizePixel = 0
    DropdownFrame.Parent = parent
    
    local DropdownCorner = Instance.new("UICorner")
    DropdownCorner.CornerRadius = UDim.new(0, 8)
    DropdownCorner.Parent = DropdownFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -24, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = DropdownFrame
    
    local Arrow = Instance.new("TextLabel")
    Arrow.Size = UDim2.new(0, 20, 1, 0)
    Arrow.Position = UDim2.new(1, -30, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "▼"
    Arrow.TextColor3 = Color3.fromRGB(200, 200, 200)
    Arrow.Font = Enum.Font.GothamBold
    Arrow.TextSize = 12
    Arrow.Parent = DropdownFrame
    
    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Size = UDim2.new(1, 0, 1, 0)
    DropdownButton.BackgroundTransparency = 1
    DropdownButton.Text = ""
    DropdownButton.Parent = DropdownFrame
    
    local DropList = Instance.new("Frame")
    DropList.Size = UDim2.new(0, 0, 0, 0)
    DropList.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    DropList.BorderSizePixel = 0
    DropList.Visible = false
    DropList.ZIndex = 10
    DropList.Parent = DropdownFrame
    
    local DropCorner = Instance.new("UICorner")
    DropCorner.CornerRadius = UDim.new(0, 8)
    DropCorner.Parent = DropList
    
    local DropLayout = Instance.new("UIListLayout")
    DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
    DropLayout.Parent = DropList
    
    for i, opt in ipairs(options) do
        local OptButton = Instance.new("TextButton")
        OptButton.Size = UDim2.new(1, 0, 0, 35)
        OptButton.BackgroundTransparency = 1
        OptButton.Text = opt
        OptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        OptButton.Font = Enum.Font.Gotham
        OptButton.TextSize = 13
        OptButton.ZIndex = 10
        OptButton.Parent = DropList
        
        OptButton.MouseEnter:Connect(function()
            OptButton.BackgroundTransparency = 0.9
            OptButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        end)
        
        OptButton.MouseLeave:Connect(function()
            OptButton.BackgroundTransparency = 1
        end)
        
        OptButton.MouseButton1Click:Connect(function()
            Label.Text = text .. ": " .. opt
            callback(opt)
            DropList.Visible = false
            DropList.Parent = DropdownFrame
            Arrow.Text = "▼"
        end)
    end
    
    DropdownButton.MouseButton1Click:Connect(function()
        DropList.Visible = not DropList.Visible
        if DropList.Visible then
            Arrow.Text = "▲"
            DropList.Parent = ScreenGui
            local absPos = DropdownFrame.AbsolutePosition
            local absSize = DropdownFrame.AbsoluteSize
            local dropHeight = #options * 35
            DropList.Size = UDim2.new(0, absSize.X, 0, dropHeight)
            local screenHeight = ScreenGui.AbsoluteSize.Y
            local spaceBelow = screenHeight - (absPos.Y + absSize.Y)
            local y
            if spaceBelow >= dropHeight then
                y = absPos.Y + absSize.Y + 2
            else
                y = absPos.Y - dropHeight - 2
            end
            DropList.Position = UDim2.new(0, absPos.X, 0, y)
        else
            Arrow.Text = "▼"
            DropList.Parent = DropdownFrame
        end
    end)
end

-- Main Tab Content
createToggle(MainTab, "🎯 ESP Charms", function(state)
    config.espCharms = state
end)

createToggle(MainTab, "❤️ ESP Health", function(state)
    config.espHealth = state
end)

createToggle(MainTab, "💀 ESP Bone", function(state)
    config.espBone = state
end)

createToggle(MainTab, "📏 ESP Line", function(state)
    config.espLine = state
end)

createToggle(MainTab, "📝 ESP Name", function(state)
    config.espName = state
end)

createToggle(MainTab, "✨ ESP Highlight", function(state)
    config.espHighlight = state
end)

createToggle(MainTab, "🎯 Aim Bullet", function(state)
    config.aimBullet = state
    if state then
        game.StarterGui:SetCore("SendNotification", {
            Title = "Aim Bullet",
            Text = "Bullet aimbot activated!",
            Duration = 3
        })
    end
end)

createToggle(MainTab, "🔫 Aimbot", function(state)
    config.aimbot = state
    if state then
        game.StarterGui:SetCore("SendNotification", {
            Title = "Aimbot",
            Text = "Aimbot activated!",
            Duration = 3
        })
    end
end)

createToggle(MainTab, "🧲 Magnet Player", function(state)
    config.magnetPlayer = state
end)

createToggle(MainTab, "⚡ Fast Reload", function(state)
    config.fastReload = state
end)

createToggle(MainTab, "♾️ Unlimited Ammo", function(state)
    config.unlimitedAmmo = state
end)

createToggle(MainTab, "🏃 Speed Hack", function(state)
    config.speedHack = state
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = state and config.speedHackValue or 16
    end
end)

createToggle(MainTab, "👻 Noclip", function(state)
    config.noclip = state
end)

createToggle(MainTab, "👁️ X-Ray", function(state)
    config.xray = state
end)

createToggle(MainTab, "🔥 Rapid Fire", function(state)
    config.rapidFire = state
end)

createToggle(MainTab, "🧱 Ignore Wall Shoot", function(state)
    config.ignoreWallShoot = state
end)

-- Settings Tab Content
createToggle(SettingsTab, "ESP Teams Only", function(state)
    config.espTeams = state
    if state then
        config.espEnemy = false
        config.espAll = false
    end
end)

createToggle(SettingsTab, "ESP Enemy Only", function(state)
    config.espEnemy = state
    if state then
        config.espTeams = false
        config.espAll = false
    end
end)

createToggle(SettingsTab, "ESP All Players", function(state)
    config.espAll = state
    if state then
        config.espTeams = false
        config.espEnemy = false
    end
end)

createToggle(SettingsTab, "Magnet Enemy", function(state)
    config.magnetEnemy = state
    if state then
        config.magnetTeams = false
        config.magnetAll = false
    end
end)

createToggle(SettingsTab, "Magnet Teams", function(state)
    config.magnetTeams = state
    if state then
        config.magnetEnemy = false
        config.magnetAll = false
    end
end)

createToggle(SettingsTab, "Magnet All", function(state)
    config.magnetAll = state
    if state then
        config.magnetEnemy = false
        config.magnetTeams = false
    end
end)

createSlider(SettingsTab, "Aim Bullet FOV", 360, config.aimBulletFOV, function(value)
    config.aimBulletFOV = value
end)

createToggle(SettingsTab, "Aim Bullet Unlimited Range", function(state)
    config.aimBulletUnlimited = state
end)

createToggle(SettingsTab, "Aim Bullet Ignore Wall", function(state)
    config.aimBulletIgnoreWall = state
end)

createSlider(SettingsTab, "Aimbot FOV", 180, config.aimbotFOV, function(value)
    config.aimbotFOV = value
end)

createSlider(SettingsTab, "Speed Hack", 150, config.speedHackValue, function(value)
    config.speedHackValue = value
    if config.speedHack then
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = value
        end
    end
end)

createSlider(SettingsTab, "X-Ray Opacity", 10, math.floor(config.xrayOpacity * 10), function(value)
    config.xrayOpacity = value / 10
end)

createSlider(SettingsTab, "Fast Reload Speed", 10, math.floor(config.fastReloadSpeed * 10), function(value)
    config.fastReloadSpeed = value / 10
end)

createSlider(SettingsTab, "Magnet Range", 200, config.magnetRange, function(value)
    config.magnetRange = value
end)

-- Credit Tab Content
local CreditFrame = Instance.new("Frame")
CreditFrame.Size = UDim2.new(1, 0, 0, 400)
CreditFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
CreditFrame.BorderSizePixel = 0
CreditFrame.Parent = CreditTab

local CreditCorner = Instance.new("UICorner")
CreditCorner.CornerRadius = UDim.new(0, 12)
CreditCorner.Parent = CreditFrame

local CreditGradient = Instance.new("UIGradient")
CreditGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 30, 50))
}
CreditGradient.Rotation = 135
CreditGradient.Parent = CreditFrame

local CreditTitle = Instance.new("TextLabel")
CreditTitle.Size = UDim2.new(1, -40, 0, 50)
CreditTitle.Position = UDim2.new(0, 20, 0, 20)
CreditTitle.BackgroundTransparency = 1
CreditTitle.Text = "⚔️ COMBAT ARENA V1