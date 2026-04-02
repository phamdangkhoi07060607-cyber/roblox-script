local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

local UIS = game:GetService("UserInputService")

local running = true

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

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.V then
        running = not running
    end
end)

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
