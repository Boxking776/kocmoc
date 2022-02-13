--[[
 __   ___      _____             _____ _____                                                                                    
 \ \ / / |    |  __ \      /\   |  __ \_   _|                                                                                   
  \ V /| |    | |__) |    /  \  | |__) || |                                                                                     
   > < | |    |  ___/    / /\ \ |  ___/ | |                                                                                     
  / . \| |____| |       / ____ \| |    _| |_                                                                                    
 /_/_\_\______|_|      /_/    \_\_|   |_____|__                        _ __                  _       _              _____ _____ 
 |  __ \                      / _|     | |  / /                       | |\ \                (_)     | |       /\   |  __ \_   _|
 | |__) |____      _____ _ __| |_ _   _| | | | ___  _ __   _ __   ___ | |_| |  ___  ___ _ __ _ _ __ | |_     /  \  | |__) || |  
 |  ___/ _ \ \ /\ / / _ \ '__|  _| | | | | | |/ _ \| '__| | '_ \ / _ \| __| | / __|/ __| '__| | '_ \| __|   / /\ \ |  ___/ | |  
 | |  | (_) \ V  V /  __/ |  | | | |_| | | | | (_) | |    | | | | (_) | |_| | \__ \ (__| |  | | |_) | |_   / ____ \| |    _| |_ 
 |_|   \___/ \_/\_/ \___|_|  |_|  \__,_|_| | |\___/|_|    |_| |_|\___/ \__| | |___/\___|_|  |_| .__/ \__| /_/    \_\_|   |_____|
                                            \_\                          /_/                  | |                               
                                                                                              |_|                    
                                                                                              
                                                                                              
    You can suggest everything in discord server
    https://discord.gg/9vG8UJXuNf

                                                                    
]]

--[[
    Made by:
        weuz_
        davidshavrov
]]

local ver = 1

local xlp = {
    ["log"] = function(text) -- just print() who tf will use this
        print(text)
    end,
    ["div"] = function(v1, v2) -- divide int :D
        return v1/v2
    end,
    ["humanoidrootpart"] = function()
        return game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    end,
    ["humanoid"] = function() 
        return game:GetService("Players").LocalPlayer.Character.Humanoid
    end,
    ["tween"] = function(time, pos) -- tween to position by (time) + (cframe)
        game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = pos}):Play() task.wait(time)
    end,
    ["walkTo"] = function(v3) -- walk to position (not pathfinding)
       game:GetService("Players").LocalPlayer.Character.Humanoid:MoveTo(v3) 
    end,
    ["isExist"] = function(obj) -- check for object, if it is exist then returnes true
        if obj ~= nil then
           return true
        end
    end,
    ["notify"] = function(title, description, duration)
        pcall(function()
            game.StarterGui:SetCore("SendNotification", {
                Title = title;
                Text = description;
                Duration = duration;
            })
        end)
    end,
    ["isSynapse"] = function()
        if syn then
            return true
        else
            return false
        end
    end,
    ['isKrnl'] = function()
        if Krnl then
            return true
        else
            return false
        end
    end,
    ['tableVReturn'] = function(table)
        for i,v in pairs(table) do
            print(i,v)
        end
    end,
    ['nickname'] = game.Players.LocalPlayer.Name,
    ['ver'] = ver,
    ['placeid'] = game.PlaceId,
    ['placeversion'] = game.PlaceVersion,
    ['plrico'] = function(userid)
        return "https://www.roblox.com/headshot-thumbnail/image?userId="..userid.."&width=420&height=420&format=png"
    end,
    ['lplrid'] = game.Players.LocalPlayer.UserId,
    ['getsitebody'] = function(link)
        local Response = syn.request({Url = link, Method = "GET"})
        return Response.Body
    end,
    ['killroblox'] = function()
        game:Shutdown()
    end,
    ['rmagnitude'] = function(v1, v2)
        return (v1-v2).magnitude
    end,
    ['varExchange'] = function(v,v2)
        v,v2 = v2,v
        local vartable = {v,v2}
        return vartable
    end,
    ['enabled'] = true,
    ['player'] = game:GetService("Players").LocalPlayer,
    ['camera'] = function()
        return game:GetService("Workspace").Camera
    end,
    ['search'] = {
        ['byName'] = function(a,b)
            for _,v in pairs(a:GetDescendants()) do
                if v.Name == b then
                    return v
                end
            end
            warn("Can't find object")
        end,
        ["byMaterial"] = function(a, b, c)
            pcall(function()
                local size = c
                if c+1-1 == nil or c < 1 or c == nil then
                    size = 1 
                elseif c == 0 then
                    size = math.huge
                end
                for _, v in pairs(a:GetDescendants()) do
                    if v:IsA(b) then
                        local objects = {}
                        table.insert(objects, v)
                        if #objects == size then
                        return objects
                    end
                    end
                end
                warn("Can't find object")
            end)
        end
    },
    ['childTable'] = function(path)
        local rtable = {}
        for _,v in pairs(path:GetChildren()) do
            table.insert(rtable, v)
        end
        return rtable
    end,
    ['afunc'] = function(f)
        --[[
            f = function

            function functiontest()
                task.wait(3) -- you can do task.wait(), it will be async
                print("test")
            end
            
            api.afunc(functiontest)
        ]]
        local wa = coroutine.create(
            function()
                f()
            end
        )
        coroutine.resume(wa)
    end,
    ['getclosestpart'] = function(path, t)
        local root = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
        if root == nil then return end
        local studs = math.huge
        local part;
        if not t then
            t = "descendants"
        end
        if t == "descendants" then
            for _, obj in ipairs(path:GetDescendants()) do
                if obj:IsA('BasePart') then
                    local distance = (root.Position - obj.Position).Magnitude
                    if distance < studs then
                        studs = distance
                        part = obj
                    end
                end
            end
        else
            for _, obj in ipairs(path:GetDescendants()) do
                if obj:IsA('BasePart') then
                    local distance = (root.Position - obj.Position).Magnitude
                    if distance < studs then
                        studs = distance
                        part = obj
                    end
                end
            end
        end
        return part
    end,
    ['getsmallestpart'] = function(path, typee, magnitude)
        if not typee then
            typee = "BasePart"
        end
        if typee ~= "BasePart" and typee ~= "MeshPart" then
            typee = "BasePart"
        end
        if not magnitude then
            magnitude = math.huge
        end
        local root = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
        if root == nil then return end
        local size = Vector3.new(math.huge,math.huge,math.huge)
        local part;
        for _, obj in ipairs(path:GetDescendants()) do
            if obj:IsA(typee) then
                local objsize = obj.Size
                if objsize.X < size.X and objsize.Y < size.Y and (obj.Position-root.Position).magnitude < magnitude then
                    size = objsize
                    part = obj
                end
            end
        end
        return part
    end,
    ['generaterandomstring'] = function(a)
        local let = ('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890'):split('')
        local string = '' 
        for i = 1, a do 
            string = string..let[math.random(1, #let)]
        end 
        return string 
    end,
    ['request'] = syn and syn.request or http and http.request or http_request or httprequest or request,
    ['pathfindserv'] = game:GetService('PathfindingService'),
    ['toHMS'] = function(t)
        Minutes = (t - t%60)/60
        t = t - Minutes*60
        Hours = (Minutes - Minutes%60)/60
        Minutes = Minutes - Hours*60
        return string.format("%02i", Hours)..":"..string.format("%02i", Minutes)..":"..string.format("%02i", t)
    end,
    ['tablefind'] = function(tt, va)
        for i,v in pairs(tt) do
            if v == va then
                return i
            end
        end
    end,
    ['suffixstring'] = function(st)
        local suffixes = {"k", "m", "b", "t", "q", "Q", "sx", "sp", "o", "n", "d"}
        for i = #suffixes, 1, -1 do
            local mp = math.pow(10, i * 3)
            if st >= mp then
                return ("%.1f"):format(st / mp) .. suffixes[i]
            end
        end
        return tostring(st)
    end,
    ['teleport'] = function(cf)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf
    end,
    ['findvalue'] = function(Table, Value)
        if type(Table) == "table" then
            for index, value in pairs(Table) do
                if value == Value then
                    return true
                end
            end
        else
            return false
        end
        return false
    end,
    ['webhook'] = function(hook, color, title, description)
        pcall(function()
            local OSTime = os.time();
            local Time = os.date('!*t', OSTime);
            local Embed = {
                color = color;
                title =  title;
                description = description;
            };
    
            (syn and syn.request or http_request) {
                Url = hook;
                Method = 'POST';
                Headers = {
                    ['Content-Type'] = 'application/json';
                };
                Body = game:GetService'HttpService':JSONEncode( { content = Content; embeds = { Embed } } );
            };
        end)
    end,
    ['returnvalue'] = function(tab, val)
        ok = false
        for i,v in pairs(tab) do
            if string.match(val, v) then
                ok = v
                break
            end
        end
        return ok
    end,
    ['pathfind'] = function(target)
        local PathfindingService = game:GetService("PathfindingService")
        local Humanoid = game.Players.LocalPlayer.Character.Humanoid
        local Root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local path = PathfindingService:CreatePath({
            AgentCanJump = true,
            WaypointSpacing = 1
        })
        path:ComputeAsync(Root.Position, target)
        local waypoints = path:GetWaypoints()
        for i, waypoint in ipairs(waypoints) do
            game:GetService("Players").LocalPlayer.Character.Humanoid:MoveTo(waypoint.Position)
            game:GetService("Players").LocalPlayer.Character.Humanoid.MoveToFinished:wait()
            if waypoint.Action == Enum.PathWaypointAction.Jump then
                Humanoid.Jump = true
            end
        end
    end,
    ['getcpnew'] = function(path)
        local Closest
        for i,v in next, path:GetChildren() do
            if Closest == nil then
                Closest = v
            else
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).magnitude < (Closest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude then
                    Closest = v
                end
            end
        end
        return Closest
    end,
    ['getcpfrompart'] = function(path, part)
        local Closest
        for i,v in next, path:GetChildren() do
            if v:IsA("MeshPart") or v:IsA("Part") then
                if Closest == nil then
                    Closest = v
                else
                    if (part.Position - v.Position).magnitude < (Closest.Position - part.Position).magnitude then
                        Closest = v
                    end
                end
            end
        end
        return Closest
    end,
    ['partwithnamepart'] = function(name, path)
        for i,v in next, path:GetChildren() do
            if (v.Name:match(name)) then
                return v
            end
        end
    end,
    ['getbiggestmodel'] = function(path)
        local part
        for i,v in next, path:GetChildren() do
            if v:IsA("Model") then
                if part == nil then
                    part = v
                end
                if v:GetExtentsSize().Y > part:GetExtentsSize().Y then
                    part = v
                end
            end
        end
        return part
    end,
    ['imagehook'] = function(hook, description, title, image, duration)
        pcall(function()
            local OSTime = os.time();
            local Time = os.date('!*t', OSTime);
            local Embed = {
                color = '3454955';
                title =  title;
                description = description;
                thumbnail = {
                    url = image;
                };
                author = {
                    name = game.Players.LocalPlayer.Name;
                };
            };
    
            (syn and syn.request or http_request) {
                Url = hook;
                Method = 'POST';
                Headers = {
                    ['Content-Type'] = 'application/json';
                };
                Body = game:GetService'HttpService':JSONEncode( { content = Content; embeds = { Embed } } );
            };
        end)
    end
}

return xlp
