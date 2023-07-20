-- Made by rang#2415 or https://v3rmillion.net/member.php?action=profile&uid=1906262

local Config = {
    Box               = true,
    BoxOutline        = true,
    BoxColor          = Color3.fromRGB(255, 255, 255),
    BoxOutlineColor   = Color3.fromRGB(0, 0, 0),
    Names             = true, -- Set this to true to show display names instead of usernames
    NamesOutline      = false,
    NamesColor        = Color3.fromRGB(255, 255, 255),
    NamesOutlineColor = Color3.fromRGB(0, 0, 0),
    NamesFont         = 2, -- 0, 1, 2, 3
    NamesSize         = 13
}

function CreateEsp(Player)
    local Box, BoxOutline, Name = Drawing.new("Square"), Drawing.new("Square"), Drawing.new("Text")

    local function RemoveEsp()
        Box:Remove()
        BoxOutline:Remove()
        Name:Remove()
    end

    local debounce = false
    local function UpdateEsp()
        if debounce then
            return
        end

        debounce = true

        if Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health > 0 and Player.Character:FindFirstChild("Head") then
            local Target2dPosition, IsVisible = workspace.CurrentCamera:WorldToViewportPoint(Player.Character.HumanoidRootPart.Position)
            local scale_factor = 1 / (Target2dPosition.Z * math.tan(math.rad(workspace.CurrentCamera.FieldOfView * 0.5)) * 2) * 100
            local width, height = math.floor(40 * scale_factor), math.floor(60 * scale_factor)

            if Config.Box then
                Box.Visible = IsVisible
                Box.Color = Config.BoxColor
                Box.Size = Vector2.new(width, height)
                Box.Position = Vector2.new(Target2dPosition.X - Box.Size.X / 2, Target2dPosition.Y - Box.Size.Y / 2)
                Box.Thickness = 1
                Box.ZIndex = 1
            else
                Box.Visible = false
            end

            if Config.BoxOutline then
                BoxOutline.Visible = IsVisible
                BoxOutline.Color = Config.BoxOutlineColor
                BoxOutline.Size = Vector2.new(width, height)
                BoxOutline.Position = Vector2.new(Target2dPosition.X - Box.Size.X / 2, Target2dPosition.Y - Box.Size.Y / 2)
                BoxOutline.Thickness = 3
                BoxOutline.ZIndex = 1
            else
                BoxOutline.Visible = false
            end

            if Config.Names then
                Name.Visible = IsVisible
                Name.Color = Config.NamesColor
                Name.Text = Player.DisplayName .. " " .. math.floor((workspace.CurrentCamera.CFrame.p - Player.Character.HumanoidRootPart.Position).magnitude) .. "m"
                Name.Center = true
                Name.Outline = Config.NamesOutline
                Name.OutlineColor = Config.NamesOutlineColor
                local yOffset = math.clamp(-15 + 0.1 * (100 / (Target2dPosition.Z + 0.1)), -30, -15)
                Name.Position = Vector2.new(Target2dPosition.X, Target2dPosition.Y - height * 0.5 + yOffset)
                Name.Font = Config.NamesFont
                Name.Size = Config.NamesSize
            else
                Name.Visible = false
            end
        else
            RemoveEsp()
            debounce = false
            return
        end

        debounce = false
    end

    local function CharacterAddedHandler()
        if Player.Character then
            UpdateEsp()
        end
    end

    Player.CharacterAdded:Connect(CharacterAddedHandler)
    Player.CharacterRemoving:Connect(RemoveEsp)
end

for _, v in pairs(game:GetService("Players"):GetPlayers()) do
    if v ~= game:GetService("Players").LocalPlayer then
        CreateEsp(v)
    end
end

game:GetService("Players").PlayerAdded:Connect(function(v)
    if v ~= game:GetService("Players").LocalPlayer then
        CreateEsp(v)
    end
end)

return Config
