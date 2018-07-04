local Player = FindMetaTable("Player")

function Player:GetMoney()
	return self:GetNWInt( 'money' ) 
end
function Player:HasMoney(amount)
	if self:GetNWInt("money") - amount >= 0 then
		return true
	else
		return false
	end
end

function Player:IsPolice()
	return self:Team() == 2
end
function Player:IsParamedic()
	return self:Team() == 3
end
function Player:IsGovOfficial()
	return self:IsPolice() || self:IsParamedic()
end
--[[
	Returns the number of seconds the player has played
	on the server globally
--]]
function Player:GetPlayTime()
	if SERVER then
		return math.Round(CurTime() - self.Jointime + self.Playtime)
	end
	if CLIENT then
		return math.Round(CurTime() - GAMEMODE.Jointime + GAMEMODE.Playtime)
	end
end
--[[
	Returns the number of seconds since the player joined
--]]
function Player:GetSessionTime()
	if SERVER then
		return math.Round(CurTime() - self.Jointime)
	end
	if CLIENT then
		return math.Round(CurTime() - GAMEMODE.Jointime)
	end
end
--[[
	Returns the salary of the player, if he's
	a cop mutliply his salary by his rank
--]]
function Player:GetSalary()
	if SERVER then
		if self:IsPolice() then
			return JOB_DB[2].Salary + self.PoliceRank * GAMEMODE.PoliceSalaryUpgrade
		elseif self:IsParamedic() then
			return JOB_DB[3].Salary + self.ParamedicRank * GAMEMODE.ParamedicSalaryUpgrade
		else
			return JOB_DB[self:Team()].Salary
		end
	end

	if CLIENT then
		if self:IsPolice() then
			return JOB_DB[2].Salary + GAMEMODE.PoliceRank * GAMEMODE.PoliceSalaryUpgrade
		elseif self:IsParamedic() then
			return JOB_DB[3].Salary + GAMEMODE.ParamedicRank * GAMEMODE.ParamedicSalaryUpgrade
		else
			return JOB_DB[self:Team()].Salary
		end
	end
	return JOB_DB[self:Team()].Salary
end
if SERVER then
	util.AddNetworkString("rank")

	function Player:SetRank(int, todb)
		self.Rank = int
		net.Start("rank")
			net.WriteEntity(self)
			net.WriteInt(self.Rank, 16)	
		net.Broadcast()
		if not todb then return end
		local q = "UPDATE players SET rank = '"..int.."' WHERE steamid = '"..self:SteamID64().."'"
		Query(q)
	end
	util.AddNetworkString("playtime")

	function Player:SetPlaytime(int, int2)
		self.Jointime = math.Round(int)
		self.Playtime = int2
		net.Start("playtime")
			net.WriteInt(self.Jointime, 32)
			net.WriteInt(self.Playtime, 32)
		net.Send(self)
	end

	util.AddNetworkString("policerank")
	function Player:SetPoliceRank(int)
		self.PoliceRank = int
		self:SetSkin(self.PoliceRank)
		net.Start("policerank")
			net.WriteInt(self.PoliceRank, 32)
		net.Send(self)
	end	

	util.AddNetworkString("paramedicrank")
	function Player:SetParamedicRank(int)
		self.ParamedicRank = int
		net.Start("policerank")
			net.WriteInt(self.ParamedicRank, 32)
		net.Send(self)
	end	
end
if CLIENT then
	net.Receive("rank", function()
		local ply = net.ReadEntity()
		local rank = net.ReadInt(16)
		print(ply, rank)
		if ply == LocalPlayer() then
			GAMEMODE.Rank = net.ReadInt(16)
		else
			ply.Rank = rank
		end
	end)
	net.Receive("playtime", function()
		GAMEMODE.Jointime = net.ReadInt(32)
		GAMEMODE.Playtime = net.ReadInt(32)
	end)
	net.Receive("policerank", function() 
		GAMEMODE.PoliceRank = net.ReadInt(32)
	end)
	net.Receive("paramedicrank", function() 
		GAMEMODE.PoliceRank = net.ReadInt(32)
	end)
end

function Player:Isadmin()
	if SERVER then
		return self.Rank >= 5 
	end
	if CLIENT then
		return GAMEMODE.Rank >= 5
	end
end