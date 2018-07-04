ADMIN_PLUGIN = {}

function GM.LoadAdminPlugin( plugin )
	ADMIN_PLUGIN[plugin.ID] = plugin
	print("Loaded "..plugin.Name) 
end

local PLUGIN = { }
PLUGIN.ID = 1
PLUGIN.Name = "Kick"
PLUGIN.Reasons = { "Disrespecting the admin","RDM","Bye"}
PLUGIN.Func = function( ply, reason)
	if IsValid(ply) && LocalPlayer():Isadmin() then
		net.Start("kick_player")
			net.WriteEntity( ply )
			net.WriteString(reason)
		net.SendToServer()
	else
		GAMEMODE.Notify("Not an admin")
	end
end
GM.LoadAdminPlugin(PLUGIN)

local PLUGIN = { }
PLUGIN.ID = 2
PLUGIN.Name = "Ban"
PLUGIN.Reasons = { "Disrespecting the admin","RDM","Bye"}
PLUGIN.Time = { 10, 60, 1440, 10080, 43200, 0}
PLUGIN.Func = function( ply, reason, time)
	if IsValid(ply) && LocalPlayer():Isadmin() then
		net.Start("ban_player")
			net.WriteEntity( ply )
			net.WriteInt(time, 32)
			net.WriteString(reason)
		net.SendToServer()
	else
		GAMEMODE.Notify("Not an admin")
	end
end
GM.LoadAdminPlugin(PLUGIN)

local PLUGIN = { }
PLUGIN.ID = 3
PLUGIN.Name = "Freeze"
PLUGIN.Func = function( ply )
	if IsValid(ply) && LocalPlayer():Isadmin() then
		net.Start("freeze_player")
			net.WriteEntity( ply )
		net.SendToServer()
	else
		GAMEMODE.Notify("Not an admin")
	end
end
GM.LoadAdminPlugin(PLUGIN)