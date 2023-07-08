local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RolesSequenceMap = ReplicatedStorage:WaitForChild("RolesSequenceMap")

for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
    local roleFolder = RolesSequenceMap:FindFirstChild(player.Name)
    if roleFolder then
        for _, role in ipairs(roleFolder:GetChildren()) do
            local roleName = role.Name
            if roleName == "Innocent" or roleName == "Mafia" or roleName == "Detective" or roleName == "Doctor" then
                print(player.Name .. "'s role: " .. roleName)
            end
        end
    end
end
