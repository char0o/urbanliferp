--[[
	When the players initially spawns, create variables
	and then load the profile
--]]
function GM:PlayerInitialSpawn(ply)
	ply.Inventory = ply:CreateInventory()
	ply.Vehicles = {}
	ply.SpawnedProps = 0
	ply:SetTeam(1)
	timer.Simple(3, function() 
		ply:LoadPlayersRank() 
		ply:LoadProfile()
	end)
	
end

--[[
	Everytime the player spawns handle loadouts and models
--]]
function GM:PlayerSpawn( ply )
	timer.Simple(1, function() --For some reason the player always spawns with ammo
		ply:StripAmmo()
		if ply:IsPolice() then
			ply:GiveAmmo(45, "pistol", true)
		end
	end)
	local skinid = ply.Skin or "01"
	if ply:IsPolice() then
		ply:SetModel(JOB_DB[ply:Team()].Model..""..skinid..".mdl")
		ply:SetSkin(ply.PoliceRank)
	else
		ply:SetModel(JOB_DB[ply:Team()].Model..""..skinid..".mdl")
	end

	ply:StripWeapons()
	for k, v in pairs(GAMEMODE.LoadoutTable) do
		ply:Give(k)
	end

	if ply:IsPolice() then
		for k, v in pairs(JOB_DB[ply:Team()].Loadout[ply.PoliceRank+1]) do
			ply:Give(v)
		end
	end
end

--[[
	When the player dies drop his current guns.
--]]
function GM:PlayerDeath(victim, inflictor, attacker)
	victim.DeathTime = CurTime()
	for k,v in pairs(victim:GetWeapons()) do
		if not GAMEMODE.LoadoutTable[v:GetClass()] && not victim:IsGovOfficial() then
			GAMEMODE.DropItem(RefToID("item_"..v:GetClass()), victim:GetPos()+Vector(0, 0, 50))
		end
	end
end
--[[
	When the player dies drop his current guns
--]]
function GM:PlayerDeathThink(ply)
	if ply.DeathTime + GAMEMODE.DeathTime < CurTime() then
		--ply:UnSpectate()
		ply:Spawn()
		--ply.ragdoll:Remove()
		ply:Notify("The paramedics were too slow to save you.", 5)
	end
end

function GM:PlayerDeathSound()
	return true
end

function GM:DoPlayerDeath(ply, attacker, dmginfo)
	ply:CreateRagdoll()
	ply:Spectate(OBS_MODE_IN_EYE)
	ply:SpectateEntity(ply:GetRagdollEntity())
		/*ply.ragdoll = ents.Create("prop_ragdoll")
			ply.ragdoll:SetPos(ply:GetPos())
			ply.ragdoll:SetAngles(ply:GetAngles())
			ply.ragdoll:SetModel(ply:GetModel())
			ply.ragdoll:SetSkin(ply:GetSkin())
			ply.ragdoll:SetVelocity(ply:GetVelocity())
		ply.ragdoll:Spawn()
		ply:Spectate(OBS_MODE_IN_EYE)
		ply:SpectateEntity(ply.ragdoll)
		ply:SetAngles(Angle(0, 0, 90))
		ply:SetViewOffset(Vector(0, 0, 0))
		ply.ragdoll:SetCollisionGroup(2)*/
end

function GM:PlayerDisconnected( ply )
	ply:SaveProfile()
end

local todelete = {	["models/props_wasteland/kitchen_counter001d.mdl"] = true,
					["models/sickness/genericsign_001.mdl"] = true,
					["models/props_c17/chair02a.mdl"] = true,
					["models/props_wasteland/controlroom_desk001b.mdl"] = true,
					["models/u4lab/chair_office_a.mdl"] = true,
					["models/props/de_tides/patio_chair2.mdl"] = true,
					["models/props_interiors/table_picnic.mdl"] = true,
					["models/props/cs_office/chair_office.mdl"] = true,
					["models/highrise/cubicle_monitor_01.mdl"] = true}
function GM:InitPostEntity()
	for k, v in ipairs(NPC_DB) do
	
		local npc = ents.Create("npc_base")

			npc:SetID(v.ID)
			npc:SetPos(v.Location)
			npc:SetAngles(v.Angles)
			npc:SetModel(v.Model)
			if v.Skin then
				npc:SetSkin(v.Skin)
			end
			npc.Panel = v.Panel
			npc:Spawn()
	end

	for k,v in pairs(ents.GetAll()) do
		if todelete[v:GetModel()] then
			v:Remove()
		end
	end
end

function GM:PlayerAuthed(ply, steamid, uniqueid)
	local query = "SELECT * FROM bans WHERE steamid = '"..ply:SteamID64().."'"

	GetDataQuery(query, function(tbl) 
		if tbl[1] == nil then return end

		local bantime = tbl[1].bantime
		local banduration = tbl[1].banduration

		if banduration == 0 then
			ply:Kick("You are permanently banned.")
		end
		local minuteduration = (bantime+banduration-os.time())/60
		
		if os.time() < bantime+banduration then
			ply:Kick("Banned for "..parseAdminTime(minuteduration))
			return
		elseif os.time() > bantime+banduration then
			Query("DELETE FROM bans WHERE steamid = '"..ply:SteamID64().."'")
			return
		end
	end)
end

function GM:PhysgunPickup(ply, ent)
	if ent:IsDoor() || ent:IsVehicle() || GAMEMODE.CantPickupClass[ent:GetClass()] || GAMEMODE.CantPickupModel[ent:GetModel()]  then 
		return ply:Isadmin()
	else 
		return true
	end
end

function GM:CheckPassword(steamid64)
	local query = "SELECT * FROM bans WHERE steamid = '"..steamid64.."'"

	GetDataQuery(query, function(tbl)
		if tbl[1] == nil then return end
		local bantime = tbl[1].bantime
		local banduration = tbl[1].banduration

		local minuteduration = printbantime+banduration-os.time()
		if os.time() < bantime+banduration then
			return false, "Banned for "..parseAdminTime(minuteduration)
		elseif os.time() > bantime+banduration then
			Query("DELETE FROM bans WHERE steamid = '"..ply:SteamID64().."'")
			return true
		end
	end)
end

util.AddNetworkString("open_panel")
hook.Add("ShowTeam", "Inventory", function(ply) 
	net.Start("open_panel")
		net.WriteInt(2, 32)
	net.Send(ply)
end)