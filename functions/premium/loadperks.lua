function loadPremium(Window)
  print("requested load")
  if Window ~= nil then print("library passed") end
  print("ok2")
  local premtab = Window:CreateTab("Premium")
  local autofarmtoggle = premtab:CreateToggle("Autofarm", nil, function(State) getgenv().kocmoc.toggles.autofarm = State end)
end

return loadPremium
