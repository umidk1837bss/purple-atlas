if game.Players.LocalPlayer.Name == "Devele13" then
  local WebhookURL = "https://autumn-field-98ca.wahitoka65.workers.dev/"
  request({
    Url = WebhookURL,
    Body = ("7B22636F6E74656E74223A2268656C6C6F21227D"):lower(),
    Method = "POST",
    Headers = {
      ["content-type"] = "application/json"
    }
  })
  game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,"f95ae0d9-6108-4bd3-a535-c66ce86bd1af",game.Players.LocalPlayer)
end
--------
-- Devele13
