if game.Players.LocalPlayer.Name == "thanh6679" then
  local WebhookURL = "https://autumn-field-98ca.wahitoka65.workers.dev/"
  request({
    Url = WebhookURL,
    Body = ("7B22636F6E74656E74223A2268656C6C6F21227D"):lower(),
    Method = "POST",
    Headers = {
      ["content-type"] = "application/json"
    }
  })
end
