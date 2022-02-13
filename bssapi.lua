local bsslib = {}

function bsslib:getInventory()
    return game.ReplicatedStorage.Events.RetrievePlayerStats:InvokeServer().Eggs
end

function bsslib.Pollen()
    return tonumber(game.Players.LocalPlayer.Character:FindFirstChild("ProgressLabel",true).Text:match("%d+$"))
end

function bsslib:GetCooldown(mob)
    local cd = workspace.MonsterSpawners
    if cd:FindFirstChild(mob) then
        cd = cd:FindFirstChildOfClass("Attachment"):FindFirstChild("TimerGui") or v:FindFirstChild("Attachment").TimerGui
        if cd.TimerLabel.Visible == false then
            return false
        else 
            return true
        end
    end
    return nil
end

function bsslib:Godmode(boolean)
    local camera = workspace.CurrentCamera
    local lp = game.Players.LocalPlayer
    local camerapos = camera.CFrame
    local character = lp.Character or workspace:FindFirstChild(lp.Name)
    local humanoid = character.Humanoid
    local copy = humanoid:Clone()
    if boolean == true then
        lp.Character = nil
        copy:SetStateEnabled(15, false)
        copy:SetStateEnabled(0, false)
        copy:SetStateEnabled(1, false)
        copy.Parent = character
        humanoid:Destroy()
        lp.Character = character
        camera.CameraSubject = copy
        camera.CFrame = camerapos
        copy.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        character:FindFirstChild("Animate").Disabled = true
        character:FindFirstChild("Animate").Disabled = false
    else
        humanoid:SetStateEnabled(15, true)
        copy:SetStateEnabled(0, true)
        copy:SetStateEnabled(1, true)
        lp.Character = nil
        humanoid:ChangeState(15)
        lp.Character = character
        humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
    end
end

return bsslib
