AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
      
	self:SetMoveType( MOVETYPE_STEP )   
	self:SetSolid( SOLID_BBOX )   
 	self:SetUseType(SIMPLE_USE)

 	self:SetHullType( HULL_HUMAN )
 	self:SetHullSizeNormal()

 	self:SetSchedule( SCHED_IDLE_STAND )
 	self:DropToFloor()

 	self.bubble = ents.Create("prop_physics")
 		self.bubble:SetPos(self:GetPos() + Vector(0, 0, 90))
 		self.bubble:SetModel("models/extras/info_speech.mdl")
 	self.bubble:Spawn()
 	self.physbubble = self.bubble:GetPhysicsObject()
 	if self.physbubble and IsValid(self.physbubble) then
 		self.physbubble:EnableMotion(false)
 	end

end
 
function ENT:AcceptInput( name, activator, caller )
	if name == "Use" && caller:IsPlayer() then
		net.Start("npc_use")
			net.WriteString(self.Panel)
			net.WriteInt(self.ID, 32)
		net.Send(caller)
	end
end

function ENT:OnTakeDamage( dmg )
	return false end

function ENT:Think()
	self.physbubble:SetAngles(self.physbubble:GetAngles() + Angle(0, 3, 0))

end