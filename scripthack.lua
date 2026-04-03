local ignoreNames = {
    Part = true,
    Grass = true,
    Trunk = true
}

function createESP(v)
    if not v:IsA("BasePart") then return end
    if ignoreNames[v.Name] then return end
    if v:FindFirstChild("PartESP") then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PartESP"
    billboard.Adornee = v
    billboard.Parent = v
    billboard.Size = UDim2.new(0,100,0,40)
    billboard.StudsOffset = Vector3.new(0,2,0)
    billboard.AlwaysOnTop = true

    local text = Instance.new("TextLabel")
    text.Parent = billboard
    text.Size = UDim2.new(1,0,1,0)
    text.BackgroundTransparency = 1
    text.Text = v.Name
    text.TextColor3 = Color3.fromRGB(255,0,0)
    text.TextScaled = true
end

-- ESP cho part đã có
for _,v in pairs(workspace:GetDescendants()) do
    createESP(v)
end

-- ESP cho part mới spawn
workspace.DescendantAdded:Connect(function(v)
    createESP(v)
end)
