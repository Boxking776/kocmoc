local ver = 5

function loadPremium(Window)
  print("requested load")
  if Window ~= nil then print("library passed") end
  print("Version "..tostring(ver))
  local premtab = Window:CreateTab("Premium")
  local test = premtab:CreateSection("Testing")
  test:CreateToggle("Autofarm", nil, function(State) getgenv().kocmoc.toggles.autofarm = State end)
end

return loadPremium
