repeat wait() until game:IsLoaded()

local floatpad = Instance.new("Part", game:GetService("Workspace"))
floatpad.CanCollide = false
floatpad.Anchored = true
floatpad.Transparency = 1
floatpad.Name = "FloatPad"

local loadedscript = game:HttpGet("https://raw.githubusercontent.com/Boxking776/kocmoc/main/functions/viciousbeeserverhop.lua")

noclip = false
local farmVici = false

local function Tween(time, pos)
    noclip = true
    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end

local ccccount = 0

local function killViciousBeeFunc()
    for _, v in pairs(workspace.Particles:GetChildren()) do
        if string.find(v.Name, "Waiting Thorn") then
            pcall(function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            end)
        end
    end
    for _, v in pairs(workspace.Monsters:GetChildren()) do
        if string.find(v.Name, "Vici") then
                ccccount = ccccount + 1
                if ccccount == 5 then
                    cccccount = 0
                    Tween(0.5,v.Torso.CFrame - Vector3.new(0, 10, 0))
                else
                Tween(0.5,v.Torso.CFrame + Vector3.new(0, 13, 0))
                end
            vici = true
        end
    end
end

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

local function isVici()
    local boo = false
        for _, v in pairs(workspace.Particles:GetDescendants()) do
        if string.find(v.Name, "Thorn") then
            boo = true
        end
    end
    for _, v in pairs(workspace.Monsters:GetChildren()) do
        if string.find(v.Name, "Vici") then
            boo = true
        end
    end
return boo
end

spawn(function()
while wait(0.2) do
    if farmVici then
        killViciousBeeFunc()
            for i=1,6 do
        game:GetService("ReplicatedStorage").Events.ClaimHive:FireServer(i)
    end
    end
end
end)

local function FarmViciousBee()
    local s,e = pcall(function()
    local obj2tp = nil
    for _, v in pairs(workspace.Particles:GetDescendants()) do
        if string.find(v.Name, "Thorn") then
            if v:IsA("Part") then
            boo = true
            end
        end
    end
    for _, v in pairs(workspace.Monsters:GetChildren()) do
        if string.find(v.Name, "Vici") then
            obj2tp = v.Torso
        end
    end
    pcall(function()
    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = obj2tp.CFrame
    end)
    repeat farmVici = true wait(1) until isVici() == false
    farmVici = false
    end)
    if not s then Log("/n"..e) end
end

wait(0.5)

game:GetService('RunService').Heartbeat:connect(function() 
    if noclip then game.Players.LocalPlayer.Character.Humanoid.BodyTypeScale.Value = 0 floatpad.CanCollide = true floatpad.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y-3.75, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z) task.wait(0)  else floatpad.CanCollide = false end
end)

local function Log(Text,Color,NewLine)
    if Color ~= nil then
        rconsoleprint("@@"..Color.."@@")
    end
    if NewLine then rconsoleprint("\n") end
    rconsolename("Kocmoc Serverhopper")
    rconsoleprint(Text)
end

local rewardsToColor = { ["Stinger"] = "LIGHT_CYAN"; ["Honey"] = "YELLOW"; ["Left"] = "RED"; }

local function generateStyle(notiText)
    local color = "DARK_GRAY"
    for i,v in pairs(rewardsToColor) do
        if string.find(notiText,i) then color = v end
    end
    return color
end

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

local lootnum = 0

local succ,err = pcall(function()
if isVici() then
    repeat wait() until workspace:FindFirstChild(game:GetService("Players").LocalPlayer.Name):FindFirstChild("HumanoidRootPart")
    wait(1)
    Log(" ",nil,true)
    Log("========= Vicious Bee Found =========","LIGHT_GREEN",true)
    Log(" ",nil,true)
    game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:WaitForChild("Alerts").ChildAdded:Connect(function(i)
        wait(0.5)
        if string.find(i.Text,"from Vic") then
            lootnum = lootnum + 1
            Log(i.Text,generateStyle(i.Text),true)
        end
    end)
    game:GetService("Players").PlayerRemoving:Connect(function(plr)
        if plr.Name == game:GetService("Players").LocalPlayer.Name then
            if lootnum == 0 then
                Log("Vicious Bee Despawned","RED",true) 
            end
        end
    end)
    FarmViciousBee()
    wait(0.5)
    stawtTewepowt()
    else
    stawtTewepowt()
end
end)

if not succ then stawtTewepowt() Log("Vicious Bee Despawned","RED",true) end repeat wait() until game:IsLoaded()
