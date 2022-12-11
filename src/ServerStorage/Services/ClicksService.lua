local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local DataStoreService = game:GetService("DataStoreService")
local ClicksDataStore = DataStoreService:GetDataStore("clicksStore")

local ClicksService = Knit.CreateService {
    Name = "ClicksService",
}

-- Variables

ClicksService.AllPlayersClicks = {}

-- Server Functions

function ClicksService:GetClicks(player)
    local clicks = ClicksDataStore:GetAsync(player.UserId)
    if not clicks then
        clicks = 0
        ClicksDataStore:SetAsync(player.UserId, clicks)
    end
    return clicks
end

function ClicksService:GiveClicks(player, amount)
    local clicks = self:GetClicks(player)
    clicks += amount
    ClicksDataStore:SetAsync(player.UserId, clicks)
    self.AllPlayersClicks[player.UserId] = clicks -- Store clicks for leaderboard
end



-- Client Functions

function ClicksService.Client:GetClicks(player)
    -- Just use the same function, no point in writing it again lol
    return self.Server:GetClicks(player)
end