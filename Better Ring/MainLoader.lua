local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Configuration
local config = {
    radius = 50,
    height = 100,
    rotationSpeed = 10,
    attractionStrength = 1000,
    includeAnchored = false,
    tornadoEnabled = false
}

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SuperRingPartsV7"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 550)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -275)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Super Ring Parts V7"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -80, 0, 15)
Subtitle.Position = UDim2.new(0, 10, 1, -18)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Made by you, Credit by lukas"
Subtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 11
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = TitleBar

-- Minimize Button
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 35, 0, 35)
MinimizeBtn.Position = UDim2.new(1, -45, 0, 7.5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 20
MinimizeBtn.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = MinimizeBtn

-- Tab Container
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 40)
TabContainer.Position = UDim2.new(0, 10, 0, 60)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -120)
ContentFrame.Position = UDim2.new(0, 10, 0, 110)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Tab System
local tabs = {}
local currentTab = nil

local function createTab(name, index)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0.32, 0, 1, 0)
    TabButton.Position = UDim2.new((index-1) * 0.34, 0, 0, 0)
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabButton.Font = Enum.Font.GothamBold
    TabButton.TextSize = 14
    TabButton.Parent = TabContainer
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabButton
    
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.BorderSizePixel = 0
    TabContent.ScrollBarThickness = 6
    TabContent.Visible = false
    TabContent.Parent = ContentFrame
    TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 10)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = TabContent
    
    tabs[name] = {button = TabButton, content = TabContent, yOffset = 0}
    
    TabButton.MouseButton1Click:Connect(function()
        for _, tab in pairs(tabs) do
            tab.button.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            tab.button.TextColor3 = Color3.fromRGB(200, 200, 200)
            tab.content.Visible = false
        end
        TabButton.BackgroundColor3 = Color3.fromRGB(60, 120, 220)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabContent.Visible = true
        currentTab = name
    end)
    
    return TabContent
end

-- Create Tabs
local MainTab = createTab("Main", 1)
local SettingsTab = createTab("Settings", 2)
local ExtrasTab = createTab("Extras", 3)

-- Helper Functions
local function createToggle(parent, text, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 45, 0, 25)
    ToggleButton.Position = UDim2.new(1, -55, 0.5, -12.5)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    ToggleButton.Text = ""
    ToggleButton.Parent = ToggleFrame
    
    local ToggleBtnCorner = Instance.new("UICorner")
    ToggleBtnCorner.CornerRadius = UDim.new(1, 0)
    ToggleBtnCorner.Parent = ToggleButton
    
    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 19, 0, 19)
    Circle.Position = UDim2.new(0, 3, 0.5, -9.5)
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
            TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 200, 50)}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -22, 0.5, -9.5)}):Play()
        else
            TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -9.5)}):Play()
        end
    end)
end

local function createSlider(parent, text, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 60)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = parent
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 8)
    SliderCorner.Parent = SliderFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = text .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame
    
    local SliderBack = Instance.new("Frame")
    SliderBack.Size = UDim2.new(1, -20, 0, 6)
    SliderBack.Position = UDim2.new(0, 10, 0, 35)
    SliderBack.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    SliderBack.BorderSizePixel = 0
    SliderBack.Parent = SliderFrame
    
    local SliderBackCorner = Instance.new("UICorner")
    SliderBackCorner.CornerRadius = UDim.new(1, 0)
    SliderBackCorner.Parent = SliderBack
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new(default/max, 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(60, 120, 220)
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
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
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

local function createButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 40)
    Button.BackgroundColor3 = Color3.fromRGB(60, 120, 220)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 14
    Button.Parent = parent
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(70, 140, 240)}):Play()
        wait(0.1)
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(60, 120, 220)}):Play()
        callback()
    end)
end

-- Main Tab Content
createToggle(MainTab, "Enable Tornado", function(state)
    config.tornadoEnabled = state
    if state then
        game.StarterGui:SetCore("SendNotification", {
            Title = "Tornado",
            Text = "Tornado Activated!",
            Duration = 3
        })
    end
end)

createToggle(MainTab, "Include Anchored Parts", function(state)
    config.includeAnchored = state
end)

-- Settings Tab Content
createSlider(SettingsTab, "Radius", 500, config.radius, function(value)
    config.radius = value
end)

createSlider(SettingsTab, "Height", 500, config.height, function(value)
    config.height = value
end)

createSlider(SettingsTab, "Rotation Speed", 100, config.rotationSpeed, function(value)
    config.rotationSpeed = value
end)

createSlider(SettingsTab, "Attraction Strength", 5000, config.attractionStrength, function(value)
    config.attractionStrength = value
end)

createButton(SettingsTab, "Reset to Default", function()
    config.radius = 50
    config.height = 100
    config.rotationSpeed = 10
    config.attractionStrength = 1000
    game.StarterGui:SetCore("SendNotification", {
        Title = "Settings",
        Text = "Reset to default!",
        Duration = 3
    })
end)

-- Extras Tab Content
createButton(ExtrasTab, "Fly GUI", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/YSL3xKYU'))()
end)

createButton(ExtrasTab, "No Fall Damage", function()
    local runsvc = game:GetService("RunService")
    local heartbeat = runsvc.Heartbeat
    local rstepped = runsvc.RenderStepped
    local novel = Vector3.zero
    
    local function nofalldamage(chr)
        local root = chr:WaitForChild("HumanoidRootPart")
        if root then
            local con
            con = heartbeat:Connect(function()
                if not root.Parent then con:Disconnect() end
                local oldvel = root.AssemblyLinearVelocity
                root.AssemblyLinearVelocity = novel
                rstepped:Wait()
                root.AssemblyLinearVelocity = oldvel
            end)
        end
    end
    
    nofalldamage(LocalPlayer.Character)
    LocalPlayer.CharacterAdded:Connect(nofalldamage)
end)

createButton(ExtrasTab, "Noclip", function()
    local Noclip = nil
    local Clip = nil
    
    function noclip()
        Clip = false
        local function Nocl()
            if Clip == false and LocalPlayer.Character ~= nil then
                for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
                    if v:IsA('BasePart') and v.CanCollide then
                        v.CanCollide = false
                    end
                end
            end
            wait(0.21)
        end
        Noclip = RunService.Stepped:Connect(Nocl)
    end
    noclip()
end)

createButton(ExtrasTab, "Infinite Jump", function()
    local InfiniteJumpEnabled = true
    UserInputService.JumpRequest:connect(function()
        if InfiniteJumpEnabled then
            LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
        end
    end)
end)

createButton(ExtrasTab, "Infinite Yield", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

-- Set default tab
tabs["Main"].button.BackgroundColor3 = Color3.fromRGB(60, 120, 220)
tabs["Main"].button.TextColor3 = Color3.fromRGB(255, 255, 255)
tabs["Main"].content.Visible = true
currentTab = "Main"

-- Minimize Functionality
local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 400, 0, 50)}):Play()
        MinimizeBtn.Text = "+"
        TabContainer.Visible = false
        ContentFrame.Visible = false
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 400, 0, 550)}):Play()
        MinimizeBtn.Text = "-"
        TabContainer.Visible = true
        ContentFrame.Visible = true
    end
end)

-- Make GUI Draggable
local dragging, dragInput, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Tornado System
local Workspace = game:GetService("Workspace")
local parts = {}
local anchoredParts = {}

local function handleAnchoredPart(part)
    if not anchoredParts[part] then
        anchoredParts[part] = {
            originalCFrame = part.CFrame,
            originalAnchored = part.Anchored,
            bodyPosition = nil,
            bodyGyro = nil
        }
    end
    
    if config.includeAnchored and config.tornadoEnabled then
        part.Anchored = false
        
        if not anchoredParts[part].bodyPosition then
            local bp = Instance.new("BodyPosition")
            bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bp.P = 10000
            bp.Parent = part
            anchoredParts[part].bodyPosition = bp
            
            local bg = Instance.new("BodyGyro")
            bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bg.P = 10000
            bg.Parent = part
            anchoredParts[part].bodyGyro = bg
        end
    else
        if anchoredParts[part] and anchoredParts[part].bodyPosition then
            anchoredParts[part].bodyPosition:Destroy()
            anchoredParts[part].bodyGyro:Destroy()
            anchoredParts[part].bodyPosition = nil
            anchoredParts[part].bodyGyro = nil
            part.CFrame = anchoredParts[part].originalCFrame
            part.Anchored = anchoredParts[part].originalAnchored
        end
    end
end

local function RetainPart(Part)
    if Part:IsA("BasePart") and Part:IsDescendantOf(workspace) then
        if Part.Parent == LocalPlayer.Character or Part:IsDescendantOf(LocalPlayer.Character) then
            return false
        end
        
        if Part.Anchored then
            handleAnchoredPart(Part)
            return config.includeAnchored
        else
            Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
            Part.CanCollide = false
            return true
        end
    end
    return false
end

local function addPart(part)
    if RetainPart(part) then
        if not table.find(parts, part) then
            table.insert(parts, part)
        end
    end
end

local function removePart(part)
    local index = table.find(parts, part)
    if index then
        table.remove(parts, index)
    end
    if anchoredParts[part] then
        if anchoredParts[part].bodyPosition then
            anchoredParts[part].bodyPosition:Destroy()
            anchoredParts[part].bodyGyro:Destroy()
        end
        anchoredParts[part] = nil
    end
end

for _, part in pairs(workspace:GetDescendants()) do
    addPart(part)
end

workspace.DescendantAdded:Connect(addPart)
workspace.DescendantRemoving:Connect(removePart)

RunService.Heartbeat:Connect(function()
    if not config.tornadoEnabled then return end
    
    local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        local tornadoCenter = humanoidRootPart.Position
        
        for _, part in pairs(parts) do
            if part.Parent then
                if part.Anchored then
                    handleAnchoredPart(part)
                    if not config.includeAnchored then
                        continue
                    end
                end
                
                local pos = part.Position
                local distance = (Vector3.new(pos.X, tornadoCenter.Y, pos.Z) - tornadoCenter).Magnitude
                local angle = math.atan2(pos.Z - tornadoCenter.Z, pos.X - tornadoCenter.X)
                local newAngle = angle + math.rad(config.rotationSpeed)
                
                local targetPos = Vector3.new(
                    tornadoCenter.X + math.cos(newAngle) * math.min(config.radius, distance),
                    tornadoCenter.Y + (config.height * (math.abs(math.sin((pos.Y - tornadoCenter.Y) / config.height)))),
                    tornadoCenter.Z + math.sin(newAngle) * math.min(config.radius, distance)
                )
                
                if anchoredParts[part] and anchoredParts[part].bodyPosition then
                    anchoredParts[part].bodyPosition.Position = targetPos
                    anchoredParts[part].bodyGyro.CFrame = CFrame.new(part.Position, targetPos)
                else
                    local directionToTarget = (targetPos - part.Position).unit
                    part.Velocity = directionToTarget * config.attractionStrength
                end
            end
        end
    end
end)

game.StarterGui:SetCore("SendNotification", {
    Title = "Super Ring Parts V7",
    Text = "Made by you, Credit by lukas",
    Duration = 5
})