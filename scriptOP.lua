local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

local items = {
"Revolver Ammo","Chair","Bolt","Log","Sheet Metal","UFO Junk","UFO Component",
"Broken Fan","Old Radio","Gears","Broken Microwave","Tyre","Metal Chair",
"Old Car Engine","Washing Machine","Cultist Experiment","Cultist Prototype",
"UFO Scrap","Old Axes","Spears","Morningstars","Crossbows","Bandage","Good Sack",
"(1) Diamond","Fuel Canister","Coal","Chainsaw"
}

local enabled = {}

-- GUI
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,500,0,400)
frame.Position = UDim2.new(0.5,-250,0.5,-200)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.Text = "ITEM FARM MENU"
title.BackgroundColor3 = Color3.fromRGB(35,35,35)
title.TextColor3 = Color3.new(1,1,1)
title.Parent = frame

-- TAB BUTTONS
local itemsTabBtn = Instance.new("TextButton")
itemsTabBtn.Size = UDim2.new(0.5,0,0,35)
itemsTabBtn.Position = UDim2.new(0,0,0,40)
itemsTabBtn.Text = "Teleport Items"
itemsTabBtn.Parent = frame

local playerTabBtn = Instance.new("TextButton")
playerTabBtn.Size = UDim2.new(0.5,0,0,35)
playerTabBtn.Position = UDim2.new(0.5,0,0,40)
playerTabBtn.Text = "Player Settings"
playerTabBtn.Parent = frame

-- TAB FRAMES
local itemsFrame = Instance.new("Frame")
itemsFrame.Size = UDim2.new(1,0,1,-75)
itemsFrame.Position = UDim2.new(0,0,0,75)
itemsFrame.BackgroundTransparency = 1
itemsFrame.Parent = frame

local playerFrame = Instance.new("Frame")
playerFrame.Size = UDim2.new(1,0,1,-75)
playerFrame.Position = UDim2.new(0,0,0,75)
playerFrame.Visible = false
playerFrame.BackgroundTransparency = 1
playerFrame.Parent = frame

-- TAB SWITCH
itemsTabBtn.MouseButton1Click:Connect(function()
	itemsFrame.Visible = true
	playerFrame.Visible = false
end)

playerTabBtn.MouseButton1Click:Connect(function()
	itemsFrame.Visible = false
	playerFrame.Visible = true
end)

-- ITEM LIST
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1,0,1,0)
scroll.CanvasSize = UDim2.new(0,0,0,#items*35)
scroll.ScrollBarThickness = 6
scroll.Parent = itemsFrame

for i,name in ipairs(items) do
	enabled[name] = false
	
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1,-10,0,30)
	btn.Position = UDim2.new(0,5,0,(i-1)*35)
	btn.Text = name.." : OFF"
	btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Parent = scroll
	
	btn.MouseButton1Click:Connect(function()
		enabled[name] = not enabled[name]
		btn.Text = name.." : "..(enabled[name] and "ON" or "OFF")
	end)
end

-- PLAYER SETTINGS
local function createSetting(name,pos,callback)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.5,0,0,40)
	label.Position = UDim2.new(0,20,0,pos)
	label.Text = name
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1,1,1)
	label.Parent = playerFrame
	
	local box = Instance.new("TextBox")
	box.Size = UDim2.new(0.3,0,0,40)
	box.Position = UDim2.new(0.6,0,0,pos)
	box.Text = ""
	box.Parent = playerFrame
	
	box.FocusLost:Connect(function()
		local val = tonumber(box.Text)
		if val then
			callback(val)
		end
	end)
end

createSetting("WalkSpeed",20,function(v)
	humanoid.WalkSpeed = v
end)

createSetting("JumpPower",80,function(v)
	humanoid.JumpPower = v
end)

createSetting("Gravity",140,function(v)
	game.Workspace.Gravity = v
end)

-- GET PART
local function getPart(obj)
	if obj:IsA("Model") then
		return obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
	elseif obj:IsA("BasePart") then
		return obj
	end
end

-- ITEM TELEPORT LOOP
task.spawn(function()
	while true do
		for _,obj in ipairs(workspace:GetDescendants()) do
			if enabled[obj.Name] then
				local part = getPart(obj)
				if part then
					part.CFrame = root.CFrame * CFrame.new(0,0,-6)
					part.Velocity = Vector3.new(0,0,0)
				end
			end
		end
		task.wait(0.15)
	end
end)
