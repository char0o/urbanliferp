GM.Debug = true --Debug version of gamemode
--[[
	Class of entities you cannot pickup with your physgun.
--]]
GM.CantPickupClass = {	["npc_base"] = true,
						["ent_item"] = true,
						["prop_ragdoll"] = true,
						["player"] = true
					}
--[[
	Model of entities you cannot pickup with your physgun.
--]]
GM.CantPickupModel = {	["models/extras/info_speech.mdl"] = true

					}
--[[
	Class of weapons equipped by default
--]]
GM.LoadoutTable = 	{	["weapon_physgun"] = true, 
						["weapon_physcannon"] = true, 
						["gmod_tool"] = true, 
						["gmod_camera"] = true, 
						["weapon_keys"] = true}
--[[
	Models of doors to indentify entity
--]]
GM.DoorModelTable = {["models/props_c17/door01_left.mdl"] = true,
						["models/props_c17/door02_double.mdl"] = true,
						["models/props_warehouse/door.mdl"] = true,
						["models/props_c17/door03_left.mdl"] = true}
--[[
	All the custom doors in evocity have model *number
	so add these too
--]]
for i=0, 500 do
	GM.DoorModelTable["*"..i] = true
end

GM.DeathTime = 10 --Number of seconds you stay dead for.
GM.PolicePromotionTime = 2 --Number of minutes before police promotion.
GM.PoliceSalaryUpgrade = 5 --
GM.ParamedicPromotionTime = 2
GM.ParamedicSalaryUpgrade = 5
GM.SalaryDelay = 60 --Number of seconds between salary payouts
GM.CraftingTimer = 10 --Number of time in seconds where a player can craft a number of items
GM.CraftingLimit = 10 --Number of items the player can craft in the timer before getting blocked from crafting