Scavenge/Build/War
-Scavenge supplies during the day
--Supplies must be taken back to the base
--Can hit players with club to knock them out and take their supplies
--Weapon tier system depending on how many supplies the team gets
-Build during the night with supplies
-Buy advanced weapons with supplies, must be voted by the team
-Prop damage

local questions = {"Question1", "Question2"}

net.Start("sendquestions")
	for k,v in pairs(questions) do
		net.WriteString(v)
	end
net.Send(ply)

cl_questions = {}
net.Receive("sendquestions", function(len, ply)
	for i=1, len do
		cl_questions[i] = net.ReadString()
	end
end)