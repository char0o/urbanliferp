local PANEL = {}

function PANEL:Init()
	self.ID = self.ID or 0
	self.dmodel = vgui.Create("DModelPanel", self)

	self.color = Color(255, 255, 255, 255)
end
function PANEL:PerformLayout()
	
	self.dmodel:SetSize(200, 200)
	self.dmodel:SetPos(0, 0)
	if self.ID ~= 0 then
		self.dmodel:SetModel(ITEM_DB[self.ID].Model)
		self.dmodel:SetLookAt(ITEM_DB[self.ID].LookAt)
		self.dmodel:SetCamPos(ITEM_DB[self.ID].CamPos)
		self.dmodel:SetFOV(ITEM_DB[self.ID].FOV)
	else
		self.dmodel:SetModel("")
	end
end

function PANEL:Paint()
	draw.RoundedBox(8, 0, 0, 200, 200, Color(60, 60, 60, 255))
end


function PANEL:Think()

end

vgui.Register("ItemPortrait", PANEL)