local Entity = FindMetaTable("Entity")
--[[
	Returns if the entity is a door using our
	door model table
--]]
function Entity:IsDoor()
	if self:IsVehicle() then return true end
	if not GAMEMODE.DoorModelTable[self:GetModel()] then return false end
	return true
end
