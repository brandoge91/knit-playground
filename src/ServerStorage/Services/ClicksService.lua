local Knit = require(game:GetService("ReplicatedStorage").Knit)
local DataStoreService = game:GetService("DataStoreService")
local ClicksDataStore = DataStoreService:GetDataStore("clicksStore")

local ClicksService = Knit.CreateService {
    Name = "ClicksService",
}

function ClicksService:GetClicks(player)
    local clicks = ClicksDataStore:GetAsync(player.UserId)
    return clicks
end

function ClicksService:GiveClicks(player, amount)
    local clicks = self:GetClicks(player)
    clicks += amount
    ClicksDataStore:SetAsync(player.UserId, clicks)
end