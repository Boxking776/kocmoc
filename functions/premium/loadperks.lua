function loadPremium(Window)
  print("requested load")
  if Window ~= nil then print("library passed") end
  local premtab = Window:CreateTab("Premium")
end

return loadPremium
