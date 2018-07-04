local Player = FindMetaTable("Player")

function Player:RealBan(time, reason)

	if not IsValid(self) || self.Rank == 9 then return end
	local ostime = math.Round(os.time() / 60)
	if time ~= 0 then 
		Query("INSERT INTO bans(steamid, steamname, bantime, banduration, reason) VALUES ('"..self:SteamID64().."', '"..self:Nick().."', '"..ostime.."', '"..time.."', '"..reason.."')") 
	else
		print("WTF")
		Query("INSERT INTO bans(steamid, steamname, bantime, banduration, reason) VALUES ('"..self:SteamID64().."', '"..self:Nick().."', '"..ostime.."', '0', '"..reason.."')")		
	end
	self:Kick(reason)

	for k, v in pairs(player.GetAll()) do
		if time == 0 then
			v:ChatPrint("Player "..self:Nick().." has been banned permanently. Reason: "..reason)
		else
			v:ChatPrint("Player "..self:Nick().." has been banned for "..parseAdminTime(time)..". Reason: "..reason)
		end
	end
end

util.AddNetworkString("kick_player")

net.Receive( "kick_player" , function(len, pl)
	local ply = net.ReadEntity()

	if not IsValid(ply) || not pl:Isadmin() || pl == ply then return end

	ply:Kick(net.ReadString())

end)

util.AddNetworkString( "ban_player" )

net.Receive( "ban_player", function(len, pl)

	local ply = net.ReadEntity()
	local int = net.ReadInt(32)
	local string = net.ReadString()

	if not IsValid(ply) || not pl:Isadmin() then return end
	print(ply)
	print(int)
	print(string)
	ply:RealBan(int, string)
end)

util.AddNetworkString("freeze_player")

net.Receive( "freeze_player", function(len, pl)
	local ply = net.ReadEntity()
	if not IsValid(ply) || not pl:Isadmin() then return end

	if not ply.Frozen then
		ply:Freeze(true)
		ply.Frozen = true
	else
		ply:Freeze(false)
		ply.Frozen = false
	end
end)
