local PANEL = {}

function PANEL:Init()
	self.title = vgui.Create("DLabel", self)
	self.title:SetFont("Verdana40")


	self.exitbutton = vgui.Create("EButton", self)
	self.exitbutton:SetFont("Tahoma40")
	self.exitbutton:SetText("X")
	self.exitbutton.DoClick = function() 
		self:Remove()
	end

	self.npcface = vgui.Create("DModelPanel", self)
	function self.npcface:LayoutEntity()
		return
	end
	self.myface = vgui.Create("DModelPanel", self)
	function self.myface:LayoutEntity()
		return
	end
end

function PANEL:PerformLayout()
	self:SetSize(800, 300)
	self:SetPos(ScrW()/2-400, ScrH()-300)

	self.exitbutton:SetSize(32, 32)
	self.exitbutton:SetPos(self:GetSize()-32, 0)

	self.title:SetTextColor(Color(64, 64, 64, 255))
	self.title:SetText(NPC_DB[self.ID].Name)

	self.title:SetSize(self:GetSize(), 32)
	self.title:SetPos(400 - string.len(self.title:GetText())*10, 0)

	self.npcface:SetPos(0, 37)
	self.npcface:SetSize(130, 130)
	self.npcface:SetModel(NPC_DB[self.ID].Model)

	self.myface:SetPos(0, 170)
	self.myface:SetSize(130, 130)
	self.myface:SetModel(LocalPlayer():GetModel())
end

function PANEL:Paint()
	surface.SetDrawColor(Color(155, 155, 155, 200))
	surface.DrawRect(0, 0, self:GetSize(), select(2, self:GetSize()))
	surface.SetDrawColor(Color(90, 90, 90, 200))
	surface.DrawRect(0, 32, self:GetSize(), 5)
	surface.DrawRect(0, 167, 130, 3)
	surface.DrawRect(130, 37, 3, 263)
end

function PANEL:Think()

end

vgui.Register("Dialog", PANEL)