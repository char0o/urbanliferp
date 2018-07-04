local Player = FindMetaTable("Player")
--[[
	Checks if the player should be promoted
	to the next rank of his job
--]]
function Player:CheckPromotion()
	if self:Team() == TEAM_CITIZEN then 
		return
	elseif self:Team() == TEAM_POLICE then
		if self.PoliceRank == 6 || math.floor(math.floor(CurTime() / 60) - math.floor(self.PoliceJoinTime/60)  + math.floor(self.PoliceTime/60)) == 0 then return end
		local modul = math.floor((math.floor(CurTime() / 60) - math.floor(self.PoliceJoinTime/60)  + math.floor(self.PoliceTime/60)) % GAMEMODE.PolicePromotionTime)
		if modul  == 0 then
			self:SetPoliceRank(self.PoliceRank + 1)
			self:Notify("Promotion!"..JOB_DB[TEAM_POLICE].Promotion[self.PoliceRank], 5)
		end
	elseif self:Team() == TEAM_PARAMEDIC then
		if self.ParamedicRank == 6 || math.floor(math.floor(CurTime() / 60) - math.floor(self.ParamedicJoinTime/60)  + math.floor(self.ParamedicTime/60)) == 0 then return end
		local modul = math.floor((math.floor(CurTime() / 60) - math.floor(self.ParamedicJoinTime/60)  + math.floor(self.ParamedicTime/60)) % GAMEMODE.ParamedicPromotionTime)
		if modul  == 0 then
			self:SetPoliceRank(self.ParamedicRank + 1)
			self:Notify("Promotion!"..JOB_DB[TEAM_POLICE].Promotion[self.ParamedicRank], 5)
		end
	end
end
--[[
	Changes the team of the player
	Updates the db with the time passed
	in the job.
--]]
function Player:ChangeJob(new)
	if new == TEAM_POLICE then
		self.PoliceJoinTime = math.Round(CurTime())
	elseif new == TEAM_PARAMEDIC then
		self.ParamedicJoinTime = math.Round(CurTime())
	end
	if self:Team() == TEAM_POLICE then
		local oldtime = self.PoliceTime
		self.PoliceTime = math.Round(CurTime() - self.PoliceJoinTime + oldtime)
		local q = "UPDATE players SET policetime = '"..self.PoliceTime.."' WHERE steamid = '"..self:SteamID64().."'"
		Query(q)
		self.PoliceJoinTime = nil
	elseif self:Team() == TEAM_PARAMEDIC then
		local oldtime = self.ParamedicTime
		self.ParamedicTime = math.Round(CurTime() - self.ParamedicJoinTime + oldtime)
		local q = "UPDATE players SET paramedictime = '"..self.ParamedicTime.."' WHERE steamid = '"..self:SteamID64().."'"
		Query(q)
		self.ParamedicJoinTime = nil
	end
	self:SetTeam(new)
end