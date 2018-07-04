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

	self:Droppable("ItemButton")

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
	--if self.ID == 0 then return end

	--surface.SetDrawColor(self.BColor)
	draw.RoundedBox(6, 0, 0, 64, 64, self.BColor)
end
function PANEL:OnMousePressed(key)
	if self.ID == 0 then return end
end
function PANEL:OnMouseReleased(key)

	if self.ID == 0 then self:InvalidateLayout(true) return end

	if key == MOUSE_LEFT && ITEM_DB[self.ID].Use then
		if LocalPlayer():HasWeapon(string.sub(ITEM_DB[self.ID].Ref, 6, string.len(ITEM_DB[self.ID].Ref, 6))) then return end

		if self.Quantity == 1  then
			GAMEMODE.UseItem(self.ID)
			self.ID = 0
			self.Quantity = 0
			self.dlabel:SetText("")
		else
			GAMEMODE.UseItem(self.ID)
			self.Quantity = self.Quantity - 1
		end
	end
	if key == MOUSE_RIGHT then
		if self.Quantity == 1 then
			GAMEMODE.DropItem(self.ID)
			self.ID = 0
			self.Quantity = 0
			self.dlabel:SetText("")
		else
			GAMEMODE.DropItem(self.ID)
			self.Quantity = self.Quantity - 1
		end
	end
	self:InvalidateLayout(true)
end

function PANEL:Think()
	if self:IsHovered() then
		self.BColor = Color(200, 200, 200, 255)
		if self:GetParent().portrait then
			if self:GetParent().portrait.ID == self.ID && self:GetParent().desc.ID == self.ID then return end
			self:GetParent().portrait.ID = self.ID
			self:GetParent().portrait:InvalidateLayout()

			self:GetParent().desc.ID = self.ID
			self:GetParent().desc:InvalidateLayout()
		end
	else
		self.BColor = Color(64, 64, 64, 255)
	end

end

vgui.Register("ItemButton", PANEL)