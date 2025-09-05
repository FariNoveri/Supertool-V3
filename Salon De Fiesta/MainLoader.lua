-- Salon de Fiesta - Exploit Version
-- Hat & Face Save/Load System dengan Local JSON
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local presetFile = "salon_de_fiesta_presets.json"

-- Load presets dari file
local function loadPresetsFromFile()
    local success, result = pcall(function()
        if isfile(presetFile) then
            local data = readfile(presetFile)
            return HttpService:JSONDecode(data)
        else
            return {}
        end
    end)
    
    if success then
        return result
    else
        warn("❌ Error loading presets: " .. result)
        return {}
    end
end

-- Save presets ke file
local function savePresetsToFile(presets)
    local success, errorMessage = pcall(function()
        local jsonData = HttpService:JSONEncode(presets)
        writefile(presetFile, jsonData)
    end)
    
    if success then
        print("✅ Presets saved to file!")
        return true
    else
        warn("❌ Error saving presets: " .. errorMessage)
        return false
    end
end

-- Load presets
local characterPresets = loadPresetsFromFile()

-- Execute commands
local function executeCommands(hatId, faceId)
    spawn(function()
        if hatId and hatId ~= "" then
            wait(0.2)
            game.Players.LocalPlayer:Chat("/hat " .. hatId)
            print("🎩 Executed: /hat " .. hatId)
        end
        
        if faceId and faceId ~= "" then
            wait(0.4)
            game.Players.LocalPlayer:Chat("/face " .. faceId)
            print("😊 Executed: /face " .. faceId)
        end
    end)
end

-- Save preset
local function savePreset(name, hatId, faceId)
    characterPresets[name] = {
        hat = hatId,
        face = faceId,
        created = os.time()
    }
    
    if savePresetsToFile(characterPresets) then
        return true
    else
        return false
    end
end

-- Delete preset
local function deletePreset(name)
    if characterPresets[name] then
        characterPresets[name] = nil
        return savePresetsToFile(characterPresets)
    else
        return false
    end
end

-- Rename preset
local function renamePreset(oldName, newName)
    if characterPresets[oldName] and not characterPresets[newName] then
        characterPresets[newName] = characterPresets[oldName]
        characterPresets[oldName] = nil
        return savePresetsToFile(characterPresets)
    else
        return false
    end
end

-- Create GUI
local function createSalonGUI()
    -- Destroy existing GUI
    if player.PlayerGui:FindFirstChild("SalonDeFiestaGUI") then
        player.PlayerGui.SalonDeFiestaGUI:Destroy()
    end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SalonDeFiestaGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player.PlayerGui
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 550)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -275)
    mainFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    -- Shadow effect
    local shadow = Instance.new("Frame")
    shadow.Size = UDim2.new(1, 6, 1, 6)
    shadow.Position = UDim2.new(0, -3, 0, -3)
    shadow.BackgroundColor3 = Color3.new(0, 0, 0)
    shadow.BackgroundTransparency = 0.8
    shadow.BorderSizePixel = 0
    shadow.ZIndex = mainFrame.ZIndex - 1
    shadow.Parent = mainFrame
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 15)
    shadowCorner.Parent = shadow
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame
    
    -- Header "SALON DE FIESTA"
    local headerText = Instance.new("TextLabel")
    headerText.Size = UDim2.new(1, 0, 0, 35)
    headerText.Position = UDim2.new(0, 0, 0, 15)
    headerText.BackgroundTransparency = 1
    headerText.Text = "SALON DE FIESTA"
    headerText.TextColor3 = Color3.new(0.1, 0.1, 0.1)
    headerText.TextSize = 24
    headerText.Font = Enum.Font.GothamBold
    headerText.Parent = mainFrame
    
    -- By text "farinoveri"
    local byText = Instance.new("TextLabel")
    byText.Size = UDim2.new(1, 0, 0, 20)
    byText.Position = UDim2.new(0, 0, 0, 45)
    byText.BackgroundTransparency = 1
    byText.Text = "farinoveri"
    byText.TextColor3 = Color3.new(0.5, 0.5, 0.5)
    byText.TextSize = 14
    byText.Font = Enum.Font.Gotham
    byText.Parent = mainFrame
    
    -- Hat ID Input
    local hatLabel = Instance.new("TextLabel")
    hatLabel.Size = UDim2.new(1, -20, 0, 20)
    hatLabel.Position = UDim2.new(0, 10, 0, 85)
    hatLabel.BackgroundTransparency = 1
    hatLabel.Text = "Hat ID:"
    hatLabel.TextColor3 = Color3.new(0, 0, 0)
    hatLabel.TextSize = 14
    hatLabel.Font = Enum.Font.Gotham
    hatLabel.TextXAlignment = Enum.TextXAlignment.Left
    hatLabel.Parent = mainFrame
    
    local hatInput = Instance.new("TextBox")
    hatInput.Size = UDim2.new(1, -20, 0, 30)
    hatInput.Position = UDim2.new(0, 10, 0, 105)
    hatInput.BackgroundColor3 = Color3.new(0.95, 0.95, 0.95)
    hatInput.BorderSizePixel = 1
    hatInput.BorderColor3 = Color3.new(0.8, 0.8, 0.8)
    hatInput.Text = ""
    hatInput.PlaceholderText = "Enter Hat/Wings/Accessories ID..."
    hatInput.TextColor3 = Color3.new(0, 0, 0)
    hatInput.TextSize = 14
    hatInput.Font = Enum.Font.Gotham
    hatInput.Parent = mainFrame
    
    -- Face ID Input
    local faceLabel = Instance.new("TextLabel")
    faceLabel.Size = UDim2.new(1, -20, 0, 20)
    faceLabel.Position = UDim2.new(0, 10, 0, 145)
    faceLabel.BackgroundTransparency = 1
    faceLabel.Text = "Face ID:"
    faceLabel.TextColor3 = Color3.new(0, 0, 0)
    faceLabel.TextSize = 14
    faceLabel.Font = Enum.Font.Gotham
    faceLabel.TextXAlignment = Enum.TextXAlignment.Left
    faceLabel.Parent = mainFrame
    
    local faceInput = Instance.new("TextBox")
    faceInput.Size = UDim2.new(1, -20, 0, 30)
    faceInput.Position = UDim2.new(0, 10, 0, 165)
    faceInput.BackgroundColor3 = Color3.new(0.95, 0.95, 0.95)
    faceInput.BorderSizePixel = 1
    faceInput.BorderColor3 = Color3.new(0.8, 0.8, 0.8)
    faceInput.Text = ""
    faceInput.PlaceholderText = "Enter Face/Mask ID..."
    faceInput.TextColor3 = Color3.new(0, 0, 0)
    faceInput.TextSize = 14
    faceInput.Font = Enum.Font.Gotham
    faceInput.Parent = mainFrame
    
    -- Preset Name Input
    local presetLabel = Instance.new("TextLabel")
    presetLabel.Size = UDim2.new(1, -20, 0, 20)
    presetLabel.Position = UDim2.new(0, 10, 0, 205)
    presetLabel.BackgroundTransparency = 1
    presetLabel.Text = "Preset Name:"
    presetLabel.TextColor3 = Color3.new(0, 0, 0)
    presetLabel.TextSize = 14
    presetLabel.Font = Enum.Font.Gotham
    presetLabel.TextXAlignment = Enum.TextXAlignment.Left
    presetLabel.Parent = mainFrame
    
    local presetInput = Instance.new("TextBox")
    presetInput.Size = UDim2.new(1, -20, 0, 30)
    presetInput.Position = UDim2.new(0, 10, 0, 225)
    presetInput.BackgroundColor3 = Color3.new(0.95, 0.95, 0.95)
    presetInput.BorderSizePixel = 1
    presetInput.BorderColor3 = Color3.new(0.8, 0.8, 0.8)
    presetInput.Text = ""
    presetInput.PlaceholderText = "Enter preset name..."
    presetInput.TextColor3 = Color3.new(0, 0, 0)
    presetInput.TextSize = 14
    presetInput.Font = Enum.Font.Gotham
    presetInput.Parent = mainFrame
    
    -- Buttons Row 1
    local saveButton = Instance.new("TextButton")
    saveButton.Size = UDim2.new(0.3, -5, 0, 35)
    saveButton.Position = UDim2.new(0.05, 0, 0, 270)
    saveButton.BackgroundColor3 = Color3.new(0.2, 0.7, 0.2)
    saveButton.BorderSizePixel = 0
    saveButton.Text = "SAVE"
    saveButton.TextColor3 = Color3.new(1, 1, 1)
    saveButton.TextSize = 14
    saveButton.Font = Enum.Font.GothamBold
    saveButton.Parent = mainFrame
    
    local loadButton = Instance.new("TextButton")
    loadButton.Size = UDim2.new(0.3, -5, 0, 35)
    loadButton.Position = UDim2.new(0.35, 0, 0, 270)
    loadButton.BackgroundColor3 = Color3.new(0.2, 0.5, 0.8)
    loadButton.BorderSizePixel = 0
    loadButton.Text = "LOAD"
    loadButton.TextColor3 = Color3.new(1, 1, 1)
    loadButton.TextSize = 14
    loadButton.Font = Enum.Font.GothamBold
    loadButton.Parent = mainFrame
    
    local applyButton = Instance.new("TextButton")
    applyButton.Size = UDim2.new(0.3, -5, 0, 35)
    applyButton.Position = UDim2.new(0.65, 0, 0, 270)
    applyButton.BackgroundColor3 = Color3.new(0.8, 0.4, 0.1)
    applyButton.BorderSizePixel = 0
    applyButton.Text = "APPLY"
    applyButton.TextColor3 = Color3.new(1, 1, 1)
    applyButton.TextSize = 14
    applyButton.Font = Enum.Font.GothamBold
    applyButton.Parent = mainFrame
    
    -- Buttons Row 2
    local deleteButton = Instance.new("TextButton")
    deleteButton.Size = UDim2.new(0.48, 0, 0, 30)
    deleteButton.Position = UDim2.new(0.05, 0, 0, 315)
    deleteButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
    deleteButton.BorderSizePixel = 0
    deleteButton.Text = "DELETE"
    deleteButton.TextColor3 = Color3.new(1, 1, 1)
    deleteButton.TextSize = 12
    deleteButton.Font = Enum.Font.GothamBold
    deleteButton.Parent = mainFrame
    
    local renameButton = Instance.new("TextButton")
    renameButton.Size = UDim2.new(0.48, 0, 0, 30)
    renameButton.Position = UDim2.new(0.52, 0, 0, 315)
    renameButton.BackgroundColor3 = Color3.new(0.6, 0.4, 0.8)
    renameButton.BorderSizePixel = 0
    renameButton.Text = "RENAME"
    renameButton.TextColor3 = Color3.new(1, 1, 1)
    renameButton.TextSize = 12
    renameButton.Font = Enum.Font.GothamBold
    renameButton.Parent = mainFrame
    
    -- Preset List
    local listLabel = Instance.new("TextLabel")
    listLabel.Size = UDim2.new(1, -20, 0, 20)
    listLabel.Position = UDim2.new(0, 10, 0, 355)
    listLabel.BackgroundTransparency = 1
    listLabel.Text = "Saved Presets:"
    listLabel.TextColor3 = Color3.new(0, 0, 0)
    listLabel.TextSize = 14
    listLabel.Font = Enum.Font.Gotham
    listLabel.TextXAlignment = Enum.TextXAlignment.Left
    listLabel.Parent = mainFrame
    
    local presetList = Instance.new("ScrollingFrame")
    presetList.Size = UDim2.new(1, -20, 0, 120)
    presetList.Position = UDim2.new(0, 10, 0, 375)
    presetList.BackgroundColor3 = Color3.new(0.9, 0.9, 0.9)
    presetList.BorderSizePixel = 1
    presetList.BorderColor3 = Color3.new(0.7, 0.7, 0.7)
    presetList.ScrollBarThickness = 8
    presetList.Parent = mainFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.Name
    listLayout.Padding = UDim.new(0, 2)
    listLayout.Parent = presetList
    
    -- Status Label
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -20, 0, 25)
    statusLabel.Position = UDim2.new(0, 10, 0, 505)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "🎭 Ready - " .. tostring(#characterPresets) .. " presets loaded"
    statusLabel.TextColor3 = Color3.new(0.5, 0.5, 0.5)
    statusLabel.TextSize = 12
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = mainFrame
    
    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 25, 0, 25)
    closeButton.Position = UDim2.new(1, -35, 0, 10)
    closeButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
    closeButton.BorderSizePixel = 0
    closeButton.Text = "×"
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.TextSize = 16
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = mainFrame
    
    -- Add corners to buttons
    for _, button in pairs({saveButton, loadButton, applyButton, deleteButton, renameButton, closeButton}) do
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = button
    end
    
    -- Update preset list with better design
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
            presetButton.Size = UDim2.new(1, -15, 0, 28)
            presetButton.BackgroundColor3 = Color3.new(0.98, 0.98, 0.98)
            presetButton.BorderSizePixel = 0
            presetButton.AutoButtonColor = false
            presetButton.Parent = presetList
            
            -- Preset button corner
            local presetCorner = Instance.new("UICorner")
            presetCorner.CornerRadius = UDim.new(0, 4)
            presetCorner.Parent = presetButton
            
            -- Preset name (main text)
            local presetName = Instance.new("TextLabel")
            presetName.Size = UDim2.new(1, -10, 0, 14)
            presetName.Position = UDim2.new(0, 8, 0, 2)
            presetName.BackgroundTransparency = 1
            presetName.Text = "🎭 " .. name
            presetName.TextColor3 = Color3.new(0.1, 0.1, 0.1)
            presetName.TextSize = 12
            presetName.Font = Enum.Font.GothamSemibold
            presetName.TextXAlignment = Enum.TextXAlignment.Left
            presetName.Parent = presetButton
            
            -- Preset details (sub text)
            local presetDetails = Instance.new("TextLabel")
            presetDetails.Size = UDim2.new(1, -10, 0, 12)
            presetDetails.Position = UDim2.new(0, 8, 0, 14)
            presetDetails.BackgroundTransparency = 1
            presetDetails.Text = "Hat: " .. (data.hat ~= "" and data.hat or "None") .. " • Face: " .. (data.face ~= "" and data.face or "None")
            presetDetails.TextColor3 = Color3.new(0.5, 0.5, 0.5)
            presetDetails.TextSize = 9
            presetDetails.Font = Enum.Font.Gotham
            presetDetails.TextXAlignment = Enum.TextXAlignment.Left
            presetDetails.Parent = presetButton
            
            -- Hover effects
            presetButton.MouseEnter:Connect(function()
                presetButton.BackgroundColor3 = Color3.new(0.9, 0.95, 1)
                presetName.TextColor3 = Color3.new(0.2, 0.5, 0.8)
            end)
            
            presetButton.MouseLeave:Connect(function()
                presetButton.BackgroundColor3 = Color3.new(0.98, 0.98, 0.98)
                presetName.TextColor3 = Color3.new(0.1, 0.1, 0.1)
            end)
            
            presetButton.MouseButton1Click:Connect(function()
                presetInput.Text = name
                hatInput.Text = data.hat or ""
                faceInput.Text = data.face or ""
                statusLabel.Text = "📂 Selected preset: " .. name
                statusLabel.TextColor3 = Color3.new(0.2, 0.5, 0.8)
            end)
        end
        
        statusLabel.Text = "🎭 " .. count .. " presets loaded"
        statusLabel.TextColor3 = Color3.new(0.5, 0.5, 0.5)
    end
    
    -- Button Events
    saveButton.MouseButton1Click:Connect(function()
        local name = presetInput.Text
        local hat = hatInput.Text
        local face = faceInput.Text
        
        if name ~= "" then
            if savePreset(name, hat, face) then
                statusLabel.Text = "✅ Preset '" .. name .. "' saved!"
                statusLabel.TextColor3 = Color3.new(0.2, 0.7, 0.2)
                updatePresetList()
            else
                statusLabel.Text = "❌ Failed to save preset!"
                statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
            end
        else
            statusLabel.Text = "❌ Enter preset name!"
            statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
        end
    end)
    
    loadButton.MouseButton1Click:Connect(function()
        local name = presetInput.Text
        if name ~= "" and characterPresets[name] then
            local preset = characterPresets[name]
            hatInput.Text = preset.hat or ""
            faceInput.Text = preset.face or ""
            statusLabel.Text = "📂 Preset '" .. name .. "' loaded!"
            statusLabel.TextColor3 = Color3.new(0.2, 0.5, 0.8)
        else
            statusLabel.Text = "❌ Preset not found!"
            statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
        end
    end)
    
    applyButton.MouseButton1Click:Connect(function()
        local hat = hatInput.Text
        local face = faceInput.Text
        if hat ~= "" or face ~= "" then
            executeCommands(hat, face)
            statusLabel.Text = "⚡ Commands executed!"
            statusLabel.TextColor3 = Color3.new(0.8, 0.4, 0.1)
        else
            statusLabel.Text = "❌ Enter at least one ID!"
            statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
        end
    end)
    
    deleteButton.MouseButton1Click:Connect(function()
        local name = presetInput.Text
        if name ~= "" and characterPresets[name] then
            if deletePreset(name) then
                statusLabel.Text = "🗑️ Preset '" .. name .. "' deleted!"
                statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
                presetInput.Text = ""
                hatInput.Text = ""
                faceInput.Text = ""
                updatePresetList()
            else
                statusLabel.Text = "❌ Failed to delete!"
                statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
            end
        else
            statusLabel.Text = "❌ Preset not found!"
            statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
        end
    end)
    
    renameButton.MouseButton1Click:Connect(function()
        local oldName = presetInput.Text
        if oldName ~= "" and characterPresets[oldName] then
            -- Simple rename dialog
            presetInput.PlaceholderText = "Enter new name for '" .. oldName .. "'..."
            presetInput.Text = ""
            statusLabel.Text = "✏️ Enter new name and click RENAME again"
            statusLabel.TextColor3 = Color3.new(0.6, 0.4, 0.8)
            
            -- One-time rename handler
            local connection
            connection = renameButton.MouseButton1Click:Connect(function()
                local newName = presetInput.Text
                if newName ~= "" and newName ~= oldName then
                    if renamePreset(oldName, newName) then
                        statusLabel.Text = "✏️ Renamed '" .. oldName .. "' to '" .. newName .. "'!"
                        statusLabel.TextColor3 = Color3.new(0.6, 0.4, 0.8)
                        presetInput.Text = newName
                        presetInput.PlaceholderText = "Enter preset name..."
                        updatePresetList()
                    else
                        statusLabel.Text = "❌ Rename failed!"
                        statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
                    end
                    connection:Disconnect()
                end
            end)
        else
            statusLabel.Text = "❌ Select preset to rename!"
            statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
        end
    end)
    
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Make draggable
    local dragging = false
    local dragInput, mousePos, framePos
    
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = mainFrame.Position
        end
    end)
    
    mainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
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
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Initialize
    updatePresetList()
    
    return screenGui
end

-- Auto-execute
print("🎭 Loading Salon de Fiesta...")
print("✨ Created by farinoveri")
print("📁 Main file: " .. presetFile)

createSalonGUI()

print("🚀 Salon de Fiesta loaded successfully!")
print("💾 " .. tostring(#characterPresets) .. " presets loaded from local file")