GM.Name = "Urban Life RP"
GM.Author = "N/A"
GM.Email = "N/A"
GM.Website = "N/A"

DeriveGamemode( "sandbox" )

JOB_DB = {}
NPC_DB = {}

TEAM_CITIZEN = 1
TEAM_POLICE = 2
TEAM_PARAMEDIC = 3

function GM:LoadJob(tbl)
	JOB_DB[tbl.ID] = tbl
	team.SetUp(tbl.ID, tbl.Name, tbl.Color)

	if SERVER then
		print("Loaded "..tbl.Name.." job.")
	end
end

function GM:LoadNPC( tbl )
	NPC_DB[tbl.ID] = tbl

	if SERVER then
		print("Loaded NPC "..tbl.Name)
	end
end

function GM:LoadItem(tbl)
	ITEM_DB[tbl.ID] = tbl
	
	if SERVER then
		print("Loaded item "..tbl.Name)
	end
end

function GM:LoadVehicle(tbl)
	VEHICLE_DB[tbl.ID] = tbl
	
	if SERVER then
		print("Loaded vehicle "..tbl.Name)
	end
end

function GM:LoadProperty(tbl)
	PROPERTY_DB[tbl.ID] = tbl
	
	if SERVER then
		print("Loaded property "..tbl.Name)
	end
end

function GM:LoadRecipe(tbl)
	RECIPE_DB[tbl.ID] = tbl
	
	if SERVER then
		print("Loaded recipe "..tbl.Name)
	end
end