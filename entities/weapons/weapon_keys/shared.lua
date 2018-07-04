if ( CLIENT ) then

	SWEP.PrintName			= "Keys"			
	SWEP.Author				= "charozoid"

	SWEP.Slot				= 1
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "c"
	
end

--SWEP.Base				= "weapon_base"
SWEP.Category			= "RP"
SWEP.DrawAmmo			= false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= ""
SWEP.WorldModel			= ""

SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "doors/door_latch1.wav" )
SWEP.Primary.ClipSize		= -1
SWEP.Primary.Delay			= 2

SWEP.Secondary.Sound		= Sound( "doors/door_latch3.wav" )
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.Delay		= 2
function SWEP:Initialize()

	self:SetHoldType("normal")
end

function SWEP:PrimaryAttack()
	if SERVER then
		local EyeTrace = self.Owner:GetEyeTrace()
		local ent = EyeTrace.Entity

		if not ent || not ent:IsValid() || not EyeTrace.Entity:IsDoor() || ent.Owner ~= self.Owner || EyeTrace.StartPos:Distance(ent:GetPos()) > 100 then return end

		ent:lock()
		self.Owner:EmitSound(self.Primary.Sound)

		self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	end
end

function SWEP:SecondaryAttack()
	if SERVER then
		local EyeTrace = self.Owner:GetEyeTrace()
		local ent = EyeTrace.Entity
		if not ent || not ent:IsValid() || not EyeTrace.Entity:IsDoor() || ent.Owner ~= self.Owner || EyeTrace.StartPos:Distance(ent:GetPos()) > 100 then return end

		ent:Unlock()
		self.Owner:EmitSound(self.Secondary.Sound)

		self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	end
end

function SWEP:DrawHUD()
	return false
end