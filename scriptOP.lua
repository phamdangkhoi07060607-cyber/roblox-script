local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

-- ITEM LISTS

local foods = {
"Carrot","Corn","Pumpkin","Berry","Apple","Morsel","CookedMorsel",
"Steak","CookedSteak","Ribs","Cooked Ribs","Cake","Chili","Stew",
"Hearty Stew","Meat? Sandwich","Seafood Chowder","Steak Dinner",
"Pumpkin Soup","BBQ Ribs","Carrot Cake","Jar o' Jelly",
"Candy Apple","Candy Corn","Pumpkin Pie","Cotton Candy"
}

local weapons = {
"Spear","Morningstar","Katana","Laser Sword","Ice Sword","Trident",
"Poison Claws","Poison Spear","Infernal Sword",
"Cultist King Mace","Obsidiron Hammer","Scythe","Vampire Scythe"
}

local armors = {
"Leather Body","Poison Armor","Iron Body","Thorn Body",
"Riot Shield","Alien Armor","Obsidiron Body"
}

local resources = {
"Revolver Ammo","Chair","Bolt","Log","Sheet Metal","UFO Junk",
"UFO Component","Broken Fan","Old Radio","Gears","Broken Microwave",
"Tyre","Metal Chair","Old Car Engine","Washing Machine",
"Cultist Experiment","Cultist Prototype","UFO Scrap",
"Bandage","Good Sack","(1) Diamond","Fuel Canister","Coal","Chainsaw"
}

-- GUI

local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,520,0,420)
frame.Position = UDim2.new(0.5,-260,0.5,-210)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.Text = "ITEM TELEPORT MENU"
title.BackgroundColor3 = Color3.fromRGB(40,40,40)
title.TextColor3 = Color3.new(1,1,1)
title.Parent = frame

-- TAB BUTTONS

local teleportBtn = Instance.new("TextButton")
teleportBtn.Size = UDim2.new(0.5,0,0,35)
teleportBtn.Position = UDim2.new(0,0,0,40)
teleportBtn.Text = "Teleport"
teleportBtn.Parent = frame

local playerBtn = Instance.new("TextButton")
playerBtn.Size = UDim2.new(0.5,0,0,35)
playerBtn.Position = UDim2.new(0.5,0,0,40)
playerBtn.Text = "Player"
playerBtn.Parent = frame

-- FRAMES

local teleportFrame = Instance.new("Frame")
teleportFrame.Size = UDim2.new(1,0,1,-75)
teleportFrame.Position = UDim2.new(0,0,0,75)
teleportFrame.BackgroundTransparency = 1
teleportFrame.Parent = frame

local playerFrame = Instance.new("Frame")
playerFrame.Size = UDim2.new(1,0,1,-75)
playerFrame.Position = UDim2.new(0,0,0,75)
playerFrame.BackgroundTransparency = 1
playerFrame.Visible = false
playerFrame.Parent = frame

teleportBtn.MouseButton1Click:Connect(function()
teleportFrame.Visible = true
playerFrame.Visible = false
end)

playerBtn.MouseButton1Click:Connect(function()
teleportFrame.Visible = false
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

local bill = Instance.new("BillboardGui")
bill.Size = UDim2.new(0,120,0,30)
bill.AlwaysOnTop = true
bill.Adornee = part
bill.Parent = part

local text = Instance.new("TextLabel")
text.Size = UDim2.new(1,0,1,0)
text.BackgroundTransparency = 1
text.Text = obj.Name
text.TextScaled = true
text.TextColor3 = Color3.fromRGB(0,255,0)
text.Parent = bill

end

-- TELEPORT ITEM

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

createESP(obj)

end

-- LIST CREATOR

local function createList(list)

for _,v in pairs(teleportFrame:GetChildren()) do
if v.Name == "itemButton" then
v:Destroy()
end
end

local y = 50

for _,itemName in pairs(list) do

local btn = Instance.new("TextButton")
btn.Name = "itemButton"
btn.Size = UDim2.new(0.9,0,0,35)
btn.Position = UDim2.new(0.05,0,0,y)
btn.Text = itemName
btn.BackgroundColor3 = Color3.fromRGB(55,55,55)
btn.TextColor3 = Color3.new(1,1,1)
btn.Parent = teleportFrame

y = y + 40

btn.MouseButton1Click:Connect(function()

for _,obj in pairs(workspace:GetDescendants()) do
if obj.Name == itemName then
teleportItem(obj)
end
end

end)

end

end

-- CATEGORY BUTTONS

local foodBtn = Instance.new("TextButton")
foodBtn.Size = UDim2.new(0.22,0,0,35)
foodBtn.Position = UDim2.new(0.02,0,0,5)
foodBtn.Text = "Food"
foodBtn.Parent = teleportFrame

foodBtn.MouseButton1Click:Connect(function()
createList(foods)
end)

local weaponBtn = foodBtn:Clone()
weaponBtn.Text = "Weapons"
weaponBtn.Position = UDim2.new(0.26,0,0,5)
weaponBtn.Parent = teleportFrame

weaponBtn.MouseButton1Click:Connect(function()
createList(weapons)
end)

local armorBtn = foodBtn:Clone()
armorBtn.Text = "Armor"
armorBtn.Position = UDim2.new(0.50,0,0,5)
armorBtn.Parent = teleportFrame

armorBtn.MouseButton1Click:Connect(function()
createList(armors)
end)

local resBtn = foodBtn:Clone()
resBtn.Text = "Resources"
resBtn.Position = UDim2.new(0.74,0,0,5)
resBtn.Parent = teleportFrame

resBtn.MouseButton1Click:Connect(function()
createList(resources)
end)

-- PLAYER SETTINGS

local function setting(name,pos,callback)

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0.4,0,0,30)
label.Position = pos
label.Text = name
label.BackgroundTransparency = 1
label.TextColor3 = Color3.new(1,1,1)
label.Parent = playerFrame

local box = Instance.new("TextBox")
box.Size = UDim2.new(0.4,0,0,30)
box.Position = pos + UDim2.new(0.45,0,0,0)
box.Parent = playerFrame

box.FocusLost:Connect(function()
local num = tonumber(box.Text)
if num then
callback(num)
end
end)

end

setting("WalkSpeed",UDim2.new(0.05,0,0.1,0),function(v)
humanoid.WalkSpeed = v
end)

setting("JumpPower",UDim2.new(0.05,0,0.25,0),function(v)
humanoid.JumpPower = v
end)

setting("Gravity",UDim2.new(0.05,0,0.4,0),function(v)
workspace.Gravity = v
end)
