ITEM_DB = {}
PROPERTY_DB = {}
VEHICLE_DB = {}
RECIPE_DB = {}
JOB_DB = {}
include( 'shared.lua' )

GM.Rank = 0
GM.Jointime = 0
GM.Playtime = 0
GM.PlayerVehicles = { }
GM.PRank = 0


include("config/config.lua")
include("config/items.lua")
include("config/jobs.lua")
include("config/npcs.lua")
include("config/properties.lua")
include("config/recipes.lua")
include("config/vehicles.lua")
include("config/adminplugins.lua")

if GM.Debug then
	include("cl_debug.lua")
end

include("sh_player.lua")
include("sh_entity.lua")
include("sh_util.lua")

include('cl_inventory.lua')
include('cl_font.lua')
include('cl_vehicle.lua')
include('cl_chat.lua')
include('cl_networking.lua')
include('cl_trade.lua')
include('cl_hooks.lua')

for k, v in pairs(file.Find("gamemodes/urbanliferp/gamemode/vgui/*.lua", "GAME")) do
	include("vgui/"..v)
end

function GM.Notify( string, time )
	notification.AddLegacy(string, NOTIFY_GENERIC, time or 3)
	surface.PlaySound("ambient/water/drip"..math.random(1, 4)..".wav")
end

function GM.TestCarDealer()
	local frame = vgui.Create("CarSeller")
	frame:MakePopup()
end

GM.CreateInventory()


net.Receive("speedometer", function()
	LocalPlayer().Speedometer = net.ReadInt(32)
end)