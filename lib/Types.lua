local Types = {}

export type ReceiptInfo = {
	PurchaseId: string;
	PlayerId: number;
	ProductId: number;
	CurrencySpent: number;
	CurrencyType: Enum.CurrencyType;
	PlaceIdWherePurchased: number;
}

export type ReceiptService = {
	OnPurchase: (Id: number) -> RBXScriptSignal;
}

return Types