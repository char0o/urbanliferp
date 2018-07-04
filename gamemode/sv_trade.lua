--[[
	When a player asks another player to trade, send a request to the
	player
--]]
util.AddNetworkString("ask_trade")
net.Receive("ask_trade", function(len, ply)
	net.Start("ask_trade")
		net.WriteEntity(ply)
	net.Send(net.ReadEntity())
end)
--[[
	Called when the requested player accepts the trade request
	Sets eachother as trade target
--]]
util.AddNetworkString("start_trade")
net.Receive("start_trade", function(len, ply)
	local target = net.ReadEntity()
	--if not IsValid(ply) || not IsValid(target) || ply:GetPos():Distance(target:GetPos()) < 250 then return end
	ply.TradeTarget = target
	target.TradeTarget = ply
	net.Start("start_trade")
		net.WriteEntity(ply)
	net.Send(target)
	net.Start("start_trade")
		net.WriteEntity(target)
	net.Send(ply)
end)
--[[
	Called when both players have accepted the trade
	Receives money and item information to give
--]]
util.AddNetworkString("end_trade")
net.Receive("end_trade", function(len, ply)
	local target = ply.TradeTarget
	local money = net.ReadInt(32)
	local len = net.ReadInt(32)

	if not money == 0 then
		if ply:HasMoney(money) then
			ply:GiveOtherMoney(target, money)
		end
	end

	for i=1,len do --For every item sent receive ID and Quantity
		local id = net.ReadInt(32)
		local quant = net.ReadInt(32)
		target:GiveItem(id, quant)
		ply:RemoveItem(id, quant)
	end
	target.AcceptTrade = false
	ply.AcceptTrade = false
end)
--[[
	Called when a player accepted the trade offer
--]]
util.AddNetworkString("accept_trade")
net.Receive("accept_trade", function(len, ply)
	local target = ply.TradeTarget
	if not IsValid(ply) || not IsValid(target) then return end
	net.Start("accept_trade")
	net.Send(target)
	ply.AcceptTrade = true
	local plytbl = {ply, target}
	--If both player have accepted tell them to end the trade
	if ply.AcceptTrade && target.AcceptTrade then
		net.Start("end_trade")
		net.Send(plytbl)
	end
end)
--[[
	Called when a player cancels the trade
	Remove eachother as trade partner
--]]
util.AddNetworkString("cancel_trade")
net.Receive("cancel_trade", function(len, ply)
	local target = ply.TradeTarget
	if not IsValid(ply) || not IsValid(target) then return end
	
	target.TradeTarget = nil
	ply.TradeTarget = nil
	target.AcceptTrade = false
	ply.AcceptTrade = false

	net.Start("cancel_trade")
	net.Send(target)
end)
--[[
	Called when a player changes the money he wants to give
--]]
util.AddNetworkString("money_trade")
net.Receive("money_trade", function(len, ply)
	local target = ply.TradeTarget
	--if not IsValid(ply) || not IsValid(target) then return end
	net.Start("money_trade")
		net.WriteInt(net.ReadInt(32), 32)
	net.Send(target)
	target.AcceptTrade = false
	ply.AcceptTrade = false
end)
--[[
	Called when a player adds an item to the trade
--]]
util.AddNetworkString("add_trade")
net.Receive("add_trade", function(len, ply)
	local target = ply.TradeTarget
	if not ply.TradeTarget then return end
	net.Start("add_trade")
		net.WriteInt(net.ReadInt(32), 32)
		net.WriteInt(net.ReadInt(32), 32)
	net.Send(target)
	target.AcceptTrade = false
	ply.AcceptTrade = false
end)
--[[
	Called when a player removes an item from the trade
--]]
util.AddNetworkString("remove_trade")
net.Receive("remove_trade", function(len, ply)
	--if not ply.TradeTarget then return end
	local target =  ply.TradeTarget
	net.Start("remove_trade")
		net.WriteInt(net.ReadInt(32), 32)
		net.WriteInt(net.ReadInt(32), 32)
	net.Send(target)
	target.AcceptTrade = false
	ply.AcceptTrade = false
end)