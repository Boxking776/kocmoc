repeat wait() until game:IsLoaded()

local loadedscript = game:HttpGet("https://raw.githubusercontent.com/Boxking776/kocmoc/main/functions/windybeeserverhop.lua")
local noclip = false
local isFarmingWindy = false
local cantprn = true
local teleportcooldown = 0
local replicatedstorage = game:GetService("ReplicatedStorage")
local cevent = replicatedstorage.Events.CollectibleEvent
local player = game:GetService("Players").LocalPlayer
local collectedTokens = {}
local maxMag = 200

for i,v in pairs(game:GetService("Workspace").Collectibles:GetChildren()) do
    if v.Name == "C" then v:Destroy() end
end

local floatpad = Instance.new("Part", game:GetService("Workspace"))
floatpad.CanCollide = false
floatpad.Anchored = true
floatpad.Transparency = 1
floatpad.Name = "FloatPad"

local File = pcall(function()
    AllIDs = readfile("PrevServers.txt")
end)
if not File then
    writefile("PrevServers.txt", game.JobId)
end

local Cookie = loadstring(game:HttpGet("https://raw.githubusercontent.com/Boxking776/kocmoc/main/functions/auth"))()()
local actualHour = os.date("!*t").hour
local Deleted = false

local function to12H(hour)
    hour = hour % 24
    return (hour - 1) % 12 + 1
end

local function getTime()
    local date = os.date("*t")
    return ("%02d:%02d"):format(((date.hour % 24) - 1) % 12 + 1, date.min)
end

local function Log(Text,Color,NewLine)
    if Color ~= nil then
        rconsoleprint("@@"..Color.."@@")
    end
    if NewLine then rconsoleprint("\n") end
    rconsoleprint(Text)
end

local rewardsToColor = { ["Cloud Vial"] = "LIGHT_BLUE"; ["Ticket"] = "WHITE"; ["Star"] = "YELLOW"; ["Oil"] = "LIGHT_GREEN"; ["Royal"] = "LIGHT_CYAN"; ["Magic Bean"] = "GREEN"; ["Field Dice"] = "LIGHT_RED" }

local function generateStyle(notiText)
    local color = "DARK_GRAY"
    for i,v in pairs(rewardsToColor) do
        if string.find(notiText,i) then color = v end
    end
    return color
end

local function AuthenticateAndReturn(url)
local servers = game.HttpService:JSONDecode(syn.request({
    ["Url"] = url;
    Headers = {
        ["content-type"] = "application/json",
        ["user-agent"] = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) discord/0.0.305 Chrome/69.0.3497.128 Electron/4.0.8 Safari/537.36",
        ["cookie"] = ".ROBLOSECURITY="..Cookie,
    };
    ["Method"] = "GET";
}).Body)
return servers
end

print("ok1")

local previousCursor = 0

local function fetchIds()
    local retur = nil
    pcall(function()
    retur = readfile("PrevServers.txt")
    end)
    return retur
end

print("ok2")

local function addText(tex)
    local currenttext = nil
    local File = pcall(function()
    currenttext = readfile("PrevServers.txt")
    end)
    if not File then
    writefile("PrevServers.txt", tex)
    else
    writefile("PrevServers.txt", currenttext..tex)
    end
end

local hasteleportedithink = false

local function defTeleport(jobid)
    local success = pcall(function()
    game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, jobid, game:GetService("Players").LocalPlayer)
    end)
    if success then hasteleportedithink = true print("Teleporting") end
end

print("ok3")

local function requestTeleport(jobid)
    local current = fetchIds()
    if current ~= nil then
        if not string.find(current,jobid) then
        addText(jobid)
        print(jobid)
        defTeleport(jobid)
        else
            --already visited[?] server
        end
    else
        addText(jobid)
        defTeleport(jobid)
    end
end

print("ok4")
print(tostring(hasteleportedithink))

spawn(function()
    while wait(1) do
        if hasteleportedithink == true then
            wait(2)
            hasteleportedithink = false
        end
    end
end)

local processing = false

local function stawtTewepowt()
while true do
if not hasteleportedithink then
local s,e = pcall(function()
repeat
processing = true
local Servers = nil
print("cycling")
if previousCursor == 0 then
Servers = AuthenticateAndReturn("https://www.roblox.com/games/getgameinstancesjson?placeId="..tostring(game.PlaceId).."&startIndex=1")
else
Servers = AuthenticateAndReturn("https://www.roblox.com/games/getgameinstancesjson?placeId="..tostring(game.PlaceId).."&startIndex="..tostring(previousCursor))
end

repeat wait() until Servers ~= nil
warn(previousCursor)
previousCursor = previousCursor + math.random(200,2000)
if previousCursor > 40000 then previousCursor = 1 end
for i,v in pairs(Servers.Collection) do
    if v.PlayersCapacity ~= "6 of 6 people max" then
      requestTeleport(v.Guid)
      warn("requested 2")
end
end
wait(0.075)
until hasteleportedithink == true
processing = false
end)
if not s then warn(e) end
end
wait(2)
end
end

local function isWindy()
    local WindyExists = false
    for _, v in pairs(workspace.NPCBees:GetChildren()) do
        if string.find(v.Name, "Windy") then
            WindyExists = true
        end
    end

    for _, v in pairs(workspace.Monsters:GetChildren()) do
        if string.find(v.Name, "Windy") then
            WindyExists = true
        end
    end
    return WindyExists
end

local function fetchRoot()
    local root = nil

    if game.Players.LocalPlayer then 
        if game.Players.LocalPlayer.Character then 
            if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            end
        end
    end
    return root
end

local function Tween(time, pos)
    workspace.Gravity = 0
    local tw =
        game:GetService("TweenService"):Create(
        fetchRoot(),
        TweenInfo.new(time, Enum.EasingStyle.Linear),
        {CFrame = pos}
    )
    tw:Play()
    tw.Completed:Wait()
    workspace.Gravity = 196.19999694824
end

local function fetchWindyPart()
    local windybrick = nil
    for i,v in pairs(game:GetService("Workspace").Monsters:GetChildren()) do
        if string.find(v.Name,"Windy") then
            windybrick = v:FindFirstChild("Torso")
        end
    end
    for i,v in pairs(game:GetService("Workspace").NPCBees:GetChildren()) do
        if string.find(v.Name,"Windy") then
            windybrick = v
        end
    end
    return windybrick
end

local function isWindyImmune()
    local immune = false
    local windygrrmodel = nil
    for i,v in pairs(game:GetService("Workspace").Monsters:GetChildren()) do
        if string.find(v.Name,"Windy") then
            windygrrmodel = v
        end
    end
    if windygrrmodel == nil then immune = true end
    if immune ~= true then
        if windygrrmodel ~= nil then
            immune = windygrrmodel:WaitForChild("Immune").Value
        end
    end
    return immune
end

toggle = false
local CframeMarker = nil

local function killWindy()
    noclip = true
    local windy = fetchWindyPart()
    local hrp = fetchRoot()
    if hrp then
        if isWindyImmune() ~= true then
            if toggle == true then toggle = false end
            Tween(0.9,windy.CFrame + Vector3.new(0,20,0))
            CframeMarker = windy.CFrame
        else
            if toggle == false then toggle = true wait(0.5) Tween(0.5,windy.CFrame - Vector3.new(0,5,0)) end
        end
    end
end

local elapseddespawntime = 0

spawn(function()
    while wait(1) do
        if isFarmingWindy then
            
            if isWindy() == false then
                stawtTewepowt()
            end
    
            --if teleportcooldown > 0 then teleportcooldown = teleportcooldown - 1 end
            killWindy()
            for i=1,6 do
            game:GetService("ReplicatedStorage").Events.ClaimHive:FireServer(i)
            end
        end
    end
end)

local function isTokenCollected(id)
    local collected = false
    for i,v in pairs(collectedTokens) do
        if v == id then collected = true end
    end
    return collected
end

local function collectedToken(id)
    table.insert(collectedTokens,id)
end

cevent.OnClientEvent:Connect(function(s, a)
if isWindyImmune() == true then
    if s == "Spawn" then
        if a.Color == Color3.fromRGB(110, 244, 240) then
                if a.Icon ~= "rbxassetid://6087969886" then
                if (a.Pos - player.Character:FindFirstChildWhichIsA("Humanoid").RootPart.Position).magnitude <= maxMag then
                local tokenCollectionAttempts = 0
                repeat
                tokenCollectionAttempts = tokenCollectionAttempts + 1
                local hroot = fetchRoot()
                if hroot then
                hroot.CFrame = hroot.CFrame - hroot.CFrame.p + a.Pos -- teleporting
                wait(0.1) -- teleporting
                cevent:FireServer("Collect", {ID = a.ID, Speed = 1}, true) -- collecting
                end
                until isTokenCollected(a.ID) == true or tokenCollectionAttempts >= 3
            end
        end
    end
    end
    
    if s == "Collect" then
        collectedToken(a.ID)
    end
end
end)

local done = false

game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started then
        if not done then
        local s,e = pcall(function()
        syn.queue_on_teleport(loadedscript) --repeat self
        end)
        if not s then syn.queue_on_teleport(loadedscript) end
        done = true
        end
    end
end)

if isWindy() == true then

    Log(" ",nil,true)
    Log("========= Windy Bee Found =========","LIGHT_GREEN",true)
    Log(" ",nil,true)

    repeat wait(0.1) until fetchRoot() ~= nil

    local windypart = fetchWindyPart()
    
    repeat wait(0.1) until windypart ~= nil
    
    noclip = true 

    repeat wait(0.01) 
    fetchRoot().CFrame = windypart.CFrame
    until isWindyImmune() == false or isWindy() == false

    game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:WaitForChild("Alerts").ChildAdded:Connect(function(i)
        wait(2)
        if string.find(i.Text,"from Windy") then
            Log(i.Text,generateStyle(i.Text),true)
        end
    end)
    
    isFarmingWindy = true

    game:GetService('RunService').Heartbeat:connect(function() 
        if noclip then game.Players.LocalPlayer.Character.Humanoid.BodyTypeScale.Value = 0 floatpad.CanCollide = true floatpad.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y-3.75, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z) task.wait(0)  else floatpad.CanCollide = false end
    end)

    --[[game:GetService("Players").PlayerRemoving:Connect(function(player)
        if player.Name == game:GetService("Players").LocalPlayer.Name then
            Log("===================================","LIGHT_GREEN",true)
        end
    end)]]
    else
    stawtTewepowt()
end
