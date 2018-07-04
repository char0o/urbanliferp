--[[
	Blocks server messages
--]]
hook.Add("ChatText", "RemoveJoin", function(index, name, text, typ) 
	if typ == "joinleave" || typ == "namechange" || typ == "servermsg" || typ == "teamchange" then
		return true
	end
	if LocalPlayer():Team() == 1 && string.find(text, "[RADIO]") then
		return true
	end
end)
--[[
	Receives chat from the server and displays it
--]]
net.Receive("chat", function() 
	local argc = net.ReadUInt(16)
	local args = {}
		
	for i = 1, argc/2, 1 do
		local col = Color(net.ReadUInt(8), net.ReadUInt(8), net.ReadUInt(8), 255)
		print(col)
		table.insert(args, col)
		table.insert(args, net.ReadString())
	end

	chat.AddText( unpack(args) )
	chat.PlaySound()
end)