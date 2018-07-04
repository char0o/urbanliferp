local PANEL = {}

function PANEL:Init()
	self.BColor = Color(155, 155, 155, 100)
	self.OColor = Color(155, 155, 155, 100)
	self.TextColor = Color(255, 255, 255, 255)
	self:SetTextColor(Color(40, 40, 40, 255))
	self:SetMouseInputEnabled(true)
end
function PANEL:PerformLayout()

end

function PANEL:Paint()
	local selfx, selfy = self:GetSize()
	surface.SetDrawColor(self.BColor)
	surface.DrawRect(0, 0, selfx, selfy)
	surface.SetTextColor(self.TextColor)
	surface.SetFont(self.Font or "default")
	local sizex, sizey = surface.GetTextSize(self.Text)
	surface.SetTextPos(selfx / 2 - sizex / 2, selfy / 2 - sizey / 2)
	surface.DrawText(self.Text or "")
end

function PANEL:OnMousePressed(key)

end

function PANEL:OnMouseReleased(key)

end
function PANEL:SetTextColor(color)
	self.TextColor = color
end
function PANEL:SetColor(color)
	self.BColor = color
	self.OColor = color
end
function PANEL:Think()

end

vgui.Register("CLabel", PANEL)