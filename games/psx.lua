-- API CALLS

if not isfolder("kocmoc") then makefolder("kocmoc") end
if isfile('kocmoc.txt') == false then (syn and syn.request or http_request)({ Url = "http://127.0.0.1:6463/rpc?v=1",Method = "POST",Headers = {["Content-Type"] = "application/json",["Origin"] = "https://discord.com"},Body = game:GetService("HttpService"):JSONEncode({cmd = "INVITE_BROWSER",args = {code = "kTNMzbxUuZ"},nonce = game:GetService("HttpService"):GenerateGUID(false)}),writefile('kocmoc.txt', "discord")})end

for _, v in pairs(game:GetService("CoreGui"):GetDescendants()) do
    if v:IsA("TextLabel") and string.find(v.Text,"Kocmoc v") then
        v.Parent.Parent:Destroy()
    end
end

getgenv().temptable = {
    version = "1.3.1",
}

getgenv().kocmoc = {
    toggles = {
    	["AntiAfk"]=false;
    	["AutoTP"]=false;
    	["AutoMakeGold"]=false;
    	["AutoMakeRainbow"]=false;
    	["AutoCollectLoot"]=false;
    	["AutoMerchant"]=false;
    	["AutoHatch"]=false;
    	["AutoTripleDamage"]=false;
    	["AutoTripleCoins"]=false;
    	["AutoSuperLucky"]=false;
    	["AutoUltraLucky"]=false;
    },
    vars = {
        
    }
}

--/--/--/--/--/--/--/ variables --/--/--/--/--/--/--/

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Boxking776/kocmoc/main/library.lua"))()
local api = loadstring(game:HttpGet("https://raw.githubusercontent.com/Boxking776/kocmoc/main/api.lua"))()
local defaultkocmoc = kocmoc
local WinConfig = { WindowName = "Kocmoc v"..temptable.version.." | Pet Simulator X", Color = Color3.fromRGB(164, 84, 255), Keybind = Enum.KeyCode.Semicolon}
local Window = library:CreateWindow(WinConfig, game:GetService("CoreGui"))
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player:WaitForCharacter()
local Humanoid = Character:WaitForChild("Humanoid")
local HumaoidRP = Character:WaitForChild("HumanoidRootPart")
local UIS = game:GetService("UserInputService")
local Mouse = Player:GetMouse()
local NotifEvent = game:GetService("ReplicatedStorage").Framework.Modules["2 | Network"]["admin cmds notification"]
local Popup = game:GetService("ReplicatedStorage").Framework.Modules["2 | Network"]["send message"];
local UIList = {
["Golden"] = "Golden Machine";
["Rainbow"] = "Rainbow Machine";
["FusePets"] = "Fusing";
["DarkMatter"] = "Dark Matter Machine";
["EnchantPets"] = "Enchant Pets";
["Merchant"] = "Merchant Shop";
["Inventory"] = nil;
["Trading"] = "Trade Manager";
["TwitterCodes"] = "Codes";
["Upgrades"] = "Upgrade Dashboard";
["Teleport"] = "Teleports";
["Achievements"] = nil;
["Collection"] = "Pet Collection";
["Settings"] = "Game Settings"
}
local RainbowMachineInfo = game:GetService("Workspace")["__THINGS"]["__REMOTES"]["get rainbow machine info"]:InvokeServer({})
local GoldenmachineInfo = game:GetService("Workspace")["__THINGS"]["__REMOTES"]["get golden machine info"]:InvokeServer({})
local goldenMergeNum = 5
local rainbowMergeNumber = 5
local PetDatabase = require(game:GetService("ReplicatedStorage").Framework.Modules["1 | Directory"].Pets["Grab All Pets"])
local TempPetDropdownDataBase = {}
local SelectedEgg = "Cracked Egg"
local LootbagsDropdown = {}
local currncydropdown = {"Coins","Tech Coins","Fantasy Coins","Diamonds","Halloween Candy","Gingerbread"}
local SelectedChestToFarm = "999999999"
local gameLib = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
local lib = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
local TapTime = .2
local Tapped = false
local Toggle = false
local FlyForce = 75
local Maxmagnitude = 120
local Stop = true
local CandyCaneStop = true
local Speed = 50
local AutofarmChestsAlso = false
local LegitFarmCoins = false
Config = getgenv().kocmoc.toggles
local notif = game:GetService("ReplicatedStorage").Framework.Modules["2 | Network"].notification

--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/
--/--/--/--/--/--/--/ functions --/--/--/--/--/--/--/

local funcs = {}

local function loadRemoteEvent(name)
    local Event = game:GetService("Workspace")["__THINGS"]["__REMOTES"]:FindFirstChild("MAIN")
    if Event ~= nil then
        Event:FireServer("b",name)
    else
        Player:Kick("A critical error occoured, please contact Boxking776#0001 with this message: \nERR_MAIN_REMOTE_EVENT_DOES_NOT_EXIST")
    end
end

local function loadRemoteFunc(name)
    local Event = game:GetService("Workspace")["__THINGS"]["__REMOTES"]:FindFirstChild("MAIN")
    if Event ~= nil then
        Event:FireServer("a",name)
    else
        Player:Kick("A critical error occoured, please contact Boxking776#0001 with this message: \nERR_MAIN_REMOTE_EVENT_DOES_NOT_EXIST")
    end
end

local function Post(Text)
	NotifEvent:Fire(Text)
end

local function PostError(ErrMessage)
	Post(ErrMessage.." | "..tostring(Errs[ErrMessage]))
end

local ConsideringPosting = false
local Delay = 1.5

local function DelayedPost(w)
	if ConsideringPosting == false then
		ConsideringPosting = true
		wait(Delay)
		ConsideringPosting = false
		local ValuetoSend = tostring(Character.Humanoid[w])
		local NewText = "Set "..w.." to "..ValuetoSend
		wait()
		Post(NewText)
	end
end

local function TogglePost(Toggle,Bool)
	local toPost = "Error generating message"
	if Bool == true then
		toPost = "Enabled "..Toggle
	else
		toPost = "Disabled "..Toggle
	end
	Post(toPost)
end

local function ToggleUI(UI)
	local UIObject = Player.PlayerGui:FindFirstChild(UI)
	if UIObject ~= nil then
		if UIObject.Enabled ~= true then
			UIObject.Enabled = true
		else
		--Post("Already Open")
		UIObject.Enabled = false
		end
	else
	PostError("ERR1")
	end
end

local function getPetDataFromId(id)
	local PetReturn = nil
        for i,v in pairs(PetDatabase) do
            if i == tostring(id) then
                PetReturn = v
            end
        end
return PetReturn
end

local function GetMyPets()
local PlrPetInfo = game:GetService("Workspace")["__THINGS"]["__REMOTES"]["get stats"]:InvokeServer({})[1]["Pets"]
warn("lol")
warn(game.HttpService:JSONEncode(PlrPetInfo))
return PlrPetInfo
end

local function getPetInfoFromHash(shash)
	local PlayerStats = game:GetService("Workspace")["__THINGS"]["__REMOTES"]["get stats"]:InvokeServer({})[1]
	local Pets = PlayerStats["Pets"]
	local found = false
	local info = nil
	for i,v in pairs(Pets) do
		if v["uid"] == shash then
			found = true
			info = v
		end
	end
	if found == false then warn("pet not found") end
	return info
end

local function getAllNormalPets()
	local regPets = {}
	local Pets = game:GetService("Workspace")["__THINGS"]["__REMOTES"]["get stats"]:InvokeServer({})[1]["Pets"]
	print(game.HttpService:JSONEncode(Pets))
    for i,v in pairs(Pets) do
        local isRainbow = v["r"]
        local isGold = v["g"]
        local isDM = v["dm"]
        local petId = v["uid"]
        local petnameid = v["id"]
        if isDM == nil and isGold == nil and isDM == nil and isRainbow == nil then
            print(petnameid)
            local data = getPetDataFromId(petnameid)
            print(data)
            table.insert(regPets,{petId,data["name"]})
        end
    end
	return regPets
end

local function getAllGoldenPets()
	local regPets = {}
	local Pets = game:GetService("Workspace")["__THINGS"]["__REMOTES"]["get stats"]:InvokeServer({})[1]["Pets"]
	print(game.HttpService:JSONEncode(Pets))
    for i,v in pairs(Pets) do
        local isRainbow = v["r"]
        local isGold = v["g"]
        local isDM = v["dm"]
        local petId = v["uid"]
        local petnameid = v["id"]
        if isDM == nil and isGold == true and isDM == nil then
            print(petnameid)
            local data = getPetDataFromId(petnameid)
            print(data)
            table.insert(regPets,{petId,data["name"]})
        end
    end
	return regPets
end

local function MakePetsGold(isauto)
    local suc,err = pcall(function()
	local regPetsList = getAllNormalPets()
	local tempAmtList = {}
	
	for i,v in pairs(regPetsList) do
	    local petName = v[2]
	    local petId = v[1]
	    
	    local CountCheck = tempAmtList[petName]
	    if CountCheck == nil then
	        tempAmtList[petName] = 1
	    else
	        tempAmtList[petName] = tempAmtList[petName] + 1
	   end
	end
	
	for i,v in pairs(tempAmtList) do
	    if v >= goldenMergeNum then
	        warn(i.." can be merged")
	        local Table = {}
	        for count = 1, goldenMergeNum do
	            local num = 0
	            for e,k in pairs(regPetsList) do
	                num = num + 1
	                petName = k[2]
	                petId = k[1]
	                if petName == tostring(i) then
	                    table.insert(Table,petId)
	                    table.remove(regPetsList,num)
	                end
	            end
	        end
            local isSuccess = workspace.__THINGS.__REMOTES:FindFirstChild("use golden machine"):InvokeServer({Table})
            wait(2)
            if isSuccess[1] == nil then
                Post("Failed "..i.." Merge")
            else
                Post("Merged "..i)
            end
	    end
	end
    end)
if not suc then Post(tostring(err)) end
end

local function MakePetsRainbow(isauto)
    local suc,err = pcall(function()
	local regPetsList = getAllGoldenPets()
	local tempAmtList = {}
	
	for i,v in pairs(regPetsList) do
	    local petName = v[2]
	    local petId = v[1]
	    
	    local CountCheck = tempAmtList[petName]
	    if CountCheck == nil then
	        tempAmtList[petName] = 1
	    else
	        tempAmtList[petName] = tempAmtList[petName] + 1
	   end
	end
	
	for i,v in pairs(tempAmtList) do
	    if v >= rainbowMergeNumber then
	        warn(i.." can be merged")
	        local Table = {}
	        for count = 1, rainbowMergeNumber do
	            local num = 0
	            for e,k in pairs(regPetsList) do
	                num = num + 1
	                petName = k[2]
	                petId = k[1]
	                if petName == tostring(i) then
	                    table.insert(Table,petId)
	                    table.remove(regPetsList,num)
	                end
	            end
	        end
            local isSuccess = workspace.__THINGS.__REMOTES:FindFirstChild("use rainbow machine"):InvokeServer({Table})
            if isSuccess[1] == nil then
                Post("Failed "..i.." Merge")
            else
                Post("Merged "..i)
            end
	    end
	end
    end)
if not suc then Post(tostring(err)) end
end

local function doespetexist(pet)
    local newpet = string.upper(pet)
    local info = {false,nil}
    for i,v in pairs(PetDatabase) do
        local name = string.upper(v["name"])
        if name == newpet then
            info = {true,v["name"]}
        end
    end
    return info
end

function HatchEgg(Pet)
   local pet = Pet
   for i,v in pairs(game.ReplicatedStorage.Game.Pets:GetChildren()) do
       if string.split(tostring(v), ' - ')[2] == pet then
           pet = string.split(tostring(v), ' - ')[1]
       end
   end
   local tbl = {
       {
       nk = 'Preston',
       idt = '69',
       e = false,
       uid = '69',
       s = 999999999999,
       id = pet,
   }}
   local egg
   for i_,script in pairs(game.ReplicatedStorage.Game.Eggs:GetDescendants()) do
       if script:IsA('ModuleScript') then
           if typeof(require(script).drops) == 'table' then
               for i,v in pairs(require(script).drops) do
                   if v[1] == pet then
                       egg = require(script).displayName
                   end
               end
           end
       end
   end
   if egg == nil then egg = 'Cracked Egg' end
   for i,v in pairs(getgc(true)) do
       if (typeof(v) == 'table' and rawget(v, 'OpenEgg')) then
           if egg ~= nil then
           v.OpenEgg(egg, tbl)
           else
               warn("no")
           end
       end
   end
end

local function StartHatch(pet)
    local infos = doespetexist(pet)
    local doesexist = infos[1]
    local fullname = infos[2]
    if doesexist == true then
        HatchEgg(fullname)
    else
        Post("Pet does not exist")
    end
end

local function fetchBank()
    local Banks = workspace.__THINGS.__REMOTES:FindFirstChild("get my banks"):InvokeServer({})
    local bank = nil
    for i,v in pairs(Banks[1]) do
    if v["BUID"] ~= nil then
    if v["Owner"] == Player.UserId then
        bank = v["BUID"]
    end
    end
    end
    return bank
end

function FarmCoin(CoinID, PetID)
   game.workspace['__THINGS']['__REMOTES']["join coin"]:InvokeServer({[1] = CoinID, [2] = {[1] = PetID}})
   game.workspace['__THINGS']['__REMOTES']["farm coin"]:FireServer({[1] = CoinID, [2] = PetID})
end

local stats076gyfuoyh = game:GetService("Workspace")["__THINGS"]["__REMOTES"]["get stats"]:InvokeServer({})[1]
local maxEquippedougfgf = stats076gyfuoyh["MaxEquipped"]

function legitFarmCoin(CoinID, Pets)
local petsTable = Pets
local SINSIANCE = workspace.__THINGS.Coins:FindFirstChild(CoinID)
if SINSIANCE ~= nil then
local petsFolder = SINSIANCE["Pets"]
local petsOn = 0
for i,v in pairs(petsTable) do
    if petsFolder:FindFirstChild(v) then
        petsOn = petsOn + 1
    end
end
if tonumber(petsOn) ~= tonumber(maxEquippedougfgf) then
lib.Signal.Fire("Group Select Coin",SINSIANCE)
end
end
end

function legitFarm1Coin(CoinID, Pet)
local SINSIANCE = workspace.__THINGS.Coins:FindFirstChild(CoinID)
if SINSIANCE ~= nil then
lib.Signal.Fire("Select Coin",SINSIANCE,Pet)
end
end

function GetMyPets()
   local returntable = {}
   for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets:GetChildren()) do
       if v.ClassName == 'TextButton' and v.Equipped.Visible then
           table.insert(returntable, v.Name)
       end
   end
   return returntable
end

function GetCoins()
   local returntable = {}
   local Num = #GetMyPets()
   local CoinsF = game:GetService("Workspace")["__THINGS"].Coins
   for i = 1,Num do
       returntable["Number"..tostring(i)] = {0,"1"}
   end
   for i,v in pairs(CoinsF:GetChildren()) do
        local M = v:FindFirstChild("Coin")
        if M then
            if M.TextureID ~= "rbxassetid://8269538491" then
            local mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - M.Position).magnitude
            if mag <= Maxmagnitude then
                if M:FindFirstChild("Particles") then
                    if AutofarmChestsAlso == true then
                    for p = 1,Num do
                    local PrevMValue = returntable["Number"..tostring(p)][1]
                    if PrevMValue < mag then
                        returntable["Number"..tostring(p)] = {mag,v.Name}
                        break
                    end
                end
                end
                else
                for p = 1,Num do
                    local PrevMValue = returntable["Number"..tostring(p)][1]
                    if PrevMValue < mag then
                        returntable["Number"..tostring(p)] = {mag,v.Name}
                        break
                    end
                end
                end
            end
        end
    end
end
return returntable
end


function GetCandyCanes()
   local returntable = {}
   local Num = #GetMyPets()
   local CoinsF = game:GetService("Workspace")["__THINGS"].Coins
   for i = 1,Num do
       returntable["Number"..tostring(i)] = {0,"1"}
   end
   for i,v in pairs(CoinsF:GetChildren()) do
        local M = v:FindFirstChild("Coin")
        if M then
            if M.TextureID == "rbxassetid://8269538491" then
            local mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - M.Position).magnitude
            if mag <= Maxmagnitude then
                if not M:FindFirstChild("Particles") then
                for p = 1,Num do
                    local PrevMValue = returntable["Number"..tostring(p)][1]
                    if PrevMValue < mag then
                        returntable["Number"..tostring(p)] = {mag,v.Name}
                        break
                    end
                end
                end
            end
        end
    end
end
return returntable
end

function CollectOrbs()
   local ohTable1 = {[1] = {}}
   for i,v in pairs(game.workspace['__THINGS'].Orbs:GetChildren()) do
       ohTable1[1][i] = v.Name
   end
   game.workspace['__THINGS']['__REMOTES']["claim orbs"]:FireServer(ohTable1)
end

local function BuyMerchantPets()
local t = game:GetService("Workspace")["__THINGS"]["__REMOTES"]["get merchant items"]:InvokeServer({})[1]
local num = 0
for i,v in pairs(t) do
    num = num + 1
    for k = 1,v["left"] do
        warn("BUYING")
        workspace.__THINGS.__REMOTES:FindFirstChild("buy merchant item"):InvokeServer({num})
    end
end
end

local random = Random.new()
local letters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'}
local player = game:GetService("Players").LocalPlayer
if _G.AdditionalCoins == nil then
_G.AdditionalCoins = 0
end

function getRandomLetter()
	return letters[random:NextInteger(1,#letters)]
end

function getRandomString(length, includeCapitals)
	local length = length or 10
	local str = ''
	for i=1,length do
		local randomLetter = getRandomLetter()
		if includeCapitals and random:NextNumber() > .5 then
			randomLetter = string.upper(randomLetter)
		end
		str = str .. randomLetter
	end
	return str
end

local function SummonGift(Type)
local s = game:GetService("Workspace")["__THINGS"]["__REMOTES"]["get stats"]:InvokeServer({})[1]
local nigerbread = s["Gingerbread"]
local World = s["World"]
local sussynum = math.random(20000,100000)
local ohString1 = getRandomString(32, true)
local ohTable3 = {
	["type"] = Type,
	["claimed"] = false,
	["position"] = player.Character.HumanoidRootPart.Position,
	["world"] = World,
	["player"] = player,
	["reward"] = {
		[1] = "Gingerbread",
		[2] = sussynum
	}
}

game:GetService("ReplicatedStorage").Framework.Modules["2 | Network"]["spawn lootbag"]:Fire(ohString1, ohTable3)
game:GetService("Workspace")["__THINGS"].Lootbags.ChildRemoved:Connect(function(instance)
if instance.Name == ohString1 then
local ohTable2 = {
	["type"] = "Gingerbread",
	["plr"] = game:GetService("Players").LocalPlayer,
	["pos"] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0,5,0),
	["am"] = sussynum
}

game:GetService("ReplicatedStorage").Framework.Modules["2 | Network"]["orb added"]:Fire(getRandomString(32, true), ohTable2)

_G.AdditionalCoins = (_G.AdditionalCoins + sussynum) * mult

local ohTable1 = {
    ["Gingerbread"] = nigerbread + _G.AdditionalCoins
}
local ohInstance2 = player
game:GetService("ReplicatedStorage").Framework.Modules["2 | Network"]["new stats"]:Fire(ohTable1, ohInstance2)
end
end)

end

local function spawnFakeOrbs(currency,amt)

local randomnum = math.random(20,50)
local indivAmt = amt/randomnum

for i = 1,randomnum do
wait(0.05)
local ohTable2 = {
    ["type"] = currency,
    ["plr"] = game:GetService("Players").LocalPlayer,
    ["pos"] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0,5,0),
    ["am"] = indivAmt
}

game:GetService("ReplicatedStorage").Framework.Modules["2 | Network"]["orb added"]:Fire(getRandomString(32, true), ohTable2)
end
end

function getchest()
    for i,v in pairs(game:GetService("Workspace")["__THINGS"].Coins:GetDescendants()) do
        if v:IsA("MeshPart") then
            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).magnitude < 750 then
            local val = (v.CFrame.X + v.CFrame.Y + v.CFrame.Z) 
            if (val-SelectedChestToFarm) < 5 and (val-SelectedChestToFarm) > -5 then
            print(v.Parent.Name)
            return v.Parent.Name
        end
end end
end 
end

local function shouldUseSelectedBoost(thing)
    local isthingylmao = false
    local boostPallette = game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts
    local boost = boostPallette:FindFirstChild(thing)
    if boost ~= nil then
    local timer = boost:FindFirstChild("TimeLeft")
    if timer ~= nil then
    if string.find(timer.Text,"00:00:") then
    isthingylmao = true
    end
    end
    else
    isthingylmao = true
    end
    return isthingylmao
end

--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/
--/--/--/--/--/--/--/ preload --/--/--/--/--/--/--/

if workspace.__THINGS.__REMOTES:FindFirstChild("use golden machine") == nil then loadRemoteEvent("use golden machine") end
if workspace.__THINGS.__REMOTES:FindFirstChild("collect bank interest") == nil then loadRemoteEvent("collect bank interest") end
if workspace.__THINGS.__REMOTES:FindFirstChild("get rainbow machine info") == nil then loadRemoteEvent("get rainbow machine info") end
if workspace.__THINGS.__REMOTES:FindFirstChild("get golden machine info") == nil then loadRemoteEvent("get golden machine info") end
if workspace.__THINGS.__REMOTES:FindFirstChild("use golden machine") == nil then loadRemoteEvent("use golden machine") end
if workspace.__THINGS.__REMOTES:FindFirstChild("get my banks") == nil then loadRemoteEvent("get my banks") end
if workspace.__THINGS.__REMOTES:FindFirstChild("farm coin") == nil then loadRemoteFunc("farm coin") end
if workspace.__THINGS.__REMOTES:FindFirstChild("claim orbs") == nil then loadRemoteFunc("claim orbs") end
if workspace.__THINGS.__REMOTES:FindFirstChild("join coin") == nil then loadRemoteEvent("join coin") end
if workspace.__THINGS.__REMOTES:FindFirstChild("buy egg") == nil then loadRemoteEvent("buy egg") end
if workspace.__THINGS.__REMOTES:FindFirstChild("is merchant here") == nil then loadRemoteEvent("is merchant here") end
if workspace.__THINGS.__REMOTES:FindFirstChild("buy merchant item") == nil then loadRemoteEvent("buy merchant item") end
if workspace.__THINGS.__REMOTES:FindFirstChild("get merchant items") == nil then loadRemoteEvent("get merchant items") end
if workspace.__THINGS.__REMOTES:FindFirstChild("activate boost") == nil then loadRemoteFunc("activate boost") end
if workspace.__THINGS.__REMOTES:FindFirstChild("redeem rank rewards") == nil then loadRemoteEvent("redeem rank rewards") end
if workspace.__THINGS.__REMOTES:FindFirstChild("use rainbow machine") == nil then loadRemoteEvent("use rainbow machine") end
if workspace.__THINGS.__REMOTES:FindFirstChild("performed teleport") == nil then loadRemoteFunc("performed teleport") end

for i,v in pairs(require(game:GetService("ReplicatedStorage").Framework.Modules["1 | Directory"].Lootbags.Lootbags)) do
table.insert(LootbagsDropdown,tostring(i))
end

--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/

local hometab = Window:CreateTab("Home")
local farmingtab = Window:CreateTab("Main")
local petstab = Window:CreateTab("Pets")
local misctab = Window:CreateTab("Misc")

local information = hometab:CreateSection("Information")
local miscfarming = farmingtab:CreateSection("Misc Farming")
local currenyfarming = farmingtab:CreateSection("Currency Framing")
local miscfeatures = misctab:CreateSection("Misc Features")
local ui = misctab:CreateSection("UI Shortcuts")
local notifs = misctab:CreateSection("Notifications")
local visual = misctab:CreateSection("Visual Spawning")
local petsmain = petstab:CreateSection("Pets")
local eggs = petstab:CreateSection("Eggs")

--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/

for i,v in pairs(UIList) do
	local UIName = i
	local UINickname = v
	if UINickname == nil then UINickname = UIName end
	
	ui:CreateButton("Open "..UINickname,function()
		ToggleUI(UIName)
	end)
end

--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/

information:CreateLabel("Welcome, "..api.nickname.."!")
information:CreateLabel("Script version: "..temptable.version)
information:CreateLabel("Place version: "..game.PlaceVersion)
information:CreateLabel(" - Not Safe Function")
information:CreateLabel("⚙ - Configurable Function")
information:CreateLabel("📜 - May be exploit specific")
information:CreateLabel("")
information:CreateLabel("Script by Boxking776")
information:CreateLabel("")
information:CreateButton("Discord Invite", function() setclipboard("https://discord.gg/kTNMzbxUuZ")  end)
information:CreateButton("Donation", function() setclipboard("https://www.paypal.com/paypalme/GHubPay") end)

eggs:CreateTextBox("Select Egg","[ Enter Egg Name ]",false,function(sel84)
    local SelectionText = string.upper(sel84)
    local EggSelectionCorrected = nil
    for i,v in pairs(game:GetService("ReplicatedStorage").Game.Eggs:GetDescendants()) do
        if string.upper(v.Name) == SelectionText then
            if v:FindFirstChild("Egg") then
                EggSelectionCorrected = v.Name
            end
        end
    end
    if EggSelectionCorrected ~= nil then
            SelectedEgg = EggSelectionCorrected
            Post("Selected "..SelectedEgg)
    else
        Post("Invalid Egg Name")
    end
end)
local eggsdropdown = {}
for i,v in pairs(game:GetService("ReplicatedStorage").Game.Eggs:GetDescendants()) do
    if v:IsA("ModuleScript") then
        local ojghf3y = require(v)
        if ojghf3y.hatchable == true and ojghf3y.disabled == false then
            table.insert(eggsdropdown,v.Name)
        end
    end
end
eggs:CreateDropdown("Select Egg",eggsdropdown,function(selection)
    SelectedEgg = selection
end)
eggs:CreateButton("Hatch Egg",function()
    workspace.__THINGS.__REMOTES:FindFirstChild("buy egg"):InvokeServer({SelectedEgg,false})
end)
eggs:CreateToggle("Auto Hatch Egg",nil,function(bool)
    Config["AutoHatch"]=bool
end)
eggs:CreateToggle("Skip Egg Hatching",nil,function(bool) 
    if bool == true then
for i,v in pairs(getgc(true)) do
   if (typeof(v) == 'table' and rawget(v, 'OpenEgg')) then
       func = v.OpenEgg
       v.OpenEgg = function()
           return true
       end
   end
end
else
for i,v in pairs(getgc(true)) do
   if (typeof(v) == 'table' and rawget(v, 'OpenEgg')) then
       v.OpenEgg = func
		func = nil
   end
end
end
TogglePost("Skip Hatching",bool)
end)

petsmain:CreateButton("Make Pets Gold",function()
    MakePetsGold(false)
end)
petsmain:CreateToggle("Auto Make Pets Gold",nil,function(bool)
    Config["AutoMakeGold"]=bool
end)
petsmain:CreateSlider("Golden Merge Amount",1,6,5,true,function(selection)
    goldenMergeNum = selection
end)
petsmain:CreateLabel("")
petsmain:CreateButton("Make Pets Rainbow",function()
    MakePetsRainbow(false)
end)
petsmain:CreateToggle("Auto Make Pets Rainbow",nil,function(bool)
    Config["AutoMakeRainbow"]=bool
end)
petsmain:CreateSlider("Rainbow Merge Amount",1,6,5,true,function(selection)
    rainbowMergeNumber = selection
end)
petsmain:CreateLabel("")
petsmain:CreateTextBox("Fake Hatch Pet","[ Enter Egg Name ]",false,function(selection)
    Selectioni3y4r90yf = selection
end)
petsmain:CreateButton("HATCH",function()
    StartHatch(Selectioni3y4r90yf)
end)

local slidersDisabled = true

miscfeatures:CreateSlider("Walkspeed", 16, 200, 16, true, function(selection) task.spawn(function() if not slidersDisabled then game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = selection DelayedPost("WalkSpeed") end end) end)--min,max,default
miscfeatures:CreateSlider("Jump Power", 32, 200, 32, true, function(selection) task.spawn(function() if not slidersDisabled then game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = selection DelayedPost("JumpPower") end end) end)--min,max,default
miscfeatures:CreateSlider("Hip Height", 2, 50, 2, true, function(selection) task.spawn(function() if not slidersDisabled then game.Players.LocalPlayer.Character:WaitForChild("Humanoid").HipHeight = selection DelayedPost("HipHeight") end end) end)--min,max,default
miscfeatures:CreateLabel("")
miscfeatures:CreateToggle("Fly Bypass",nil,function(bool)
    Toggle = bool
	if bool == false then
		Character.HumanoidRootPart.Anchored = false
		for i,v in pairs(Character.HumanoidRootPart:GetChildren()) do
			if v.Name == "ForwardMovement" then v:Destroy() end
			if v.Name == "BodyGyro" then v:Destroy() end
		end
	end
	TogglePost("Fly",bool)
end)
miscfeatures:CreateSlider("Fly Speed",75,300,100,true,function(selection)
    FlyForce = selection
end)
--[[
miscfeatures:CreateSlider("Hoverboard Speed",1,3,2,true,function()
if not slidersDisabled then 
for i,v in pairs(game:GetService("ReplicatedStorage").Game.Hoverboards:GetChildren()) do
    local modul = nil
    for k,e in pairs(v:GetChildren()) do
        if string.find(e.Name,"Data") then
            modul = e
        end
    end
    if modul ~= nil then
        local s = require(modul)
        s["speed"] = sel
    else
        warn("no module found lol")
    end
end

workspace.__THINGS.__REMOTES:FindFirstChild("update hoverboard state"):FireServer({false})
wait(0.1)
workspace.__THINGS.__REMOTES:FindFirstChild("update hoverboard state"):FireServer({true})
end end)]]

slidersDisabled = false

miscfeatures:CreateLabel("")
notifs:CreateTextBox("Admin Notification","[ Enter Text ]",false,function(str) Post(str) end)
notifs:CreateTextBox("Custom Notification","[ Enter Text ]",false,function(str) notif:Fire(str) end)
notifs:CreateTextBox("Custom Popup","[ Enter Text ]",false,function(str) Popup:Fire(str, Color3.new(1, 999)); end)
notifs:CreateLabel("")
notifs:CreateButton("Instant-TP Pets",function() workspace.__THINGS.__REMOTES:FindFirstChild("performed teleport"):FireServer({}) end)

visual:CreateDropdown("Select Lootbag",LootbagsDropdown,function(selection)
    selectedLootbag = selection
    notif:Fire("Selected "..selection)
end)

visual:CreateDropdown("Select Currency",currncydropdown,function(selection)
    currencyvar = selection
    notif:Fire("Selected "..selection)
end)

visual:CreateTextBox("Select Amount","[ Enter Number ]",true,function(amount) amt = tonumber(amount) end)
visual:CreateLabel("")
visual:CreateButton("Fake Spawn Lootbag",function() SummonGift(selectedLootbag) end)
visual:CreateButton("Fake Spawn Orbs",function() spawnFakeOrbs(currencyvar,amt) end)
visual:CreateButton("Spawn Fireworks",function() game:GetService("ReplicatedStorage").Framework.Modules["2 | Network"]["fireworks animation"]:Fire(game.Players.LocalPlayer) end)

miscfarming:CreateToggle("Auto Triple Damage",nil,function(bool)
    Config["AutoTripleDamage"] = bool
end)

miscfarming:CreateToggle("Auto Triple Coins",nil,function(bool)
    Config["AutoTripleCoins"] = bool
end)

miscfarming:CreateToggle("Auto Super Lucky",nil,function(bool)
    Config["AutoSuperLucky"] = bool
end)

miscfarming:CreateToggle("Auto Ultra Lucky",nil,function(bool)
    Config["AutoUltraLucky"] = bool
end)

miscfarming:CreateLabel("")
miscfarming:CreateToggle("Auto Merchant Buying",nil,function(bool)
    Config["AutoMerchant"]=bool
    TogglePost("Merchant Notifier",bool)
end)
miscfarming:CreateLabel("")

if not getgenv().loadedstattracker then getgenv().loadedstattracker = false end
local gamelibrary = require(game:GetService("ReplicatedStorage").Framework.Library)
miscfarming:CreateButton("Currency Stat Tracker",function()
    if getgenv().loadedstattracker ~= true then
        getgenv().loadedstattracker = true
            local Save = gamelibrary.Save.Get
            local Commas = gamelibrary.Functions.Commas
            local types = {}
            local menus = game:GetService("Players").LocalPlayer.PlayerGui.Main.Right
            for i, v in pairs(menus:GetChildren()) do
                if v.ClassName == 'Frame' and v.Name ~= 'Rank' and not string.find(v.Name, "2") then
                    table.insert(types, v.Name)
                end
            end
            
            function get(thistype)
                return Save()[thistype]
            end
            
            menus.Diamonds.LayoutOrder = 99990
            menus['Tech Coins'].LayoutOrder = 99992
            menus['Fantasy Coins'].LayoutOrder = 99994
            menus.Coins.LayoutOrder = 99996
            menus.UIListLayout.HorizontalAlignment = 2
            
            _G.MyTypes = {}
            for i,v in pairs(types) do
                if not menus:FindFirstChild(v.."2") then
                    local tempmaker = menus:FindFirstChild(v):Clone()
                    tempmaker.Name = tostring(tempmaker.Name .. "2")
                    tempmaker.Parent = menus
                    tempmaker.Size = UDim2.new(0, 200, 0, 35)
                    tempmaker.LayoutOrder = tempmaker.LayoutOrder + 1
                    _G.MyTypes[v] = tempmaker
                end
            end
            menus.Diamonds2.Add.Visible = false
            
            for i,v in pairs(types) do
                spawn(function()
                    local megatable = {}
                    local imaginaryi = 1
                    while wait(0.5) do
                        local currentbal = get(v)
                        megatable[imaginaryi] = currentbal
                        local diffy = currentbal - (megatable[imaginaryi-120] or megatable[1])
                        imaginaryi = imaginaryi + 1
                        _G.MyTypes[v].Amount.Text = tostring(Commas(diffy).." in 60s")
                        _G.MyTypes[v]["Amount_odometerGUIFX"].Text = tostring(Commas(diffy).." in 60s")
                    end
                end)
            end
    end
end)

miscfarming:CreateButton("Claim Rewards",function()
    local thing = workspace.__THINGS.__REMOTES:FindFirstChild("redeem rank rewards"):InvokeServer({})
    if thing[1]==nil then
        Post("Error Redeeming")
    end
end)

miscfarming:CreateButton("Claim Bank Interest","",function()
    local Bank = fetchBank()
    if Bank ~= nil then
        local Resp = workspace.__THINGS.__REMOTES:FindFirstChild("collect bank interest"):InvokeServer({Bank})
        Post(Resp[2])
    else
        Post("You don't own a bank")
    end
end)

currenyfarming:CreateToggle("Enable Coin Autofarm",nil,function(bool)
    Stop = not bool
end)

currenyfarming:CreateSlider("Autofarm Coin Range", 20, 500, 120, true, function(choice)
Maxmagnitude = choice
end)

currenyfarming:CreateToggle("Legitimate Farming Style",nil,function(bool)
    LegitFarmCoins = bool
end)

currenyfarming:CreateLabel(" ")

local Chests = {
    "Volcano Chest",
    "Ancient Chest",
    "Haunted Chest",
    "Heaven's Gate Chest 1",
    "Heaven's Gate Chest 2",
    "Giant Heaven's Gate Chest",
    "Tech Entry Chest",
    "Giant Steampunk Chest",
    "Giant Alien Chest",
    "Giant Axolotl Chest",
    "Giant Pixel Chest",
}

local ChestConversion = {
    ["Volcano Chest"] = -2199.1033782958984,
    ["Ancient Chest"] = 3149.397430419922,
    ["Haunted Chest"] = 2231.8964233398438,
    ["Heaven's Gate Chest 1"] = 4862.132736206055,
    ["Heaven's Gate Chest 2"] = 4900.572708129883,
    ["Giant Heaven's Gate Chest"] = 5290.193313598633,
    ["Tech Entry Chest"] = -1188.5158386230469,
    ["Giant Steampunk Chest"] = 2939.4519805908203,
    ["Giant Alien Chest"] = 2150.534553527832,
    ["Giant Axolotl Chest"] = 7800.039789199829,
    ["Giant Pixel Chest"] = 5955.8543365597725,
}

currenyfarming:CreateDropdown("Select Chest to Farm",Chests,function(selection2)
    SelectedChestToFarm = ChestConversion[selection2]
    notif:Fire("Selected "..selection2)
end)

currenyfarming:CreateToggle("Farm Selected Chest",nil,function(selectiont)
    getgenv().start = selectiont
end)

currenyfarming:CreateLabel(" ")

currenyfarming:CreateSlider("Farming Speed",1,200,75,true,function(choice)
    Speed = choice
end)

currenyfarming:CreateToggle("Auto Collect Lootbags",nil,function(bool)
    Config["AutoCollectLoot"]=bool
end)


--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/

local mSessionOver = true

UIS.InputBegan:Connect(function(Input)
    if Input.KeyCode == Enum.KeyCode.W then
        if Toggle == false then return end
        HumaoidRP.Anchored = false
        if HumaoidRP:FindFirstChildOfClass("BodyVelocity") then
            HumaoidRP:FindFirstChildOfClass("BodyVelocity"):Destroy()
        end
        local Forward = Instance.new("BodyVelocity",HumaoidRP)
        Forward.Name = "ForwardMovement"
        Forward.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
        local Gyro = Instance.new("BodyGyro",HumaoidRP)
        Gyro.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
        Gyro.D = 500
        Gyro.P = 10000
        while Toggle == true do
            Forward.Velocity =  workspace.CurrentCamera.CFrame.lookVector * FlyForce
            Gyro.CFrame = workspace.CurrentCamera.CFrame
            wait()
        end
    end
    if Input.KeyCode == Enum.KeyCode.S then
        if Toggle == false then return end
        HumaoidRP.Anchored = false
        if HumaoidRP:FindFirstChildOfClass("BodyVelocity") then
            HumaoidRP:FindFirstChildOfClass("BodyVelocity"):Destroy()
        end
        local Back = Instance.new("BodyVelocity",HumaoidRP)
        Back.Name = "BackMovement"
        Back.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
        local Gyro = Instance.new("BodyGyro",HumaoidRP)
        Gyro.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
        Gyro.D = 500
        Gyro.P = 10000
        while Toggle == true do
            Back.Velocity =  workspace.CurrentCamera.CFrame.lookVector * -FlyForce
            Gyro.CFrame = workspace.CurrentCamera.CFrame
            wait()
        end
    end
end)

UIS.InputEnded:Connect(function(Input)
    if Input.KeyCode == Enum.KeyCode.W then
        if Toggle == false then return end
        if HumaoidRP:FindFirstChild("ForwardMovement") then
            HumaoidRP.ForwardMovement:Destroy()
            HumaoidRP.Anchored = true
            if HumaoidRP:FindFirstChildOfClass("BodyGyro") then
                HumaoidRP:FindFirstChildOfClass("BodyGyro"):Destroy()
            end
        end
    end
    if Input.KeyCode == Enum.KeyCode.S then
        if Toggle == false then return end
        if HumaoidRP:FindFirstChild("BackMovement") then
            HumaoidRP.BackMovement:Destroy()
            HumaoidRP.Anchored = true
            if HumaoidRP:FindFirstChildOfClass("BodyGyro") then
                HumaoidRP:FindFirstChildOfClass("BodyGyro"):Destroy()
            end
        end
    end
end)

--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/

task.spawn(function() while task.wait(Speed/75) do
if not Stop then
    local cointhiny = GetCoins()
    local pethingy = GetMyPets()
    for i = 1, #pethingy do
        if LegitFarmCoins == true then
        local s,e = pcall(function() legitFarm1Coin(cointhiny["Number"..tostring(i)][2], pethingy[i%#pethingy+1]) end) if not s then warn(e) end
        pcall(function() CollectOrbs() end)
        else
       pcall(function() FarmCoin(cointhiny["Number"..tostring(i)][2], pethingy[i%#pethingy+1]) end)
       pcall(function() CollectOrbs() end)
       end
    end
    end
    if getgenv().start then
    local cointhiny = getchest()
    local pethingy = GetMyPets()
    warn(tostring(cointhiny))
        pcall(function() legitFarmCoin(cointhiny, pethingy) end)
    end
    if Config["AutoTP"]==true then
        workspace.__THINGS.__REMOTES:FindFirstChild("performed teleport"):FireServer({})
    end
    if Config["AutoMakeGold"]==true then
        MakePetsGold(false)
    end
    if Config["AutoMakeRainbow"]==true then
        MakePetsRainbow(true)
    end
    if Config["AutoMerchant"]==true then
        local isMerchantHere = game:GetService("Workspace")["__THINGS"]["__REMOTES"]["is merchant here"]:InvokeServer({})[1];
        if isMerchantHere then
            if mSessionOver == true then
            notif:Fire("The merchant has arrived!")
            notif:Fire("Buying Pets...")
            BuyMerchantPets()
            mSessionOver = false
            end
        else
            mSessionOver = true
        end
    end
    if Config["AutoHatch"] == true then
    workspace.__THINGS.__REMOTES:FindFirstChild("buy egg"):InvokeServer({SelectedEgg,false})
    end
    if Config["AutoTripleDamage"] == true then
    if shouldUseSelectedBoost("Triple Damage") == true then
    workspace.__THINGS.__REMOTES:FindFirstChild("activate boost"):FireServer({"Triple Damage"})
    end
    end
    if Config["AutoTripleCoins"] == true then
    if shouldUseSelectedBoost("Triple Coins") == true then
    workspace.__THINGS.__REMOTES:FindFirstChild("activate boost"):FireServer({"Triple Coins"})
    end
    end
    if Config["AutoSuperLucky"] == true then
    if shouldUseSelectedBoost("Super Lucky") == true then
    workspace.__THINGS.__REMOTES:FindFirstChild("activate boost"):FireServer({"Super Lucky"})
    end
    end
    if Config["AutoUltraLucky"] == true then
    if shouldUseSelectedBoost("Ultra Lucky") == true then
    workspace.__THINGS.__REMOTES:FindFirstChild("activate boost"):FireServer({"Ultra Lucky"})
    end
    end
end end)

if _G.autoload then if isfile("kocmoc/PSX_".._G.autoload..".json") then kocmoc = game:service'HttpService':JSONDecode(readfile("kocmoc/PSX_".._G.autoload..".json")) end end
