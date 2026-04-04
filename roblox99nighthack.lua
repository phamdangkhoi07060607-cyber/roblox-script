local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

local items = {
"Revolver Ammo","Chair","Bolt","Log","Sheet Metal","UFO Junk","UFO Component",
"Broken Fan","Old Radio","Gears","Broken Microwave","Tyre","Metal Chair",
"Old Car Engine","Washing Machine","Cultist Experiment","Cultist Prototype",
"UFO Scrap","Old Axes","Spears","Morningstars","Crossbows",
"Bandage","Good Sack","(1) Diamond","Fuel Canister","Coal","Chainsaw"
}

local enabled = {}

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,500,0,400)
frame.Position = UDim2.new(0.5,-250,0.5,-200)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.Text = "ITEM CONTROL PANEL"
title.BackgroundColor3 = Color3.fromRGB(40,40,40)
title.TextColor3 = Color3.new(1,1,1)
title.Parent = frame

-- Tabs
local itemTabBtn = Instance.new("TextButton")
itemTabBtn.Size = UDim2.new(0.5,0,0,35)
itemTabBtn.Position = UDim2.new(0,0,0,40)
itemTabBtn.Text = "Teleport Items"
itemTabBtn.Parent = frame

local playerTabBtn = Instance.new("TextButton")
playerTabBtn.Size = UDim2.new(0.5,0,0,35)
playerTabBtn.Position = UDim2.new(0.5,0,0,40)
playerTabBtn.Text = "Player Settings"
playerTabBtn.Parent = frame

local itemsFrame = Instance.new("Frame")
itemsFrame.Size = UDim2.new(1,0,1,-75)
itemsFrame.Position = UDim2.new(0,0,0,75)
itemsFrame.BackgroundTransparency = 1
itemsFrame.Parent = frame

local playerFrame = Instance.new("Frame")
playerFrame.Size = UDim2.new(1,0,1,-75)
playerFrame.Position = UDim2.new(0,0,0,75)
playerFrame.BackgroundTransparency = 1
playerFrame.Visible = false
playerFrame.Parent = frame

itemTabBtn.MouseButton1Click:Connect(function()
itemsFrame.Visible = true
playerFrame.Visible = false
end)

playerTabBtn.MouseButton1Click:Connect(function()
itemsFrame.Visible = false
playerFrame.Visible = true
end)

-- ESP
local function createESP(obj)

local part
if obj:IsA("Model") then
part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
elseif obj:IsA("BasePart") then
part = obj
end

if not part then return end

local billboard = Instance.new("BillboardGui")
billboard.Size = UDim2.new(0,120,0,30)
billboard.AlwaysOnTop = true
billboard.Adornee = part
billboard.Parent = part

local text = Instance.new("TextLabel")
text.Size = UDim2.new(1,0,1,0)
text.BackgroundTransparency = 1
text.Text = obj.Name
text.TextColor3 = Color3.fromRGB(0,255,0)
text.TextScaled = true
text.Parent = billboard

end

-- Teleport item
local function teleportItem(obj)

local part
if obj:IsA("Model") then
part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
elseif obj:IsA("BasePart") then
part = obj
end

if not part then return end

local old = part.Anchored

part.Anchored = true
part.CFrame = root.CFrame * CFrame.new(0,0,-6)

task.wait()

part.Anchored = old

end

-- Item buttons
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

if enabled[name] then
btn.Text = name.." : ON"

for _,v in pairs(workspace:GetDescendants()) do
if v.Name == name then
teleportItem(v)
createESP(v)
end
end

else
btn.Text = name.." : OFF"
end

end)

end

-- Player settings

local function createBox(text,pos,callback)

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0.4,0,0,30)
label.Position = pos
label.Text = text
label.BackgroundTransparency = 1
label.TextColor3 = Color3.new(1,1,1)
label.Parent = playerFrame

local box = Instance.new("TextBox")
box.Size = UDim2.new(0.4,0,0,30)
box.Position = pos + UDim2.new(0.45,0,0,0)
box.Text = ""
box.Parent = playerFrame

box.FocusLost:Connect(function()
local num = tonumber(box.Text)
if num then
callback(num)
end
end)

end

createBox("WalkSpeed",UDim2.new(0.05,0,0.1,0),function(v)
humanoid.WalkSpeed = v
end)

createBox("JumpPower",UDim2.new(0.05,0,0.25,0),function(v)
humanoid.JumpPower = v
end)

createBox("Gravity",UDim2.new(0.05,0,0.4,0),function(v)
workspace.Gravity = v
end)
