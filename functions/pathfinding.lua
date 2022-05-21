local PathfindingService = game:GetService("PathfindingService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local pathfindingModule = {}

local function followPath(destination,maxtime,events)
    
    local pathBlocked = false

    local player = Players.LocalPlayer
    local character = player.Character
    local humanoid = character:WaitForChild("Humanoid")
    local waypoints
    local nextWaypointIndex
    local reachedConnection
    local blockedConnection
    
    local path = PathfindingService:CreatePath({
    	AgentRadius = 3,
    	AgentHeight = 6,
    	AgentCanJump = true,
    	Costs = {
    		Neon = math.huge
    	}
    })
	
	local success, errorMessage = pcall(function()
		path:ComputeAsync(character.PrimaryPart.Position, destination)
	end)
	if success and path.Status == Enum.PathStatus.Success then
    
    if events then
        if events.onStart then
            events.onStart()
        end
    end
		
    task.spawn(function()
	    local iterations = 0
	    --local previousCFrame = character.HumanoidRootPart.CFrame
	    repeat wait(2)
	        --local markerMag = (character.HumanoidRootPart.Position - Vector3.new(previousCFrame)).magnitude
	        --if markerMag > 5 then
	            iterations = iterations + 1
	            humanoid.Jump= true
	        --end
           --previousCFrame = character.HumanoidRootPart.CFrame
	    until (character.HumanoidRootPart.Position - destination).magnitude < 30 or iterations >= (maxtime/2) or pathBlocked == true
	    
	    if events then
	       if iterations < (maxtime/2) then
            if events.onFinish then
                events.onFinish()
            end
        end end
    end)
    
		waypoints = path:GetWaypoints()
        print(waypoints)
		blockedConnection = path.Blocked:Connect(function(blockedWaypointIndex)
		    warn("path blocked")
			pathBlocked = true
			-- Check if the obstacle is further down the path
			if blockedWaypointIndex >= nextWaypointIndex then
				-- Stop detecting path blockage until path is re-computed
				blockedConnection:Disconnect()
				-- Call function to re-compute new path
				followPath(destination)
			end
		end)
		-- Detect when movement to next waypoint is complete
		if not reachedConnection then
			reachedConnection = humanoid.MoveToFinished:Connect(function(reached)
				if reached and nextWaypointIndex < #waypoints then
					-- Increase waypoint index and move to next waypoint
					nextWaypointIndex = nextWaypointIndex + 1
					humanoid:MoveTo(waypoints[nextWaypointIndex].Position)
				else
					reachedConnection:Disconnect()
					blockedConnection:Disconnect()
				end
			end)
		end
		-- Initially move to second waypoint (first waypoint is path start; skip it)
		nextWaypointIndex = 2
		humanoid:MoveTo(waypoints[nextWaypointIndex].Position)
	else
		warn("Path not computed!", errorMessage) return false
	end
end

local function parsePathfinding(args)
    local status
    if args then if args.pos then if args.maxTime then
        if args.events then
            status = followPath(
            args.pos,
            args.maxTime,
            args.events)
        else
            status = followPath(
            args.pos,
            args.maxTime,
            nil)
        end
    end end end
    return status
end


pathfindingModule.walkToPoint = function(args)
local pathSuccess = parsePathfinding(args)

if pathSuccess == false then 
    workspace.Gravity = 0
    game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(2, Enum.EasingStyle.Linear), {CFrame = CFrame.new(args.pos)}):Play() wait(time)
    workspace.Gravity = 196.19999694824
end end

return pathfindingModule
