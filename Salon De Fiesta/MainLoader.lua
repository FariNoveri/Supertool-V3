-- Salon de Fiesta - Exploit Version (Updated UI with Outfit Save)
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")

local player = Players.LocalPlayer
local presetFile = "salon_de_fiesta_presets.json"

-- Properties to save from HumanoidDescription
local descProperties = {
    "Accessories", "BackAccessory", "ClimbAnimation", "Face", "FaceAccessory", "FallAnimation", "FrontAccessory",
    "GraphicTShirt", "HairAccessory", "HatAccessory", "Head", "HeadColor", "IdleAnimation", "JumpAnimation",
    "LeftArm", "LeftArmColor", "LeftLeg", "LeftLegColor", "NeckAccessory", "Pants", "RightArm", "RightArmColor",
    "RightLeg", "RightLegColor", "RunAnimation", "Shirt", "ShouldersAccessory", "SwimAnimation", "Torso",
    "TorsoColor", "WaistAccessory", "WalkAnimation", "BodyTypeScale", "DepthScale", "HeadScale", "HeightScale",
    "ProportionScale", "WidthScale"
}

-- Load presets from file
local function loadPresetsFromFile()
    local success, result = pcall(function()
        if isfile(presetFile) then
            return HttpService:JSONDecode(readfile(presetFile))
        end
        return {}
    end)
    return success and result or {}
end

-- Save presets to file
local function savePresetsToFile(presets)
    local success = pcall(function()
        writefile(presetFile, HttpService:JSONEncode(presets))
    end)
    return success
end

-- Load presets
local characterPresets = loadPresetsFromFile()

-- Validate asset ID
local function isValidAsset(assetId)
    if assetId == "" or assetId == "0" then return true end
    local success = pcall(function()
        MarketplaceService:GetProductInfo(tonumber(assetId))
    end)
    return success
end

-- Get thumbnail URL for asset
local function getThumbnailUrl(assetId)
    if assetId == "" or assetId == "0" then return "" end
    return "https://thumbnails.roblox.com/v1/assets?assetIds=" .. assetId .. "&size=150x150&format=Png"
end

-- HumanoidDescription to table
local function descToTable(desc)
    local t = {}
    for _, prop in ipairs(descProperties) do
        t[prop] = desc[prop]
    end
    return t
end

-- Table to HumanoidDescription
local function tableToDesc(t)
    local desc = Instance.new("HumanoidDescription")
    for prop, value in pairs(t) do
        desc[prop] = value
    end
    return desc
end

-- Capture current outfit
local function captureOutfit()
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return nil end
    return descToTable(humanoid:GetAppliedDescription())
end

-- Apply outfit
local function applyOutfit(descTable)
    local desc = tableToDesc(descTable)
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:ApplyDescription(desc)
    end
end

-- Validate outfit IDs
local function validateOutfit(descTable)
    for _, prop in ipairs(descProperties) do
        local value = descTable[prop]
        if typeof(value) == "string" and value:match("%d") then
            for id in value:gmatch("(%d+)") do
                if not isValidAsset(id) then return false end
            end
        end
    end
    return true
end

-- Save preset
local function savePreset(name, descTable)
    if not validateOutfit(descTable) then return false end
    characterPresets[name] = {desc = descTable, created = os.time()}
    return savePresetsToFile(characterPresets)
end

-- Delete preset
local function deletePreset(name)
    if characterPresets[name] then
        characterPresets[name] = nil
        return savePresetsToFile(characterPresets)
    end
    return false
end

-- Rename preset
local function renamePreset(oldName, newName)
    if characterPresets[oldName] and not characterPresets[newName] then
        characterPresets[newName] = characterPresets[oldName]
        characterPresets[oldName] = nil
        return savePresetsToFile(characterPresets)
    end
    return false
end

-- Create UI
local function createSalonGUI()
    if player.PlayerGui:FindFirstChild("SalonDeFiestaGUI") then
        player.PlayerGui.SalonDeFiestaGUI:Destroy()
    end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SalonDeFiestaGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player.PlayerGui
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 300, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    mainFrame.BackgroundTransparency = 0.2
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame
    
    -- Header
    local headerText = Instance.new("TextLabel")
    headerText.Size = UDim2.new(1, -20, 0, 30)
    headerText.Position = UDim2.new(0, 10, 0, 10)
    headerText.BackgroundTransparency = 1
    headerText.Text = "SALON DE FIESTA"
    headerText.TextColor3 = Color3.new(0, 0, 0)
    headerText.TextSize = 18
    headerText.Font = Enum.Font.GothamBold
    headerText.Parent = mainFrame
    
    -- By text
    local byText = Instance.new("TextLabel")
    byText.Size = UDim2.new(1, -20, 0, 15)
    byText.Position = UDim2.new(0, 10, 0, 35)
    byText.BackgroundTransparency = 1
    byText.Text = "by farinoveri"
    byText.TextColor3 = Color3.new(0.4, 0.4, 0.4)
    byText.TextSize = 10
    byText.Font = Enum.Font.Gotham
    byText.Parent = mainFrame
    
    -- Preset Name Input
    local presetInput = Instance.new("TextBox")
    presetInput.Size = UDim2.new(1, -20, 0, 30)
    presetInput.Position = UDim2.new(0, 10, 0, 60)
    presetInput.BackgroundColor3 = Color3.new(1, 1, 1)
    presetInput.BackgroundTransparency = 0.5
    presetInput.Text = ""
    presetInput.PlaceholderText = "Preset Name..."
    presetInput.TextColor3 = Color3.new(0, 0, 0)
    presetInput.TextSize = 12
    presetInput.Font = Enum.Font.Gotham
    presetInput.Parent = mainFrame
    Instance.new("UICorner", presetInput).CornerRadius = UDim.new(0, 4)
    
    -- Capture Button
    local captureButton = Instance.new("TextButton")
    captureButton.Size = UDim2.new(1, -20, 0, 30)
    captureButton.Position = UDim2.new(0, 10, 0, 95)
    captureButton.BackgroundColor3 = Color3.new(0.2, 0.7, 0.2)
    captureButton.Text = "CAPTURE OUTFIT"
    captureButton.TextColor3 = Color3.new(1, 1, 1)
    captureButton.TextSize = 12
    captureButton.Font = Enum.Font.GothamBold
    captureButton.Parent = mainFrame
    Instance.new("UICorner", captureButton).CornerRadius = UDim.new(0, 4)
    
    -- Buttons
    local saveButton = Instance.new("TextButton")
    saveButton.Size = UDim2.new(0.31, -5, 0, 30)
    saveButton.Position = UDim2.new(0.05, 0, 0, 130)
    saveButton.BackgroundColor3 = Color3.new(0.2, 0.7, 0.2)
    saveButton.Text = "SAVE"
    saveButton.TextColor3 = Color3.new(1, 1, 1)
    saveButton.TextSize = 12
    saveButton.Font = Enum.Font.GothamBold
    saveButton.Parent = mainFrame
    Instance.new("UICorner", saveButton).CornerRadius = UDim.new(0, 4)
    
    local loadButton = Instance.new("TextButton")
    loadButton.Size = UDim2.new(0.31, -5, 0, 30)
    loadButton.Position = UDim2.new(0.36, 0, 0, 130)
    loadButton.BackgroundColor3 = Color3.new(0.2, 0.5, 0.8)
    loadButton.Text = "LOAD"
    loadButton.TextColor3 = Color3.new(1, 1, 1)
    loadButton.TextSize = 12
    loadButton.Font = Enum.Font.GothamBold
    loadButton.Parent = mainFrame
    Instance.new("UICorner", loadButton).CornerRadius = UDim.new(0, 4)
    
    local applyButton = Instance.new("TextButton")
    applyButton.Size = UDim2.new(0.31, -5, 0, 30)
    applyButton.Position = UDim2.new(0.67, 0, 0, 130)
    applyButton.BackgroundColor3 = Color3.new(0.8, 0.4, 0.1)
    applyButton.Text = "APPLY"
    applyButton.TextColor3 = Color3.new(1, 1, 1)
    applyButton.TextSize = 12
    applyButton.Font = Enum.Font.GothamBold
    applyButton.Parent = mainFrame
    Instance.new("UICorner", applyButton).CornerRadius = UDim.new(0, 4)
    
    local deleteButton = Instance.new("TextButton")
    deleteButton.Size = UDim2.new(0.48, -5, 0, 30)
    deleteButton.Position = UDim2.new(0.05, 0, 0, 165)
    deleteButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
    deleteButton.Text = "DELETE"
    deleteButton.TextColor3 = Color3.new(1, 1, 1)
    deleteButton.TextSize = 12
    deleteButton.Font = Enum.Font.GothamBold
    deleteButton.Parent = mainFrame
    Instance.new("UICorner", deleteButton).CornerRadius = UDim.new(0, 4)
    
    local renameButton = Instance.new("TextButton")
    renameButton.Size = UDim2.new(0.48, -5, 0, 30)
    renameButton.Position = UDim2.new(0.53, 0, 0, 165)
    renameButton.BackgroundColor3 = Color3.new(0.6, 0.4, 0.8)
    renameButton.Text = "RENAME"
    renameButton.TextColor3 = Color3.new(1, 1, 1)
    renameButton.TextSize = 12
    renameButton.Font = Enum.Font.GothamBold
    renameButton.Parent = mainFrame
    Instance.new("UICorner", renameButton).CornerRadius = UDim.new(0, 4)
    
    -- Preset List
    local presetList = Instance.new("ScrollingFrame")
    presetList.Size = UDim2.new(1, -20, 0, 170)
    presetList.Position = UDim2.new(0, 10, 0, 200)
    presetList.BackgroundColor3 = Color3.new(1, 1, 1)
    presetList.BackgroundTransparency = 0.5
    presetList.BorderSizePixel = 0
    presetList.ScrollBarThickness = 6
    presetList.Parent = mainFrame
    Instance.new("UICorner", presetList).CornerRadius = UDim.new(0, 4)
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.Name
    listLayout.Padding = UDim.new(0, 2)
    listLayout.Parent = presetList
    
    -- Status Label
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -20, 0, 20)
    statusLabel.Position = UDim2.new(0, 10, 0, 375)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "🎭 Ready"
    statusLabel.TextColor3 = Color3.new(0.4, 0.4, 0.4)
    statusLabel.TextSize = 10
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = mainFrame
    
    -- Minimize Button (Circular with 'S')
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.Position = UDim2.new(1, -40, 0, 5)
    minimizeButton.BackgroundColor3 = Color3.new(0.2, 0.5, 0.8)
    minimizeButton.Text = "S"
    minimizeButton.TextColor3 = Color3.new(1, 1, 1)
    minimizeButton.TextSize = 14
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.Parent = mainFrame
    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0.5, 0)
    minCorner.Parent = minimizeButton
    
    -- Minimize Icon Frame (top-left 'S')
    local iconFrame = Instance.new("Frame")
    iconFrame.Size = UDim2.new(0, 40, 0, 40)
    iconFrame.Position = UDim2.new(0, 0, 0, 0)
    iconFrame.BackgroundColor3 = Color3.new(0.2, 0.5, 0.8)
    iconFrame.BackgroundTransparency = 0
    iconFrame.BorderSizePixel = 0
    iconFrame.Visible = false
    iconFrame.Parent = screenGui
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0.5, 0)
    iconCorner.Parent = iconFrame
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(1, 0, 1, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = "S"
    iconLabel.TextColor3 = Color3.new(1, 1, 1)
    iconLabel.TextSize = 20
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.TextXAlignment = Enum.TextXAlignment.Left
    iconLabel.TextYAlignment = Enum.TextYAlignment.Top
    iconLabel.Parent = iconFrame
    
    -- Current captured outfit
    local currentOutfit = nil
    
    -- Update preset list
    local function updatePresetList()
        for _, child in pairs(presetList:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        local count = 0
        for name, data in pairs(characterPresets) do
            count = count + 1
            local presetButton = Instance.new("TextButton")
            presetButton.Size = UDim2.new(1, -10, 0, 24)
            presetButton.BackgroundColor3 = Color3.new(1, 1, 1)
            presetButton.BackgroundTransparency = 0.6
            presetButton.Text = "🎭 " .. name .. " (IDs: " .. (data.desc.Accessories or "None") .. ")"
            presetButton.TextColor3 = Color3.new(0, 0, 0)
            presetButton.TextSize = 10
            presetButton.Font = Enum.Font.GothamSemibold
            presetButton.TextXAlignment = Enum.TextXAlignment.Left
            presetButton.Parent = presetList
            Instance.new("UICorner", presetButton).CornerRadius = UDim.new(0, 4)
            
            presetButton.MouseEnter:Connect(function()
                presetButton.BackgroundTransparency = 0.3
            end)
            presetButton.MouseLeave:Connect(function()
                presetButton.BackgroundTransparency = 0.6
            end)
            presetButton.MouseButton1Click:Connect(function()
                presetInput.Text = name
                currentOutfit = data.desc
                statusLabel.Text = "📂 Selected: " .. name
                statusLabel.TextColor3 = Color3.new(0.2, 0.5, 0.8)
            end)
        end
        
        statusLabel.Text = "🎭 " .. count .. " presets"
    end
    
    -- Button Events
    captureButton.MouseButton1Click:Connect(function()
        currentOutfit = captureOutfit()
        if currentOutfit then
            statusLabel.Text = "📸 Outfit captured"
            statusLabel.TextColor3 = Color3.new(0.2, 0.7, 0.2)
        else
            statusLabel.Text = "❌ No humanoid"
            statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
        end
    end)
    
    saveButton.MouseButton1Click:Connect(function()
        local name = presetInput.Text
        if name ~= "" and currentOutfit then
            if savePreset(name, currentOutfit) then
                statusLabel.Text = "✅ Saved: " .. name
                statusLabel.TextColor3 = Color3.new(0.2, 0.7, 0.2)
                updatePresetList()
            else
                statusLabel.Text = "❌ Invalid IDs"
                statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
            end
        else
            statusLabel.Text = "❌ Name/outfit required"
            statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
        end
    end)
    
    loadButton.MouseButton1Click:Connect(function()
        local name = presetInput.Text
        if name ~= "" and characterPresets[name] then
            currentOutfit = characterPresets[name].desc
            statusLabel.Text = "📂 Loaded: " .. name
            statusLabel.TextColor3 = Color3.new(0.2, 0.5, 0.8)
        else
            statusLabel.Text = "❌ Preset not found"
            statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
        end
    end)
    
    applyButton.MouseButton1Click:Connect(function()
        if currentOutfit then
            applyOutfit(currentOutfit)
            statusLabel.Text = "⚡ Applied"
            statusLabel.TextColor3 = Color3.new(0.8, 0.4, 0.1)
        else
            statusLabel.Text = "❌ No outfit"
            statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
        end
    end)
    
    deleteButton.MouseButton1Click:Connect(function()
        local name = presetInput.Text
        if name ~= "" and characterPresets[name] then
            if deletePreset(name) then
                statusLabel.Text = "🗑️ Deleted: " .. name
                statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
                presetInput.Text = ""
                currentOutfit = nil
                updatePresetList()
            else
                statusLabel.Text = "❌ Delete failed"
                statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
            end
        else
            statusLabel.Text = "❌ Preset not found"
            statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
        end
    end)
    
    renameButton.MouseButton1Click:Connect(function()
        local oldName = presetInput.Text
        if oldName ~= "" and characterPresets[oldName] then
            presetInput.Text = ""
            presetInput.PlaceholderText = "New name for '" .. oldName .. "'..."
            statusLabel.Text = "✏️ Enter new name"
            statusLabel.TextColor3 = Color3.new(0.6, 0.4, 0.8)
            
            local connection
            connection = renameButton.MouseButton1Click:Connect(function()
                local newName = presetInput.Text
                if newName ~= "" and newName ~= oldName then
                    if renamePreset(oldName, newName) then
                        statusLabel.Text = "✏️ Renamed to: " .. newName
                        statusLabel.TextColor3 = Color3.new(0.6, 0.4, 0.8)
                        presetInput.Text = newName
                        presetInput.PlaceholderText = "Preset Name..."
                        updatePresetList()
                    else
                        statusLabel.Text = "❌ Rename failed"
                        statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
                    end
                    connection:Disconnect()
                end
            end)
        else
            statusLabel.Text = "❌ Select preset"
            statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
        end
    end)
    
    -- Minimize functionality
    local isMinimized = false
    minimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            mainFrame.Visible = false
            iconFrame.Visible = true
        else
            mainFrame.Visible = true
            iconFrame.Visible = false
        end
    end)
    
    iconFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isMinimized = false
            mainFrame.Visible = true
            iconFrame.Visible = false
        end
    end)
    
    -- Draggable for main frame
    local dragging, dragInput, mousePos, framePos
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = mainFrame.Position
        end
    end)
    
    mainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            mainFrame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    -- Draggable for icon frame
    local iconDragging, iconDragInput, iconMousePos, iconFramePos
    iconFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            iconDragging = true
            iconMousePos = input.Position
            iconFramePos = iconFrame.Position
        end
    end)
    
    iconFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            iconDragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == iconDragInput and iconDragging then
            local delta = input.Position - iconMousePos
            iconFrame.Position = UDim2.new(
                iconFramePos.X.Scale,
                iconFramePos.X.Offset + delta.X,
                iconFramePos.Y.Scale,
                iconFramePos.Y.Offset + delta.Y
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            iconDragging = false
        end
    end)
    
    updatePresetList()
    return screenGui
end

-- Auto-execute
createSalonGUI()