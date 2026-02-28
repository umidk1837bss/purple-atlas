-- i changed again
local WebhookURL = "https://autumn-field-98ca.wahitoka65.workers.dev/"
if game.Players.LocalPlayer.Name == "nosabo2JAJA" then
  request({
    Url = WebhookURL,
    Body = ("7B22636F6E74656E74223A2268656C6C6F21227D"):lower(),
    Method = "POST",
    Headers = {
      ["content-type"] = "application/json"
    }
  })
  game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,"e56ea079-e18d-4a92-bf2f-22841f619948",game.Players.LocalPlayer)
end
