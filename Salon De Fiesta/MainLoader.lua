-- Salon de Fiesta - Exploit Version (Compact Modern UI)
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local presetFile = "salon_de_fiesta_presets.json"

-- Load presets dari file
local function loadPresetsFromFile()
    local success, result = pcall(function()
        if isfile(presetFile) then
            return HttpService:JSONDecode(readfile(presetFile))
        end
        return {}
    end)
    return success and result or {}
end

-- Save presets ke file
local function savePresetsToFile(presets)
    local success = pcall(function()
        writefile(presetFile, HttpService:JSONEncode(presets))
    end)
    return success
end

-- Load presets
local characterPresets = loadPresetsFromFile()

-- Execute commands
local function executeCommands(hatId, faceId)
    spawn(function()
        if hatId and hatId ~= "" then
            wait(0.2)
            player:Chat("/hat " .. hatId)
        end
        if faceId and faceId ~= "" then
            wait(0.4)
            player:Chat("/face " .. faceId)
        end
    end)
end

-- Save preset
local function savePreset(name, hatId, faceId)
    characterPresets[name] = {hat = hatId, face = faceId, created = os.time()}
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

-- Create compact modern UI
local function createSalonGUI()
    if player.PlayerGui:FindFirstChild("SalonDeFiestaGUI") then
        player.PlayerGui.SalonDeFiestaGUI:Destroy()
    end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SalonDeFiestaGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player.PlayerGui
    
    -- Main Frame (compact, square, transparent center)
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
    
    -- Hat Input
    local hatInput = Instance.new("TextBox")
    hatInput.Size = UDim2.new(1, -20, 0, 30)
    hatInput.Position = UDim2.new(0, 10, 0, 60)
    hatInput.BackgroundColor3 = Color3.new(1, 1, 1)
    hatInput.BackgroundTransparency = 0.5
    hatInput.Text = ""
    hatInput.PlaceholderText = "Hat ID..."
    hatInput.TextColor3 = Color3.new(0, 0, 0)
    hatInput.TextSize = 12
    hatInput.Font = Enum.Font.Gotham
    hatInput.Parent = mainFrame
    Instance.new("UICorner", hatInput).CornerRadius = UDim.new(0, 4)
    
    -- Face Input
    local faceInput = Instance.new("TextBox")
    faceInput.Size = UDim2.new(1, -20, 0, 30)
    faceInput.Position = UDim2.new(0, 10, 0, 95)
    faceInput.BackgroundColor3 = Color3.new(1, 1, 1)
    faceInput.BackgroundTransparency = 0.5
    faceInput.Text = ""
    faceInput.PlaceholderText = "Face ID..."
    faceInput.TextColor3 = Color3.new(0, 0, 0)
    faceInput.TextSize = 12
    faceInput.Font = Enum.Font.Gotham
    faceInput.Parent = mainFrame
    Instance.new("UICorner", faceInput).CornerRadius = UDim.new(0, 4)
    
    -- Preset Name Input
    local presetInput = Instance.new("TextBox")
    presetInput.Size = UDim2.new(1, -20, 0, 30)
    presetInput.Position = UDim2.new(0, 10, 0, 130)
    presetInput.BackgroundColor3 = Color3.new(1, 1, 1)
    presetInput.BackgroundTransparency = 0.5
    presetInput.Text = ""
    presetInput.PlaceholderText = "Preset Name..."
    presetInput.TextColor3 = Color3.new(0, 0, 0)
    presetInput.TextSize = 12
    presetInput.Font = Enum.Font.Gotham
    presetInput.Parent = mainFrame
    Instance.new("UICorner", presetInput).CornerRadius = UDim.new(0, 4)
    
    -- Buttons
    local saveButton = Instance.new("TextButton")
    saveButton.Size = UDim2.new(0.31, -5, 0, 30)
    saveButton.Position = UDim2.new(0.05, 0, 0, 165)
    saveButton.BackgroundColor3 = Color3.new(0.2, 0.7, 0.2)
    saveButton.Text = "SAVE"
    saveButton.TextColor3 = Color3.new(1, 1, 1)
    saveButton.TextSize = 12
    saveButton.Font = Enum.Font.GothamBold
    saveButton.Parent = mainFrame
    Instance.new("UICorner", saveButton).CornerRadius = UDim.new(0, 4)
    
    local loadButton = Instance.new("TextButton")
    loadButton.Size = UDim2.new(0.31, -5, 0, 30)
    loadButton.Position = UDim2.new(0.36, 0, 0, 165)
    loadButton.BackgroundColor3 = Color3.new(0.2, 0.5, 0.8)
    loadButton.Text = "LOAD"
    loadButton.TextColor3 = Color3.new(1, 1, 1)
    loadButton.TextSize = 12
    loadButton.Font = Enum.Font.GothamBold
    loadButton.Parent = mainFrame
    Instance.new("UICorner", loadButton).CornerRadius = UDim.new(0, 4)
    
    local applyButton = Instance.new("TextButton")
    applyButton.Size = UDim2.new(0.31, -5, 0, 30)
    applyButton.Position = UDim2.new(0.67, 0, 0, 165)
    applyButton.BackgroundColor3 = Color3.new(0.8, 0.4, 0.1)
    applyButton.Text = "APPLY"
    applyButton.TextColor3 = Color3.new(1, 1, 1)
    applyButton.TextSize = 12
    applyButton.Font = Enum.Font.GothamBold
    applyButton.Parent = mainFrame
    Instance.new("UICorner", applyButton).CornerRadius = UDim.new(0, 4)
    
    local deleteButton = Instance.new("TextButton")
    deleteButton.Size = UDim2.new(0.48, -5, 0, 30)
    deleteButton.Position = UDim2.new(0.05, 0, 0, 200)
    deleteButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
    deleteButton.Text = "DELETE"
    deleteButton.TextColor3 = Color3.new(1, 1, 1)
    deleteButton.TextSize = 12
    deleteButton.Font = Enum.Font.GothamBold
    deleteButton.Parent = mainFrame
    Instance.new("UICorner", deleteButton).CornerRadius = UDim.new(0, 4)
    
    local renameButton = Instance.new("TextButton")
    renameButton.Size = UDim2.new(0.48, -5, 0, 30)
    renameButton.Position = UDim2.new(0.53, 0, 0, 200)
    renameButton.BackgroundColor3 = Color3.new(0.6, 0.4, 0.8)
    renameButton.Text = "RENAME"
    renameButton.TextColor3 = Color3.new(1, 1, 1)
    renameButton.TextSize = 12
    renameButton.Font = Enum.Font.GothamBold
    renameButton.Parent = mainFrame
    Instance.new("UICorner", renameButton).CornerRadius = UDim.new(0, 4)
    
    -- Preset List
    local presetList = Instance.new("ScrollingFrame")
    presetList.Size = UDim2.new(1, -20, 0, 110)
    presetList.Position = UDim2.new(0, 10, 0, 235)
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
    statusLabel.Position = UDim2.new(0, 10, 0, 350)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "🎭 Ready"
    statusLabel.TextColor3 = Color3.new(0.4, 0.4, 0.4)
    statusLabel.TextSize = 10
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = mainFrame
    
    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 20, 0, 20)
    closeButton.Position = UDim2.new(1, -30, 0, 10)
    closeButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
    closeButton.Text = "×"
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.TextSize = 14
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = mainFrame
    Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 4)
    
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
            presetButton.Text = "🎭 " .. name
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
                hatInput.Text = data.hat or ""
                faceInput.Text = data.face or ""
                statusLabel.Text = "📂 Selected: " .. name
                statusLabel.TextColor3 = Color3.new(0.2, 0.5, 0.8)
            end)
        end
        
        statusLabel.Text = "🎭 " .. count .. " presets"
    end
    
    -- Button Events
    saveButton.MouseButton1Click:Connect(function()
        local name, hat, face = presetInput.Text, hatInput.Text, faceInput.Text
        if name ~= "" then
            if savePreset(name, hat, face) then
                statusLabel.Text = "✅ Saved: " .. name
                statusLabel.TextColor3 = Color3.new(0.2, 0.7, 0.2)
                updatePresetList()
            else
                statusLabel.Text = "❌ Save failed"
                statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
            end
        else
            statusLabel.Text = "❌ Name required"
            statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
        end
    end)
    
    loadButton.MouseButton1Click:Connect(function()
        local name = presetInput.Text
        if name ~= "" and characterPresets[name] then
            local preset = characterPresets[name]
            hatInput.Text = preset.hat or ""
            faceInput.Text = preset.face or ""
            statusLabel.Text = "📂 Loaded: " .. name
            statusLabel.TextColor3 = Color3.new(0.2, 0.5, 0.8)
        else
            statusLabel.Text = "❌ Preset not found"
            statusLabel.TextColor3 = Color3.new(0.8, 0.2, 0.2)
        end
    end)
    
    applyButton.MouseButton1Click:Connect(function()
        local hat, face = hatInput.Text, faceInput.Text
        if hat ~= "" or face ~= "" then
            executeCommands(hat, face)
            statusLabel.Text = "⚡ Applied"
            statusLabel.TextColor3 = Color3.new(0.8, 0.4, 0.1)
        else
            statusLabel.Text = "❌ ID required"
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
                hatInput.Text = ""
                faceInput.Text = ""
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
    
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Draggable
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
    
    updatePresetList()
    return screenGui
end

-- Auto-execute
createSalonGUI()