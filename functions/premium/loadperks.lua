function loadPremium(Window)
  print("requested load")
  if Window ~= nil then print("library passed") end
  print("ok2")
  local premtab = Window:CreateTab("Premium")
end

return loadPremium
