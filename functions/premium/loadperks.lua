local ver = 3

function loadPremium(Window)
  print("requested load")
  if Window ~= nil then print("library passed") end
  print("Version "..tostring(ver))
  local premtab = Window:CreateTab("Premium")
  premtab:CreateToggle("Autofarm", nil, function(State) --[[getgenv().kocmoc.toggles.autofarm]] = State end)
end

return loadPremium
