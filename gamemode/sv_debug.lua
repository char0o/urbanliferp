concommand.Add("sql_createtable", function()
	Query("CREATE TABLE items (steamid bigint UNSIGNED, itemid tinyint UNSIGNED, quantity smallint UNSIGNED, PRIMARY KEY(steamid, itemid))")
	Query("CREATE TABLE players (steamid bigint UNSIGNED, steamname varchar(32), skin char(2), money int UNSIGNED, rank tinyint UNSIGNED, playtime int UNSIGNED, policerank tinyint UNSIGNED, policetime int UNSIGNED, paramedicrank tinyint UNSIGNED, paramedictime int UNSIGNED,  PRIMARY KEY(steamid))")
	Query("CREATE TABLE bans (steamid bigint UNSIGNED, steamname varchar(32), bantime int UNSIGNED, banduration smallint UNSIGNED, reason varchar(50), PRIMARY KEY(steamid))")	
	Query("CREATE TABLE vehicles (steamid bigint UNSIGNED, steamname varchar(32), vehicleid tinyint UNSIGNED, color varchar(50), PRIMARY KEY(steamid, vehicleid))")
end)
concommand.Add('sql_dropthetable', function() 
	Query("DROP TABLE players, bans, items, vehicles")
end)
concommand.Add("rp_spawnvehicle", function(ply, cmd, args)
	ply:SpawnVehicle(tonumber(args[1]))
end)
concommand.Add("rp_getinseat", function(ply, cmd, args) 
	local eye = ply:GetEyeTrace().Entity
	ply:EnterVehicle(eye.SeatDB[tonumber(args[1])])
end)

concommand.Add("rp_sendvehicles", function(ply) 
	ply:SendVehicles()
end)

concommand.Add("rp_newcolor", function(ply, cmd, args) 
	ply:ChangePaint(tonumber(args[1]), tonumber(args[2]))
end)

concommand.Add("rp_getvehicles", function(ply) 
	for k,v in pairs(ply.Vehicles) do
		print(k, v.Color)
	end
end)

concommand.Add("rp_spawnpersonalvehicle", function(ply, cmd, args) 
	if not ply.Vehicles[tonumber(args[1])] then return end

	ply:SpawnVehicle(tonumber(args[1]), ply.Vehicles[tonumber(args[1])].Color, ply:GetPos(), ply:GetAngles())
end)

concommand.Add("rp_clearvehicles_sv", function(ply) 
	ply.Vehicles = {}
end)

concommand.Add("rp_printcartable", function() 
	PrintTable(BuyCarPos)
end)
concommand.Add("rp_givemoney", function(ply, cmd, args)
	ply:AddMoney(tonumber(args[1]))
end)
concommand.Add("rp_setowner", function(ply, cmd, args)
	local eye = ply:GetEyeTrace().Entity

	eye:Setowner(ply)
	print("set "..ply:Nick().." as owner")
end)
