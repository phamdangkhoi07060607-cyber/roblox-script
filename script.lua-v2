local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

local running = false

local positions = {
    Vector3.new(-1913, 64, -655),
    Vector3.new(149, 660, -192),
    Vector3.new(-253, 153, -418),
    Vector3.new(-550, 82, 645),
    Vector3.new(87, 75, -479),
    Vector3.new(64, 88, 430),
    Vector3.new(715, 68, 113),
    Vector3.new(616, 90, -37)
}

-- tạo GUI
local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- nút mở GUI
local open = Instance.new("TextButton")
open.Parent = gui
open.Size = UDim2.new(0,120,0,40)
open.Position = UDim2.new(0,20,0,200)
open.Text = "Teleport GUI"

-- frame
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,200,0,120)
frame.Position = UDim2.new(0,20,0,250)
frame.Visible = false
frame.BackgroundColor3 = Color3.fromRGB(40,40,40)

-- nút toggle
local toggle = Instance.new("TextButton")
toggle.Parent = frame
toggle.Size = UDim2.new(1,0,0,40)
toggle.Position = UDim2.new(0,0,0,10)
toggle.Text = "Auto Teleport OFF"

-- mở frame
open.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-- bật tắt teleport
toggle.MouseButton1Click:Connect(function()
	running = not running
	
	if running then
		toggle.Text = "Auto Teleport ON"
	else
		toggle.Text = "Auto Teleport OFF"
	end
end)

-- teleport loop
task.spawn(function()
	while true do
		if running then
			for _,pos in ipairs(positions) do
				root.CFrame = CFrame.new(pos)
				task.wait(0.8)
			end
		else
			task.wait(0.1)
		end
	end
end)
