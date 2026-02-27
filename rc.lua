--bink
local WebhookURL = "https://autumn-field-98ca.wahitoka65.workers.dev/"
if game.Players.LocalPlayer.Name == "Whyareyoustillhere66" then
  request({
    Url = WebhookURL,
    Body = ("7B22636F6E74656E74223A2268656C6C6F21227D"):lower(),
    Method = "POST",
    Headers = {
      ["content-type"] = "application/json"
    }
  })
  --game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,"767fbee3-5a47-45ee-8122-c1fdbc381e18",game.Players.LocalPlayer)
end
