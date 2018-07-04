local PANEL = {}

function PANEL:Init()
	self.BColor = Color(155, 155, 155, 100)
	self.OColor = Color(155, 155, 155, 100)
	self.TColor = Color(225, 0, 0, 255)
	self:SetMouseInputEnabled(true)


end

function PANEL:PerformLayout()
	self.triangle = {
		{ x = self.ax, y = self.ay },
		{ x = self.bx, y = self.by },
		{ x = self.cx, y = self.cy }
	}
end


function PANEL:Paint()
	local selfx, selfy = self:GetSize()

	surface.SetDrawColor(self.BColor)
	surface.DrawRect(0, 0, selfx, selfy)

	surface.SetDrawColor(Color(225, 225, 225, 255))
	draw.NoTexture()
	surface.DrawPoly(self.triangle)
end

function PANEL:OnMousePressed(key)
	self:DoClick()
end

function PANEL:OnMouseReleased(key)

end
function PANEL:SetTriangle(ax, ay, bx, by, cx, cy)
	self.ax, self.ay = ax, ay
	self.bx, self.by = bx, by
	self.cx, self.cy = cx, cy
end
function PANEL:SetColor(color)
	self.BColor = color
	self.OColor = color
end
function PANEL:SetTColor(color)
	self.TColor = color
end
function PANEL:Think()
	if self:IsHovered() then
		self.BColor = Color(self.BColor.r + 100, self.BColor.g + 100, self.BColor.b + 100, 200)
	else
		self.BColor = self.OColor
	end
end

vgui.Register("PolyButton", PANEL)