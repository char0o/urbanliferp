--[[
	Clientside emitsound
	Sends the sound string to the server
--]]
function GM.EmitSound(sound)
	net.Start("emitsound")
		net.WriteString(sound)
	net.SendToServer()
end

--[[
	Called when the server opens a panel on a client
	Receives panel ID
--]]
local panels = {"ModelSelect", "Inventory", "TradeMenu"}

net.Receive("open_panel", function() 
	local panel = vgui.Create(panels[net.ReadInt(32)])
		panel:MakePopup()
end)
--[[
	Called when a player talks to an npc, open the npcs panel
--]]
net.Receive("npc_use", function()
	local talk = vgui.Create(""..net.ReadString())
	talk:MakePopup()
end)
--[[
	Called when the server notifies the client
--]]
net.Receive( "notification", function()
	GAMEMODE.Notify(net.ReadString(), net.ReadInt(32))
end)
--[[
	Called when the server wants to use surface.playsound
--]]
net.Receive("playsound", function()
	surface.PlaySound(net.ReadString())
end)