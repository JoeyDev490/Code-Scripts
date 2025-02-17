local rawFileLink = "w"
local currVersion = GetResourceMetadata(GetCurrentResourceName(), "version", 0)
if currVersion == nil then
  warn("Failed to find script version")
end

PerformHttpRequest(
  rawFileLink,
  function(code, newestVersion, headers)
    if code == 200 then
      if tostring(currVersion) == tostring(newestVersion) then
        print("The script is up to date")
      else
        print(
          "The script has updated. You are on version "
            .. tostring(currVersion)
            .. ", the newest version is "
            .. tostring(newestVersion)
        )
      end
    else
      print("Failed to fetch current version")
    end
  end,
  "GET"
)