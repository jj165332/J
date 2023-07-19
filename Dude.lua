local Config = {
    -- Your existing configuration here...
}

local PlayerNames = {}

function GetNonOverlappingYPosition(Target2dPosition, currentIndex)
    -- Your existing GetNonOverlappingYPosition function...
end

function CreateEsp(Player)
    -- Your existing CreateEsp function here...

    local NameOutline = Drawing.new("Text")

    local PlayerData = {
        Player = Player,
        NameOutline = NameOutline,
        -- Rest of your existing PlayerData...
    }

    table.insert(PlayerNames, PlayerData)

    local Updater = game:GetService("RunService").RenderStepped:Connect(function()
        -- Your existing update logic here...

        if Config.Names then
            -- Update the NameOutline position along with the display name
            NameOutline.Text = Player.DisplayName -- Set the text of the NameOutline to the player's display name
            NameOutline.Position = Vector2.new(Player.Character.Head.Position.X, Player.Character.Head.Position.Y) -- Set the position of the NameOutline

            -- Rest of your existing Name update logic...
        else
            NameOutline.Visible = false
            PlayerData.Visible = false
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
