--Chat variables
local LOCAL = 0
local RADIO = 1
local ADMIN = 2

--[[
	Makes it so the player cannot hear the voice of another player
	unless they are near. Second return bool for echo
--]]
function GM:PlayerCanHearPlayersVoice( listener, talker )
	if listener:GetPos():Distance(talker:GetPos()) <= 500 then
		return true, true
	end
end
--[[
	Function when a player sends a chat message. Returns
	an empty string and sends a custom message instead.
--]]
function GM:PlayerSay( sender, text, isteam)

	if string.sub(text, 1, 6) == "/radio" || isteam then
		if sender:IsGovOffical() then
			GAMEMODE.PlayerRealSay(nil, RADIO, Color(0,0,255), "[RADIO]".. sender:Nick()..":"..string.sub(text, 8))
			return ""
		else
			sender:Notify("You can't use the radio if you are not a government employee!")
		return ""
		end
	end
	if string.sub( text, 1, 4) == "/ooc" then
		GAMEMODE.PlayerRealSay(nil, nil, Color(255, 255, 255),"[OOC]", JOB_DB[sender:Team()].Color, sender:Nick()..":", Color(255, 255, 255), string.sub(text, 5))
		return ""
	end
	if string.sub( text, 1, 2) == "//" then
		GAMEMODE.PlayerRealSay(nil, nil, Color(255, 255, 255),"[OOC]", JOB_DB[sender:Team()].Color, sender:Nick()..":", Color(255, 255, 255), string.sub(text, 3))
		return ""
	end
	if string.sub(text, 1, 5) == "/looc" then
		GAMEMODE.PlayerRealSay(sender, LOCAL, Color(255, 255, 255), "[LOOC]", JOB_DB[sender:Team()].Color, sender:Nick()..":", Color(255, 255, 255), string.sub(text, 6))
		return ""
	end
	if string.sub(text, 1, 6) == "/admin" then
		if sender:isAdmin() then
			GAMEMODE.PlayerRealSay(sender, ADMIN, Color(255, 0, 0), "[ADMIN]"..sender:Nick()..":"..string.sub(text, 8))
			return ""
		else
			sender:Notify("You can't use the admin chat if you are not an admin!")
			return ""
		end
	end
	GAMEMODE.PlayerRealSay(sender, LOCAL, JOB_DB[sender:Team()].Color, sender:Nick()..":", Color(255, 255, 255), " "..text)
	return ""
end

--[[
	GAMEMODE.PlayerRealSay(ply or nil, chatid or nil, Color(), string, Color(), string, etc.)
	Custom chat function with variable number of
	arguments.
	If the first argument and second arguments are nil, send to everyone
	If the first argument is nil then the second argument is the chat type
	If the first argument is a player and second argument is nil, only send to that player
	If the first argument is a player and second argument is chat type it's to get talker's
	position(like in local)
--]]
util.AddNetworkString("chat")
function GM.PlayerRealSay(...)
	arg = {...}
	net.Start("chat")
	net.WriteUInt(#arg, 16)
		if type(arg[1]) == "Player" && arg[2] == nil then		
			for _, v in pairs(arg) do
				if type(v) == "string" then
					net.WriteString(v)
				elseif type(v) == "table" then
					net.WriteUInt(v.r, 8)
					net.WriteUInt(v.g, 8)
					net.WriteUInt(v.b, 8)
				end
			end
		net.Send(arg[1])
		elseif type(arg[2]) == "number" then
			if arg[2] == LOCAL then
				local tosend = {}
				for _, v in pairs(arg) do
					if type(v) == "string" then
						net.WriteString(v)
						print(v)
					elseif type(v) == "table" then
						print(v.r, v.g, v.b)
						net.WriteUInt(v.r, 8)
						net.WriteUInt(v.g, 8)
						net.WriteUInt(v.b, 8)
					end
				end
				for k,v in pairs(ents.FindInSphere(arg[1]:GetPos(), 500)) do
					if type(v) == "Player" then
						table.insert(tosend, v)
					end
				end
				net.Send(tosend)
			elseif arg[2] == RADIO then
				local tosend = {}
				for _, v in pairs(arg) do
					if type(v) == "string" then
						net.WriteString(v)
					elseif type(v) == "table" then
						net.WriteUInt(v.r, 8)
						net.WriteUInt(v.g, 8)
						net.WriteUInt(v.b, 8)
					end
				end
				for k, v in pairs(player.GetAll()) do
					if v:Team() == 2 then
						table.insert(tosend, v)
					end
				end
				net.Send(tosend)
			elseif arg[2] == ADMIN then
				local tosend = {}
				for _, v in pairs(arg) do
					if type(v) == "string" then
						net.WriteString(v)
					elseif type(v) == "table" then
						net.WriteUInt(v.r, 8)
						net.WriteUInt(v.g, 8)
						net.WriteUInt(v.b, 8)
					end
				end
				for k,v in pairs(player.GetAll()) do
					if v:Isadmin() then
						table.insert(tosend, v)
					end
				end
				net.Send(tosend)
			end
		else
			for _, v in pairs(arg) do
				if type(v) == "string" then
					net.WriteString(v)
				elseif type(v) == "table" then
					net.WriteUInt(v.r, 8)
					net.WriteUInt(v.g, 8)
					net.WriteUInt(v.b, 8)
				end
			end
		net.Broadcast()
		end
end
