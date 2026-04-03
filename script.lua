local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Tạo GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,300,0,400)
frame.Position = UDim2.new(0,10,0,10)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Parent = screenGui

local scrolling = Instance.new("ScrollingFrame")
scrolling.Size = UDim2.new(1,0,1,0)
scrolling.CanvasSize = UDim2.new(0,0,0,0)
scrolling.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Parent = scrolling

-- Hàm thêm tên Part vào GUI
local function addPart(part)
	if part:IsA("Part") then
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1,0,0,25)
		label.Text = part.Name
		label.TextColor3 = Color3.new(1,1,1)
		label.BackgroundTransparency = 1
		label.Parent = scrolling
	end
end

-- Quét tất cả Part
for _,v in pairs(workspace:GetDescendants()) do
	addPart(v)
end

-- Khi có Part mới
workspace.DescendantAdded:Connect(addPart)
