local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local roleFolder = ReplicatedStorage:WaitForChild("Scripts"):WaitForChild("Modules"):WaitForChild("roles")

local function displayRoleName()
    for _, player in ipairs(Players:GetPlayers()) do
        local roleModule = roleFolder:FindFirstChild(player.Name)
        if roleModule then
            local role = require(roleModule)
            local roleLabel = Instance.new("TextLabel")
            roleLabel.Text = role
            roleLabel.Size = UDim2.new(0, 100, 0, 20)
            roleLabel.Position = UDim2.new(0, 0, 0, -30)
            roleLabel.TextColor3 = Color3.new(1, 1, 1)
            roleLabel.BackgroundTransparency = 1
            roleLabel.Font = Enum.Font.SourceSansBold
            roleLabel.Parent = player.Character.Head
        end
    end
end

displayRoleName()
