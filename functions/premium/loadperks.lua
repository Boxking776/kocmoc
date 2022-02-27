local ver = 6
local ASSET_ID = 8958348861
 
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local PlayerOwnsAsset = MarketplaceService.PlayerOwnsAsset
local player = game:GetService("Players").LocalPlayer

local function isPremium()
local success, doesPlayerOwnAsset = pcall(PlayerOwnsAsset, MarketplaceService, player, ASSET_ID)
return doesPlayerOwnAsset
end

function loadPremium(Window)
  print("requested load")
  if Window ~= nil then print("library passed") end
  print("Version "..tostring(ver))
  local premtab = Window:CreateTab("Premium")
  local info = premtab:CreateSection("Info")
  if isPremium() then info:CreateLabel("You are a Premium user.") else info:CreateLabel("You are not a Premium user.") end
end

return loadPremium
