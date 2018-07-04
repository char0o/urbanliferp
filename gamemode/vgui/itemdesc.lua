local PANEL = {}

function PANEL:Init()	
	self.ID = self.ID or 0
	self.desc = vgui.Create("DLabel", self)
	self.desc:SetFont("Arial24")
	self.desc:SetTextColor(Color(155, 155, 155, 255))
	self.desc:SetText("")
	self.desc:SetContentAlignment(7)

	self.title = vgui.Create("DLabel", self)
	self.title:SetFont("Arial24")
	self.title:SetTextColor(Color(155, 155, 155, 255))
	self.title:SetText("")
	self.title:SetContentAlignment(5)

end

function PANEL:PerformLayout()
	self.sx, self.sy = self:GetSize()
	self.desc:SetPos(5, 30)
	self.desc:SetSize(380, 100)

	self.title:SetPos(5, 0)
	self.title:SetSize(380, 25)

	if self.ID ~= 0 then
		self.desc:SetText(ITEM_DB[self.ID].Description)
		self.title:SetText(ITEM_DB[self.ID].Name)
	else
		self.desc:SetText("")
		self.title:SetText("")
	end
end

function PANEL:Paint()
	draw.RoundedBox(8, 0, 0, self.sx, self.sy, Color(60, 60, 60, 255))
	surface.SetDrawColor(40, 40, 40, 255)
	surface.DrawRect(0, 25, 380, 5)
	if self.ID == 0 then return end
end


function PANEL:Think()

end

vgui.Register("ItemDesc", PANEL)