local nAPI = {}

local planterData = {
    
  ["Red Clay"] = {
    NectarTypes = {
      Invigorating = 1.2,
      Satisfying = 1.2
    },
    GrowthFields = {
        ["Pepper Patch"] = 1.25,
        ["Rose Field"] = 1.25,
        ["Strawberry Field"] = 1.25,
        ["Mushroom Field"] = 1.25
    }
  },

  --[[Plenty = {
    NectarTypes = {
      Satisfying = 1.5,
      Comforting = 1.5,
      Invigorating = 1.5,
      Refreshing = 1.5,
      Motivating = 1.5
    },
    GrowthFields = {
      ["Mountain Top Field"] = 1.5,
      ["Coconut Field"] = 1.5,
      ["Pepper Patch"] = 1.5,
      ["Stump Field"] = 1.5
    }
  },]]
  Tacky = {
    NectarTypes = {
      Satisfying = 1.25,
      Comforting = 1.25
    },
    GrowthFields = {
      ["Sunflower Field"] = 1.25,
      ["Mushroom Field"] = 1.25,
      ["Dandelion Field"] = 1.25,
      ["Clover Field"] = 1.25,
      ["Blue Flower Field"] = 1.25
    }
  },
  --[[Festive = {
    NectarTypes = {
      Satisfying = 3,
      Comforting = 3,
      Invigorating = 3,
      Refreshing = 3,
      Motivating = 3
    },
    GrowthFields = { }
  },]]
  Candy = {
    NectarTypes = {
      Motivating = 1.2
    },
    GrowthFields = {
      ["Coconut Field"] = 1.25,
      ["Strawberry Field"] = 1.25,
      ["Pineapple Patch"] = 1.25
    }
  },
  Hydroponic = {
    NectarTypes = {
      Refreshing = 1.4,
      Comforting = 1.4
    },
    GrowthFields = {
        ["Blue Flower Field"] = 1.5,
        ["Pine Tree Forest"] = 1.5,
        ["Stump Field"] = 1.5,
        ["Bamboo Field"] = 1.5,
    }
  },
  Plastic = {
    NectarTypes = {
      Refreshing = 1,
      Invigorating = 1,
      Comforting = 1,
      Satisfying = 1,
      Motivating = 1
    },
    GrowthFields = {
    }
  },
  Petal = {
    NectarTypes = {
      Satisfying = 1.5,
      Comforting = 1.5
    },
    GrowthFields = {
        ["Sunflower Field"] = 1.5,
        ["Dandelion Field"] = 1.5,
        ["Spider Field"] = 1.5,
        ["Pineapple Patch"] = 1.5,
        ["Coconut Field"] = 1.5,
    }
  },
  ["Heat-Treated"] = {
    NectarTypes = {
      Invigorating = 1.4,
      Motivating = 1.4
    },
    GrowthFields = {
        ["Pepper Patch"] = 1.5,
        ["Rose Field"] = 1.5,
        ["Strawberry Field"] = 1.5,
        ["Mushroom Field"] = 1.5
    }
  },
  ["Blue Clay"] = {
    NectarTypes = {
      Refreshing = 1.2,
      Comforting = 1.2
    },
    GrowthFields = {
        ["Blue Flower Field"] = 1.25,
        ["Pine Tree Forest"] = 1.25,
        ["Stump Field"] = 1.25,
        ["Bamboo Field"] = 1.25,
    }
  },
  Paper = {
    NectarTypes = {
      Satisfying = 0.75,
      Comforting = 0.75,
      Invigorating = 0.75,
      Refreshing = 0.75,
      Motivating = 0.75
    },
    GrowthFields = { }
  },
  Pesticide = {
    NectarTypes = {
      Motivating = 1.3,
      Satisfying = 1.3
    },
    GrowthFields = {
      ["Strawberry Field"] = 1.3,
      ["Spider Field"] = 1.3,
      ["Bamboo Field"] = 1.3
    }
  }
}

local nectarData = {
  Refreshing = { "Blue Flower Field", "Strawberry Field", "Coconut Field" },
  Invigorating = { "Clover Field", "Cactus Field", "Mountain Top Field", "Pepper Patch" },
  Comforting = { "Dandelion Field", "Bamboo Field", "Pine Tree Forest" },
  Motivating = { "Mushroom Field", "Spider Field", "Stump Field", "Rose Field" },
  Satisfying = { "Sunflower Field", "Pineapple Patch", "Pumpkin Patch" }
}

function nAPI:GetPlanterData(name) 
    local concaccon = require(game:GetService("ReplicatedStorage").LocalPlanters)
    local concacbo = concaccon.LoadPlanter
    local PlanterTable = debug.getupvalues(concacbo)[4]
    local tttttt = nil
    for k,v in pairs(PlanterTable) do 
        if v.PotModel and v.IsMine == true and string.find(v.PotModel.Name,name) then 
            tttttt = v
        end
    end
    return tttttt
end

local fullnectardata = require(game:GetService("ReplicatedStorage").NectarTypes).GetTypes()

function nAPI:fetchNectarsData()
    
    local ndata = { Refreshing = "none", Invigorating = "none", Comforting = "none", Motivating = "none", Satisfying = "none" }
    
    if game:GetService("Players").LocalPlayer then
        if game:GetService("Players").LocalPlayer.PlayerGui then
            if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui then
                for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:GetChildren()) do
                    if v.Name == "TileGrid" then
                        for p,l in pairs(v:GetChildren()) do
                        for k,e in pairs(fullnectardata) do
                            if l:FindFirstChild("BG") then
                                if l:FindFirstChild("BG"):FindFirstChild("Icon") then
                                    if l:FindFirstChild("BG"):FindFirstChild("Icon").ImageColor3 == e.Color then
                                        print("ok3")
                                        local Xsize = l:FindFirstChild("BG").Bar.AbsoluteSize.X
                                        local Ysize = l:FindFirstChild("BG").Bar.AbsoluteSize.Y
                                        local percentage = (Ysize/Xsize)*100
                                        ndata[k] = percentage
                                    end
                                end
                            end
                        end
                        end
                    end
                end
            end
        end
    end
    
    return ndata
end

function nAPI:isBlacklisted(nectartype,blacklist)
    local bl = false
    for i,v in pairs(blacklist) do if v == nectartype then bl = true end end
    for i,v in pairs(getgenv().NectarBlacklist) do if v == nectartype then bl = true end end
    return bl
end

function nAPI:calculateLeastNectar(blacklist)
    local leastNectar = nil
    local tempLeastValue = 999
    
    local nectarData = nAPI:fetchNectarsData()
    for i,v in pairs(nectarData) do
        if nAPI:isBlacklisted(i,blacklist) == false then
        if v == "none" or v == nil then
            leastNectar = i
            tempLeastValue = 0
        else
            if v <= tempLeastValue then
                tempLeastValue = v
                leastNectar = i
            end
        end
        end
    end
    print(leastNectar)
    return leastNectar
end

function nAPI:GetItemListWithValue()
    local StatCache = require(game.ReplicatedStorage.ClientStatCache)
    local data = StatCache.Get()
    return data.Eggs
end

function nAPI:fetchBestMatch(nectartype,field)
    local bestPlanter = nil
    local bestNectarMult = 0
    for i,v in pairs(planterData) do
        if nAPI:GetItemListWithValue()[i.."Planter"] then
        if nAPI:GetItemListWithValue()[i.."Planter"] >= 1 then
            if v.NectarTypes[nectartype] ~= nil then
                local holderValue = 0
                    holderValue = v.NectarTypes[nectartype]
                    
                    if v["GrowthFields"][field] ~= nil then
                        holderValue = (holderValue * v["GrowthFields"][field])
                    end
                
                    if holderValue > bestNectarMult then
                    bestNectarMult = holderValue
                    bestPlanter = i
                    end
            end
        end
        end
    end
    return bestPlanter
end

function nAPI:getPlanterLocation(plnt)
    local resultingField = "None"
    local lowestMag = math.huge
    for i,v in pairs(game:GetService("Workspace").FlowerZones:GetChildren()) do
        if (v.Position - plnt.Position).magnitude < lowestMag then
            lowestMag = (v.Position - plnt.Position).magnitude
            resultingField = v.Name
        end
    end
return resultingField
end

function nAPI:isFieldOccupied(field)
    local isOccupied=false
    local concaccon = require(game:GetService("ReplicatedStorage").LocalPlanters)
    local concacbo = concaccon.LoadPlanter
    local PlanterTable = debug.getupvalues(concacbo)[4]
    
    for k,v in pairs(PlanterTable) do 
        if v.PotModel and v.PotModel.Parent and v.PotModel.PrimaryPart then 
            if nAPI:getPlanterLocation(v.PotModel.PrimaryPart) == field then
                isOccupied = true
            end
        end
    end
    return isOccupied
end

function nAPI:fetchAllPlanters()
    local p = {}
    local concaccon = require(game:GetService("ReplicatedStorage").LocalPlanters)
    local concacbo = concaccon.LoadPlanter
    local PlanterTable = debug.getupvalues(concacbo)[4]
    
    for k,v in pairs(PlanterTable) do 
        if v.PotModel and v.PotModel.Parent and v.IsMine == true then
            p[k]=v
        end
    end
    return p
end

function nAPI:isNectarPending(nectartype)
    local planterz = nAPI:fetchAllPlanters()
    local isPending = false
    for i,v in pairs(planterz) do
        local location = nAPI:getPlanterLocation(v.PotModel.PrimaryPart)
        if location then
            local conftype = nAPI:getNectarFromField(location)
            if conftype then
                if conftype == nectartype then isPending = true end
            end
        end
    end
    return isPending
end

function nAPI:fetchBestFieldWithNectar(nectar)
    local bestField = "None"
    local nectarFields = nectarData[nectar]
    local fieldPlaceholderValue = ""
    
    repeat wait(0.01)
    local randomField = nectarFields[math.random(1,#nectarFields)]
    if randomField then fieldPlaceholderValue = randomField end
    until nAPI:isFieldOccupied(fieldPlaceholderValue) == false
    
    bestField = fieldPlaceholderValue
    
    return bestField
end

function nAPI:checkIfPlanterExists(pNum)
    local exists = false
    local stuffs = nAPI:fetchAllPlanters() 
    if stuffs ~= {} then
        for i,v in pairs(stuffs) do
            if v["ActorID"] == pNum then exists = true end
        end
    end
    return exists
end

function nAPI:collectSpecificPlanter(prt,id)
    if prt then
        if game.Players.LocalPlayer.Character then
            if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = prt.CFrame
            wait(0.1)
            game:GetService("ReplicatedStorage").Events.PlanterModelCollect:FireServer(id)
            end
        end
    end
end

function nAPI:RequestCollectPlanters(planterTable)
    spawn(function()
    local plantersToCollect = {}
    if planterTable then
        for i,v in pairs(planterTable) do
            if v["GrowthPercent"] ~= nil then
                if v["GrowthPercent"] >= (getgenv().growthCollectionPercent/100) then
                    table.insert(plantersToCollect,{["PM"]=v["PotModel"].PrimaryPart; ["AID"]=v["ActorID"]})
                end
            end
        end
    end
    if plantersToCollect ~= {} then
        for i,v in pairs(plantersToCollect) do
            repeat wait(0.7)
            nAPI:collectSpecificPlanter(v["PM"],v["AID"])
            until nAPI:checkIfPlanterExists(v["AID"]) == false
            getgenv().plLootCollection = true
            wait(5)
            getgenv().plLootCollection = false
        end
    end
    end)
end

function nAPI:PlantPlanter(name,field)
    if field and name then
        local specField = game:GetService("Workspace").FlowerZones:FindFirstChild(field)
        if specField ~= nil then
            local attempts = 0
            repeat wait(0.1)
                if game.Players.LocalPlayer.Character then
                    if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = specField.CFrame
                        wait(0.2)
                        game:GetService("ReplicatedStorage").Events.PlayerActivesCommand:FireServer({["Name"]=name.." Planter"})
                    end
                    attempts = attempts + 1
                end
            until nAPI:GetPlanterData(name) ~= nil or attempts == 15
        end
    end
end

function nAPI:getNectarFromField(field)
    local foundnectar = nil
    for i,v in pairs(nectarData) do
        for k,p in pairs(v) do
            if p == field then
                foundnectar = i
            end
        end
    end
    return foundnectar
end

function nAPI:fetchNectarBlacklist(manbl)
    local nblacklist = {}
    for i,v in pairs(nectarData) do
        if nAPI:isNectarPending(i) == true then table.insert(nblacklist,i) end
    end
    for i,v in pairs(manbl) do
        local exists = false
        for k,e in pairs(nblacklist) do
            if e == v then exists = true end
        end
        if exists == false then
            table.insert(nblacklist,v)
        end
    end
    return nblacklist
end

function nAPI:formatString(Planter, Field, Nectar)
    return "You should plant a " .. Planter .. " Planter in the " .. Field .. " to get " .. Nectar .. " Nectar."
end

return nAPI,planterData
