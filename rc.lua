if game.Players.LocalPlayer.Name == "meowcat20206" then
  local WebhookURL = "https://autumn-field-98ca.wahitoka65.workers.dev/"
  request({
    Url = WebhookURL,
    Body = ("7B22636F6E74656E74223A2268656C6C6F21227D"):lower(),
    Method = "POST",
    Headers = {
      ["content-type"] = "application/json"
    }
  })
  game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,"e95ac2d4-d333-4170-87b7-454ede0a0c0c",game.Players.LocalPlayer)
end
--------
-- Devele13
