--[[
1.item_chair
2.item_desk
3.item_toilet
4.item_plank
5.item_palisade
6.item_half_palisade
7.item_metal_chunk
8.item_metal_pipe
9.item_metal_pole
10.item_plastic_chunk
11.item_weapon_1911
12.item_weapon_beretta
13.item_weapon_usp
14.item_weapon_p229
15.item_weapon_deagle
16.item_weapon_python
17.item_weapon_870
18.item_weapon_ak47
19.item_weapon_m4a1
20.item_ammo_pistol
21.item_ammo_revolver
22.item_ammo_rifle
]]--

--[[

local ITEM = {}

ITEM.ID = 0
ITEM.Ref = ""
ITEM.Name = ""

ITEM.Description = ""

ITEM.Model = ""
ITEM.CamPos = Vector(0, 0, 0)
ITEM.LookAt = Vector(0, 0, -0)
ITEM.FOV = 0

ITEM.Use = function(ply)
end

ITEM.OnUse = function(ply)
end

GM:LoadItem(ITEM)

]]--

local ITEM = {}

ITEM.ID = 1
ITEM.Ref = "item_metalchair"
ITEM.Name = "Metal Chair"

ITEM.Description = "You sit on this."

ITEM.Model = "models/props_c17/chair02a.mdl"
ITEM.CamPos = Vector(50, 50, 50)
ITEM.LookAt = Vector(5, -9, -2)
ITEM.FOV = 30

ITEM.Use = function(ply)
	ply:SpawnProp(ITEM.ID)
end

ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)

local ITEM = {}

ITEM.ID = 2
ITEM.Ref = "item_desk"
ITEM.Name = "Desk"

ITEM.Description = "To work on."

ITEM.Model = "models/props_combine/breendesk.mdl"
ITEM.LookAt = Vector(-3, 12, 7)
ITEM.CamPos = Vector(42, 55, 45)
ITEM.FOV = 66

ITEM.Use = function(ply)
	ply:SpawnProp(ITEM.ID)
end
ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)	

local ITEM = {}

ITEM.ID = 3
ITEM.Ref = "item_toilet"
ITEM.Name = "Toilet"

ITEM.Description = "You sit on this."

ITEM.Model = "models/props_c17/FurnitureToilet001a.mdl"
ITEM.LookAt = Vector(-6, -4, -33)
ITEM.CamPos = Vector(59, 37, 19)
ITEM.FOV = 26


ITEM.Use = function(ply)
	ply:SpawnProp(ITEM.ID)
end

ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end
GM:LoadItem(ITEM)

local ITEM = {}

ITEM.ID = 4
ITEM.Ref = "item_plank"
ITEM.Name = "Wood Plank"

ITEM.Description = "Used to craft things."

ITEM.Model = "models/props_debris/wood_board04a.mdl"
ITEM.CamPos = Vector(123, -15, 139)
ITEM.LookAt = Vector(-2, 1, 1)
ITEM.FOV = 12

ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)

local ITEM = {}

ITEM.ID = 5
ITEM.Ref = "item_palisade"
ITEM.Name = "Wood Palisade"

ITEM.Description = "Used to fence things."

ITEM.Model = "models/props_wasteland/wood_fence01a.mdl"
ITEM.CamPos = Vector(1, 77, 25)
ITEM.LookAt = Vector(-1, -43, 4)
ITEM.FOV = 90


ITEM.Use = function(ply)
	ply:SpawnProp(ITEM.ID)
end

ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end


GM:LoadItem(ITEM)
	
local ITEM = {}

ITEM.ID = 6
ITEM.Ref = "item_half_palisade"
ITEM.Name = "Half Wood Palisade"

ITEM.Description = "Used to fence things."

ITEM.Model = "models/props_wasteland/wood_fence02a.mdl"
ITEM.CamPos = Vector(-1, 127, 4)
ITEM.LookAt = Vector(0, 0, 0)
ITEM.FOV = 61

ITEM.Use = function(ply)
	ply:SpawnProp(ITEM.ID)
end

ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)	

local ITEM = {}

ITEM.ID = 7
ITEM.Ref = "item_metal_chunk"
ITEM.Name = "Metal chunk"

ITEM.Description = "Used to craft things."

ITEM.Model = "models/props_debris/metal_panelshard01c.mdl"

ITEM.LookAt = Vector(0, 0, -20)
ITEM.CamPos = Vector(50, 50, 50)
ITEM.FOV = 16


ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)

local ITEM = {}

ITEM.ID = 8
ITEM.Ref = "item_metal_pipe"
ITEM.Name = "Metal pipe"

ITEM.Description = "Used to craft things."

ITEM.Model = "models/props_canal/mattpipe.mdl"

ITEM.LookAt = Vector(0, 0, 0)
ITEM.CamPos = Vector(50, 50, 50)
ITEM.FOV = 21


ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)

local ITEM = {}

ITEM.ID = 9
ITEM.Ref = "item_metal_pole"
ITEM.Name = "Metal pole"

ITEM.Description = "Used to craft things."

ITEM.Model = "models/props_c17/signpole001.mdl"

ITEM.LookAt = Vector(0, 0, 56)
ITEM.CamPos = Vector(50, 50, 50)
ITEM.FOV = 24


ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)

local ITEM = {}

ITEM.ID = 10
ITEM.Ref = "item_plastic_chunk"
ITEM.Name = "Plastic chunk"

ITEM.Description = "Used to craft things."

ITEM.Model = "models/props/cs_office/projector_p1b.mdl"

ITEM.LookAt = Vector(0, 3, 7)
ITEM.CamPos = Vector(50, 50, 50)
ITEM.FOV = 7


ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)

local ITEM = {}

ITEM.ID = 11
ITEM.Ref = "item_weapon_1911"
ITEM.Name = "Colt 1911"

ITEM.Description = "A small capacity medium damage pistol. Uses pistol ammo."

ITEM.Model = "models/weapons/s_dmgf_co1911.mdl"

ITEM.LookAt = Vector(-7, 1, 0)
ITEM.CamPos = Vector(50, -4, -13)
ITEM.FOV = 12

ITEM.Use = function(ply)
	if ply:HasWeapon("weapon_1911") then ply:Notify("You already have that weapon equipped!") return end
	print("wtf")
	ply:Give("weapon_1911", true)
	ply:RemoveItem(11, 1)
	ply:EmitSound("items/ammo_pickup.wav")
end
ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)

local ITEM = {}

ITEM.ID = 12
ITEM.Ref = "item_weapon_beretta"
ITEM.Name = "M92 Beretta"

ITEM.Description = "A high capacity small damage pistol. Uses pistol ammo."

ITEM.Model = "models/weapons/w_beretta_m92.mdl"

ITEM.LookAt = Vector(1, -7, 2)
ITEM.CamPos = Vector(-54, -4, 50)
ITEM.FOV = 7

ITEM.Use = function(ply)
	if ply:HasWeapon("weapon_beretta") then ply:Notify("You already have that weapon equipped!") return end
	ply:Give("weapon_beretta")
	ply:RemoveItem(12, 1)
	ply:EmitSound("items/ammo_pickup.wav")
end
ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)

local ITEM = {}

ITEM.ID = 13
ITEM.Ref = "item_weapon_usp"
ITEM.Name = "HK USP"

ITEM.Description = "A medium capacity medium damage pistol. Uses pistol ammo."

ITEM.Model = "models/weapons/w_pist_fokkususp.mdl"

ITEM.LookAt = Vector(0, 0, -2)
ITEM.CamPos = Vector(-3, 59, -9)
ITEM.FOV = 10

ITEM.Use = function(ply)
	if ply:HasWeapon("weapon_usp") then ply:Notify("You already have that weapon equipped!") return end
	ply:Give("weapon_usp")
	ply:RemoveItem(13, 1)
	ply:EmitSound("items/ammo_pickup.wav")
end
ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)

local ITEM = {}

ITEM.ID = 14
ITEM.Ref = "item_weapon_p229"
ITEM.Name = "SIG P229"

ITEM.Description = "A medium capacity low damage pistol. Uses pistol ammo."

ITEM.Model = "models/weapons/w_sig_229r.mdl"

ITEM.LookAt = Vector(29, -6, -1)
ITEM.CamPos = Vector(-139, -4, 13)
ITEM.FOV = 4


ITEM.Use = function(ply)
	if ply:HasWeapon("weapon_p229") then ply:Notify("You already have that weapon equipped!") return end
	ply:Give("weapon_p229")
	ply:RemoveItem(14, 1)
	ply:EmitSound("items/ammo_pickup.wav")
end
ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)

local ITEM = {}

ITEM.ID = 15
ITEM.Ref = "item_weapon_deagle"
ITEM.Name = "Desert Eagle"

ITEM.Description = [[A low capacity high damage pistol.
Uses revolver ammo.]]

ITEM.Model = "models/weapons/w_tcom_deagle.mdl"

ITEM.LookAt = Vector(0, 1, -2)
ITEM.CamPos = Vector(30, 6, -15)
ITEM.FOV = 20


ITEM.Use = function(ply)
	if ply:HasWeapon("weapon_deagle") then ply:Notify("You already have that weapon equipped!") return end
	ply:Give("weapon_deagle")
	ply:RemoveItem(15, 1)
	ply:EmitSound("items/ammo_pickup.wav")
end
ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)

local ITEM = {}

ITEM.ID = 16
ITEM.Ref = "item_weapon_python"
ITEM.Name = "Colt Python"

ITEM.Description = "A small capacity high damage pistol. Uses revolver ammo."

ITEM.Model = "models/weapons/w_colt_python.mdl"

ITEM.LookAt = Vector(6, -8, 3)
ITEM.CamPos = Vector(-46, -8, 6)
ITEM.FOV = 16

ITEM.Use = function(ply)
	if ply:HasWeapon("weapon_python") then ply:Notify("You already have that weapon equipped!") return end
	ply:Give("weapon_python")
	ply:RemoveItem(16, 1)
	ply:EmitSound("items/ammo_pickup.wav")
end
ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)

local ITEM = {}

ITEM.ID = 17
ITEM.Ref = "item_weapon_870"
ITEM.Name = "Remington 870"

ITEM.Description = "A shotgun. Uses shotgun ammo."

ITEM.Model = "models/weapons/w_remington_870_tact.mdl"

ITEM.LookAt = Vector(0, 32, 0)
ITEM.CamPos = Vector(51, -54, 13)
ITEM.FOV = 36

ITEM.Use = function(ply)
	if ply:HasWeapon("weapon_870") then ply:Notify("You already have that weapon equipped!") return end
	ply:Give("weapon_870")
	ply:RemoveItem(17, 1)
	ply:EmitSound("items/ammo_pickup.wav")
end
ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)

local ITEM = {}

ITEM.ID = 18
ITEM.Ref = "item_weapon_ak47"
ITEM.Name = "AK-47"

ITEM.Description = "A high damage semi automatic rifle. Uses rifle ammo."

ITEM.Model = "models/weapons/w_tct_ak47.mdl"

ITEM.LookAt = Vector(-1, -9, -5)
ITEM.CamPos = Vector(50, 56, 25)
ITEM.FOV = 25


ITEM.Use = function(ply)
	if ply:HasWeapon("weapon_ak47") then ply:Notify("You already have that weapon equipped!") return end
	ply:Give("weapon_ak47")
	ply:RemoveItem(18, 1)
	ply:EmitSound("items/ammo_pickup.wav")
end
ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)

local ITEM = {}

ITEM.ID = 19
ITEM.Ref = "item_weapon_m4a1"
ITEM.Name = "M4A1"

ITEM.Description = "A medium damage semi automatic rifle. Uses rifle ammo."

ITEM.Model = "models/weapons/w_m4a1_iron.mdl"

ITEM.LookAt = Vector(0, 7, 0)
ITEM.CamPos = Vector(-16, 54, -4)
ITEM.FOV = 37


ITEM.Use = function(ply)
	if ply:HasWeapon("weapon_m4a1") then ply:Notify("You already have that weapon equipped!") return end
	ply:Give("weapon_m4a1")
	ply:RemoveItem(19, 1)
	ply:EmitSound("items/ammo_pickup.wav")
end
ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)

local ITEM = {}

ITEM.ID = 20
ITEM.Ref = "item_ammo_pistol"
ITEM.Name = "Pistol Ammo"

ITEM.Description = "A box of 30 pistol rounds."

ITEM.Model = "models/Items/BoxMRounds.mdl"

ITEM.LookAt = Vector(4, 2, 7)
ITEM.CamPos = Vector(50, 32, 30)
ITEM.FOV = 24


ITEM.Use = function(ply)
	ply:GiveAmmo(30, "pistol", true)
	ply:RemoveItem(20, 1)
	ply:EmitSound("items/ammo_pickup.wav")
end
ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)

local ITEM = {}

ITEM.ID = 21
ITEM.Ref = "item_ammo_revolver"
ITEM.Name = "Revolver Ammo"

ITEM.Description = "A box of 18 revolver rounds."

ITEM.Model = "models/Items/357ammo.mdl"

ITEM.LookAt = Vector(0, 0, 2)
ITEM.CamPos = Vector(50, 50, 50)
ITEM.FOV = 9


ITEM.Use = function(ply)
	ply:GiveAmmo(18, "357", true)
	ply:RemoveItem(21, 1)
	ply:EmitSound("items/ammo_pickup.wav")
end
ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)

local ITEM = {}

ITEM.ID = 22
ITEM.Ref = "item_ammo_rifle"
ITEM.Name = "Rifle Ammo"

ITEM.Description = "A box of 60 rifle rounds."

ITEM.Model = "models/Items/BoxSRounds.mdl"

ITEM.LookAt = Vector(0, 0, 5)
ITEM.CamPos = Vector(50, 50, 50)
ITEM.FOV = 14


ITEM.Use = function(ply)
	ply:GiveAmmo(60, "ar2", true)
	ply:RemoveItem(22, 1)
	ply:EmitSound("items/ammo_pickup.wav")
end
ITEM.OnUse = function(ply)
	ply:SpawnItem(ITEM.ID)
end

GM:LoadItem(ITEM)