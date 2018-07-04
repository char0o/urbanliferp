local Player = FindMetaTable("Player")

function Player:RentProperty(id)
	if not PROPERTY_DB[id] || not self:IsValid() then return end
	for _, v in pairs(PROPERTY_DB[id].Doors) do
		for _, u in pairs(ents.FindInSphere(v.Pos, 5)) do
			if not v.Model == u:GetModel() || not u.Owner == NULL then return end
			u:Setowner(self)
		end
	end
	self:RemoveMoney(PROPERTY_DB[id].Price)
end

function Player:VacantProperty(id)
	if not PROPERTY_DB[id] || not self:IsValid() then return end
	for _, v in pairs(PROPERTY_DB[id].Doors) do
		for _, u in pairs(ents.FindInSphere(v.Pos, 5)) do
			if not v.Model == u:GetModel() || not v.Owner == self then return end
			u:Setowner(NULL)
		end
	end
	self:AddMoney(PROPERTY_DB[id].Price/2)
end