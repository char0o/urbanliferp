RP = {}
VEHICLE_DB = {}
ITEM_DB = {}
PROPERTY_DB = {}
RECIPE_DB = {}

include( "shared.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

for k, v in pairs(file.Find("gamemodes/urbanliferp/gamemode/config/*.lua", "GAME")) do
	include("config/"..v)
	AddCSLuaFile("config/"..v)
end

if GM.Debug then
	include("sv_debug.lua")
	AddCSLuaFile("cl_debug.lua")
end

AddCSLuaFile( "cl_inventory.lua" )
AddCSLuaFile( "cl_vehicle.lua")
AddCSLuaFile( "cl_font.lua" )
AddCSLuaFile( "sh_entity.lua" )
AddCSLuaFile( "sh_player.lua" )
AddCSLuaFile( "sh_util.lua" )
AddCSLuaFile( "cl_chat.lua" )
AddCSLuaFile( "cl_networking.lua" )
AddCSLuaFile( "cl_trade.lua" )
AddCSLuaFile( "cl_hooks.lua" )

include( "sh_entity.lua" )
include( "sh_player.lua" )
include ("sh_util.lua" )

include( "sv_hooks.lua" )
include( "sv_player.lua" )
include( "sv_entity.lua" )
include( "sv_sql.lua" )
include( "sv_chat.lua" )
include( "sv_inventory.lua" )
include( "sv_networking.lua" )
include( "sv_admin.lua" )
include( "sv_vehicle.lua" )
include( "sv_property.lua" )
include( "sv_trade.lua" )
include( "sv_jobs.lua" )

for k, v in pairs(file.Find("gamemodes/urbanliferp/gamemode/vgui/*.lua", "GAME")) do
	AddCSLuaFile("vgui/"..v)
end

timer.Create('payday', GM.SalaryDelay, 0, function() 
	for k, v in pairs( player.GetAll() ) do
		local sal = v:GetSalary()

		v:AddMoney(sal)
		v:Notify("Received "..sal.."$ for salary!", 2)
		v:CheckPromotion()
	end 
end)
