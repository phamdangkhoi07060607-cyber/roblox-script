-- GUI + TELEPORT ITEM + PLAYER SETTINGS + ESP
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

--------------------------------------------------
-- ITEM LIST
--------------------------------------------------

local Items = {

Food = {
"Bandage",
"Good Sack"
},

Weapon = {
"Spear",
"Morningstar",
"Katana",
"Laser Sword",
"Ice Sword",
"Trident",
"Poison Claws",
"Poison Spear",
"Infernal Sword",
"Cultist King Mace",
"Obsidiron Hammer",
"Scythe",
"Vampire Scythe"
},

Armour = {
"Leather Body",
"Poison Armor",
"Iron Body",
"Thorn Body",
"Riot Shield",
"Alien Armor",
"Obsidiron Body"
},

Resource = {
"Diamond",
"Fuel Canister",
"Coal"
}

}

--------------------------------------------------
-- ESP
--------------------------------------------------

local function createESP(part)

if part:FindFirstChild("ESP") then return end

local bill = Instance.new("BillboardGui")
bill.Name = "ESP"
bill.Size = UDim2.new(0,100,0,40)
bill.AlwaysOnTop = true
bill.Adornee = part
bill.Parent = part

local text = Instance.new("TextLabel")
text.Size = UDim2.new(1,0,1,0)
text.BackgroundTransparency = 1
text.TextColor3 = Color3.new(1,0,0)
text.TextStrokeTransparency = 0
text.TextScaled = true
text.Text = part.Name
text.Parent = bill

end

for _,v in pairs(workspace:GetDescendants()) do
if v:IsA("BasePart") then
createESP(v)
end
end

workspace.DescendantAdded:Connect(function(v)
if v:IsA("BasePart") then
createESP(v)
end
end)

--------------------------------------------------
-- TELEPORT FUNCTION
--------------------------------------------------

local function teleportItem(name)

local char = player.Character
if not char then return end

local root = char:FindFirstChild("HumanoidRootPart")
if not root then return end

for _,v in pairs(workspace:GetDescendants()) do
if v:IsA("BasePart") and v.Name == name then

v.Anchored = true
v.CFrame = root.CFrame * CFrame.new(0,0,-5)

task.wait(0.15)

v.Anchored = false

end
end

end

--------------------------------------------------
-- GUI
--------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,500,0,350)
main.Position = UDim2.new(0.5,-250,0.5,-175)
main.BackgroundColor3 = Color3.fromRGB(30,30,30)

--------------------------------------------------
-- CLOSE BUTTON
--------------------------------------------------

local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,5)
close.Text = "X"

close.MouseButton1Click:Connect(function()
main.Visible = false
end)

--------------------------------------------------
-- OPEN BUTTON
--------------------------------------------------

local open = Instance.new("TextButton", gui)
open.Size = UDim2.new(0,120,0,35)
open.Position = UDim2.new(0,20,0.5,0)
open.Text = "OPEN GUI"

open.MouseButton1Click:Connect(function()
main.Visible = true
end)

--------------------------------------------------
-- SCROLL FRAME
--------------------------------------------------

local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1,-20,1,-60)
scroll.Position = UDim2.new(0,10,0,50)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,5)

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
end)

--------------------------------------------------
-- CREATE ITEM BUTTONS
--------------------------------------------------

for category, list in pairs(Items) do

local label = Instance.new("TextLabel", scroll)
label.Text = "=== "..category.." ==="
label.Size = UDim2.new(1,0,0,30)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.new(1,1,1)
label.TextScaled = true

for _,itemName in pairs(list) do

local btn = Instance.new("TextButton", scroll)
btn.Size = UDim2.new(1,0,0,30)
btn.Text = itemName

btn.MouseButton1Click:Connect(function()
teleportItem(itemName)
end)

end

end

--------------------------------------------------
-- PLAYER SETTINGS
--------------------------------------------------

local function createSetting(name,default,callback)

local box = Instance.new("TextBox", scroll)
box.Size = UDim2.new(1,0,0,30)
box.Text = name.." : "..default

box.FocusLost:Connect(function()

local num = tonumber(box.Text:match("%d+"))
if num then
callback(num)
end

end)

end

createSetting("Speed",16,function(v)

local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
if hum then
hum.WalkSpeed = v
end

end)

createSetting("JumpPower",50,function(v)

local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
if hum then
hum.JumpPower = v
end

end)

createSetting("Gravity",196,function(v)

workspace.Gravity = v

end)
