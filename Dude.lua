-- made by KY#6446
function sendmsg(msg)
game.StarterGui:SetCore("ChatMakeSystemMessage", {
Text = msg;
})
end 
local rolesandcolors = {
    ["Mafia"] = Color3.fromRGB(255,0,0), 
    ["Vampire"] = Color3.fromRGB(0,255,0),
    ["Coven"] = Color3.fromRGB(255,255,0),
    ["Werewolf"] = Color3.fromRGB(64,64,64),
    ['Bodyguard'] = Color3.fromRGB(0,0,255),
    ['Medic'] = Color3.fromRGB(0,0,255),
    ['Guardian'] = Color3.fromRGB(0,0,255),
    ['Vigilante'] = Color3.fromRGB(0,0,255),
    ['Liberator'] = Color3.fromRGB(0,0,255),
    ['Veteran'] = Color3.fromRGB(0,0,255),
    ['Bounty Hunter'] = Color3.fromRGB(0,0,255),
	['Lookout'] = Color3.fromRGB(0, 0, 255)
	['Jailor'] = Color3.fromRGB(0, 0, 255)
	['Enforcer'] = Color3.fromRGB(0, 0, 255)
	['Distractor'] = Color3.fromRGB(0, 0, 255)
	['Medium'] = Color3.fromRGB(0, 0, 255)
	['Retributionist'] = Color3.fromRGB(0, 0, 255)
	['Trapper'] = Color3.fromRGB(0, 0, 255)
}
local gunsandroles = {
    ["Shield"] = "Bodyguard",
    ["Knife"] = "Killer",
    ["GuardianSword"] = "Guardian",
    ["Revolver"] = "Vigilante",
    ["Katana"] = "Assassin",
    ["ShieldK"] = "Liberator",
    ["Medkit"] = "Medic",
    ["Pistol"] = "Veteran",
    ["Winchester"] = "Bounty Hunter",
}

function bypac()
local ACRemote = game:GetService("ReplicatedStorage").Remotes.FinishAudio
local ACBypass
ACBypass = hookmetamethod(game, "__namecall", function(...)
    local method = getnamecallmethod();
    local args = ...;

    if not checkcaller() then
        if typeof(self) == "Instance" and self == ACRemote and method == "FireServer" then
            return wait(9e9);
        end
    end

    return ACBypass(...)
end)
end
sendmsg("BOXTON CLI")
sendmsg("[CLI] Bypassing anticheat")
wait(1)
bypac()
wait()
sendmsg("[CLI] Anticheat bypassed!")
wait()
sendmsg("[CLI] Snooping for roles..")

for i, v in pairs(game:GetService("Workspace").Game:GetChildren()) do
  local folder = v.Name
  v.ChildAdded:Connect(function(p)
    local plr = game.Players:FindFirstChild(p.Name)
    if not plr:GetAttribute("NSXFA") then
      plr:SetAttribute("NSXFA", folder)
      sendmsg('[' .. plr:GetAttribute("NSXFA") .. "] (" .. plr.PlayerData.DisplayName.Value .. ")[" .. plr.PlayerData.Number.Value .. "] has been exposed \n")
    end
  end)
end


game.Players.DescendantAdded:Connect(function(t)
    if t:IsA("Tool") then
        local plr = t.Parent.Parent
        local tool = t
        if not game.Players:FindFirstChild(t.Parent.Parent.Name):GetAttribute("NSXFA") then 
        if gunsandroles[t.Name] ~= nil then
             plr:SetAttribute("NSXFA",gunsandroles[t.Name])  
         end 
          
            wait()
        sendmsg("[" .. 
            (plr:GetAttribute("NSXFA") or "Unknown") .. 
            "] (" .. plr.PlayerData.DisplayName.Value .. ")[" .. plr.PlayerData.Number.Value  ..  "] was found with " .. tool.Name .. '\n')
        end 
    end 
end)
for i,plr in pairs(game.Players:GetChildren()) do 
local v = plr
if plr:GetAttribute("NSXFA") then 
       sendmsg('[' .. 
            plr:GetAttribute("NSXFA") ..
            "] (" .. plr.PlayerData.DisplayName.Value  .. ")[" .. plr.PlayerData.Number.Value  ..  "] has been exposed \n")
end 
  spawn(function()
      while wait() do 
          local charr = v.Character or v.CharacterAdded:Wait()

local oh = charr:FindFirstChild("Overhead",true)
if oh then 
    oh.AlwaysOnTop = true
    if v == game.Players.LocalPlayer then 
        oh.PlayerName.Text = '[' .. plr.PlayerData.Number.Value .. '] ' .. plr.PlayerData.DisplayName.Value
        oh.PlayerName.TextColor3 = Color3.fromRGB(255,80,192)
    elseif v:GetAttribute("NSXFA")~= nil and  rolesandcolors[v:GetAttribute("NSXFA")] ~= nil then 
        oh.PlayerName.Text = '[' .. plr.PlayerData.Number.Value .. '] ' .. plr.PlayerData.DisplayName.Value
        oh.PlayerName.TextColor3 = rolesandcolors[v:GetAttribute("NSXFA")]
    else
         oh.PlayerName.Text = '[' .. plr.PlayerData.Number.Value .. '] ' .. plr.PlayerData.DisplayName.Value
        oh.PlayerName.TextColor3 = Color3.fromRGB(255,255,255)
    end 
end 
          end 
      end)
end
