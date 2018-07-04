GM.PlayerInventory = { }
--[[
	Create the local player's inventory under GM.PlayerInventory
--]]
function GM.CreateInventory()

	for i = 1, 32 do
		table.insert(GM.PlayerInventory, {Slot = 0, ID = 0, Quantity = 0, Ref = "" })
	end

end
--[[
	Receives the player inventory when he connects
--]]
net.Receive( "inventory", function()
	local id = net.ReadInt(32)
	local quant = net.ReadInt(32)
	local slot = net.ReadInt(32)
	GAMEMODE.SetItem(slot, id, quant)
end)

--[[
	Give an item to the player
--]]
function GM.GiveItem(id, quantity)

	local inv = GAMEMODE.PlayerInventory

	for k, v in pairs(inv) do

		if v.ID == id then

			inv[k].Slot = k
			inv[k].Quantity = v.Quantity + quantity

			break
		end

		if v.ID == 0 then

			inv[k].ID = id
			inv[k].Slot = k
			inv[k].Quantity = quantity
			inv[k].Ref = ITEM_DB[id].Ref

			break
		end
	end
end
--[[
	Remove an item from the player
--]]
function GM.RemoveItem(id, quantity)
	local inv = GAMEMODE.PlayerInventory

	for k, v in pairs(inv) do

		if v.ID == id then

			local quant = v.Quantity

			if(quant - quantity) < 0 then

				break
			elseif (quant - quantity) >= 0 then

				inv[k].Quantity = v.Quantity - quantity

				break
			elseif (quant - quantity) <= 0 then

				GAMEMODE.ClearSlot(v.Slot)

				break	
			end
			break
		end
	end
end
--[[
	Clear the selected inventory slot
--]]
function GM.ClearSlot(slot)
	local inv = GAMEMODE.PlayerInventory
	inv[slot] = {Slot = 0, ID = 0, Quantity = 0, Ref = ""}
end
--[[
	Checks if the selected inventory slot is empty
--]]
function GM.SlotIsEmpty(slot)
	local inv = GAMEMODE.PlayerInventory

	if inv[slot].ID == 0 then
		return true
	else
		return false
	end
end
--[[
	Change the slot of 2 selected items
	Networks the change to the server
--]]
function GM.ChangeItemSlot(oldslot, newslot) --If there's an item in the newslot, switch it

		local inv = GAMEMODE.PlayerInventory

		if newslot > 32 && oldslot > 32 then

			print('Slot number is too high')
			return

		elseif oldslot == newslot then
			
			print("Can't have the same slot number!")
			return 
		end

		for k, v in pairs(inv) do 

			if GAMEMODE.SlotIsEmpty(newslot) then
				GAMEMODE.SetItem(newslot, inv[oldslot].ID, inv[oldslot].Quantity)
				GAMEMODE.ClearSlot(oldslot)
				net.Start("item_changeslot")
					net.WriteInt(oldslot, 16)
					net.WriteInt(newslot, 16)
				net.SendToServer()
				break
			end

			if not GAMEMODE.SlotIsEmpty(newslot) then
				if GAMEMODE.SlotIsEmpty(oldslot) then
					GAMEMODE.SetItem(oldslot, inv[newslot].ID, inv[newslot].Quantity)
					GAMEMODE.ClearSlot(newslot)
					net.Start("item_changeslot")
						net.WriteInt(oldslot, 16)
						net.WriteInt(newslot, 16)
					net.SendToServer()
					break
				else
				local oldid, oldquant = inv[newslot].ID, inv[newslot].Quantity
					GAMEMODE.SetItem(newslot, inv[oldslot].ID, inv[oldslot].Quantity)
					GAMEMODE.SetItem(oldslot, oldid, oldquant)
					net.Start("item_changeslot")
						net.WriteInt(oldslot, 16)
						net.WriteInt(newslot, 16)
					net.SendToServer()
					break
				end
				break
			end
		end	
end
--[[
	Sets the item ID and quantity to the selected slot
--]]
function GM.SetItem(slot, id, quantity)

	local inv = GAMEMODE.PlayerInventory

	inv[slot].Slot     = slot
	inv[slot].ID       = id
	inv[slot].Quantity = quantity
	inv[slot].Ref 	   = ITEM_DB[id].Ref
end
--[[
	Called from inventory when the player drops a item
	Networks the item ID to the server
--]]
function GM.DropItem(id)

	if id == 0 then return end
	net.Start("item_drop")
		net.WriteInt(id, 32)
	net.SendToServer()
	istime = false
end
--[[
	Called from inventory when the player uses an item
	Networks the item ID to the server
--]]
function GM.UseItem(id)
	if id == 0 then return end
	net.Start("item_use")
		net.WriteInt(id, 32)
	net.SendToServer()
end

--[[
	Called from the crafting menu to craft and item from recipe ID
	Blocks the player from crafting after a certain number of crafts for an amount of time
	Networks the recipe ID to the server
--]]
local craftcount = 0
local crafttime = 0
function GM.Craft(recipeid)
	if not timer.Exists("craftban") then
		timer.Create("craftban", GAMEMODE.CraftingTimer, 1, function() 
			timer.Destroy("craftban") 
			craftcount = 0
			crafttime = 0
		end)
		crafttime = math.Round(CurTime())
	end
	if timer.Exists("craftban") && craftcount == GAMEMODE.CraftingLimit then 
		GAMEMODE.Notify("You are crafting too fast, cannot craft for "..math.Round(CurTime())-crafttime.." seconds")
		return
	end
	local plyitem = 0
	local count = #RECIPE_DB[recipeid].Components
	for k,v in pairs(RECIPE_DB[recipeid].Components) do
		for l,u in pairs(GAMEMODE.PlayerInventory) do
			if u.ID == v.ID && u.Quantity >= v.Quantity then
				plyitem = plyitem + 1
			end
		end
	end
	if plyitem == count then
		net.Start("item_craft")
			net.WriteInt(recipeid, 32)
		net.SendToServer()
		craftcount = craftcount + 1
	else
		GAMEMODE.Notify("You don't have the required components.")
	end
end
--[[
	Net callbacks
--]]
net.Receive("item_set", function()
	GAMEMODE.SetItem(net.ReadInt(32), net.ReadInt(32), net.ReadInt(32))
end)

net.Receive("item_give", function()
	GAMEMODE.GiveItem(net.ReadInt(32), net.ReadInt(32))
end)

net.Receive("remove_item", function()
	GAMEMODE.RemoveItem(net.ReadInt(32), net.ReadInt(32))
end)

net.Receive("item_clearslot", function() 
	GAMEMODE.ClearSlot(net.ReadInt(32))
end)