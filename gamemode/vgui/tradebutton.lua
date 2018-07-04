local PANEL = {}

function PANEL:Init()	
	self.scrw = ScrW()
	self.scrh = ScrH()


	self.BColor = Color(64, 64, 64, 255)
	self.dmodel = vgui.Create("DModelPanel", self)
	self.dmodel:SetMouseInputEnabled(false)

	self.dlabel = vgui.Create("DLabel", self)
	self.dlabel:SetFont("Arial16")
	self.dlabel:SetTextColor(Color(155, 155, 155, 255))
	self.dlabel:SetText("")
	function self.dmodel:LayoutEntity(ent) return end


end

function PANEL:PerformLayout()
	self.sx, self.sy = self:GetSize()
	self.px, self.py = self:GetPos()

	self.dmodel:SetSize(self.sx, self.sy)
	if self.ID == 0 then self.dmodel:SetModel("")  return end

	self.dmodel:SetModel( ITEM_DB[self.ID].Model)
	self.dmodel:SetCamPos( ITEM_DB[self.ID].CamPos)
	self.dmodel:SetLookAt( ITEM_DB[self.ID].LookAt)
	self.dmodel:SetFOV( ITEM_DB[self.ID].FOV)

	self.dlabel:SetSize(30, 16)
	if self.Quantity > 99 then
		self.dlabel:SetPos(44,48)
	elseif self.Quantity > 9 then
		self.dlabel:SetPos(50,48)
	else
		self.dlabel:SetPos(54,48)
	end
	self.dlabel:SetText(""..self.Quantity)


end

function PANEL:Paint()
	draw.RoundedBox(6, 0, 0, 64, 64, self.BColor)
end
function PANEL:OnMousePressed(key)
	if self.ID == 0 then return end
end
function PANEL:OnMouseReleased(key)

	if self.ID == 0 || self.NotClickable then self:InvalidateLayout() return end

	if key == MOUSE_LEFT then
		if self.functions == 1 then
			self:GetParent():AddToTrade(self.ID, 1)
		end
		if self.functions == 2 then
			self:GetParent():RemoveFromTrade(self.ID, 1)
		end
	end
	if key == MOUSE_RIGHT then
		if self.functions == 1 then
			self:GetParent():AddToTrade(self.ID, 5)			
		end
		if self.functions == 2 then
			self:GetParent():RemoveFromTrade(self.ID, 5)
		end
	end
	self:InvalidateLayout()
end

function PANEL:ClearSlot()
	self.ID = 0
	self.Quantity = 0
	self.dlabel:SetText("")
end
function PANEL:Think()
	if self.NotClickable then return end
	if self:IsHovered() then
		self.BColor = Color(200, 200, 200, 255)
	else
		self.BColor = Color(64, 64, 64, 255)
	end

end

vgui.Register("TradeButton", PANEL)