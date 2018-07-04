local NPC = { }

NPC.ID = 1
NPC.Name = "Police Chief"
NPC.Ref = "npc_police"
NPC.Panel = "Dialog"
NPC.Model = "models/ecpd/male_03_npc.mdl"
NPC.Skin = 6
NPC.Location = Vector(-7233.6918945313, -9210.615234375, 72.03125)
NPC.Angles = Angle( 0, 90, 0 )

GM:LoadNPC(NPC)

local NPC = { }

NPC.ID = 2
NPC.Name = "Paramedic"
NPC.Ref = "npc_paramedic"
NPC.Panel = "Dialog"
NPC.Model = "models/humans/group03m/male_02.mdl"
NPC.Location = Vector(-9603.8466796875, 9167.7802734375, 72.03125)
NPC.Angles = Angle( 0, 90, 0 )

GM:LoadNPC(NPC)

local NPC = { }

NPC.ID = 3
NPC.Name = "Car Dealer"
NPC.Ref = "npc_cardealer"
NPC.Panel = "CarDealer"
NPC.Model = "models/humans/group03m/male_02.mdl"
NPC.Location = Vector(5064.6708984375, -3657.4462890625, 228.03125)
NPC.Angles = Angle( 0, -90, 0 )

GM:LoadNPC(NPC)

local NPC = { }

NPC.ID = 4
NPC.Name = "Garagist"
NPC.Ref = "npc_garage"
NPC.Panel = "Garage"
NPC.Model = "models/odessa.mdl"
NPC.Location = Vector(-5374.55, -10275.9, 71.03)
NPC.Angles = Angle( 0, 0, 0 )

GM:LoadNPC(NPC)