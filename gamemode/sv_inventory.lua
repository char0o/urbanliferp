local Player = FindMetaTable("Player")
--[[
	Creates the player's inventory and
	returns the table
	Currently only has 32 slots
--]]
function Player:CreateInventory()

	local Inventory = {}

	for i=1,32 do 
		table.insert(Inventory, {Slot = 0, ID = 0, Quantity = 0, Ref = "" })
	end
	
	return Inventory

end

--[[
	Sets a specific slots of the inventory
	with a new id and quantity
	Updates to clientside
--]]
util.AddNetworkString("item_set")
function Player:SetItem(slot, id, quantity)

	self.Inventory[slot].Slot     = slot
	self.Inventory[slot].ID       = id
	self.Inventory[slot].Quantity = quantity
	self.Inventory[slot].Ref 	  = ITEM_DB[tonumber(id)].Ref

	net.Start("item_set")
		net.WriteInt(slot, 32)
		net.WriteInt(id, 32)
		net.WriteInt(quantity, 32)
	net.Send(self)

end


function Player:PrintInventory()
	local inv = self.Inventory

	for k, v in pairs(inv) do 
		if(v.ID) ~= 0 then
			PrintTable(v)
		end
	end
end

--[[
	Adds a new item to the inventory using item ID
	Updates to clientside
--]]
util.AddNetworkString("item_give")
function Player:GiveItem(id, quantity)
	local inv = self.Inventory

	if ITEM_DB[id] then --If there is already this item in the inventory
		for k, v in pairs(self.Inventory) do
			if v.ID == id then

				inv[k].Slot = k
				inv[k].Quantity = v.Quantity + quantity

				net.Start("item_give")
					net.WriteInt(id, 32)
					net.WriteInt(quantity, 32)
				net.Send(self)

				self:PlaySound("physics/wood/wood_box_impact_soft1.wav")

				Query("UPDATE items SET quantity='"..v.Quantity.."' WHERE steamid = '"..self:SteamID64().."' AND itemid = '"..v.ID.."' ")
				break
			end

			if v.ID == 0 then --If there is not already this item in the inventory
				inv[k] = {Slot = k, ID = id, Quantity = quantity, Ref = ITEM_DB[id].Ref}
				net.Start("item_give")
						net.WriteInt(id, 32)
						net.WriteInt(quantity, 32)
				net.Send(self)
				Query("INSERT INTO items (steamid, itemid, quantity) VALUES ('"..self:SteamID64().."', '"..id.."', '"..quantity.."')")
				self:PlaySound("physics/wood/wood_box_impact_soft1.wav")
				break
			end
		end
	else
		print("Wrong ID")
		self:Notify("Wrong ID")
	end
end

--[[
	Remove and item from the inventory using item ID
	Updates to clientside
--]]
util.AddNetworkString("remove_item")
function Player:RemoveItem(id, quantity)
	local inv = self.Inventory
	if not id or not quantity  then print("Args missing") return end

	for k, v in pairs(inv) do
		if v.ID == id then

			local quant = v.Quantity
			if(quant - quantity) < 0 then
				break
			elseif (quant - quantity) > 0 then

				inv[k].Quantity = v.Quantity - quantity
				net.Start("remove_item")
					net.WriteInt(id, 32)
					net.WriteInt(quantity, 32)
				net.Send(self)
				Query("UPDATE items SET quantity = '"..v.Quantity.."' WHERE steamid = '"..self:SteamID64().."' AND itemid = '"..v.ID.."'")
				break
			elseif (quant - quantity) == 0 then
				self:ClearSlot(v.Slot)
				Query("DELETE FROM items WHERE steamid='"..self:SteamID64().."' AND itemid='"..v.ID.."' ")
				break	
			end
			break
		end
	end
end
--[[
	Receives slot movement from clientside
--]]
util.AddNetworkString("item_changeslot")
net.Receive("item_changeslot", function(len, ply) 
	ply:ChangeItemSlot(net.ReadInt(16), net.ReadInt(16))
end)

--[[
	Changes the position of 2 items in the inventory
--]]
function Player:ChangeItemSlot(oldslot, newslot) --If there's an item in the newslot, switch it

		local inv = self.Inventory

		if newslot > 32 && oldslot > 32 then

			print('Slot number is too high')
			return

		elseif oldslot == newslot then
			
			print("Can't have the same slot number!")
			return 
		end

		for k, v in pairs(inv) do 

			if self:SlotIsEmpty(newslot) then
				self:SetItem(newslot, inv[oldslot].ID, inv[oldslot].Quantity)
				self:ClearSlot(oldslot)
				/*net.Start("item_changeslot")
					net.WriteInt(oldslot, 32)
					net.WriteInt(newslot, 32)
				net.Send(self)*/
				break
			end

			if not self:SlotIsEmpty(newslot) then
				if self:SlotIsEmpty(oldslot) then
					self:SetItem(oldslot, inv[newslot].ID, inv[newslot].Quantity)
					self:ClearSlot(newslot)
					/*net.Start("item_changeslot")
						net.WriteInt(oldslot, 32)
						net.WriteInt(newslot, 32)
					net.Send(self)*/
					break
				else
				local oldid, oldquant = inv[newslot].ID, inv[newslot].Quantity
					self:SetItem(newslot, inv[oldslot].ID, inv[oldslot].Quantity)
					self:SetItem(oldslot, oldid, oldquant)
					/*net.Start("item_changeslot")
						net.WriteInt(newslot, 32)
						net.WriteInt(oldslot, 32)
					net.Send()*/
					break
				end
				break
			end
		end	
end

function Player:InventoryIsFull()
	local inv = self.Inventory

	for k,v in pairs(inv) do
		if v.ID == 0 then
			return false
		end
	end
	return true
end

util.AddNetworkString("item_clearslot")
function Player:ClearSlot(slot)
	local inv = self.Inventory
	inv[slot] = {Slot = 0, ID = 0, Quantity = 0, Ref = ""}
	net.Start("item_clearslot")
		net.WriteInt(slot, 32)
	net.Send(self)
	/*for k,v in pairs(inv) do
		if v.Slot == slot then
			inv[k] = {Slot = 0, ID = 0, Quantity = 0, Ref = ""}
			break
		end
	end*/
end

util.AddNetworkString("inventory")
function Player:SendInventory()

	local inv = self.Inventory


		for k,v in pairs(inv) do

			if v.ID ~= 0 then
				net.Start("inventory")
					net.WriteInt( v.ID, 32 )
					net.WriteInt( v.Quantity, 32 )
					net.WriteInt( v.Slot, 32 )
				net.Send( self )
			end
		end
end

function Player:GetItemSlot(slot)
	return self.Inventory[slot] end

function Player:SlotIsEmpty(slot)
	local inv = self.Inventory

	if inv[slot].ID == 0 then
		return true
	else
		return false
	end
end

function Player:HasItem(id, quant)
	for k,v in pairs(self.Inventory) do
		if v.ID == id then
			if v.Quantity >= quant then
				return true
			end
		end
	end
end

function Player:GetInventory()
	return self.Inventory end

util.AddNetworkString("item_use")
net.Receive("item_use", function(len, ply)
	local id = net.ReadInt(32)
	ply:UseItem(id)
end)
function Player:UseItem(id)
	for k,v in pairs(self.Inventory) do
		if v.ID == id && ITEM_DB[id].Use then
			if v.Quantity > 0 then
				self:RemoveItem(id, 1)
				ITEM_DB[id].Use(self)
			end
		end
	end
end

util.AddNetworkString("item_drop")
net.Receive("item_drop", function(len, ply) 
	ply:DropItem(net.ReadInt(32))
end)
function Player:DropItem(itemid)

	local trace = self:GetEyeTrace()

	for k, v in pairs(self.Inventory) do
		if v.ID == itemid && v.Quantity > 0 then

			local ent = ents.Create("ent_item")
				ent:SetModel(ITEM_DB[itemid].Model)
				ent:SetPos(self:EyePos() + self:GetAngles():Forward() * 64 + Vector(0, 0, 20))
				ent:SetID(itemid)
				ent:Spawn()
				self:RemoveItem(itemid, 1)
			break
		end	
	end
end

function Player:SpawnProp(itemid)
	local prop = ents.Create("prop_physics")
		prop:SetModel(ITEM_DB[itemid].Model)
		prop:SetPos(self:EyePos() + self:GetAngles():Forward() * 64 + Vector(0, 0, 20))
		prop.Owner = self
		prop.ID = itemid
	prop:Spawn()
	self.SpawnedProps = self.SpawnedProps + 1
end

--[[
	Receives the crafting message from clientside
--]]
util.AddNetworkString("item_craft")
net.Receive("item_craft", function(len, ply)
	ply:UseRecipe(RECIPE_DB[net.ReadInt(32)])
end)
--[[
	Function to craft an item using a recipe ID
	Checks if the player has all the items using the components
--]]
function Player:UseRecipe(recipe)
	local plyitem = 0
	local count = #recipe.Components
	for k,v in pairs(recipe.Components) do
		for l,u in pairs(self.Inventory) do
			if u.ID == v.ID && u.Quantity >= v.Quantity then
				plyitem = plyitem + 1
			end
		end
	end
	if plyitem == count then
		for i=1,count do
			self:RemoveItem(recipe.Components[i].ID, recipe.Components[i].Quantity)
		end
		self:GiveItem(recipe.ItemID.ID, recipe.ItemID.Quantity)
	end

end

function GM.DropItem(itemid, pos)
	local ent = ents.Create("ent_item")
			ent:SetModel(ITEM_DB[itemid].Model)
			ent:SetPos(pos)
			ent:SetID(itemid)
			ent:Spawn()
end

hook.Add("KeyPress", "RemoveProp", function(ply, key)
	local eye = ply:GetEyeTrace().Entity
	if key == IN_USE then
		if ply:KeyDown(IN_SPEED) then		
			if eye.Owner == ply && not eye:IsDoor() && ply:GetPos():Distance(eye:GetPos()) < 100 then
				eye:Remove()
				ply:GiveItem(eye.ID, 1)
				ply:PlaySound("buttons/lightswitch2.wav")
			end
		end
	end
end)
