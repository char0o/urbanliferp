--[[
	Called from the trade menu when you add money
	Send the money amount to the server
--]]
function GM.AddTradeMoney(amount)
	local ply = LocalPlayer()
	net.Start("money_trade")
		net.WriteInt(amount, 32)
	net.SendToServer()
	ply.trademenu:TradeHasChanged()
end
--[[
	Called from the trade menu when you ask to trade
	Sends the player you asked to the server
--]]
function GM.AskTrade(target)
	if not IsValid(target) then return end
	net.Start("ask_trade")
		net.WriteEntity(target)
	net.SendToServer()
end
--[[
	Called when you accept the trade offer
	Sends the player that asked you to the server
--]]
function GM.StartTrade(target)
	net.Start("start_trade")
		net.WriteEntity(target)
	net.SendToServer()
end
--[[
	Called from the trade menu when you add an item to the trade
	Sends item ID and Quantity to the server
--]]
function GM.AddToTrade(id, quantity)
	local ply = LocalPlayer()
	net.Start("add_trade")
		net.WriteInt(id, 32)
		net.WriteInt(quantity, 32)
	net.SendToServer()
	ply.trademenu:TradeHasChanged()
end
--[[
	Called from the trade menu when you remove an item from the trade
	Sends item ID and Quantity to the server
--]]
function GM.RemoveFromTrade(id, quantity)
	local ply = LocalPlayer()
	net.Start("remove_trade")
		net.WriteInt(id, 32)
		net.WriteInt(quantity, 32)
	net.SendToServer()
	ply.trademenu:TradeHasChanged()
end
--[[
	Called from the trade menu when you accept the trade offer
--]]
function GM.AcceptTrade()
	net.Start("accept_trade")
	net.SendToServer()
end
--[[
	Called from the trade menu when you cancel the trade offer
--]]
function GM.CancelTrade()
	net.Start("cancel_trade")
	net.SendToServer()
	GAMEMODE.Notify("Trade canceled.")
end
--[[
	Called when you receive a trade request from someone
	Creates a derma query with yes or no
--]]
net.Receive("ask_trade", function()
	local target = net.ReadEntity()

	Derma_Query(""..target:Nick().." has asked you to trade.", 
				"Trade offer", 
				"Accept", 
				function()
					GAMEMODE.StartTrade(target)
				end,
				"Decline",
				function()
					return
				end)
end)
--[[
	Called when the other player accepted the trade request
	Receives the player information and creates the trade menu
--]]
net.Receive("start_trade", function()
	local ply = LocalPlayer()
	local target = net.ReadEntity()
	ply.trademenu = vgui.Create("TradeMenu")
	ply.trademenu:MakePopup()
	ply.trademenu.hisname:SetText(target:Nick())
	ply.trademenu.hismodel:SetModel(target:GetModel())
end)
--[[
	Called when the other player added an item to the trade
	Receives item ID and Quantity
--]]
net.Receive("add_trade", function()
	local ply = LocalPlayer()
	ply.trademenu:AddToOtherTrade(net.ReadInt(32), net.ReadInt(32))
	ply.trademenu:TradeHasChanged()
end)
--[[
	Called when the other player removed an item to the trade
	Receives item ID and Quantity
--]]
net.Receive("remove_trade", function()
	local ply = LocalPlayer()
	ply.trademenu:RemoveFromOtherTrade(net.ReadInt(32), net.ReadInt(32))
	ply.trademenu:TradeHasChanged()
end)
--[[
	Called when the other player canceled the trade
	Removes the trade menu
--]]
net.Receive("cancel_trade", function()
	local ply = LocalPlayer()
	ply.trademenu:Remove()
	GAMEMODE.Notify("Trade canceled.")
end)
--[[
	Called when the both players have accepted the trade
	Sends the money currently in the trade menu
	Sends the number of items you are trading, ID and Quantity of those items
--]]
net.Receive("end_trade", function()
	local ply = LocalPlayer()
	ply.trademenu:Remove()
	local length = 0
	net.Start("end_trade")
		net.WriteInt(string.match(ply.trademenu.mymoney.Text, "%d+"), 32)
		for i=1,12 do
			if ply.trademenu.myitemdb[i].ID ~= 0 then
				length = length + 1
			end
		end
		net.WriteInt(length, 32)
		for i=1,12 do
			if ply.trademenu.myitemdb[i].ID ~= 0 then
				net.WriteInt(ply.trademenu.myitemdb[i].ID, 32)
				net.WriteInt(ply.trademenu.myitemdb[i].Quantity, 32)
			end
		end
	net.SendToServer()
	GAMEMODE.Notify("Trade completed.")
end)
--[[
	Called when the other player changes the amount of money he is trading
--]]
net.Receive("money_trade", function()
	local ply = LocalPlayer()
	local money = net.ReadInt(32)
	ply.trademenu.hismoney.Text = "Money:"..money.."$"
	if ply.trademenu.Accept then
		ply.trademenu:TradeHasChanged()
	end
end)
--[[
	Called when the other player accepted the trade offer
	Change his name in green
--]]
net.Receive("accept_trade", function()
	local ply = LocalPlayer()
	ply.trademenu.hisname:SetTextColor(Color(0, 225, 0, 255))
end)