local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LogService = game:GetService("LogService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Backpack = LocalPlayer:WaitForChild("Backpack")

local gearMuterActive = false
local gearConnections = {}
local gearMuteCount = 0

local animTrackerActive = false
local trackedAnims = {}
local animList = {}
local animSavePath = "AnimationTracker/"
if not isfolder(animSavePath) then
    makefolder(animSavePath)
end

local copiedMap = nil
local totalMapParts = 0
local mapSettings = {
    CopyLighting = true,
    CopyTerrain = false,
    IgnoreCharacters = true
}

local serverJoinInput = ""
local jobIdInput = ""

local currentAnimTracks = {}
local Animator = Humanoid:WaitForChild("Animator")

local consoleLoggerActive = false
local consoleMessages = {}
local consoleConnection = nil
local maxConsoleMessages = 100

local toggleUIKeybind = Enum.KeyCode.Insert

local antiAfkActive = false
local antiAfkConnection = nil
local saniye = 0
local dakika = 0
local saat = 0
local fpsUpdateConnection = nil
local pingTask = nil
local timerTask = nil

local ANIM_PACKS = {
    ["Rthro"] = {walk = 2510196951, run = 2510198475, jump = 2510197830, idle = 2510196885, fall = 2510195892, swim = 2510199791, climb = 2510192778},
    ["Ninja"] = {walk = 656118852, run = 656121766, jump = 656117878, idle = 656117400, fall = 656115606, swim = 656119721, climb = 656114359},
    ["Robot"] = {walk = 616163682, run = 616163682, jump = 616161997, idle = 616158929, fall = 616157476, swim = 616165109, climb = 616156119},
    ["Elder"] = {walk = 845403856, run = 845386501, jump = 845398858, idle = 845397899, fall = 845403127, swim = 845403127, climb = 845392038},
    ["Zombie"] = {walk = 616163682, run = 616163682, jump = 616161997, idle = 616158929, fall = 616157476, swim = 616165109, climb = 616156119},
    ["Knight"] = {walk = 657552124, run = 657564596, jump = 658409194, idle = 657595757, fall = 657600338, swim = 657560551, climb = 658360781},
    ["Superhero"] = {walk = 717898303, run = 717894941, jump = 717901680, idle = 717900016, fall = 717895879, swim = 717899538, climb = 717896528},
    ["Pirate"] = {walk = 750783738, run = 750784579, jump = 750787460, idle = 750781874, fall = 750785693, swim = 750784579, climb = 750779899},
    ["Werewolf"] = {walk = 1083216690, run = 1083216690, jump = 1083218792, idle = 1083195517, fall = 1083189019, swim = 1083222527, climb = 1083182000},
    ["Astronaut"] = {walk = 891636393, run = 891636393, jump = 891627522, idle = 891621366, fall = 891617961, swim = 891639666, climb = 891609353},
    ["Bubbly"] = {walk = 910025107, run = 910028148, jump = 910016857, idle = 910004836, fall = 910001910, swim = 910030921, climb = 909997997},
    ["Stylish"] = {walk = 616136790, run = 616140816, jump = 616139451, idle = 616136790, fall = 616134815, swim = 616143378, climb = 616133594},
    ["Toy"] = {walk = 782842708, run = 782843345, jump = 782847020, idle = 782841498, fall = 782846423, swim = 782844582, climb = 782843869},
    ["Vampire"] = {walk = 1083462077, run = 1083462077, jump = 1083455352, idle = 1083445855, fall = 1083443587, swim = 1083464683, climb = 1083439238},
    ["Cartoony"] = {walk = 742637544, run = 742638445, jump = 742637942, idle = 742637544, fall = 742637151, swim = 742639666, climb = 742636889},
    ["Mage"] = {walk = 707897309, run = 707861613, jump = 707853694, idle = 707855907, fall = 707829716, swim = 707876443, climb = 707826056},
    ["Cowboy"] = {walk = 1014390418, run = 1014421541, jump = 1014394726, idle = 1014390418, fall = 1014375066, swim = 1014456391, climb = 1014004699},
    ["Penguin"] = {walk = 3333499508, run = 3360754937, jump = 3333538554, idle = 3333499508, fall = 3333481888, swim = 3360773491, climb = 3333457882},
    ["Toilet"] = {walk = 4417979645, run = 4417979645, jump = 4417979645, idle = 4417979645, fall = 4417979645, swim = 4417979645, climb = 4417979645},
    ["Bold"] = {walk = 16738340646, run = 16738337225, jump = 16738336650, idle = 16738333868, fall = 16738333171, swim = 16738339158, climb = 16738332169},
    ["Realistic"] = {walk = 11600249883, run = 11600211410, jump = 11600210487, idle = 17172918855, fall = 11600206437, swim = 11600212676, climb = 11600205519}
}

local EMOTES = {
    {name = "Kick", id = 3696763549}, {name = "Punch", id = 3175197128}, {name = "Sleep", id = 3698251627},
    {name = "Sit", id = 2506281703}, {name = "Hero Landing", id = 3696889652}, {name = "Dab", id = 3695297207},
    {name = "Take L", id = 3337966527}, {name = "Default Dance", id = 3337966527}, {name = "T-Pose", id = 3337966527}
}

local Window = Fluent:CreateWindow({
    Title = "DEV TOOLS PACK",
    SubTitle = "by Fari Noveri",
    TabWidth = 160,
    Size = UDim2.fromOffset(600, 520),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = toggleUIKeybind
})

local Tabs = {
    GearMuter = Window:AddTab({ Title = "Gear Muter", Icon = "volume-x" }),
    AnimTracker = Window:AddTab({ Title = "Anim Tracker", Icon = "film" }),
    AnimPlayer = Window:AddTab({ Title = "Anim Player", Icon = "play-circle" }),
    MusicDetector = Window:AddTab({ Title = "Music Finder", Icon = "music" }),
    MapCopier = Window:AddTab({ Title = "Map Copier", Icon = "map" }),
    Character = Window:AddTab({ Title = "Character", Icon = "user" }),
    Console = Window:AddTab({ Title = "Console", Icon = "terminal" }),
    Server = Window:AddTab({ Title = "Server", Icon = "link" }),
    AntiAFK = Window:AddTab({ Title = "Anti AFK", Icon = "clock" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local GearStatusParagraph = Tabs.GearMuter:AddParagraph({
    Title = "Status",
    Content = "Script is currently inactive. Toggle below to start."
})

local GearStatsLabel = Tabs.GearMuter:AddParagraph({
    Title = "Statistics",
    Content = "Total sounds muted: 0"
})

local function muteGearSounds(tool)
    local soundsMuted = 0
    for _, obj in ipairs(tool:GetDescendants()) do
        if obj:IsA("Sound") then
            obj.Volume = 0
            obj:Stop()
            soundsMuted = soundsMuted + 1
        end
    end
    return soundsMuted
end

local function startGearMuter()
    gearMuteCount = 0
    
    for _, player in ipairs(Players:GetPlayers()) do
        local char = player.Character
        if char then
            for _, tool in ipairs(char:GetChildren()) do
                if tool:IsA("Tool") then
                    gearMuteCount = gearMuteCount + muteGearSounds(tool)
                end
            end
        end
        local bp = player:FindFirstChild("Backpack")
        if bp then
            for _, tool in ipairs(bp:GetChildren()) do
                if tool:IsA("Tool") then
                    gearMuteCount = gearMuteCount + muteGearSounds(tool)
                end
            end
        end
    end
    
    gearConnections.players = Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(char)
            gearConnections[char] = char.ChildAdded:Connect(function(child)
                if child:IsA("Tool") then
                    gearMuteCount = gearMuteCount + muteGearSounds(child)
                    gearConnections[child] = child.DescendantAdded:Connect(function(desc)
                        if desc:IsA("Sound") then
                            desc.Volume = 0
                            desc:Stop()
                            gearMuteCount = gearMuteCount + 1
                        end
                    end)
                end
            end)
        end)
        local bp = player:WaitForChild("Backpack")
        gearConnections[bp] = bp.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then
                gearMuteCount = gearMuteCount + muteGearSounds(child)
                gearConnections[child] = child.DescendantAdded:Connect(function(desc)
                    if desc:IsA("Sound") then
                        desc.Volume = 0
                        desc:Stop()
                        gearMuteCount = gearMuteCount + 1
                    end
                end)
            end
        end)
    end)
    
    gearConnections.loop = task.spawn(function()
        while gearMuterActive do
            task.wait(2)
            for _, player in ipairs(Players:GetPlayers()) do
                local char = player.Character
                if char then
                    for _, tool in ipairs(char:GetChildren()) do
                        if tool:IsA("Tool") then
                            muteGearSounds(tool)
                        end
                    end
                end
                local bp = player:FindFirstChild("Backpack")
                if bp then
                    for _, tool in ipairs(bp:GetChildren()) do
                        if tool:IsA("Tool") then
                            muteGearSounds(tool)
                        end
                    end
                end
            end
        end
    end)
    
    Fluent:Notify({
        Title = "Gear Muter",
        Content = "Activated! Monitoring gear sounds...",
        Duration = 3
    })
end

local function stopGearMuter()
    for _, conn in pairs(gearConnections) do
        if typeof(conn) == "RBXScriptConnection" then
            conn:Disconnect()
        elseif typeof(conn) == "thread" then
            task.cancel(conn)
        end
    end
    gearConnections = {}
    
    Fluent:Notify({
        Title = "Gear Muter",
        Content = "Stopped. Total muted: " .. gearMuteCount,
        Duration = 3
    })
end

Tabs.GearMuter:AddToggle("GearMuterToggle", {
    Title = "Enable Gear Sound Muter",
    Description = "Auto-mute all gear/tool sounds",
    Default = false,
    Callback = function(Value)
        gearMuterActive = Value
        
        if Value then
            startGearMuter()
            GearStatusParagraph:SetDesc("ACTIVE - Muting all gear sounds automatically")
        else
            stopGearMuter()
            GearStatusParagraph:SetDesc("INACTIVE - Sounds will play normally")
        end
    end
})

Tabs.GearMuter:AddButton({
    Title = "Force Mute All Gears Now",
    Description = "Manual mute current gears",
    Callback = function()
        local count = 0
        for _, player in ipairs(Players:GetPlayers()) do
            local char = player.Character
            if char then
                for _, tool in ipairs(char:GetChildren()) do
                    if tool:IsA("Tool") then
                        count = count + muteGearSounds(tool)
                    end
                end
            end
            local bp = player:FindFirstChild("Backpack")
            if bp then
                for _, tool in ipairs(bp:GetChildren()) do
                    if tool:IsA("Tool") then
                        count = count + muteGearSounds(tool)
                    end
                end
            end
        end
        Fluent:Notify({
            Title = "Manual Mute",
            Content = "Muted " .. count .. " sounds",
            Duration = 3
        })
    end
})

task.spawn(function()
    while true do
        task.wait(3)
        if gearMuterActive then
            GearStatsLabel:SetDesc("Total sounds muted: " .. gearMuteCount)
        end
    end
end)

local AnimStatusLabel = Tabs.AnimTracker:AddParagraph({
    Title = "Animation Tracker",
    Content = "0 animations tracked\nSave path: workspace/" .. animSavePath
})

local AnimListBox = Tabs.AnimTracker:AddParagraph({
    Title = "Recent Animations",
    Content = "No animations tracked yet. Enable tracker to start."
})

local animTrackerConnection = nil

local function saveAnimation(id)
    local success, result = pcall(function()
        local anim = game:GetObjects("rbxassetid://" .. id)[1]
        if not anim then return false, "Failed to load" end
        
        local animData = {
            Name = anim.Name,
            AnimationId = "rbxassetid://" .. id,
            ClassName = anim.ClassName,
            SavedAt = os.date("%Y-%m-%d %H:%M:%S")
        }
        
        local jsonData = HttpService:JSONEncode(animData)
        local fileName = animSavePath .. "Anim_" .. id .. ".json"
        writefile(fileName, jsonData)
        
        local idFileName = animSavePath .. "Anim_" .. id .. "_ID.txt"
        local idContent = "Animation ID: " .. id .. "\n"
        idContent = idContent .. "Direct Link: https://create.roblox.com/store/asset/" .. id .. "\n"
        idContent = idContent .. "Asset ID: rbxassetid://" .. id .. "\n"
        writefile(idFileName, idContent)
        
        return true, fileName
    end)
    
    return success, result
end

local function updateAnimList()
    local count = #animList
    AnimStatusLabel:SetDesc(count .. " animation" .. (count ~= 1 and "s" or "") .. " tracked\nSave: workspace/" .. animSavePath)
    
    local display = ""
    for i = 1, math.min(5, #animList) do
        local data = animList[i]
        local id = string.match(data.id, "%d+") or "N/A"
        display = display .. "ID: " .. id .. " | " .. data.time .. (data.saved and " [Saved]" or "") .. "\n"
    end
    
    if display == "" then
        display = animTrackerActive and "Tracker active - waiting for animations..." or "Enable tracker to start detecting"
    end
    
    AnimListBox:SetDesc(display)
end

local function trackAnim(animTrack)
    if not animTrackerActive then return end
    
    local id = animTrack.Animation.AnimationId
    
    if not trackedAnims[id] then
        trackedAnims[id] = true
        
        table.insert(animList, 1, {
            id = id,
            time = os.date("%H:%M:%S"),
            saved = false
        })
        
        updateAnimList()
    end
end

Tabs.AnimTracker:AddToggle("AnimTrackerToggle", {
    Title = "Enable Animation Tracker",
    Description = "Start detecting playing animations",
    Default = false,
    Callback = function(Value)
        animTrackerActive = Value
        
        if Value then
            if animTrackerConnection then
                animTrackerConnection:Disconnect()
            end
            
            animTrackerConnection = Humanoid.AnimationPlayed:Connect(function(track)
                pcall(function() trackAnim(track) end)
            end)
            
            Fluent:Notify({
                Title = "Animation Tracker",
                Content = "Tracker enabled - detecting animations...",
                Duration = 3
            })
        else
            if animTrackerConnection then
                animTrackerConnection:Disconnect()
                animTrackerConnection = nil
            end
            
            Fluent:Notify({
                Title = "Animation Tracker",
                Content = "Tracker disabled",
                Duration = 2
            })
        end
        
        updateAnimList()
    end
})

Tabs.AnimTracker:AddButton({
    Title = "Copy Last Animation ID",
    Description = "Copy the most recent tracked animation ID",
    Callback = function()
        if #animList > 0 then
            local id = string.match(animList[1].id, "%d+")
            if id and (setclipboard or toclipboard) then
                (setclipboard or toclipboard)(id)
                Fluent:Notify({
                    Title = "Animation Tracker",
                    Content = "Copied ID: " .. id,
                    Duration = 2
                })
            end
        else
            Fluent:Notify({
                Title = "Animation Tracker",
                Content = "No animations tracked yet",
                Duration = 2
            })
        end
    end
})

Tabs.AnimTracker:AddButton({
    Title = "Save All Animations",
    Description = "Save all tracked animations to files",
    Callback = function()
        local savedCount = 0
        for _, data in ipairs(animList) do
            local id = string.match(data.id, "%d+")
            if id and not data.saved then
                local success = saveAnimation(id)
                if success then
                    data.saved = true
                    savedCount = savedCount + 1
                end
            end
        end
        updateAnimList()
        Fluent:Notify({
            Title = "Animation Tracker",
            Content = "Saved " .. savedCount .. " animations!",
            Duration = 3
        })
    end
})

Tabs.AnimTracker:AddButton({
    Title = "Clear Tracked List",
    Description = "Reset animation list",
    Callback = function()
        animList = {}
        trackedAnims = {}
        updateAnimList()
        Fluent:Notify({
            Title = "Animation Tracker",
            Content = "List cleared!",
            Duration = 2
        })
    end
})

Tabs.AnimPlayer:AddParagraph({
    Title = "Animation Player",
    Content = "Play emotes and apply animation packs to your character"
})

local function stopAllAnims()
    for _, t in pairs(currentAnimTracks) do
        if t and t.IsPlaying then
            t:Stop()
        end
    end
    currentAnimTracks = {}
end

local function playEmote(id)
    stopAllAnims()
    local a = Instance.new("Animation")
    a.AnimationId = "rbxassetid://" .. id
    local t = Animator:LoadAnimation(a)
    t:Play()
    table.insert(currentAnimTracks, t)
    t.Stopped:Connect(function()
        a:Destroy()
    end)
end

local function applyAnimPack(packName, animType)
    local pack = ANIM_PACKS[packName]
    if not pack then return end
    
    local animate = Character:FindFirstChild("Animate")
    if not animate then
        Fluent:Notify({
            Title = "Animation Player",
            Content = "Animate script not found!",
            Duration = 2
        })
        return
    end
    
    if animType == "all" then
        if pack.walk then animate.walk.WalkAnim.AnimationId = "rbxassetid://" .. pack.walk end
        if pack.run then animate.run.RunAnim.AnimationId = "rbxassetid://" .. pack.run end
        if pack.jump then animate.jump.JumpAnim.AnimationId = "rbxassetid://" .. pack.jump end
        if pack.idle then 
            animate.idle.Animation1.AnimationId = "rbxassetid://" .. pack.idle 
            animate.idle.Animation2.AnimationId = "rbxassetid://" .. pack.idle 
        end
        if pack.fall then animate.fall.FallAnim.AnimationId = "rbxassetid://" .. pack.fall end
        if pack.swim then animate.swim.Swim.AnimationId = "rbxassetid://" .. pack.swim end
        if pack.climb then animate.climb.ClimbAnim.AnimationId = "rbxassetid://" .. pack.climb end
    else
        if animType == "walk" and pack.walk then animate.walk.WalkAnim.AnimationId = "rbxassetid://" .. pack.walk
        elseif animType == "run" and pack.run then animate.run.RunAnim.AnimationId = "rbxassetid://" .. pack.run
        elseif animType == "jump" and pack.jump then animate.jump.JumpAnim.AnimationId = "rbxassetid://" .. pack.jump
        elseif animType == "idle" and pack.idle then 
            animate.idle.Animation1.AnimationId = "rbxassetid://" .. pack.idle 
            animate.idle.Animation2.AnimationId = "rbxassetid://" .. pack.idle 
        elseif animType == "fall" and pack.fall then animate.fall.FallAnim.AnimationId = "rbxassetid://" .. pack.fall
        elseif animType == "swim" and pack.swim then animate.swim.Swim.AnimationId = "rbxassetid://" .. pack.swim
        elseif animType == "climb" and pack.climb then animate.climb.ClimbAnim.AnimationId = "rbxassetid://" .. pack.climb
        end
    end
end

Tabs.AnimPlayer:AddButton({
    Title = "Stop All Animations",
    Description = "Stop all currently playing animations",
    Callback = function()
        stopAllAnims()
        Fluent:Notify({
            Title = "Animation Player",
            Content = "All animations stopped",
            Duration = 2
        })
    end
})

Tabs.AnimPlayer:AddSection("Quick Emotes")

for _, emote in ipairs(EMOTES) do
    Tabs.AnimPlayer:AddButton({
        Title = emote.name,
        Callback = function()
            playEmote(emote.id)
        end
    })
end

Tabs.AnimPlayer:AddSection("Animation Packs")

local packNames = {}
for name in pairs(ANIM_PACKS) do
    table.insert(packNames, name)
end
table.sort(packNames)

local selectedPack = packNames[1]

Tabs.AnimPlayer:AddDropdown("AnimPackSelect", {
    Title = "Select Animation Pack",
    Values = packNames,
    Default = 1,
    Callback = function(Value)
        selectedPack = Value
    end
})

Tabs.AnimPlayer:AddButton({
    Title = "Apply Full Pack",
    Description = "Apply all animations from selected pack",
    Callback = function()
        applyAnimPack(selectedPack, "all")
        Fluent:Notify({
            Title = "Animation Player",
            Content = "Applied pack: " .. selectedPack,
            Duration = 2
        })
    end
})

local animTypes = {"walk", "run", "jump", "idle", "fall", "swim", "climb"}
for _, animType in ipairs(animTypes) do
    Tabs.AnimPlayer:AddButton({
        Title = "Apply " .. animType:sub(1,1):upper() .. animType:sub(2),
        Callback = function()
            applyAnimPack(selectedPack, animType)
            Fluent:Notify({
                Title = "Animation Player",
                Content = "Applied " .. animType .. " from " .. selectedPack,
                Duration = 2
            })
        end
    })
end

local musicList = {}
local MusicDropdown = Tabs.MusicDetector:AddDropdown("MusicSelect", {
    Title = "Detected Music",
    Values = {},
    Default = nil,
    Callback = function() end
})

local function getMusicName(id)
    local ok, res = pcall(function()
        local data = HttpService:JSONDecode(game:HttpGet("https://economy.roblox.com/v2/assets/"..id.."/details"))
        return data.Name or "Unknown"
    end)
    return ok and res or "Unknown"
end

local function scanMusic()
    local sounds = {}
    for _, loc in pairs({Workspace, game.SoundService, game.ReplicatedStorage}) do
        for _, obj in pairs(loc:GetDescendants()) do
            if obj:IsA("Sound") and obj.IsPlaying then
                table.insert(sounds, obj)
            end
        end
    end
    
    musicList = {}
    local values = {}
    for i, snd in ipairs(sounds) do
        local id = string.match(tostring(snd.SoundId), "%d+") or "N/A"
        local name = getMusicName(id)
        table.insert(musicList, id)
        table.insert(values, name .. " - " .. id)
    end
    
    MusicDropdown:SetOptions(values)
    
    if #sounds == 0 then
        Fluent:Notify({
            Title = "Music Detector",
            Content = "No music playing",
            Duration = 3
        })
    else
        Fluent:Notify({
            Title = "Music Detector",
            Content = "Found " .. #sounds .. " playing sound(s)",
            Duration = 3
        })
    end
end

Tabs.MusicDetector:AddButton({
    Title = "Scan for Music",
    Description = "Find all playing sounds in the game",
    Callback = scanMusic
})

Tabs.MusicDetector:AddButton({
    Title = "Copy Selected ID",
    Description = "Copy the selected sound ID",
    Callback = function()
        local selected = MusicDropdown.Value
        if selected then
            local id = string.match(selected, "%d+$")
            if id and (setclipboard or toclipboard) then
                (setclipboard or toclipboard)(id)
                Fluent:Notify({
                    Title = "Music Detector",
                    Content = "Copied ID: " .. id,
                    Duration = 2
                })
                return
            end
        end
        Fluent:Notify({
            Title = "Music Detector",
            Content = "No selection",
            Duration = 2
        })
    end
})

local MapStatusLabel = Tabs.MapCopier:AddParagraph({
    Title = "Map Copier Status",
    Content = "Ready to copy map\nParts: 0 | Memory: 0 MB"
})

Tabs.MapCopier:AddToggle("CopyLighting", {
    Title = "Copy Lighting Settings",
    Default = true,
    Callback = function(Value)
        mapSettings.CopyLighting = Value
    end
})

Tabs.MapCopier:AddToggle("IgnoreChars", {
    Title = "Ignore Characters",
    Default = true,
    Callback = function(Value)
        mapSettings.IgnoreCharacters = Value
    end
})

Tabs.MapCopier:AddToggle("CopyTerrain", {
    Title = "Copy Terrain (Experimental)",
    Default = false,
    Callback = function(Value)
        mapSettings.CopyTerrain = Value
    end
})

local function shouldIgnoreObject(obj)
    if mapSettings.IgnoreCharacters then
        if obj:IsA("Model") and obj:FindFirstChildOfClass("Humanoid") then return true end
        if obj.Parent and obj.Parent:FindFirstChildOfClass("Humanoid") then return true end
    end
    if obj:IsA("Camera") then return true end
    if obj:IsA("Terrain") and not mapSettings.CopyTerrain then return true end
    return false
end

local function copyMap()
    MapStatusLabel:SetDesc("Copying map...")
    totalMapParts = 0
    
    local MapFolder = Instance.new("Folder")
    MapFolder.Name = "CopiedMap_" .. game.PlaceId
    
    for _, obj in pairs(Workspace:GetChildren()) do
        if not shouldIgnoreObject(obj) then
            pcall(function()
                local clone = obj:Clone()
                clone.Parent = MapFolder
                
                if clone:IsA("BasePart") then totalMapParts = totalMapParts + 1 end
                for _, desc in pairs(clone:GetDescendants()) do
                    if desc:IsA("BasePart") then totalMapParts = totalMapParts + 1 end
                end
                
                task.wait(0.01)
            end)
        end
    end
    
    if mapSettings.CopyLighting then
        local LightingClone = Instance.new("Folder")
        LightingClone.Name = "LightingSettings"
        LightingClone.Parent = MapFolder
        
        pcall(function()
            for _, obj in pairs(game:GetService("Lighting"):GetChildren()) do
                obj:Clone().Parent = LightingClone
            end
        end)
    end
    
    copiedMap = MapFolder
    local memory = totalMapParts * 0.001
    
    MapStatusLabel:SetDesc("Map copied!\nParts: " .. totalMapParts .. " | Memory: " .. string.format("%.2f", memory) .. " MB")
    
    Fluent:Notify({
        Title = "Map Copier",
        Content = "Copied " .. totalMapParts .. " parts!",
        Duration = 3
    })
end

Tabs.MapCopier:AddButton({
    Title = "Copy Current Map",
    Description = "Copy the entire map to memory",
    Callback = copyMap
})

Tabs.MapCopier:AddButton({
    Title = "Load to Workspace",
    Description = "Load copied map to workspace",
    Callback = function()
        if not copiedMap then
            Fluent:Notify({ Title = "Map Copier", Content = "No map copied yet!", Duration = 2 })
            return
        end
        
        MapStatusLabel:SetDesc("Loading to workspace...")
        
        for _, obj in pairs(Workspace:GetChildren()) do
            local shouldKeep = obj:IsA("Camera") or obj:IsA("Terrain") 
                or obj == LocalPlayer.Character or obj:FindFirstChildOfClass("Humanoid")
            if not shouldKeep then pcall(function() obj:Destroy() end) end
        end
        
        for _, obj in pairs(copiedMap:GetChildren()) do
            obj:Clone().Parent = Workspace
            task.wait(0.01)
        end
        
        if copiedMap:FindFirstChild("LightingSettings") then
            pcall(function()
                for _, obj in pairs(copiedMap.LightingSettings:GetChildren()) do
                    obj:Clone().Parent = game:GetService("Lighting")
                end
            end)
        end
        
        MapStatusLabel:SetDesc("Map loaded to workspace!")
        Fluent:Notify({ Title = "Map Copier", Content = "Map loaded!", Duration = 3 })
    end
})

Tabs.MapCopier:AddButton({
    Title = "Save to File",
    Description = "Save map using saveinstance",
    Callback = function()
        if not copiedMap then
            Fluent:Notify({ Title = "Map Copier", Content = "No map copied!", Duration = 2 })
            return
        end
        
        pcall(function()
            if saveinstance then
                saveinstance({ ClassName = "DataModel", Children = {copiedMap} })
                Fluent:Notify({ Title = "Map Copier", Content = "Map saved to file!", Duration = 3 })
            else
                Fluent:Notify({ Title = "Map Copier", Content = "saveinstance not supported", Duration = 2 })
            end
        end)
    end
})

Tabs.MapCopier:AddButton({
    Title = "Clear Copied Map",
    Description = "Remove from memory",
    Callback = function()
        if copiedMap then copiedMap:Destroy() end
        copiedMap = nil
        totalMapParts = 0
        MapStatusLabel:SetDesc("Cleared copied map")
    end
})

Tabs.Character:AddParagraph({
    Title = "Character Tools",
    Content = "Manage your character accessories and effects"
})

local affectAll = false

Tabs.Character:AddToggle("AffectAll", {
    Title = "Affect All Players",
    Description = "Apply remove actions to everyone",
    Default = false,
    Callback = function(Value)
        affectAll = Value
    end
})

Tabs.Character:AddSection("Remove Items")

local function removeAccessories(char)
    local count = 0
    for _, obj in pairs(char:GetChildren()) do
        if obj:IsA("Accessory") then
            obj:Destroy()
            count = count + 1
        end
    end
    return count
end

Tabs.Character:AddButton({
    Title = "Remove Effect Accessories",
    Description = "Remove all hats, hair, and accessories",
    Callback = function()
        local total = 0
        if affectAll then
            for _, player in ipairs(Players:GetPlayers()) do
                local char = player.Character
                if char then
                    total = total + removeAccessories(char)
                end
            end
        else
            total = removeAccessories(Character)
        end
        Fluent:Notify({
            Title = "Character",
            Content = "Removed " .. total .. " accessories",
            Duration = 2
        })
    end
})

local function removeHatEffects(char)
    local count = 0
    for _, accessory in pairs(char:GetChildren()) do
        if accessory:IsA("Accessory") then
            for _, effect in pairs(accessory:GetDescendants()) do
                if effect:IsA("ParticleEmitter") or effect:IsA("Beam") or 
                   effect:IsA("Trail") or effect:IsA("Fire") or 
                   effect:IsA("Smoke") or effect:IsA("Sparkles") or
                   effect:IsA("PointLight") or effect:IsA("SpotLight") or
                   effect:IsA("SurfaceLight") then
                    effect:Destroy()
                    count = count + 1
                end
            end
        end
    end
    return count
end

Tabs.Character:AddButton({
    Title = "Remove Hat Effects",
    Description = "Remove visual effects from accessories (8-bit crown, sparkles, etc.)",
    Callback = function()
        local total = 0
        if affectAll then
            for _, player in ipairs(Players:GetPlayers()) do
                local char = player.Character
                if char then
                    total = total + removeHatEffects(char)
                end
            end
        else
            total = removeHatEffects(Character)
        end
        Fluent:Notify({
            Title = "Character",
            Content = "Removed " .. total .. " hat effects",
            Duration = 2
        })
    end
})

local function removeSupercrown(char)
    local item = char:FindFirstChild("supercrown")
    if item then
        item:Destroy()
        return 1
    end
    return 0
end

Tabs.Character:AddButton({
    Title = "Remove Supercrown",
    Description = "Remove supercrown from character",
    Callback = function()
        local total = 0
        if affectAll then
            for _, player in ipairs(Players:GetPlayers()) do
                local char = player.Character
                if char then
                    total = total + removeSupercrown(char)
                end
            end
        else
            total = removeSupercrown(Character)
        end
        Fluent:Notify({
            Title = "Character",
            Content = "Removed " .. total .. " supercrown(s)",
            Duration = 2
        })
    end
})

local function removeKshine(char)
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local item = hrp:FindFirstChild("kshine")
        if item then
            item:Destroy()
            return 1
        end
    end
    return 0
end

Tabs.Character:AddButton({
    Title = "Remove Kshine",
    Description = "Remove kshine from HumanoidRootPart",
    Callback = function()
        local total = 0
        if affectAll then
            for _, player in ipairs(Players:GetPlayers()) do
                local char = player.Character
                if char then
                    total = total + removeKshine(char)
                end
            end
        else
            total = removeKshine(Character)
        end
        Fluent:Notify({
            Title = "Character",
            Content = "Removed " .. total .. " kshine(s)",
            Duration = 2
        })
    end
})

local function removeKpe(char)
    local item = char:FindFirstChild("kpe")
    if item then
        item:Destroy()
        return 1
    end
    return 0
end

Tabs.Character:AddButton({
    Title = "Remove Kpe",
    Description = "Remove kpe from character",
    Callback = function()
        local total = 0
        if affectAll then
            for _, player in ipairs(Players:GetPlayers()) do
                local char = player.Character
                if char then
                    total = total + removeKpe(char)
                end
            end
        else
            total = removeKpe(Character)
        end
        Fluent:Notify({
            Title = "Character",
            Content = "Removed " .. total .. " kpe(s)",
            Duration = 2
        })
    end
})

Tabs.Character:AddButton({
    Title = "Reset Character",
    Description = "Reset your character to respawn",
    Callback = function()
        Character:BreakJoints()
        Fluent:Notify({
            Title = "Character",
            Content = "Character reset",
            Duration = 2
        })
    end
})

local ConsoleStatusLabel = Tabs.Console:AddParagraph({
    Title = "Console Logger Status",
    Content = "Logger is inactive. Enable to start capturing console messages."
})

local ConsoleMessagesLabel = Tabs.Console:AddParagraph({
    Title = "Recent Messages",
    Content = "No messages captured yet."
})

local function updateConsoleDisplay()
    local display = ""
    local startIndex = math.max(1, #consoleMessages - 9)
    
    for i = startIndex, #consoleMessages do
        local msg = consoleMessages[i]
        display = display .. "[" .. msg.type .. "] " .. msg.message .. "\n"
    end
    
    if display == "" then
        display = consoleLoggerActive and "Logger active - waiting for messages..." or "Enable logger to start capturing"
    end
    
    ConsoleMessagesLabel:SetDesc(display)
    ConsoleStatusLabel:SetDesc("Messages captured: " .. #consoleMessages .. "/" .. maxConsoleMessages)
end

local function startConsoleLogger()
    consoleConnection = LogService.MessageOut:Connect(function(message, messageType)
        if messageType == Enum.MessageType.MessageError or 
           messageType == Enum.MessageType.MessageWarning or 
           messageType == Enum.MessageType.MessageInfo then
            
            table.insert(consoleMessages, {
                message = message,
                type = messageType.Name:gsub("Message", ""),
                timestamp = os.date("%H:%M:%S")
            })
            
            if #consoleMessages > maxConsoleMessages then
                table.remove(consoleMessages, 1)
            end
            
            updateConsoleDisplay()
        end
    end)
end

local function stopConsoleLogger()
    if consoleConnection then
        consoleConnection:Disconnect()
        consoleConnection = nil
    end
end

Tabs.Console:AddToggle("ConsoleLoggerToggle", {
    Title = "Enable Console Logger",
    Description = "Capture errors, warnings, and info messages",
    Default = false,
    Callback = function(Value)
        consoleLoggerActive = Value
        
        if Value then
            startConsoleLogger()
            Fluent:Notify({
                Title = "Console Logger",
                Content = "Logger enabled - capturing messages...",
                Duration = 3
            })
        else
            stopConsoleLogger()
            Fluent:Notify({
                Title = "Console Logger",
                Content = "Logger disabled",
                Duration = 2
            })
        end
        
        updateConsoleDisplay()
    end
})

Tabs.Console:AddButton({
    Title = "Copy All Messages",
    Description = "Copy all captured console messages to clipboard",
    Callback = function()
        if #consoleMessages == 0 then
            Fluent:Notify({
                Title = "Console Logger",
                Content = "No messages to copy",
                Duration = 2
            })
            return
        end
        
        local fullLog = "Console Log - " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n"
        fullLog = fullLog .. "========================================\n\n"
        
        for _, msg in ipairs(consoleMessages) do
            fullLog = fullLog .. "[" .. msg.timestamp .. "] [" .. msg.type .. "] " .. msg.message .. "\n"
        end
        
        if setclipboard or toclipboard then
            (setclipboard or toclipboard)(fullLog)
            Fluent:Notify({
                Title = "Console Logger",
                Content = "Copied " .. #consoleMessages .. " messages",
                Duration = 2
            })
        end
    end
})

Tabs.Console:AddButton({
    Title = "Clear Messages",
    Description = "Clear all captured messages",
    Callback = function()
        consoleMessages = {}
        updateConsoleDisplay()
        Fluent:Notify({
            Title = "Console Logger",
            Content = "Messages cleared",
            Duration = 2
        })
    end
})

local ServerStatus = Tabs.Server:AddParagraph({
    Title = "Server Status",
    Content = "Paste javascript or raw Roblox.GameLauncher code below"
})

local ServerJoinInput = Tabs.Server:AddInput("ServerJoinInput", {
    Title = "Join Code",
    Description = "Paste: javascript:... or Roblox.GameLauncher.joinGameInstance(...)",
    Default = "",
    Placeholder = "Paste join code here...",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        serverJoinInput = Value
    end
})

local JobIdInput = Tabs.Server:AddInput("JobIdInput", {
    Title = "Job ID",
    Description = "Enter Job ID to join",
    Default = "",
    Placeholder = "Enter Job ID here...",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        jobIdInput = Value
    end
})

local function extractServerIds(input)
    local placeId, jobId = nil, nil
    input = input:gsub("%s+", ""):gsub('"', "'")
    
    local jsPatternPlace = "joinGameInstance%((%d+)"
    local rawPatternJob = "%(%d+,[%s]*['\"]([^'\"]+)['\"]%)"
    
    for place in input:gmatch(jsPatternPlace) do
        placeId = tonumber(place)
        break
    end
    
    if placeId then
        for job in input:gmatch(rawPatternJob) do
            jobId = job
            break
        end
    end
    
    return placeId, jobId
end

Tabs.Server:AddButton({
    Title = "Join Server",
    Description = "Join the server from pasted code",
    Callback = function()
        if serverJoinInput == "" or not serverJoinInput:find("joinGameInstance") then
            ServerStatus:SetDesc("Invalid join code!")
            Fluent:Notify({ Title = "Server", Content = "Invalid code!", Duration = 2 })
            return
        end
        
        local placeId, jobId = extractServerIds(serverJoinInput)
        
        if not placeId or not jobId then
            ServerStatus:SetDesc("Failed to parse IDs")
            Fluent:Notify({ Title = "Server", Content = "Parse failed!", Duration = 2 })
            return
        end
        
        ServerStatus:SetDesc("Joining " .. placeId .. "...")
        Fluent:Notify({ Title = "Server", Content = "Teleporting...", Duration = 2 })
        
        pcall(function()
            TeleportService:TeleportToPlaceInstance(placeId, jobId, LocalPlayer)
        end)
        
        task.wait(2)
        ServerStatus:SetDesc("Teleport sent!")
    end
})

Tabs.Server:AddButton({
    Title = "Join via Job ID",
    Description = "Join server using entered Job ID",
    Callback = function()
        if jobIdInput == "" then
            ServerStatus:SetDesc("No Job ID entered!")
            Fluent:Notify({ Title = "Server", Content = "Enter Job ID!", Duration = 2 })
            return
        end
        
        ServerStatus:SetDesc("Joining current place with Job ID " .. jobIdInput .. "...")
        Fluent:Notify({ Title = "Server", Content = "Teleporting...", Duration = 2 })
        
        pcall(function()
            TeleportService:TeleportToPlaceInstance(game.PlaceId, jobIdInput, LocalPlayer)
        end)
        
        task.wait(2)
        ServerStatus:SetDesc("Teleport sent!")
    end
})

Tabs.Server:AddButton({
    Title = "Rejoin Server",
    Description = "Rejoin the current server",
    Callback = function()
        ServerStatus:SetDesc("Rejoining current server...")
        Fluent:Notify({ Title = "Server", Content = "Teleporting...", Duration = 2 })
        
        pcall(function()
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end)
        
        task.wait(2)
        ServerStatus:SetDesc("Teleport sent!")
    end
})

Tabs.Server:AddButton({
    Title = "Clear Input",
    Description = "Clear the input box",
    Callback = function()
        serverJoinInput = ""
        ServerJoinInput:SetValue("")
        jobIdInput = ""
        JobIdInput:SetValue("")
        ServerStatus:SetDesc("Input cleared")
    end
})

local AntiAfkStatus = Tabs.AntiAFK:AddParagraph({
    Title = "Status",
    Content = "Anti AFK is inactive."
})

local TimerLabel = Tabs.AntiAFK:AddParagraph({
    Title = "Timer",
    Content = "0:0:0"
})

local PingLabel = Tabs.AntiAFK:AddParagraph({
    Title = "Ping",
    Content = "N/A"
})

local FpsLabel = Tabs.AntiAFK:AddParagraph({
    Title = "FPS",
    Content = "N/A"
})

local function startAntiAfk()
    antiAfkConnection = LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
    
    saniye = 0
    dakika = 0
    saat = 0
    
    local FPS = {}
    local sec = tick()
    fpsUpdateConnection = RunService.RenderStepped:Connect(function()
        local fr = tick()
        for index = #FPS,1,-1 do
            FPS[index + 1] = (FPS[index] >= fr - 1) and FPS[index] or nil
        end
        FPS[1] = fr
        local fps = (tick() - sec >= 1 and #FPS) or (#FPS / (tick() - sec))
        fps = math.floor(fps)
        FpsLabel:SetDesc(tostring(fps))
    end)
    
    pingTask = task.spawn(function()
        while antiAfkActive do
            wait(1)
            local ping = tonumber(game:GetService("Stats"):FindFirstChild("PerformanceStats").Ping:GetValue())
            ping = math.floor(ping)
            PingLabel:SetDesc(tostring(ping))
        end
    end)
    
    timerTask = task.spawn(function()
        while antiAfkActive do
            saniye = saniye + 1
            if saniye >= 60 then
                saniye = 0
                dakika = dakika + 1
            end
            if dakika >= 60 then
                dakika = 0
                saat = saat + 1
            end
            TimerLabel:SetDesc(saat .. ":" .. dakika .. ":" .. saniye)
            wait(1)
        end
    end)
    
    AntiAfkStatus:SetDesc("Anti AFK is active.")
    Fluent:Notify({
        Title = "Anti AFK",
        Content = "Enabled",
        Duration = 3
    })
end

local function stopAntiAfk()
    if antiAfkConnection then
        antiAfkConnection:Disconnect()
        antiAfkConnection = nil
    end
    if fpsUpdateConnection then
        fpsUpdateConnection:Disconnect()
        fpsUpdateConnection = nil
    end
    if pingTask then
        task.cancel(pingTask)
        pingTask = nil
    end
    if timerTask then
        task.cancel(timerTask)
        timerTask = nil
    end
    AntiAfkStatus:SetDesc("Anti AFK is inactive.")
    Fluent:Notify({
        Title = "Anti AFK",
        Content = "Disabled",
        Duration = 3
    })
end

Tabs.AntiAFK:AddToggle("AntiAfkToggle", {
    Title = "Enable Anti AFK",
    Description = "Prevent AFK kick",
    Default = false,
    Callback = function(Value)
        antiAfkActive = Value
        if Value then
            startAntiAfk()
        else
            stopAntiAfk()
        end
    end
})

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

InterfaceManager:SetFolder("DevToolsPack")
SaveManager:SetFolder("DevToolsPack/configs")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)

Window:SelectTab(1)

Fluent:Notify({
    Title = "DEV TOOLS PACK",
    Content = "by Fari Noveri - All tools loaded successfully!",
    Duration = 5
})