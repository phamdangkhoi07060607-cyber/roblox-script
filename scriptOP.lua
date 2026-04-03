local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

-- giá trị mặc định
local normalSpeed = 16
local normalJump = 50
local normalGravity = 196.2

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,230,0,300)
frame.Position = UDim2.new(0,20,0,200)
frame.BackgroundColor3 = Color3.fromRGB(40,40,40)

-- SPEED
local speedBox = Instance.new("TextBox")
speedBox.Parent = frame
speedBox.Size = UDim2.new(1,0,0,30)
speedBox.Position = UDim2.new(0,0,0,10)
speedBox.Text = "Speed"

local speedBtn = Instance.new("TextButton")
speedBtn.Parent = frame
speedBtn.Size = UDim2.new(1,0,0,30)
speedBtn.Position = UDim2.new(0,0,0,40)
speedBtn.Text = "Set Speed"

speedBtn.MouseButton1Click:Connect(function()
	local v = tonumber(speedBox.Text)
	if v then
		humanoid.WalkSpeed = v
	end
end)

-- JUMP
local jumpBox = Instance.new("TextBox")
jumpBox.Parent = frame
jumpBox.Size = UDim2.new(1,0,0,30)
jumpBox.Position = UDim2.new(0,0,0,80)
jumpBox.Text = "JumpPower"

local jumpBtn = Instance.new("TextButton")
jumpBtn.Parent = frame
jumpBtn.Size = UDim2.new(1,0,0,30)
jumpBtn.Position = UDim2.new(0,0,0,110)
jumpBtn.Text = "Set Jump"

jumpBtn.MouseButton1Click:Connect(function()
	local v = tonumber(jumpBox.Text)
	if v then
		humanoid.UseJumpPower = true
		humanoid.JumpPower = v
	end
end)

-- GRAVITY
local gravBox = Instance.new("TextBox")
gravBox.Parent = frame
gravBox.Size = UDim2.new(1,0,0,30)
gravBox.Position = UDim2.new(0,0,0,150)
gravBox.Text = "Gravity"

local gravBtn = Instance.new("TextButton")
gravBtn.Parent = frame
gravBtn.Size = UDim2.new(1,0,0,30)
gravBtn.Position = UDim2.new(0,0,0,180)
gravBtn.Text = "Set Gravity"

gravBtn.MouseButton1Click:Connect(function()
	local v = tonumber(gravBox.Text)
	if v then
		game.Workspace.Gravity = v
	end
end)

-- TELEPORT
local tpBox = Instance.new("TextBox")
tpBox.Parent = frame
tpBox.Size = UDim2.new(1,0,0,30)
tpBox.Position = UDim2.new(0,0,0,210)
tpBox.Text = "Player Name"

local tpBtn = Instance.new("TextButton")
tpBtn.Parent = frame
tpBtn.Size = UDim2.new(1,0,0,30)
tpBtn.Position = UDim2.new(0,0,0,240)
tpBtn.Text = "Teleport"

tpBtn.MouseButton1Click:Connect(function()
	local target = game.Players:FindFirstChild(tpBox.Text)
	if target and target.Character then
		local root = target.Character:FindFirstChild("HumanoidRootPart")
		if root then
			char.HumanoidRootPart.CFrame = root.CFrame
		end
	end
end)

-- SET NORMAL
local normalBtn = Instance.new("TextButton")
normalBtn.Parent = frame
normalBtn.Size = UDim2.new(1,0,0,30)
normalBtn.Position = UDim2.new(0,0,0,270)
normalBtn.Text = "Set To Normal"

normalBtn.MouseButton1Click:Connect(function()
	humanoid.WalkSpeed = normalSpeed
	humanoid.UseJumpPower = true
	humanoid.JumpPower = normalJump
	game.Workspace.Gravity = normalGravity
end)
