local Config = {
    OutlineEnabled    = true,
    OutlineColor      = Color3.fromRGB(255, 0, 0),
    Names             = true,
    NamesColor        = Color3.fromRGB(255, 255, 255),
    NamesFont         = Enum.Font.SourceSans,
    NamesSize         = 10,
}

function CreateEsp(Player)
    local Line, Name = Drawing.new("Line"), Drawing.new("Text")
    
    local function IsVisible(part)
        local camera = workspace.CurrentCamera
        local viewVector = camera.CFrame.lookVector
        local partPos, isVisible = camera:WorldToViewportPoint(part.Position)
        local ray = Ray.new(camera.CFrame.p, (part.Position - camera.CFrame.p).unit * 3000)
        local part, position = workspace:FindPartOnRayWithIgnoreList(ray, {camera, Player.Character})
        if part then
            local _, pos = camera:WorldToViewportPoint(position)
            if (pos - partPos).magnitude < 5 then
                isVisible = true
            else
                isVisible = false
            end
        end
        return isVisible, partPos
    end
    
    local function DrawEsp()
        if Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character.Humanoid.Health > 0 and Player.Character:FindFirstChild("Head") then
            local isPlayerVisible, playerPosition = IsVisible(Player.Character.Head)
            if isPlayerVisible then
                local headPos = workspace.CurrentCamera:WorldToViewportPoint(Player.Character.Head.Position)
                local rootPos = workspace.CurrentCamera:WorldToViewportPoint(Player.Character.HumanoidRootPart.Position)
                local distance = (Vector2.new(headPos.X, headPos.Y) - Vector2.new(rootPos.X, rootPos.Y)).magnitude
                
                if Config.OutlineEnabled then
                    Line.Visible = true
                    Line.From = Vector2.new(rootPos.X, rootPos.Y)
                    Line.To = Vector2.new(headPos.X, headPos.Y)
                    Line.Color = Config.OutlineColor
                    Line.Thickness = 1
                    Line.Transparency = 1
                    Line.Visible = true
                else
                    Line.Visible = false
                end
                
                if Config.Names then
                    Name.Visible = true
                    Name.Position = Vector2.new(rootPos.X, headPos.Y)
                    Name.Color = Config.NamesColor
                    Name.Center = true
                    Name.Outline = true
                    Name.OutlineColor = Color3.new(0, 0, 0)
                    Name.Font = Config.NamesFont
                    Name.Size = Config.NamesSize
                    Name.Text = Player.Name .. " (" .. math.floor((workspace.CurrentCamera.CFrame.p - Player.Character.HumanoidRootPart.Position).magnitude) .. "m)"
                else
                    Name.Visible = false
                end
            else
                Line.Visible = false
                Name.Visible = false
            end
        else
            Line.Visible = false
            Name.Visible = false
        end
    end
    
    game:GetService("RunService").RenderStepped:Connect(DrawEsp)
end

for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
    if v ~= game:GetService("Players").LocalPlayer then
        CreateEsp(v)
        v.CharacterAdded:Connect(function()
            wait(1)
            if v.Character then
                CreateEsp(v)
            end
        end)
    end
end

game:GetService("Players").PlayerAdded:Connect(function(v)
    if v ~= game:GetService("Players").LocalPlayer then
        v.CharacterAdded:Connect(function()
            wait(1)
            if v.Character then
                CreateEsp(v)
            end
        end)
    end
end)

return Config
