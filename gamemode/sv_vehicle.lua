local Player = FindMetaTable("Player")

local BuyCarPos = { { Pos = Vector(4364.31, -5898.44, 55.78), Ang = Angle(0, 158.55, 0.18) }  }

function Player:SpawnVehicle(id, color, pos, ang)
	if self.SpawnedVehicle then self:Notify("Already a car spawned", 2) return end
	local vehicle = ents.Create("prop_vehicle_jeep")
		vehicle:SetPos(pos)
		vehicle:SetAngles(ang)
		vehicle:SetModel(VEHICLE_DB[id].Model)
		vehicle:SetColor(color)
		vehicle:SetKeyValue("vehiclescript", "scripts/vehicles/rp_"..VEHICLE_DB[id].Script..".txt")
		vehicle:Setowner(self)
		vehicle.SeatDB = { }
		vehicle.ExitPoint = VEHICLE_DB[id].ExitPoint
		vehicle:lock()
		for k,v in pairs(VEHICLE_DB[id].PassengerSeats) do
			local seats = ents.Create("prop_vehicle_prisoner_pod")
				seats:SetKeyValue("vehiclescript", "scripts/vehicles/prisoner_pod.txt")
				seats:SetModel("models/nova/airboat_seat.mdl")
				seats:SetPos(vehicle:GetPos()+vehicle:GetRight()*v.x+vehicle:GetForward()*v.y+vehicle:GetUp()*v.z)
				seats:SetAngles(vehicle:GetAngles())
				seats:SetParent(vehicle)
				seats:SetNoDraw(true)
				seats.ID = k + 1
			seats:Spawn()
			vehicle.SeatDB[k] = seats
		end
	vehicle:Spawn()
	self.SpawnedVehicle = vehicle
end
function GM.EnterVehicle(ply, veh)
	if not IsValid(ply) || not IsValid(veh) || not veh:IsVehicle() || not ply:IsPlayer() || veh.Locked then return end

	if veh:GetModel() == "models/nova/jeep_seat.mdl" then

	else
		if veh:GetDriver() ~= NULL then
			for k,v in pairs(veh.SeatDB) do
				if v:GetDriver() == NULL then
					ply:EnterVehicle(v)
					break
				end
			end
		end
	end
end
hook.Add("PlayerUse", "entervehicle", GM.EnterVehicle)

util.AddNetworkString("vehicles")

function Player:BuyVehicle(vehid, color)
	if not VEHICLE_DB[vehid] || self:GetNWInt("money") < VEHICLE_DB[vehid].Price then return end
	local colorstring = ""..color.r.." "..color.g.." "..color.b.." 255"
	self:RemoveMoney(VEHICLE_DB[vehid].Price)
	self.Vehicles[vehid] = {Color = color}
	Query("INSERT INTO vehicles (steamid, steamname, vehicleid, color) VALUES ('"..self:SteamID64().."', '"..self:Nick().."' ,'"..vehid.."', '"..colorstring.."') ")
	net.Start("vehicles")
		net.WriteInt(vehid, 32)
		net.WriteInt(color.r, 32)
		net.WriteInt(color.g, 32)
		net.WriteInt(color.b, 32)
	net.Send(self)
	if self.SpawnedVehicle then
		self.SpawnedVehicle:Remove()
		self.SpawnedVehicle = nil
	end
	print(BuyCarPos[1])
	self:SpawnVehicle(vehid, color, BuyCarPos[1].Pos, BuyCarPos[1].Ang)
end

function Player:RemoveCar()
	self.SpawnedVehicle:Remove()
	self.SpawnedVehicle = nil
end
function Player:HasVehicle(vehid)
	for k,v in pairs(self.Vehicles) do
		if k == vehid then 
			return true
		else
			return false
		end
	end
end

function Player:SetVehicle(vehid, color)
	self.Vehicles[vehid] = {Color = color}
	net.Start("vehicles")
		net.WriteInt(vehid, 32)
		net.WriteInt(color.r, 32)
		net.WriteInt(color.g, 32)
		net.WriteInt(color.b, 32)
	net.Send(self)
end

function Player:SendVehicles()
	for k,v in pairs(self.Vehicles) do
		net.Start("vehicles")
			net.WriteInt(k, 32)
			net.WriteInt(v.Color.r, 32)
			net.WriteInt(v.Color.g, 32)
			net.WriteInt(v.Color.b, 32)
		net.Send(self)
	end
end

function Player:ChangePaint(vehid, color)
	if not self.Vehicles[vehid] then return end
	local colorstring = ""..color.r.." "..color.g.." "..color.b" 255"
	self.Vehicles[vehid] = {Color = color}
	net.Start("vehicles")
		net.WriteInt(vehid, 32)
		net.WriteInt(color.r, 32)
		net.WriteInt(color.g, 32)
		net.WriteInt(color.b, 32)
	net.Send(self)
	Query("UPDATE vehicles SET color = '"..colorstring.."' WHERE steamid = '"..self:SteamID64().."'")
end
util.AddNetworkString("buy_car")

net.Receive("buy_car", function(len, ply) 
	local carid, color = net.ReadInt(32), Color(net.ReadInt(32), net.ReadInt(32), net.ReadInt(32))

	ply:BuyVehicle(carid, color)
end)
util.AddNetworkString("speedometer")
function GM:PlayerEnteredVehicle(ply, veh)
	timer.Create( "speedometer", 0.25, 0, function()
		net.Start("speedometer")
			net.WriteInt(veh:GetSpeed(), 32)
		net.Send(ply)
	end)
	net.Send(ply)
end

function GM:PlayerLeaveVehicle(ply, veh)
	timer.Remove("speedometer")
	if veh:GetParent() ~= NULL then
		ply:SetPos(veh:GetParent():GetPos() + veh:GetParent():GetRight() * veh:GetParent().ExitPoint[veh.ID].x + veh:GetParent():GetForward() * veh:GetParent().ExitPoint[veh.ID].y + veh:GetParent():GetUp() * veh:GetParent().ExitPoint[veh.ID].z)
		ply:SetEyeAngles(Angle(0, 180, 0))
		return
	end
	ply:SetPos(veh:GetPos()+veh:GetRight() * veh.ExitPoint[1].x+veh:GetForward() * veh.ExitPoint[1].y + veh:GetUp() * veh.ExitPoint[1].z)
	ply:SetEyeAngles(Angle(0, 180, 0))
end