local JOB = { }

JOB.ID = 1
JOB.Name = "Citizen"
JOB.Ref = "job_citizen"
JOB.Salary = 50
JOB.Model = "models/player/Group01/Male_"
JOB.Color = Color(0, 255, 0, 255)
JOB.Loadout = { }
GM:LoadJob(JOB)

local JOB = { }

JOB.ID = 2
JOB.Name = "Police Officer"
JOB.Ref = "job_police"
JOB.Salary = 70
JOB.Color = Color(0, 0, 255, 255)
JOB.Model = "models/ecpd/male_"
JOB.Loadout = { {"weapon_beretta"},
				{"weapon_beretta"},
				{"weapon_beretta", "weapon_870"},
				{"weapon_beretta", "weapon_870"},
				{"weapon_beretta", "weapon_870"},
				{"weapon_beretta", "weapon_870"},
				{"weapon_beretta", "weapon_870"}
			}
JOB.Promotion = {	"You can now spawn a police car. Salary increased by 5$.",
					"You now have a Remington 870 in your loadout.Salary increased by 5$.",
					"You now have access to the undercover cop car. Salary increased by 5$",
					"",
					"",
					"You can now join the SWAT team. Salary increased by 5$"}
GM:LoadJob(JOB)

local JOB = { }

JOB.ID = 3
JOB.Name = "Paramedic"
JOB.Ref = "job_paramedic"
JOB.Salary = 75
JOB.Color = Color(0, 0, 255, 255)
JOB.Model = "models/humans/group01/scrub2"
JOB.Loadout = { {"weapon_beretta"} }

JOB.Promotion = {	"You can now spawn a police car. Salary increased by 5$.",
					"You now have a Remington 870 in your loadout.Salary increased by 5$.",
					"You now have access to the undercover cop car. Salary increased by 5$",
					"",
					"",
					"You can now join the SWAT team. Salary increased by 5$"}
GM:LoadJob(JOB)