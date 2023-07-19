local Config = {
    -- Your existing configuration here...
}

local PlayerNames = {}

function GetNonOverlappingYPosition(Target2dPosition, currentIndex)
    -- Your existing GetNonOverlappingYPosition function...
end

function CreateEsp(Player)
    -- Your existing CreateEsp function here...

    local BoxOutline, NameOutline = Drawing.new("Square"), Drawing.new("Text")

    local PlayerData = {
        Player = Player,
        BoxOutline = BoxOutline,
        NameOutline = NameOutline,
        -- Rest of your existing PlayerData...
    }

    table.insert(PlayerNames, PlayerData)

    local Updater = game:GetService("RunService").RenderStepped:Connect(function()
        -- Your existing update logic here...

        if Config.Names then
            -- Update the NameOutline position along with the display name
            NameOutline.Text = Player.DisplayName -- Set the text of the NameOutline to the player's display name
            NameOutline.Size = Config.TextSize -- Set the font size of the NameOutline
            NameOutline.Color = Config.TextColor -- Set the color of the NameOutline
            NameOutline.Position = Vector2.new(Player.Character.Head.Position.X, Player.Character.Head.Position.Y) -- Set the position of the NameOutline

            -- Rest of your existing Name update logic...
        else
            NameOutline.Visible = false
            PlayerData.Visible = false
        end

        if Config.Box then
            -- Update the BoxOutline position and size along with the box
            BoxOutline.Visible = IsVisible
            BoxOutline.Color = Config.BoxOutlineColor
            BoxOutline.Size = Vector2.new(width, height)
            BoxOutline.Position = Vector2.new(Target2dPosition.X - Box.Size.X / 2, Target2dPosition.Y - Box.Size.Y / 2)
            BoxOutline.Thickness = 2  -- Adjust the outline thickness as needed
            BoxOutline.Transparency = 1  -- Set outline transparency to 1 (fully visible)

            -- Rest of your existing Box update logic...
        else
            BoxOutline.Visible = false
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
