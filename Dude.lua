-- Made by rang#2415 or https://v3rmillion.net/member.php?action=profile&uid=1906262

local Config = {
    -- ... (keep the rest of your configuration settings)
    Names = true, -- Set this to true to show display names instead of usernames
}

function CreateEsp(Player)
    local Box, BoxOutline, Name, HealthBar, HealthBarOutline = Drawing.new("Square"), Drawing.new("Square"), Drawing.new("Text"), Drawing.new("Square"), Drawing.new("Square")
    local Updater = game:GetService("RunService").RenderStepped:Connect(function()
        if Player.Character ~= nil and Player.Character:FindFirstChild("Humanoid") ~= nil and Player.Character:FindFirstChild("HumanoidRootPart") ~= nil and Player.Character.Humanoid.Health > 0 and Player.Character:FindFirstChild("Head") ~= nil then
            local Target2dPosition, IsVisible = workspace.CurrentCamera:WorldToViewportPoint(Player.Character.HumanoidRootPart.Position)
            local scale_factor = 1 / (Target2dPosition.Z * math.tan(math.rad(workspace.CurrentCamera.FieldOfView * 0.5)) * 2) * 100
            local width, height = math.floor(40 * scale_factor), math.floor(60 * scale_factor)
            if Config.Box then
                -- ... (keep the rest of your Box drawing code)
            else
                Box.Visible = false
                BoxOutline.Visible = false
            end
            if Config.Names then
                Name.Visible = IsVisible
                Name.Color = Config.NamesColor
                Name.Text = Player.DisplayName .. " " .. math.floor((workspace.CurrentCamera.CFrame.p - Player.Character.HumanoidRootPart.Position).magnitude) .. "m"
                Name.Center = true
                Name.Outline = Config.NamesOutline
                Name.OutlineColor = Config.NamesOutlineColor
                -- Adjust the vertical position of the name based on distance from camera
                local yOffset = math.clamp(-15 + 0.1 * (100 / (Target2dPosition.Z + 0.1)), -30, -15)
                Name.Position = Vector2.new(Target2dPosition.X, Target2dPosition.Y - height * 0.5 + yOffset)
                Name.Font = Config.NamesFont
                Name.Size = Config.NamesSize
            else
                Name.Visible = false
            end
            -- ... (keep the rest of your HealthBar drawing code)
        else
            -- ... (keep the rest of your visibility handling code)
        end
    end)
end

for _, v in pairs(game:GetService("Players"):GetPlayers()) do
    if v ~= game:GetService("Players").LocalPlayer then
        CreateEsp(v)
        v.CharacterAdded:Connect(function()
            CreateEsp(v)
        end)
    end
end

game:GetService("Players").PlayerAdded:Connect(function(v)
    if v ~= game:GetService("Players").LocalPlayer then
        CreateEsp(v)
        v.CharacterAdded:Connect(function()
            CreateEsp(v)
        end)
    end
end)

return Config
