local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local Player = game:GetService("Players").LocalPlayer
Knit.Start():catch(warn)

local ClicksService = Knit.GetService("ClicksService")

ClicksService:GetClicks(Player):andThen(function(clicks)
    print(clicks)
end)
