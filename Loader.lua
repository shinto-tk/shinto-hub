repeat task.wait() until game.GameId ~= 0
if Shinto and Shinto.Loaded then
    Shinto.Utilities.UI:Notification({
        Title = "Shinto Hub",
        Description = "Script already executed!",
        Duration = 5
    }) return
end

local PlayerService = game:GetService("Players")
local LocalPlayer = PlayerService.LocalPlayer

local function GetSupportedGame() local Game
    for Id,Info in pairs(Shinto.Games) do
        if tostring(game.GameId) == Id then
            Game = Info break
        end
    end if not Game then
        Game = Shinto.Games.Universal
    end return Game
end

local function GetScript(Script)
    return Shinto.Debug and readfile("Shinto/" .. Script .. ".lua")
    or game:HttpGetAsync("https://raw.githubusercontent.com/shinto-tk/shinto-hub/main/" .. Script .. ".lua")
end

local function LoadScript(Script)
    return loadstring(Shinto.Debug and readfile("Shinto/" .. Script .. ".lua")
    or game:HttpGetAsync("https://raw.githubusercontent.com/shinto-tk/shinto-hub/main/" .. Script .. ".lua"))()
end

getgenv().Shinto = {
    Loaded = false,
    Debug = false,
    Utilities = {},
    Games = {
        ["Universal"] = {
            Name = "Universal",
            Script = "Universal"
        },
        ["1054526971"] = {
            Name = "Blackhawk Rescue Mission 5",
            Script = "Games/BRM5"
        },
        ["580765040"] = {
            Name = "RAGDOLL UNIVERSE",
            Script = "Games/RU"
        },
        ["1168263273"] = {
            Name = "Bad Business",
            Script = "Games/BB"
        },
        ["807930589"] = {
            Name = "The Wild West",
            Script = "Games/TWW"
        },
        ["187796008"] = {
            Name = "Those Who Remain",
            Script = "Games/TWR"
        },
        ["1586272220"] = {
            Name = "Steel Titans",
            Script = "Games/ST"
        },
        ["358276974"] = {
            Name = "Apocalypse Rising 2",
            Script = "Games/AR2"
        }
    }
}

Shinto.Utilities.Misc = LoadScript("Utilities/Misc")
Shinto.Utilities.UI = LoadScript("Utilities/UI")
Shinto.Utilities.Drawing = LoadScript("Utilities/Drawing")

LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started then
        local QueueOnTeleport = (syn and syn.queue_on_teleport) or queue_on_teleport
        QueueOnTeleport(GetScript("Loader"))
    end
end)

local SupportedGame = GetSupportedGame()
if SupportedGame then
    Shinto.Game = SupportedGame.Name
    LoadScript(SupportedGame.Script)
    Shinto.Utilities.UI:Notification({
        Title = "Shinto Hub",
        Description = Shinto.Game .. " loaded!",
        Duration = 5
    }) Shinto.Loaded = true
end
