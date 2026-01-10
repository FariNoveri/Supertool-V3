local _call3 = game:GetService("Players")
local _call5 = game:GetService("TweenService")
local _call8 = _call3.LocalPlayer:WaitForChild("PlayerGui")
local _LocalPlayer9 = _call3.LocalPlayer
local loading = _call8:FindFirstChild("LoadingScreen")
if loading then loading:Destroy() end
local _call15 = Instance.new("ScreenGui")
_call15.Name = "LoadingScreen"
_call15.ResetOnSpawn = false
_call15.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_call15.Parent = _call8
local _call19 = Instance.new("Frame")
_call19.Name = "MODDED BY ATLAS CLUB"
_call19.Size = UDim2.new(0, 450, 0, 250)
_call19.AnchorPoint = Vector2.new(0.5, 0.5)
_call19.Position = UDim2.new(0.5, 0, 0.42, 0)
_call19.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
_call19.ClipsDescendants = true
_call19.BackgroundTransparency = 0
_call19.Parent = _call15
local _call29 = Instance.new("UIStroke")
_call29.Color = Color3.fromRGB(70, 130, 255)
_call29.Thickness = 2
_call29.Parent = _call19
local _call33 = Instance.new("UICorner")
_call33.CornerRadius = UDim.new(0, 12)
_call33.Parent = _call19
local _call37 = Instance.new("Frame")
_call37.Name = "ParticleContainer"
_call37.Size = UDim2.new(1, 0, 1, 0)
_call37.BackgroundTransparency = 1
_call37.ClipsDescendants = false
_call37.ZIndex = 1
_call37.Parent = _call19
task.spawn(function()
    while true do
    local _call45 = Instance.new("Frame")
    _call45.Size = UDim2.new(0, 6, 0, 6)
    _call45.Position = UDim2.new(0.55, 0, 1.1, 0)
    _call45.BackgroundColor3 = Color3.fromRGB(137, 198, 255)
    _call45.BackgroundTransparency = 0.58
    _call45.BorderSizePixel = 0
    _call45.ZIndex = 2
    _call45.Parent = _call37
    local _call53 = Instance.new("UICorner")
    _call53.CornerRadius = UDim.new(1, 0)
    _call53.Parent = _call45
    local _call68 = _call5:Create(_call45, TweenInfo.new(4.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call45.Position.X.Scale, 0, - 0.15, 0),
    })
    _call68:Play()
    _call68.Completed:Connect(function()
        _call45:Destroy()
    end)
    task.wait(0.26)
    local _call79 = Instance.new("Frame")
    _call79.Size = UDim2.new(0, 6, 0, 7)
    _call79.Position = UDim2.new(0.51, 0, 1.1, 0)
    _call79.BackgroundColor3 = Color3.fromRGB(210, 201, 255)
    _call79.BackgroundTransparency = 0.47
    _call79.BorderSizePixel = 0
    _call79.ZIndex = 2
    _call79.Parent = _call37
    local _call87 = Instance.new("UICorner")
    _call87.CornerRadius = UDim.new(1, 0)
    _call87.Parent = _call79
    local _call102 = _call5:Create(_call79, TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call79.Position.X.Scale, 0, - 0.16, 0),
    })
    _call102:Play()
    _call102.Completed:Connect(function()
        _call79:Destroy()
    end)
    task.wait(0.29)
    local _call113 = Instance.new("Frame")
    _call113.Size = UDim2.new(0, 5, 0, 6)
    _call113.Position = UDim2.new(0.27, 0, 1.1, 0)
    _call113.BackgroundColor3 = Color3.fromRGB(184, 250, 255)
    _call113.BackgroundTransparency = 0.37
    _call113.BorderSizePixel = 0
    _call113.ZIndex = 2
    _call113.Parent = _call37
    local _call121 = Instance.new("UICorner")
    _call121.CornerRadius = UDim.new(1, 0)
    _call121.Parent = _call113
    local _call136 = _call5:Create(_call113, TweenInfo.new(7.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call113.Position.X.Scale, 0, - 0.12, 0),
    })
    _call136:Play()
    _call136.Completed:Connect(function()
        _call113:Destroy()
    end)
    task.wait(0.25)
    local _call147 = Instance.new("Frame")
    _call147.Size = UDim2.new(0, 5, 0, 3)
    _call147.Position = UDim2.new(0.62, 0, 1.1, 0)
    _call147.BackgroundColor3 = Color3.fromRGB(146, 205, 255)
    _call147.BackgroundTransparency = 0.4
    _call147.BorderSizePixel = 0
    _call147.ZIndex = 2
    _call147.Parent = _call37
    local _call155 = Instance.new("UICorner")
    _call155.CornerRadius = UDim.new(1, 0)
    _call155.Parent = _call147
    local _call170 = _call5:Create(_call147, TweenInfo.new(7.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call147.Position.X.Scale, 0, - 0.18, 0),
    })
    _call170:Play()
    _call170.Completed:Connect(function()
        _call147:Destroy()
    end)
    task.wait(0.17)
    local _call181 = Instance.new("Frame")
    _call181.Size = UDim2.new(0, 4, 0, 4)
    _call181.Position = UDim2.new(0.62, 0, 1.1, 0)
    _call181.BackgroundColor3 = Color3.fromRGB(184, 167, 255)
    _call181.BackgroundTransparency = 0.42
    _call181.BorderSizePixel = 0
    _call181.ZIndex = 2
    _call181.Parent = _call37
    local _call189 = Instance.new("UICorner")
    _call189.CornerRadius = UDim.new(1, 0)
    _call189.Parent = _call181
    local _call204 = _call5:Create(_call181, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call181.Position.X.Scale, 0, - 0.19, 0),
    })
    _call204:Play()
    _call204.Completed:Connect(function()
        _call181:Destroy()
    end)
    task.wait(0.2)
    local _call215 = Instance.new("Frame")
    _call215.Size = UDim2.new(0, 4, 0, 5)
    _call215.Position = UDim2.new(0.49, 0, 1.1, 0)
    _call215.BackgroundColor3 = Color3.fromRGB(110, 157, 255)
    _call215.BackgroundTransparency = 0.5
    _call215.BorderSizePixel = 0
    _call215.ZIndex = 2
    _call215.Parent = _call37
    local _call223 = Instance.new("UICorner")
    _call223.CornerRadius = UDim.new(1, 0)
    _call223.Parent = _call215
    local _call238 = _call5:Create(_call215, TweenInfo.new(6.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call215.Position.X.Scale, 0, - 0.09, 0),
    })
    _call238:Play()
    _call238.Completed:Connect(function()
        _call215:Destroy()
    end)
    task.wait(0.28)
    local _call249 = Instance.new("Frame")
    _call249.Size = UDim2.new(0, 6, 0, 3)
    _call249.Position = UDim2.new(0.99, 0, 1.1, 0)
    _call249.BackgroundColor3 = Color3.fromRGB(104, 210, 255)
    _call249.BackgroundTransparency = 0.3
    _call249.BorderSizePixel = 0
    _call249.ZIndex = 2
    _call249.Parent = _call37
    local _call257 = Instance.new("UICorner")
    _call257.CornerRadius = UDim.new(1, 0)
    _call257.Parent = _call249
    local _call272 = _call5:Create(_call249, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call249.Position.X.Scale, 0, - 0.05, 0),
    })
    _call272:Play()
    _call272.Completed:Connect(function()
        _call249:Destroy()
    end)
    task.wait(0.23)
    local _call283 = Instance.new("Frame")
    _call283.Size = UDim2.new(0, 3, 0, 8)
    _call283.Position = UDim2.new(0.67, 0, 1.1, 0)
    _call283.BackgroundColor3 = Color3.fromRGB(120, 156, 255)
    _call283.BackgroundTransparency = 0.43
    _call283.BorderSizePixel = 0
    _call283.ZIndex = 2
    _call283.Parent = _call37
    local _call291 = Instance.new("UICorner")
    _call291.CornerRadius = UDim.new(1, 0)
    _call291.Parent = _call283
    local _call306 = _call5:Create(_call283, TweenInfo.new(5.9, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call283.Position.X.Scale, 0, - 0.06, 0),
    })
    _call306:Play()
    _call306.Completed:Connect(function()
        _call283:Destroy()
    end)
    task.wait(0.28)
    local _call317 = Instance.new("Frame")
    _call317.Size = UDim2.new(0, 8, 0, 8)
    _call317.Position = UDim2.new(0.76, 0, 1.1, 0)
    _call317.BackgroundColor3 = Color3.fromRGB(222, 195, 255)
    _call317.BackgroundTransparency = 0.39
    _call317.BorderSizePixel = 0
    _call317.ZIndex = 2
    _call317.Parent = _call37
    local _call325 = Instance.new("UICorner")
    _call325.CornerRadius = UDim.new(1, 0)
    _call325.Parent = _call317
    local _call340 = _call5:Create(_call317, TweenInfo.new(4.7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call317.Position.X.Scale, 0, - 0.1, 0),
    })
    _call340:Play()
    _call340.Completed:Connect(function()
        _call317:Destroy()
    end)
    task.wait(0.28)
    local _call351 = Instance.new("Frame")
    _call351.Size = UDim2.new(0, 8, 0, 4)
    _call351.Position = UDim2.new(0.15, 0, 1.1, 0)
    _call351.BackgroundColor3 = Color3.fromRGB(136, 245, 255)
    _call351.BackgroundTransparency = 0.38
    _call351.BorderSizePixel = 0
    _call351.ZIndex = 2
    _call351.Parent = _call37
    local _call359 = Instance.new("UICorner")
    _call359.CornerRadius = UDim.new(1, 0)
    _call359.Parent = _call351
    local _call374 = _call5:Create(_call351, TweenInfo.new(7.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call351.Position.X.Scale, 0, - 0.05, 0),
    })
    _call374:Play()
    _call374.Completed:Connect(function()
        _call351:Destroy()
    end)
    task.wait(0.26)
    local _call385 = Instance.new("Frame")
    _call385.Size = UDim2.new(0, 7, 0, 8)
    _call385.Position = UDim2.new(0.35, 0, 1.1, 0)
    _call385.BackgroundColor3 = Color3.fromRGB(230, 242, 255)
    _call385.BackgroundTransparency = 0.51
    _call385.BorderSizePixel = 0
    _call385.ZIndex = 2
    _call385.Parent = _call37
    local _call393 = Instance.new("UICorner")
    _call393.CornerRadius = UDim.new(1, 0)
    _call393.Parent = _call385
    local _call408 = _call5:Create(_call385, TweenInfo.new(7.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call385.Position.X.Scale, 0, - 0.09, 0),
    })
    _call408:Play()
    _call408.Completed:Connect(function()
        _call385:Destroy()
    end)
    task.wait(0.15)
    local _call419 = Instance.new("Frame")
    _call419.Size = UDim2.new(0, 4, 0, 3)
    _call419.Position = UDim2.new(0.81, 0, 1.1, 0)
    _call419.BackgroundColor3 = Color3.fromRGB(244, 230, 255)
    _call419.BackgroundTransparency = 0.3
    _call419.BorderSizePixel = 0
    _call419.ZIndex = 2
    _call419.Parent = _call37
    local _call427 = Instance.new("UICorner")
    _call427.CornerRadius = UDim.new(1, 0)
    _call427.Parent = _call419
    local _call442 = _call5:Create(_call419, TweenInfo.new(6.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call419.Position.X.Scale, 0, - 0.19, 0),
    })
    _call442:Play()
    _call442.Completed:Connect(function()
        _call419:Destroy()
    end)
    task.wait(0.27)
    local _call453 = Instance.new("Frame")
    _call453.Size = UDim2.new(0, 7, 0, 7)
    _call453.Position = UDim2.new(0.99, 0, 1.1, 0)
    _call453.BackgroundColor3 = Color3.fromRGB(117, 189, 255)
    _call453.BackgroundTransparency = 0.62
    _call453.BorderSizePixel = 0
    _call453.ZIndex = 2
    _call453.Parent = _call37
    local _call461 = Instance.new("UICorner")
    _call461.CornerRadius = UDim.new(1, 0)
    _call461.Parent = _call453
    local _call476 = _call5:Create(_call453, TweenInfo.new(5.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call453.Position.X.Scale, 0, - 0.16, 0),
    })
    _call476:Play()
    _call476.Completed:Connect(function()
        _call453:Destroy()
    end)
    task.wait(0.19)
    local _call487 = Instance.new("Frame")
    _call487.Size = UDim2.new(0, 7, 0, 4)
    _call487.Position = UDim2.new(0.52, 0, 1.1, 0)
    _call487.BackgroundColor3 = Color3.fromRGB(136, 164, 255)
    _call487.BackgroundTransparency = 0.65
    _call487.BorderSizePixel = 0
    _call487.ZIndex = 2
    _call487.Parent = _call37
    local _call495 = Instance.new("UICorner")
    _call495.CornerRadius = UDim.new(1, 0)
    _call495.Parent = _call487
    local _call510 = _call5:Create(_call487, TweenInfo.new(6.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call487.Position.X.Scale, 0, - 0.09, 0),
    })
    _call510:Play()
    _call510.Completed:Connect(function()
        _call487:Destroy()
    end)
    task.wait(0.12)
    local _call521 = Instance.new("Frame")
    _call521.Size = UDim2.new(0, 7, 0, 8)
    _call521.Position = UDim2.new(0.51, 0, 1.1, 0)
    _call521.BackgroundColor3 = Color3.fromRGB(124, 237, 255)
    _call521.BackgroundTransparency = 0.42
    _call521.BorderSizePixel = 0
    _call521.ZIndex = 2
    _call521.Parent = _call37
    local _call529 = Instance.new("UICorner")
    _call529.CornerRadius = UDim.new(1, 0)
    _call529.Parent = _call521
    local _call544 = _call5:Create(_call521, TweenInfo.new(5.9, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call521.Position.X.Scale, 0, - 0.06, 0),
    })
    _call544:Play()
    _call544.Completed:Connect(function()
        _call521:Destroy()
    end)
    task.wait(0.15)
    local _call555 = Instance.new("Frame")
    _call555.Size = UDim2.new(0, 8, 0, 3)
    _call555.Position = UDim2.new(0.94, 0, 1.1, 0)
    _call555.BackgroundColor3 = Color3.fromRGB(239, 219, 255)
    _call555.BackgroundTransparency = 0.47
    _call555.BorderSizePixel = 0
    _call555.ZIndex = 2
    _call555.Parent = _call37
    local _call563 = Instance.new("UICorner")
    _call563.CornerRadius = UDim.new(1, 0)
    _call563.Parent = _call555
    local _call578 = _call5:Create(_call555, TweenInfo.new(7.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call555.Position.X.Scale, 0, - 0.2, 0),
    })
    _call578:Play()
    _call578.Completed:Connect(function()
        _call555:Destroy()
    end)
    task.wait(0.21)
    local _call588 = Instance.new("Frame")
    _call588.Size = UDim2.new(0, 3, 0, 5)
    _call588.Position = UDim2.new(0.01, 0, 1.1, 0)
    _call588.BackgroundColor3 = Color3.fromRGB(124, 238, 255)
    _call588.BackgroundTransparency = 0.69
    _call588.BorderSizePixel = 0
    _call588.ZIndex = 2
    _call588.Parent = _call37
    local _call596 = Instance.new("UICorner")
    _call596.CornerRadius = UDim.new(1, 0)
    _call596.Parent = _call588
    local _call611 = _call5:Create(_call588, TweenInfo.new(7.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call588.Position.X.Scale, 0, - 0.06, 0),
    })
    _call611:Play()
    _call611.Completed:Connect(function()
        _call588:Destroy()
    end)
    task.wait(0.27)
    local _call622 = Instance.new("Frame")
    _call622.Size = UDim2.new(0, 7, 0, 7)
    _call622.Position = UDim2.new(0.13, 0, 1.1, 0)
    _call622.BackgroundColor3 = Color3.fromRGB(121, 204, 255)
    _call622.BackgroundTransparency = 0.43
    _call622.BorderSizePixel = 0
    _call622.ZIndex = 2
    _call622.Parent = _call37
    local _call630 = Instance.new("UICorner")
    _call630.CornerRadius = UDim.new(1, 0)
    _call630.Parent = _call622
    local _call645 = _call5:Create(_call622, TweenInfo.new(7.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call622.Position.X.Scale, 0, - 0.19, 0),
    })
    _call645:Play()
    _call645.Completed:Connect(function()
        _call622:Destroy()
    end)
    task.wait(0.2)
    local _call655 = Instance.new("Frame")
    _call655.Size = UDim2.new(0, 7, 0, 4)
    _call655.Position = UDim2.new(1, 0, 1.1, 0)
    _call655.BackgroundColor3 = Color3.fromRGB(126, 176, 255)
    _call655.BackgroundTransparency = 0.65
    _call655.BorderSizePixel = 0
    _call655.ZIndex = 2
    _call655.Parent = _call37
    local _call663 = Instance.new("UICorner")
    _call663.CornerRadius = UDim.new(1, 0)
    _call663.Parent = _call655
    local _call678 = _call5:Create(_call655, TweenInfo.new(5.7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call655.Position.X.Scale, 0, - 0.09, 0),
    })
    _call678:Play()
    _call678.Completed:Connect(function()
        _call655:Destroy()
    end)
    task.wait(0.23)
    local _call687 = Instance.new("Frame")
    _call687.Size = UDim2.new(0, 8, 0, 4)
    _call687.Position = UDim2.new(0.47, 0, 1.1, 0)
    _call687.BackgroundColor3 = Color3.fromRGB(153, 211, 255)
    _call687.BackgroundTransparency = 0.43
    _call687.BorderSizePixel = 0
    _call687.ZIndex = 2
    _call687.Parent = _call37
    local _call695 = Instance.new("UICorner")
    _call695.CornerRadius = UDim.new(1, 0)
    _call695.Parent = _call687
    local _call710 = _call5:Create(_call687, TweenInfo.new(4.7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call687.Position.X.Scale, 0, - 0.18, 0),
    })
    _call710:Play()
    _call710.Completed:Connect(function()
        _call687:Destroy()
    end)
    task.wait(0.22)
    local _call719 = Instance.new("Frame")
    _call719.Size = UDim2.new(0, 6, 0, 6)
    _call719.Position = UDim2.new(0.45, 0, 1.1, 0)
    _call719.BackgroundColor3 = Color3.fromRGB(254, 212, 255)
    _call719.BackgroundTransparency = 0.57
    _call719.BorderSizePixel = 0
    _call719.ZIndex = 2
    _call719.Parent = _call37
    local _call727 = Instance.new("UICorner")
    _call727.CornerRadius = UDim.new(1, 0)
    _call727.Parent = _call719
    local _call742 = _call5:Create(_call719, TweenInfo.new(7.9, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call719.Position.X.Scale, 0, - 0.07, 0),
    })
    _call742:Play()
    _call742.Completed:Connect(function()
        _call719:Destroy()
    end)
    task.wait(0.14)
    local _call751 = Instance.new("Frame")
    _call751.Size = UDim2.new(0, 7, 0, 6)
    _call751.Position = UDim2.new(0.05, 0, 1.1, 0)
    _call751.BackgroundColor3 = Color3.fromRGB(103, 181, 255)
    _call751.BackgroundTransparency = 0.37
    _call751.BorderSizePixel = 0
    _call751.ZIndex = 2
    _call751.Parent = _call37
    local _call759 = Instance.new("UICorner")
    _call759.CornerRadius = UDim.new(1, 0)
    _call759.Parent = _call751
    local _call774 = _call5:Create(_call751, TweenInfo.new(4.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call751.Position.X.Scale, 0, - 0.09, 0),
    })
    _call774:Play()
    _call774.Completed:Connect(function()
        _call751:Destroy()
    end)
    task.wait(0.16)
    local _call783 = Instance.new("Frame")
    _call783.Size = UDim2.new(0, 5, 0, 3)
    _call783.Position = UDim2.new(0.56, 0, 1.1, 0)
    _call783.BackgroundColor3 = Color3.fromRGB(233, 240, 255)
    _call783.BackgroundTransparency = 0.3
    _call783.BorderSizePixel = 0
    _call783.ZIndex = 2
    _call783.Parent = _call37
    local _call791 = Instance.new("UICorner")
    _call791.CornerRadius = UDim.new(1, 0)
    _call791.Parent = _call783
    local _call806 = _call5:Create(_call783, TweenInfo.new(7.8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call783.Position.X.Scale, 0, - 0.16, 0),
    })
    _call806:Play()
    _call806.Completed:Connect(function()
        _call783:Destroy()
    end)
    task.wait(0.23)
    local _call815 = Instance.new("Frame")
    _call815.Size = UDim2.new(0, 8, 0, 4)
    _call815.Position = UDim2.new(0.66, 0, 1.1, 0)
    _call815.BackgroundColor3 = Color3.fromRGB(171, 252, 255)
    _call815.BackgroundTransparency = 0.58
    _call815.BorderSizePixel = 0
    _call815.ZIndex = 2
    _call815.Parent = _call37
    local _call823 = Instance.new("UICorner")
    _call823.CornerRadius = UDim.new(1, 0)
    _call823.Parent = _call815
    local _call838 = _call5:Create(_call815, TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(_call815.Position.X.Scale, 0, - 0.15, 0),
    })
    _call838:Play()
    _call838.Completed:Connect(function()
        _call815:Destroy()
    end)
    task.wait(1)
    end
end)
local _call827 = Instance.new("Frame")
_call827.Name = "AvatarFrame"
_call827.Size = UDim2.new(0, 70, 0, 70)
_call827.Position = UDim2.new(0.5, 0, 0.23, 0)
_call827.AnchorPoint = Vector2.new(0.5, 0.5)
_call827.BackgroundTransparency = 1
_call827.ZIndex = 3
_call827.Parent = _call19
local _call835 = Instance.new("ImageLabel")
_call835.Name = "Avatar"
_call835.Size = UDim2.new(1, 0, 1, 0)
_call835.BackgroundTransparency = 1
_call835.Image = _call3:GetUserThumbnailAsync(_LocalPlayer9.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
_call835.ZIndex = 3
_call835.Parent = _call827
local _call846 = Instance.new("UICorner")
_call846.CornerRadius = UDim.new(1, 0)
_call846.Parent = _call835
local _call850 = Instance.new("TextLabel")
_call850.Name = "Title"
_call850.Size = UDim2.new(1, 0, 0, 30)
_call850.Position = UDim2.new(0.5, 0, 0.45, 0)
_call850.AnchorPoint = Vector2.new(0.5, 0.5)
_call850.Text = "S I E X T H E R"
_call850.Font = Enum.Font.GothamBold
_call850.TextColor3 = Color3.fromRGB(70, 130, 255)
_call850.TextSize = 28
_call850.BackgroundTransparency = 1
_call850.ZIndex = 3
_call850.Parent = _call19
local _call862 = Instance.new("UIGradient")
_call862.Parent = _call850
local _call880 = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(70, 130, 255)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(70, 130, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
})
_call862.Color = _call880
_call862.Offset = Vector2.new(- 1, 0)
_call862.Rotation = 0
task.spawn(function()
    while true do
        _call862.Offset = Vector2.new(_call862.Offset.X + 0.01, 0)
        if _call862.Offset.X > 1 then
            _call862.Offset = Vector2.new(-1, 0)
        end
        task.wait(0.05)
    end
end)
local _call887 = Instance.new("TextLabel")
_call887.Name = "WelcomeText1"
_call887.Size = UDim2.new(1, - 40, 0, 20)
_call887.Position = UDim2.new(0.5, 0, 0.58, 0)
_call887.AnchorPoint = Vector2.new(0.5, 0.5)
_call887.Text = "Hello " .. _LocalPlayer9.Name
_call887.Font = Enum.Font.Gotham
_call887.TextColor3 = Color3.fromRGB(200, 200, 200)
_call887.TextSize = 16
_call887.TextWrapped = true
_call887.BackgroundTransparency = 1
_call887.ZIndex = 3
_call887.Parent = _call19
local _call899 = Instance.new("TextLabel")
_call899.Name = "WelcomeText2"
_call899.Size = UDim2.new(1, - 40, 0, 20)
_call899.Position = UDim2.new(0.5, 0, 0.66, 0)
_call899.AnchorPoint = Vector2.new(0.5, 0.5)
_call899.Text = "Welcome back! Have a nice day!"
_call899.Font = Enum.Font.Gotham
_call899.TextColor3 = Color3.fromRGB(200, 200, 200)
_call899.TextSize = 16
_call899.TextWrapped = true
_call899.BackgroundTransparency = 1
_call899.ZIndex = 3
_call899.Parent = _call19
local _call911 = Instance.new("TextLabel")
_call911.Name = "StatusText"
_call911.Size = UDim2.new(1, - 40, 0, 20)
_call911.Position = UDim2.new(0.5, 0, 0.77, 0)
_call911.AnchorPoint = Vector2.new(0.5, 0.5)
_call911.Text = "Initializing..."
_call911.Font = Enum.Font.Gotham
_call911.TextColor3 = Color3.fromRGB(220, 220, 220)
_call911.TextSize = 14
_call911.BackgroundTransparency = 1
_call911.ZIndex = 3
_call911.Parent = _call19
local _call923 = Instance.new("Frame")
_call923.Name = "BarBackground"
_call923.Size = UDim2.new(1, - 40, 0, 15)
_call923.Position = UDim2.new(0.5, 0, 0.87, 0)
_call923.AnchorPoint = Vector2.new(0.5, 0.5)
_call923.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
_call923.BackgroundTransparency = 0.5
_call923.ZIndex = 3
_call923.Parent = _call19
local _call933 = Instance.new("UICorner")
_call933.CornerRadius = UDim.new(1, 0)
_call933.Parent = _call923
local _call937 = Instance.new("Frame")
_call937.Name = "BarFill"
_call937.Size = UDim2.new(0, 0, 1, 0)
_call937.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_call937.ZIndex = 4
_call937.Parent = _call923
local _call943 = Instance.new("UICorner")
_call943.CornerRadius = UDim.new(1, 0)
_call943.Parent = _call937
local _call947 = Instance.new("UIGradient")
local _call965 = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 144, 255)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(70, 170, 255)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(135, 170, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
})
_call947.Color = _call965
_call947.Rotation = 0
_call947.Offset = Vector2.new(- 1, 0)
_call947.Parent = _call937
task.spawn(function()
    while true do
        _call947.Offset = Vector2.new(_call947.Offset.X + 0.01, 0)
        if _call947.Offset.X > 1 then
            _call947.Offset = Vector2.new(-1, 0)
        end
        task.wait(0.05)
    end
end)
local _call972 = Instance.new("TextLabel")
_call972.Name = "PercentText"
_call972.Size = UDim2.new(1, 0, 1, 0)
_call972.Position = UDim2.new(0.5, 0, 0.5, 0)
_call972.AnchorPoint = Vector2.new(0.5, 0.5)
_call972.Text = "0%"
_call972.Font = Enum.Font.GothamBold
_call972.TextColor3 = Color3.fromRGB(255, 255, 255)
_call972.TextSize = 12
_call972.TextStrokeTransparency = 0.5
_call972.BackgroundTransparency = 1
_call972.ZIndex = 5
_call972.Parent = _call923
local _call996 = _call5:Create(_call937, TweenInfo.new(8, Enum.EasingStyle.Linear), {
    Size = UDim2.new(1, 0, 1, 0),
})
local start = tick()
_call996:Play()
task.spawn(function()
    while true do
        local elapsed = tick() - start
        local progress = math.min(elapsed / 8, 1)
        local percent = math.floor(progress * 100)
        _call972.Text = percent .. "%"
        if progress >= 1 then break end
        task.wait(0.1)
    end
end)