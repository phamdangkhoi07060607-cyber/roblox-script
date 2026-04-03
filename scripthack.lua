-- Client ESP Part Name
for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("Part") then
        
        local billboard = Instance.new("BillboardGui")
        billboard.Parent = v
        billboard.Size = UDim2.new(0,100,0,40)
        billboard.StudsOffset = Vector3.new(0,2,0)
        billboard.AlwaysOnTop = true
        
        local text = Instance.new("TextLabel")
        text.Parent = billboard
        text.Size = UDim2.new(1,0,1,0)
        text.BackgroundTransparency = 1
        text.Text = v.Name
        text.TextColor3 = Color3.new(1,0,0)
        text.TextScaled = true
    end
end
