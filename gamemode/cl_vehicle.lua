--[[
	Receives player's vehicle from the server
--]]
net.Receive("vehicles", function() 
	local vehid = net.ReadInt(32)
	local vehcolor = Color(net.ReadInt(32), net.ReadInt(32), net.ReadInt(32))

	GAMEMODE.PlayerVehicles[vehid] = {Color = vehcolor}
end)
--[[
	Returns if the player has the vehicle from ID
--]]
function GM.PlayerHasVehicle(id)
	if GAMEMODE.PlayerVehicles[id] then
		return true
	else
		return false
	end
end
--[[
	Called from the car dealer to buy a car
	Sends vehicle ID and color to server
--]]
function GM.PlayerBuyCar(vehid, color)
	PrintTable(color)
	net.Start("buy_car")
		net.WriteInt(vehid, 32)
		net.WriteInt(color.r, 32)
		net.WriteInt(color.g, 32)
		net.WriteInt(color.b, 32)
	net.SendToServer()
end
