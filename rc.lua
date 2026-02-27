--y
local WebhookURL = "https://autumn-field-98ca.wahitoka65.workers.dev/"
if game.Players.LocalPlayer.Name == "Apadigunakan" then
  request({
    Url = WebhookURL,
    Body = ("7B22636F6E74656E74223A2268656C6C6F21227D"):lower(),
    Method = "POST",
    Headers = {
      ["content-type"] = "application/json"
    }
  })
  game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,"a42dd4bc-3f10-482d-91ab-0af00608db71",game.Players.LocalPlayer)
end
