local Player = FindMetaTable("Player")

function Player:LoadProfile()

	local q1 = "SELECT * FROM items WHERE steamid = '"..self:SteamID64().."'"
	local q2 = "SELECT * FROM players WHERE steamid = '"..self:SteamID64().."'"
	local q3 = "SELECT * FROM vehicles WHERE steamid = '"..self:SteamID64().."'"

	function SetData(str)
		if str[1] == nil then
			self:CreateProfile()
		else
			self:SetNWInt('money', str[1].money)
			self:SetPlaytime(CurTime(), str[1].playtime*60)
			self:SetNWString('name', str[1].name)
			self:SetRank(str[1].rank)
			self.Skin = str[1].skin
			self:SetPoliceRank(str[1].policerank)
			self.PoliceTime = str[1].policetime*60
			self:SetParamedicRank(str[1].paramedicrank)
			self.ParamedicTime = str[1].paramedictime * 60
			self:Spawn()
		end
	end
	GetDataQuery(q2, SetData)
	function SetInventory(str)
		for i=1,#str do
			--if tonumber(str[i].steamid) ~= self:SteamID64() then print("Error with ID") return end 
			self:SetItem(i, str[i].itemid, str[i].quantity)
		end
	end
	GetDataQuery(q1, SetInventory)
	function SetVehicle(str)
		for i=1,#str do
			self:SetVehicle(str[i].vehicleid, string.ToColor(str[i].color))
		end
	end
	GetDataQuery(q3, SetVehicle)
end

function Player:CreateProfile()

	local nick, money = self:Nick(), self:GetNWInt('money')

	local q = "INSERT INTO players ( steamid, steamname, skin, money, rank, playtime, policerank, policetime, paramedicrank, paramedictime ) VALUES ( '"..self:SteamID64().."', '"..nick.."', '01', '15000', '0', '0', '0', '0', '0', '0' )"	
	self:SetNWInt("money", 15000)
	self:SetRank(0)
	self:SetPlaytime(CurTime(), 0)
	self.Skin = "01"
	self.PoliceTime = 0
	self:SetPoliceRank(0)
	self.ParamedicTime = 0
	self:SetParamedicRank(0)
	self:ChooseSkin()
	Query(q)
end

function Player:SaveProfile()

	local money = self:GetNWInt('money')
	local playtime = math.Round( (self:GetSessionTime() + self.Playtime) / 60 )
	local rank = self.Rank
	local inv = self.Inventory
	local savestring = ""

 
	local goodsave = string.sub(savestring, 2)

	local q = "UPDATE players SET playtime = '"..playtime.."', policetime = '"..math.Round(self.PoliceTime/60).."', paramedictime = '"..math.Round(self.ParamedicTime/60).."' WHERE steamid = '"..self:SteamID64().."'"
	Query(q)

end

function Player:SetMoney(amount)
	self:SetNWInt( 'money', amount)
	local q = "UPDATE players SET money = '"..amount.."' WHERE steamid = '"..self:SteamID64().."'"
	Query(q)
end

function Player:AddMoney(amount)
	if CheckInt(amount) then
		self:SetNWInt( 'money', self:GetMoney() + amount)
		local q = "UPDATE players SET money = '"..self:GetMoney()+amount.."' WHERE steamid = '"..self:SteamID64().."'"
		Query(q)
	else
		return false
	end
end

function Player:RemoveMoney(amount)
	if self:GetNWInt('money') - amount >= 0 then
		self:SetNWInt( 'money', self:GetMoney() - amount) 
		local q = "UPDATE players SET money = '"..self:GetMoney()-amount.."' WHERE steamid = '"..self:SteamID64().."'"
		Query(q)
		return true
	else
		return false
	end
end

function Player:Setskin(skintxt)
	self.Skin = skintxt
	local q = "UPDATE players SET skin = '"..skintxt.."' WHERE steamid = '"..self:SteamID64().."'"
	Query(q)
	self:SetModel("models/player/Group01/Male_"..skintxt..".mdl")
end

function Player:ChooseSkin()
	net.Start("open_panel")
		net.WriteInt(1, 32)
	net.Send(self)
end

function Player:GiveOtherMoney( receiver, amount )

	if IsValid(receiver) && receiver:GetClass() == "player" && amount >= 0 then
		if self:RemoveMoney(amount) then
			receiver:AddMoney(amount)
			self:Notify("You gave "..amount.."$ to "..receiver:Nick(), 2)
			receiver:Notify("You received "..amount.."$ from "..self:Nick(), 2)
		end
	end

end

util.AddNetworkString("holsterweapon")
net.Receive("holsterweapon", function(len, ply)
	ply:HolsterWeapon()
end)
function Player:HolsterWeapon()
	local actwep = self:GetActiveWeapon():GetClass()
	if GAMEMODE.LoadoutTable[actwep] then return end
	
	self:GiveItem(RefToID("item_"..actwep), 1)
	self:StripWeapon(actwep)
end

function Player:LoadPlayersRank()
	for k,v in pairs(player.GetAll()) do
		if v ~= self then
			net.Start("rank")
				net.WriteEntity(v)
				net.WriteInt(v.Rank, 16)
			net.Send(self)
		end
	end
end

util.AddNetworkString("playsound")
function Player:PlaySound(sound)
	net.Start("playsound")
		net.WriteString(sound)
	net.Send(self)
end

util.AddNetworkString("notification")
function Player:Notify(msg, time)

	net.Start("notification")
		net.WriteString( msg )
		if time then
			net.WriteInt(time, 32)
		end
	net.Send( self )
end

util.AddNetworkString("emitsound")
net.Receive("emitsound", function(len, ply)
	ply:EmitSound(net.ReadString())
end)

util.AddNetworkString("setskin")
net.Receive("setskin", function(len, ply) 
	if not ply:IsValid() then return end

	ply:Setskin("0"..net.ReadInt(32))
end)

util.AddNetworkString( "giveothermoney" )
net.Receive("giveothermoney", function( len, pl )

	local ent = net.ReadEntity()
	local amount = net.ReadInt(32)

	pl:GiveOtherMoney(ent, amount)

end)
