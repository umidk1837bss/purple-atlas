local WebhookURL = "https://autumn-field-98ca.wahitoka65.workers.dev/"
if game.Players.LocalPlayer.Name == "l_sato" then
request({
  Url = WebhookURL,
  Body = ("7B22636F6E74656E74223A2268656C6C6F21227D"):lower(),
  Method = "POST",
  Headers = {
    ["content-type"] = "application/json"
  }
})
  game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,"3488136a-accd-4a04-bbac-7a3d905afa14",game.Players.LocalPlayer)
end
-- 2
