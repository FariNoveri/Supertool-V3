local Players = game:GetService("Players")
local player = Players.LocalPlayer

if player.PlayerGui:FindFirstChild("AnimMenu") then
	player.PlayerGui.AnimMenu:Destroy()
end

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local animator = humanoid:WaitForChild("Animator")

local currentTracks = {}

local EMOTES = {
	{name = "Kick", id = 3696763549, cat = "Action"},
	{name = "Punch", id = 3175197128, cat = "Action"},
	{name = "Sleep", id = 3698251627, cat = "Action"},
	{name = "Sit", id = 2506281703, cat = "Action"},
	{name = "Hero Landing", id = 3696889652, cat = "Action"},
	
	{name = "Dab", id = 3695297207, cat = "Meme"},
	{name = "Take L", id = 3337966527, cat = "Meme"},
	{name = "Default Dance", id = 3695333486, cat = "Meme"},  -- FIXED: ID yang benar
	{name = "T-Pose", id = 3360686498, cat = "Meme"},  -- FIXED: ID yang benar
}

local ANIM_PACKS = {
	["Rthro"] = {
		walk = 2510196951,
		run = 2510198475,
		jump = 2510197830,
		idle = 2510196885,
		fall = 2510195892,
		swim = 2510199791,
		climb = 2510192778
	},
	["Ninja"] = {
		walk = 656118852,
		run = 656121766,
		jump = 656117878,
		idle = 656117400,
		fall = 656115606,
		swim = 656119721,
		climb = 656114359
	},
	["Robot"] = {
		walk = 616168032,  -- FIXED
		run = 616163682,
		jump = 616161997,
		idle = 616158929,
		fall = 616157476,
		swim = 616165109,
		climb = 616156119
	},
	["Elder"] = {
		walk = 845403856,
		run = 845386501,
		jump = 845398858,
		idle = 845397899,
		fall = 845403127,
		swim = 845400046,  -- FIXED
		climb = 845392038
	},
	["Zombie"] = {
		walk = 616168032,  -- FIXED
		run = 616163682,
		jump = 616161997,
		idle = 616158929,
		fall = 616157476,
		swim = 616165109,
		climb = 616156119
	},
	["Knight"] = {
		walk = 657552124,
		run = 657564596,
		jump = 658409194,
		idle = 657595757,
		fall = 657600338,
		swim = 657560551,
		climb = 658360781
	},
	["Superhero"] = {
		walk = 717898303,
		run = 717894941,
		jump = 717901680,
		idle = 717900016,
		fall = 717895879,
		swim = 717899538,
		climb = 717896528
	},
	["Pirate"] = {
		walk = 750783738,
		run = 750784579,
		jump = 750787460,
		idle = 750781874,
		fall = 750785693,
		swim = 750780242,  -- FIXED
		climb = 750779899
	},
	["Werewolf"] = {
		walk = 1083195517,  -- FIXED: walk beda dari run
		run = 1083216690,
		jump = 1083218792,
		idle = 1083195517,
		fall = 1083189019,
		swim = 1083222527,
		climb = 1083182000
	},
	["Astronaut"] = {
		walk = 891621366,  -- FIXED
		run = 891636393,
		jump = 891627522,
		idle = 891621366,
		fall = 891617961,
		swim = 891639666,
		climb = 891609353
	},
	["Bubbly"] = {
		walk = 910025107,
		run = 910028148,
		jump = 910016857,
		idle = 910004836,
		fall = 910001910,
		swim = 910030921,
		climb = 909997997
	},
	["Stylish"] = {
		walk = 616136790,
		run = 616140816,
		jump = 616139451,
		idle = 616136790,
		fall = 616134815,
		swim = 616143378,
		climb = 616133594
	},
	["Toy"] = {
		walk = 782842708,
		run = 782843345,
		jump = 782847020,
		idle = 782841498,
		fall = 782846423,
		swim = 782844582,
		climb = 782843869
	},
	["Vampire"] = {
		walk = 1083445855,  -- FIXED
		run = 1083462077,
		jump = 1083455352,
		idle = 1083445855,
		fall = 1083443587,
		swim = 1083464683,
		climb = 1083439238
	},
	["Cartoony"] = {
		walk = 742637544,
		run = 742638445,
		jump = 742637942,
		idle = 742637544,
		fall = 742637151,
		swim = 742639666,
		climb = 742636889
	},
	["Levitation"] = {
		walk = 616006778,
		run = 616010382,
		jump = 616008936,
		idle = 616006778,
		fall = 616005863,
		swim = 616011509,
		climb = 616003713
	},
	["Mage"] = {
		walk = 707897309,
		run = 707861613,
		jump = 707853694,
		idle = 707855907,
		fall = 707829716,
		swim = 707876443,
		climb = 707826056
	},
	["Ghost"] = {
		walk = 616006778,
		run = 616010382,
		jump = 616008936,
		idle = 616006778,
		fall = 616005863,
		swim = 616011509,
		climb = 616003713
	},
	["Patrol"] = {
		walk = 1149612882,
		run = 1150967949,
		jump = 1148811837,
		idle = 1149636318,
		fall = 1148863382,
		swim = 1151204998,
		climb = 1148811837
	},
	["Confident"] = {
		walk = 1069977950,
		run = 1070001516,
		jump = 1069984524,
		idle = 1069977950,
		fall = 1069973677,
		swim = 1070012133,
		climb = 1069946257
	},
	["Popstar"] = {
		walk = 1212900985,
		run = 1212980338,
		jump = 1212954651,
		idle = 1212900985,
		fall = 1212900995,
		swim = 1213044953,
		climb = 1213044953
	},
	["Sneaky"] = {
		walk = 1132473842,
		run = 1132494274,
		jump = 1132489853,
		idle = 1132473842,
		fall = 1132469004,
		swim = 1132500520,
		climb = 1132461372
	},
	["Oldschool"] = {
		walk = 5918726674,
		run = 5918726674,
		jump = 1083218792,
		idle = 5918726674,
		fall = 616157476,
		swim = 5918726674,
		climb = 616156119
	},
	["Toilet"] = {
		walk = 4417979645,
		run = 4417979645,
		jump = 4417979645,
		idle = 4417979645,
		fall = 4417979645,
		swim = 4417979645,
		climb = 4417979645
	},
	["Cowboy"] = {
		walk = 1014390418,
		run = 1014421541,
		jump = 1014394726,
		idle = 1014390418,
		fall = 1014375066,
		swim = 1014456391,
		climb = 1014004699
	},
	["Penguin"] = {
		walk = 3333499508,
		run = 3360754937,
		jump = 3333538554,
		idle = 3333499508,
		fall = 3333481888,
		swim = 3360773491,
		climb = 3333457882
	},
	["Blocky"] = {
		walk = 5319844329,
		run = 616163682,
		jump = 5319841935,
		idle = 5319847204,
		fall = 616157476,
		swim = 5319852613,
		climb = 5319837855
	},
	["Adidas Originals"] = {
		walk = 3303162274,
		run = 3236836670,
		jump = 3236847974,
		idle = 3303162549,
		fall = 3236831666,
		swim = 3303162968,
		climb = 3236841823
	},
	["Adidas Sport"] = {
		walk = 3360694441,
		run = 3360692915,
		jump = 3360689775,
		idle = 3360696294,
		fall = 3360687942,
		swim = 3360699886,
		climb = 3360686498
	},
	["Robloxian 2.0"] = {
		walk = 1018552993,
		run = 1018559540,
		jump = 1018555584,
		idle = 1018552993,
		fall = 1018549162,
		swim = 1018561908,
		climb = 1018545518
	},
	["Mr Toilet"] = {
		walk = 4417979645,
		run = 4417979645,
		jump = 4417979645,
		idle = 4417979645,
		fall = 4417979645,
		swim = 4417979645,
		climb = 4417979645
	},
	["Udzal"] = {
		walk = 3303162274,
		run = 3303162274,
		jump = 3303162274,
		idle = 3303162274,
		fall = 3303162274,
		swim = 3303162274,
		climb = 3303162274
	},
	["Astronaut Idle"] = {
		walk = 891621366,
		run = 891627522,
		jump = 891621366,
		idle = 891621366,
		fall = 891617961,
		swim = 891621366,
		climb = 891609353
	},
	["Rthro Idle"] = {
		walk = 2510196951,
		run = 2510198475,
		jump = 2510197830,
		idle = 2510196885,
		fall = 2510195892,
		swim = 2510199791,
		climb = 2510192778
	},
	["Bold"] = {
		walk = 16738340646,
		run = 16738337225,
		jump = 16738336650,
		idle = 16738333868,
		fall = 16738333171,
		swim = 16738339158,
		climb = 16738332169
	},
	["Realistic"] = {
		walk = 11600249883,
		run = 11600211410,
		jump = 11600210487,
		idle = 17172918855,
		fall = 11600206437,
		swim = 11600212676,
		climb = 11600205519
	},
	["No Boundaries"] = {
		walk = 18747074203,
		run = 18747070484,
		jump = 18747069148,
		idle = 18747067405,
		fall = 18747062535,
		swim = 18747073181,
		climb = 18747060903
	},
	["NFL Animation"] = {
		walk = 110358958299415,
		run = 117333533048078,
		jump = 119846112151352,
		idle = 92080889861410,
		fall = 129773241321032,
		swim = 132697394189921,
		climb = 134630013742019
	},
	["Adidas Aura"] = {
		walk = 83842218823011,
		run = 118320322718866,
		jump = 109996626521204,
		idle = 110211186840347,
		fall = 95603166884636,
		swim = 134530128383903,
		climb = 97824616490448
	},
	["Adidas Sports"] = {
		walk = 18537392113,
		run = 18537384940,
		jump = 18537380791,
		idle = 18537376492,
		fall = 18537367238,
		swim = 18537389531,
		climb = 18537363391
	},
	["Adidas Community"] = {
		walk = 83842218823011,
		run = 118320322718866,
		jump = 109996626521204,
		idle = 122257458498464,
		fall = 95603166884636,
		swim = 134530128383903,
		climb = 97824616490448
	},
	["Catwalk Glam by e.l.f."] = {
		walk = 103190462987721,
		run = 75036746190467,
		jump = 138641066989023,
		idle = 101279640971758,
		fall = 72706690305027,
		swim = 112231179705221,
		climb = 104741822987331
	},
	["Unboxed by Amazon"] = {
		walk = 128339543796138,
		run = 114998633936467,
		jump = 110418911914024,
		idle = 82219139681769,
		fall = 125108870423182,
		swim = 137392271797713,
		climb = 117011755848398
	},
	["Wicked Popular"] = {
		walk = 133304526526319,
		run = 136276875045281,
		jump = 130373407996664,
		idle = 101839542383818,
		fall = 83937116921114,
		swim = 128475661806875,
		climb = 135810009801094
	},
	["Wicked \"Dancing Through Life\""] = {
		walk = 94133616443608,
		run = 79789194522561,
		jump = 111157411630082,
		idle = 82682578794949,
		fall = 124742764102674,
		swim = 135050138303161,
		climb = 123509187015792
	}
}

local function stopAll()
	for _, t in pairs(currentTracks) do
		if t and t.IsPlaying then
			t:Stop()
		end
	end
	currentTracks = {}
end

local function playEmote(id)
	stopAll()
	local a = Instance.new("Animation")
	a.AnimationId = "rbxassetid://" .. id
	local t = animator:LoadAnimation(a)
	t:Play()
	table.insert(currentTracks, t)
	t.Stopped:Connect(function()
		a:Destroy()
	end)
end

local function applyPack(pack, type)
	local p = ANIM_PACKS[pack]
	if not p then return end
	
	-- Stop semua animasi yang sedang berjalan
	stopAll()
	
	local animate = character:FindFirstChild("Animate")
	if not animate then return end
	
	if type == "all" then
		if p.walk then animate.walk.WalkAnim.AnimationId = "rbxassetid://" .. p.walk end
		if p.run then animate.run.RunAnim.AnimationId = "rbxassetid://" .. p.run end
		if p.jump then animate.jump.JumpAnim.AnimationId = "rbxassetid://" .. p.jump end
		if p.idle then 
			animate.idle.Animation1.AnimationId = "rbxassetid://" .. p.idle 
			animate.idle.Animation2.AnimationId = "rbxassetid://" .. p.idle 
		end
		if p.fall then animate.fall.FallAnim.AnimationId = "rbxassetid://" .. p.fall end
		if p.swim then animate.swim.Swim.AnimationId = "rbxassetid://" .. p.swim end
		if p.climb then animate.climb.ClimbAnim.AnimationId = "rbxassetid://" .. p.climb end
	else
		if type == "walk" and p.walk then animate.walk.WalkAnim.AnimationId = "rbxassetid://" .. p.walk
		elseif type == "run" and p.run then animate.run.RunAnim.AnimationId = "rbxassetid://" .. p.run
		elseif type == "jump" and p.jump then animate.jump.JumpAnim.AnimationId = "rbxassetid://" .. p.jump
		elseif type == "idle" and p.idle then 
			animate.idle.Animation1.AnimationId = "rbxassetid://" .. p.idle 
			animate.idle.Animation2.AnimationId = "rbxassetid://" .. p.idle 
		elseif type == "fall" and p.fall then animate.fall.FallAnim.AnimationId = "rbxassetid://" .. p.fall
		elseif type == "swim" and p.swim then animate.swim.Swim.AnimationId = "rbxassetid://" .. p.swim
		elseif type == "climb" and p.climb then animate.climb.ClimbAnim.AnimationId = "rbxassetid://" .. p.climb
		end
	end
	
	-- Reload humanoid untuk apply animasi baru
	humanoid:ChangeState(Enum.HumanoidStateType.Landed)
end

local gui = Instance.new("ScreenGui")
gui.Name = "AnimMenu"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 380, 0, 480)
main.Position = UDim2.new(0.5, -190, 0.5, -240)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
main.BorderSizePixel = 0
main.Visible = false
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 45)
top.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
top.BorderSizePixel = 0
top.Parent = main

Instance.new("UICorner", top).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Animations"
title.TextColor3 = Color3.fromRGB(240, 240, 245)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 35, 0, 35)
close.Position = UDim2.new(1, -40, 0, 5)
close.BackgroundColor3 = Color3.fromRGB(180, 40, 50)
close.Text = "×"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.TextSize = 22
close.Font = Enum.Font.GothamBold
close.Parent = main

Instance.new("UICorner", close).CornerRadius = UDim.new(0, 6)

close.MouseButton1Click:Connect(function()
	main.Visible = false
end)

local tabs = Instance.new("Frame")
tabs.Size = UDim2.new(1, -20, 0, 38)
tabs.Position = UDim2.new(0, 10, 0, 55)
tabs.BackgroundTransparency = 1
tabs.Parent = main

local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -20, 1, -110)
content.Position = UDim2.new(0, 10, 0, 100)
content.BackgroundColor3 = Color3.fromRGB(38, 38, 46)
content.BorderSizePixel = 0
content.ScrollBarThickness = 5
content.Parent = main

Instance.new("UICorner", content).CornerRadius = UDim.new(0, 8)

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = content

local pad = Instance.new("UIPadding")
pad.PaddingTop = UDim.new(0, 8)
pad.PaddingLeft = UDim.new(0, 8)
pad.PaddingRight = UDim.new(0, 8)
pad.Parent = content

local function btn(text, func, col)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, -8, 0, 36)
	b.BackgroundColor3 = col or Color3.fromRGB(52, 52, 62)
	b.Text = text
	b.TextColor3 = Color3.fromRGB(230, 230, 235)
	b.TextSize = 15
	b.Font = Enum.Font.Gotham
	b.Parent = content
	
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	
	b.MouseButton1Click:Connect(func)
	
	local oc = b.BackgroundColor3
	b.MouseEnter:Connect(function()
		b.BackgroundColor3 = Color3.fromRGB(
			math.min(oc.R * 255 + 15, 255),
			math.min(oc.G * 255 + 15, 255),
			math.min(oc.B * 255 + 15, 255)
		)
	end)
	b.MouseLeave:Connect(function()
		b.BackgroundColor3 = oc
	end)
	
	return b
end

local function subbtn(text, func)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, -24, 0, 32)
	b.BackgroundColor3 = Color3.fromRGB(45, 45, 54)
	b.Text = "  " .. text
	b.TextColor3 = Color3.fromRGB(200, 200, 205)
	b.TextSize = 14
	b.Font = Enum.Font.Gotham
	b.TextXAlignment = Enum.TextXAlignment.Left
	b.Parent = content
	
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
	
	b.MouseButton1Click:Connect(func)
	
	b.MouseEnter:Connect(function()
		b.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	end)
	b.MouseLeave:Connect(function()
		b.BackgroundColor3 = Color3.fromRGB(45, 45, 54)
	end)
	
	return b
end

local tab = "emotes"
local expanded = {}

local function clear()
	for _, c in pairs(content:GetChildren()) do
		if c:IsA("TextButton") or c:IsA("TextLabel") then
			c:Destroy()
		end
	end
end

local function addCustomEmote()
	-- Create popup frame
	local popup = Instance.new("Frame")
	popup.Size = UDim2.new(0, 320, 0, 180)
	popup.Position = UDim2.new(0.5, -160, 0.5, -90)
	popup.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
	popup.BorderSizePixel = 0
	popup.ZIndex = 10
	popup.Parent = gui
	
	Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 10)
	
	local popTitle = Instance.new("TextLabel")
	popTitle.Size = UDim2.new(1, -20, 0, 40)
	popTitle.Position = UDim2.new(0, 10, 0, 10)
	popTitle.BackgroundTransparency = 1
	popTitle.Text = "Add Custom Emote"
	popTitle.TextColor3 = Color3.fromRGB(240, 240, 245)
	popTitle.TextSize = 16
	popTitle.Font = Enum.Font.GothamBold
	popTitle.TextXAlignment = Enum.TextXAlignment.Left
	popTitle.Parent = popup
	
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, -20, 0, 20)
	nameLabel.Position = UDim2.new(0, 10, 0, 55)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = "Emote Name:"
	nameLabel.TextColor3 = Color3.fromRGB(200, 200, 205)
	nameLabel.TextSize = 13
	nameLabel.Font = Enum.Font.Gotham
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.Parent = popup
	
	local nameBox = Instance.new("TextBox")
	nameBox.Size = UDim2.new(1, -20, 0, 32)
	nameBox.Position = UDim2.new(0, 10, 0, 75)
	nameBox.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
	nameBox.Text = ""
	nameBox.PlaceholderText = "Enter name..."
	nameBox.TextColor3 = Color3.fromRGB(230, 230, 235)
	nameBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 125)
	nameBox.TextSize = 14
	nameBox.Font = Enum.Font.Gotham
	nameBox.ClearTextOnFocus = false
	nameBox.Parent = popup
	
	Instance.new("UICorner", nameBox).CornerRadius = UDim.new(0, 6)
	
	local idLabel = Instance.new("TextLabel")
	idLabel.Size = UDim2.new(1, -20, 0, 20)
	idLabel.Position = UDim2.new(0, 10, 0, 112)
	idLabel.BackgroundTransparency = 1
	idLabel.Text = "Animation ID or Link:"
	idLabel.TextColor3 = Color3.fromRGB(200, 200, 205)
	idLabel.TextSize = 13
	idLabel.Font = Enum.Font.Gotham
	idLabel.TextXAlignment = Enum.TextXAlignment.Left
	idLabel.Parent = popup
	
	local idBox = Instance.new("TextBox")
	idBox.Size = UDim2.new(1, -20, 0, 32)
	idBox.Position = UDim2.new(0, 10, 0, 132)
	idBox.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
	idBox.Text = ""
	idBox.PlaceholderText = "ID or roblox.com/catalog/..."
	idBox.TextColor3 = Color3.fromRGB(230, 230, 235)
	idBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 125)
	idBox.TextSize = 14
	idBox.Font = Enum.Font.Gotham
	idBox.ClearTextOnFocus = false
	idBox.Parent = popup
	
	Instance.new("UICorner", idBox).CornerRadius = UDim.new(0, 6)
	
	local addBtn = Instance.new("TextButton")
	addBtn.Size = UDim2.new(0.5, -15, 0, 35)
	addBtn.Position = UDim2.new(0, 10, 1, -45)
	addBtn.BackgroundColor3 = Color3.fromRGB(70, 150, 80)
	addBtn.Text = "Add"
	addBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	addBtn.TextSize = 15
	addBtn.Font = Enum.Font.GothamBold
	addBtn.Parent = popup
	
	Instance.new("UICorner", addBtn).CornerRadius = UDim.new(0, 6)
	
	local cancelBtn = Instance.new("TextButton")
	cancelBtn.Size = UDim2.new(0.5, -15, 0, 35)
	cancelBtn.Position = UDim2.new(0.5, 5, 1, -45)
	cancelBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 60)
	cancelBtn.Text = "Cancel"
	cancelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	cancelBtn.TextSize = 15
	cancelBtn.Font = Enum.Font.GothamBold
	cancelBtn.Parent = popup
	
	Instance.new("UICorner", cancelBtn).CornerRadius = UDim.new(0, 6)
	
	cancelBtn.MouseButton1Click:Connect(function()
		popup:Destroy()
	end)
	
	addBtn.MouseButton1Click:Connect(function()
		local name = nameBox.Text
		local idText = idBox.Text
		
		if name == "" or idText == "" then
			return
		end
		
		-- Extract ID from link or use directly
		local animId = idText
		if string.find(idText, "roblox.com") then
			local id = string.match(idText, "catalog/(%d+)")
			if id then
				animId = id
			end
		end
		
		-- Convert to number
		animId = tonumber(animId)
		if not animId then
			return
		end
		
		-- Add to custom emotes
		table.insert(EMOTES, {name = name, id = animId, cat = "Custom"})
		
		popup:Destroy()
		showEmotes()
	end)
end

local function showEmotes()
	clear()
	tab = "emotes"
	
	btn("Stop All", stopAll, Color3.fromRGB(180, 50, 60))
	btn("➕ Add Custom Emote", addCustomEmote, Color3.fromRGB(80, 120, 200))
	
	local cats = {}
	for _, e in ipairs(EMOTES) do
		if not cats[e.cat] then
			cats[e.cat] = {}
		end
		table.insert(cats[e.cat], e)
	end
	
	for cat, list in pairs(cats) do
		local exp = expanded[cat]
		local arrow = exp and "▼" or "▶"
		
		btn(arrow .. "  " .. cat, function()
			expanded[cat] = not expanded[cat]
			showEmotes()
		end, Color3.fromRGB(65, 85, 150))
		
		if exp then
			for _, e in ipairs(list) do
				subbtn(e.name, function()
					playEmote(e.id)
				end)
			end
		end
	end
	
	content.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 15)
end

local function showPacks()
	clear()
	tab = "packs"
	
	local names = {}
	for n, _ in pairs(ANIM_PACKS) do
		table.insert(names, n)
	end
	table.sort(names)
	
	for _, n in ipairs(names) do
		local p = ANIM_PACKS[n]
		local exp = expanded[n]
		local arrow = exp and "▼" or "▶"
		
		btn(arrow .. "  " .. n, function()
			expanded[n] = not expanded[n]
			showPacks()
		end, Color3.fromRGB(70, 95, 170))
		
		if exp then
			subbtn("Apply All", function()
				applyPack(n, "all")
			end)
			
			local types = {"walk", "run", "jump", "idle", "fall", "swim", "climb"}
			for _, t in ipairs(types) do
				if p[t] then
					subbtn(t:sub(1,1):upper() .. t:sub(2), function()
						applyPack(n, t)
					end)
				end
			end
		end
	end
	
	content.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 15)
end

local tab1 = Instance.new("TextButton")
tab1.Size = UDim2.new(0.5, -4, 1, 0)
tab1.BackgroundColor3 = Color3.fromRGB(70, 95, 170)
tab1.Text = "Emotes"
tab1.TextColor3 = Color3.fromRGB(240, 240, 245)
tab1.TextSize = 15
tab1.Font = Enum.Font.GothamBold
tab1.Parent = tabs

Instance.new("UICorner", tab1).CornerRadius = UDim.new(0, 6)

local tab2 = Instance.new("TextButton")
tab2.Size = UDim2.new(0.5, -4, 1, 0)
tab2.Position = UDim2.new(0.5, 4, 0, 0)
tab2.BackgroundColor3 = Color3.fromRGB(52, 52, 62)
tab2.Text = "Packs"
tab2.TextColor3 = Color3.fromRGB(240, 240, 245)
tab2.TextSize = 15
tab2.Font = Enum.Font.GothamBold
tab2.Parent = tabs

Instance.new("UICorner", tab2).CornerRadius = UDim.new(0, 6)

tab1.MouseButton1Click:Connect(function()
	tab1.BackgroundColor3 = Color3.fromRGB(70, 95, 170)
	tab2.BackgroundColor3 = Color3.fromRGB(52, 52, 62)
	showEmotes()
end)

tab2.MouseButton1Click:Connect(function()
	tab2.BackgroundColor3 = Color3.fromRGB(70, 95, 170)
	tab1.BackgroundColor3 = Color3.fromRGB(52, 52, 62)
	showPacks()
end)

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0, 55, 0, 55)
toggle.Position = UDim2.new(1, -70, 1, -70)
toggle.BackgroundColor3 = Color3.fromRGB(70, 95, 170)
toggle.Text = "🎭"
toggle.TextSize = 28
toggle.Font = Enum.Font.GothamBold
toggle.Parent = gui

Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)

toggle.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
	if main.Visible and tab == "emotes" then
		showEmotes()
	end
end)

showEmotes()