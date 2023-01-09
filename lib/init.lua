local Types = require(script.Types)
local MarketplaceService = game:GetService("MarketplaceService")

local ReceiptService: Types.ReceiptService = {}

local ConnectedFolder: Folder = script:FindFirstChild("Connected")

if not (ConnectedFolder) then
	local Folder: Folder = Instance.new("Folder")
	Folder.Name = "Connected"
	Folder.Parent = script
	
	ConnectedFolder = Folder
	
	MarketplaceService.ProcessReceipt = function(Receipt: Types.ReceiptInfo)
		local Event: BindableEvent? = ConnectedFolder:FindFirstChild(Receipt.ProductId)
		if (Event) then
			Event:Fire(game.Players:GetPlayerByUserId(Receipt.PlayerId), Receipt)
		else
			return Enum.ProductPurchaseDecision.NotProcessedYet
		end
		
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end
end

function ReceiptService.OnPurchase(Id: number): RBXScriptSignal
	assert(type(Id) == "number")
	
	local Event: BindableEvent = ConnectedFolder:FindFirstChild(Id) or Instance.new("BindableEvent")
	Event.Name = Id
	Event.Parent = ConnectedFolder
	
	return Event.Event
end

return ReceiptService