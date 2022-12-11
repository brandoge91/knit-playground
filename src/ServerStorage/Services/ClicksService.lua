local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local DataStoreService = game:GetService("DataStoreService")
local ClicksDataStore = DataStoreService:GetDataStore("clicksStore")
local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local Signal = require(Knit.Util.Signal)

local ClicksService = Knit.CreateService {
    Name = "ClicksService",
    Client = {
        AddClicksPlease = Knit.CreateSignal(),
        Clicks = Knit.CreateProperty(0),
    }
    
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
    self.Client.Clicks:SetFor(player, clicks)
end

-- Client Functions

function ClicksService.Client:GetClicks(player)
    -- Just use the same function, no point in writing it again lol
    return self.Server:GetClicks(player)
end

-- Initialize the service
function ClicksService:KnitInit()

    local rng = Random.new()
    
    -- Give player random amount of points:
    self.Client.AddClicksPlease:Connect(function(player)
        local clicks = rng:NextInteger(0, 10)
        self:AddClicks(player, clicks)
        print("Gave " .. player.Name .. " " .. clicks .. " clicks`")
    end)

    -- Clean up data when player leaves:
    game:GetService("Players").PlayerRemoving:Connect(function(player)
        self.AllPlayersClicks[player] = nil
    end)

end


return ClicksService
