local players = game:GetService("Players")
local house = {
    HandleError = function(err)
        warn(err)
    end,
}

local exploit = string.lower(identifyexecutor());
local global_new_websocket_connection
if string.find(exploit,"krnl") then
	global_new_websocket_connection = Krnl.WebSocket.connect
end
if string.find(exploit,"synapse") then
	global_new_websocket_connection = syn.websocket.connect
end
if string.find(exploit,"script") then
	global_new_websocket_connection = WebSocket.connect
end

local function censorURL(url)
    return string.gsub(url,"\106\115\112\114\111\106\101\099\116\046\115\099\104\101\114\118\105\046\114\101\112\108\046\099\111",string.rep("-",25))
end

house.SocketListen = function(socket,callback)
    if not socket or type(callback)~="function" then return; end
    local s,e = pcall(function()
        socket.OnMessage:Connect(function(msg)
            callback(msg);
        end)
    end)
    if not s then
        house.HandleError(e)
        return;
    end
end

house.SocketPost = function(socket,data)
    if not socket or not data then return; end
    local s,e = pcall(function() socket:Send(data) end)
    if not s then
        house.HandleError(e)
        return;
    end
  return true;
end

house.NewSession = function(socketUrl)
    local connection
    local expectedTermination = false
    if type(socketUrl)~="string" then return; end
    local s,e = pcall(function()
        connection = global_new_websocket_connection(socketUrl)
    end)
    if not s or not connection then
        house.HandleError(e or "Unknown error connecting to socket\n")
        return;
    end
    connection.OnClose:Connect(function()
        if not expectedTermination then
            warn("Unexpected disconnection from websocket");
        else
            warn("Websocket terminated.\n");
        end
    end)
    return connection, function() expectedTermination = true; connection:Close() end;
end

if global_new_websocket_connection then
return house;
end
