local Entity = FindMetaTable("Entity")

function Entity:Setowner(ent)
	self.Owner = ent
	self:SetNWEntity("owner", ent)
end

function Entity:SetID(id)

	self.ID = id

end

function Entity:lock()
	self:Fire("Lock")
	self.Locked = true
end

function Entity:Unlock()
	self:Fire("Unlock")
	self.Locked = false
end