local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local ClicksService = require(game:GetService("ServerStorage").Source.Services.ClicksService)
local Players = game:GetService("Players")
Knit.Start():catch(warn)

Players.PlayerAdded:Connect(function(player)
    -- Get the clicks and create leaderstats, we will use signals to update the value
    local clicks = ClicksService:GetClicks(player)
    local leaderStats = Instance.new("Folder")
    leaderStats.Name = "leaderstats"
    leaderStats.Parent = player
    local clicksValue = Instance.new("IntValue")
    clicksValue.Name = "Clicks"
    clicksValue.Value = clicks
    clicksValue.Parent = leaderStats

    -- Clone the clicker tool from ReplicatedStorage/tools and give it to the player
    local clickerTool = game:GetService("ReplicatedStorage").Tools.Clicker:Clone()
    clickerTool.Parent = player.Backpack
end)
