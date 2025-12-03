local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Load UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Super Ring Parts V7", "DarkTheme")

-- Configuration
local config = {
    radius = 50,
    height = 100,
    rotationSpeed = 10,
    attractionStrength = 1000,
    includeAnchored = false,
    tornadoEnabled = false
}

-- Tabs
local MainTab = Window:NewTab("Main")
local SettingsTab = Window:NewTab("Settings")
local ExtrasTab = Window:NewTab("Extras")

-- Main Section
local TornadoSection = MainTab:NewSection("Tornado Control")

TornadoSection:NewToggle("Enable Tornado", "Turn the tornado on/off", function(state)
    config.tornadoEnabled = state
    if state then
        game.StarterGui:SetCore("SendNotification", {
            Title = "Tornado",
            Text = "Tornado Activated!",
            Duration = 3
        })
    end
end)

TornadoSection:NewToggle("Include Anchored Parts", "Make non-moving objects join tornado", function(state)
    config.includeAnchored = state
end)

-- Settings Section
local ConfigSection = SettingsTab:NewSection("Tornado Settings")

ConfigSection:NewSlider("Radius", "Tornado radius size", 500, 10, function(s)
    config.radius = s
end)

ConfigSection:NewSlider("Height", "Tornado height", 500, 10, function(s)
    config.height = s
end)

ConfigSection:NewSlider("Rotation Speed", "How fast parts spin", 100, 1, function(s)
    config.rotationSpeed = s
end)

ConfigSection:NewSlider("Attraction Strength", "How strong the pull is", 5000, 100, function(s)
    config.attractionStrength = s
end)

ConfigSection:NewButton("Reset to Default", "Reset all settings", function()
    config.radius = 50
    config.height = 100
    config.rotationSpeed = 10
    config.attractionStrength = 1000
end)

-- Extras Section
local ExtrasSection = ExtrasTab:NewSection("Extra Scripts")

ExtrasSection:NewButton("Fly GUI", "Enable flying", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/YSL3xKYU'))()
end)

ExtrasSection:NewButton("No Fall Damage", "Remove fall damage", function()
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

ExtrasSection:NewButton("Noclip", "Walk through walls", function()
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

ExtrasSection:NewButton("Infinite Jump", "Jump infinitely", function()
    local InfiniteJumpEnabled = true
    UserInputService.JumpRequest:connect(function()
        if InfiniteJumpEnabled then
            LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
        end
    end)
end)

ExtrasSection:NewButton("Infinite Yield", "Admin commands", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

-- Tornado System
local Workspace = game:GetService("Workspace")
local parts = {}
local anchoredParts = {}

-- Function to handle anchored parts
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
        
        -- Create BodyPosition if it doesn't exist
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
        -- Restore original state
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

-- Scan workspace
for _, part in pairs(workspace:GetDescendants()) do
    addPart(part)
end

workspace.DescendantAdded:Connect(addPart)
workspace.DescendantRemoving:Connect(removePart)

-- Tornado Logic
RunService.Heartbeat:Connect(function()
    if not config.tornadoEnabled then return end
    
    local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        local tornadoCenter = humanoidRootPart.Position
        
        for _, part in pairs(parts) do
            if part.Parent then
                -- Re-check if we should handle this part
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
                
                -- Handle based on part type
                if anchoredParts[part] and anchoredParts[part].bodyPosition then
                    -- Use BodyPosition for originally anchored parts
                    anchoredParts[part].bodyPosition.Position = targetPos
                    anchoredParts[part].bodyGyro.CFrame = CFrame.new(part.Position, targetPos)
                else
                    -- Use Velocity for normal parts
                    local directionToTarget = (targetPos - part.Position).unit
                    part.Velocity = directionToTarget * config.attractionStrength
                end
            end
        end
    end
end)

-- Cleanup when toggled off
game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        for part, data in pairs(anchoredParts) do
            if part and part.Parent then
                if data.bodyPosition then
                    data.bodyPosition:Destroy()
                    data.bodyGyro:Destroy()
                end
                part.CFrame = data.originalCFrame
                part.Anchored = data.originalAnchored
            end
        end
    end
end)

-- Welcome notification
game.StarterGui:SetCore("SendNotification", {
    Title = "Super Ring Parts V7",
    Text = "Loaded successfully! Made by Fari Noveri, Credit by lukas",
    Duration = 5
})