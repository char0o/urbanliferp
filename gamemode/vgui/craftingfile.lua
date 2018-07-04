local PANEL = {}

function PANEL:Init()
	self.dmodel = vgui.Create("DModelPanel", self)
	self.dmodel.DoClick = function()
		GAMEMODE.Craft(self.ID)
	end

	self.componentslab = vgui.Create("DLabel", self)
	self.componentslab:SetTextColor(Color(155, 155, 155, 255))
	self.componentslab:SetFont("Arial24")
	self.componentslab:SetText("")
	self.componentslab:SetContentAlignment(7)

	self.text = ""
	function self.dmodel:LayoutEntity()
		return
	end
end
function PANEL:PerformLayout()
	self.sx, self.sy = self:GetSize()
	self.dmodel:SetSize(113, 113)
	self.dmodelpx, self.dmodelpy = self.dmodel:GetPos()
	self.dmodelsx, self.dmodelsy = self.dmodel:GetSize()
	self.dmodel:SetPos(0, 37)
	self.dmodel:SetModel(ITEM_DB[RECIPE_DB[self.ID].ItemID.ID].Model)
	self.dmodel:SetCamPos( ITEM_DB[RECIPE_DB[self.ID].ItemID.ID].CamPos)
	self.dmodel:SetLookAt( ITEM_DB[RECIPE_DB[self.ID].ItemID.ID].LookAt)
	self.dmodel:SetFOV( ITEM_DB[RECIPE_DB[self.ID].ItemID.ID].FOV)

	self.componentslab:SetSize(287, 113)
	self.componentslab:SetPos(113, 37)
	for k,v in pairs(RECIPE_DB[self.ID].Components) do
		print(k)
		self.text = v.Quantity.."x"..ITEM_DB[v.ID].Name.."\n"
	end
	self.componentslab:SetText(self.text)
end

function PANEL:Paint()
	surface.SetDrawColor(Color(60, 60, 60, 225))
	surface.DrawRect(0, 0, self.sx, self.sy)
	surface.SetDrawColor(Color(40, 40, 40, 225))
	surface.DrawRect(self.dmodelpx, self.dmodelpy, self.dmodelsx, self.dmodelsy)

	surface.SetFont("Arial32")
	surface.SetTextColor(Color(155, 155, 155, 255))
	surface.SetTextPos(self.sx/2 - surface.GetTextSize(RECIPE_DB[self.ID].Name) / 2, 0)
	surface.DrawText(RECIPE_DB[self.ID].Name)

	surface.SetDrawColor(Color(40, 40, 40, 255))
	surface.DrawRect(0, 32, self.sx, 5)
end

function PANEL:OnMousePressed(key)

end

function PANEL:OnMouseReleased(key)

end

function PANEL:Think()

end

vgui.Register("CraftingFile", PANEL)