local PANEL = {}

function PANEL:Init()
	self.TextColor = Color(255, 255, 255, 255)
	self:SetTextColor(Color(40, 40, 40, 255))
	self:SetMouseInputEnabled(true)
end
function PANEL:PerformLayout()
	self.OColor = self.BColor
end

function PANEL:Paint()
	local selfx, selfy = self:GetSize()
	draw.RoundedBox(8, 0, 0, selfx, selfy, self.BColor or Color(0, 0, 0, 0))
	surface.SetTextColor(self.TextColor)
	surface.SetFont(self.Font or "default")
	local sizex, sizey = surface.GetTextSize(self.Text)
	surface.SetTextPos(selfx / 2 - sizex / 2, selfy / 2 - sizey / 2)
	surface.DrawText(self.Text or "")
	
end

function PANEL:OnMousePressed(key)

end

function PANEL:OnMouseReleased(key)
	if self.NotClickable then return end
	self:DoClick()
end
function PANEL:SetTextColor(color)
	self.TextColor = color
end
function PANEL:SetColor(color)
	self.BColor = color
	self.OColor = color
end
function PANEL:Think()
	if self.NotClickable then return end
	if self:IsHovered() then
		self.BColor = Color(self.BColor.r + 100, self.BColor.g + 100, self.BColor.b + 100, 200)
	else
		self.BColor = self.OColor
	end
end

vgui.Register("RoundedButton", PANEL)