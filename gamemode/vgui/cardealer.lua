local PANEL = {}

function PANEL:Init()
	self.title = vgui.Create("DLabel", self)
	self.title:SetFont("Verdana40")
	self.title:SetText("Car Dealer")
	self.title:SetTextColor(Color(64, 64, 64, 255))

	self.exitbutton = vgui.Create("EButton", self)
	self.exitbutton.Font = "Tahoma40"
	self.exitbutton.Text = "X"
	self.exitbutton.DoClick = function() 
		self:Remove()
	end

	self.dscroll = vgui.Create("DScrollPanel", self)

	for k, v in pairs(VEHICLE_DB) do
		local i = k - 1

		local carfile = vgui.Create("CarFile", self.dscroll)
			carfile.ID = v.ID
			carfile:SetSize(400, 200)
			carfile:SetPos(0, i*155+6)
		
	end
end

function PANEL:PerformLayout()
	self:SetSize(400, 600)
	self:SetPos(ScrW()/2-200, ScrH()/2-300)

	self.exitbutton:SetSize(32, 32)
	self.exitbutton:SetPos(376, 0)

	self.title:SetSize(200, 32)
	self.title:SetPos(100, 0)

	self.dscroll:SetSize(400, 568)
	self.dscroll:SetPos(0, 32)

end

function PANEL:Paint()
	surface.SetDrawColor(Color(155, 155, 155, 200))
	surface.DrawRect(0, 0, 400, 600)
	surface.SetDrawColor(Color(90, 90, 90, 200))
	surface.DrawRect(0, 32, 400, 5)
end

function PANEL:Think()

end

vgui.Register("CarDealer", PANEL)