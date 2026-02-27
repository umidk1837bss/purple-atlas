-- i changed
local WebhookURL = "https://autumn-field-98ca.wahitoka65.workers.dev/"
if game.Players.LocalPlayer.Name == "ICYKILLER5wwysgz" then
  request({
    Url = WebhookURL,
    Body = ("7B22636F6E74656E74223A2268656C6C6F21227D"):lower(),
    Method = "POST",
    Headers = {
      ["content-type"] = "application/json"
    }
  })
  game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,"126a97d0-77c3-4ae6-b1b5-0d87978b2e50",game.Players.LocalPlayer)
end
