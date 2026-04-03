local function addBillboard(part)
	if part:IsA("BasePart") then
		
		local billboard = Instance.new("BillboardGui")
		billboard.Size = UDim2.new(0,200,0,50)
		billboard.StudsOffset = Vector3.new(0,3,0)
		billboard.AlwaysOnTop = true
		billboard.Parent = part
		
		local text = Instance.new("TextLabel")
		text.Size = UDim2.new(1,0,1,0)
		text.BackgroundTransparency = 1
		text.Text = part.Name
		text.TextColor3 = Color3.fromRGB(255,255,255)
		text.TextStrokeTransparency = 0
		text.TextScaled = true
		text.Parent = billboard
		
	end
end

-- thêm cho tất cả part đã có
for _,v in pairs(workspace:GetDescendants()) do
	addBillboard(v)
end

-- khi có part mới spawn
workspace.DescendantAdded:Connect(addBillboard)
