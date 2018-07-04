local PANEL = {}

function PANEL:Init()
	self.title = "Crafting"

	self.exitbutton = vgui.Create("EButton", self)
	self.exitbutton.Font = "Tahoma40"
	self.exitbutton.Text = "X"
	self.exitbutton:SetColor(Color(80, 80, 80, 225))
	self.exitbutton.DoClick = function() 
		self:Remove()
	end

	self.propsbutton = vgui.Create("EButton", self)
	self.propsbutton.Font = "Arial24"
	self.propsbutton.Text = "Props"
	self.propsbutton.DoClick = function() 
		self:Remove()
	end

	self.gunsbutton = vgui.Create("EButton", self)
	self.gunsbutton.Font = "Arial24"
	self.gunsbutton.Text = "Guns"
	self.gunsbutton.DoClick = function() 
		self:Remove()
	end

	self.ammobutton = vgui.Create("EButton", self)
	self.ammobutton.Font = "Arial24"
	self.ammobutton.Text = "Ammo"
	self.ammobutton.DoClick = function() 
		self:Remove()
	end

	self.miscbutton = vgui.Create("EButton", self)
	self.miscbutton.Font = "Arial24"
	self.miscbutton.Text = "Misc"
	self.miscbutton.DoClick = function() 
		self:Remove()
	end
	self.dscroll = vgui.Create("DScrollPanel", self)

	for k,v in pairs(RECIPE_DB) do
		local i = k - 1

		local craftingfile = vgui.Create("CraftingFile", self.dscroll)
			craftingfile.ID = v.ID
			craftingfile.Name = v.Name
			craftingfile.Components = v.Components
			craftingfile.Result = v.ItemID

			craftingfile:SetSize(400, 150)
			craftingfile:SetPos(0, i*152)
	end
end

function PANEL:PerformLayout()
	self:SetSize(400, 600)
	self.sx, self.sy = self:GetSize()

	self:SetPos(ScrW()/2 - self.sx/2, ScrH()/2-self.sy/2)

	self.exitbutton:SetSize(32, 32)
	self.exitbutton:SetPos(self.sx-32, 0)

	self.propsbutton:SetSize(75, 40)
	self.propsbutton:SetPos(0, 37)

	self.gunsbutton:SetSize(75, 40)
	self.gunsbutton:SetPos(80, 37)

	self.ammobutton:SetSize(75, 40)
	self.ammobutton:SetPos(160, 37)

	self.miscbutton:SetSize(75, 40)
	self.miscbutton:SetPos(240, 37)

	self.dscroll:SetSize(400, 563)
	self.dscroll:SetPos(0, 77)

end

function PANEL:Paint()
	surface.SetDrawColor(Color(80, 80, 80, 225))
	surface.DrawRect(0, 0, self.sx, self.sy)
	surface.SetDrawColor(Color(40, 40, 40, 255))
	surface.DrawRect(0, 32, self.sx, 5)

	surface.SetDrawColor(Color(80, 80, 80, 225))
	surface.SetFont("Verdana40")
	surface.SetTextColor(Color(40, 40, 40, 255))
	surface.SetTextPos(self.sx/2 - surface.GetTextSize(self.title) / 2, -5)
	surface.DrawText(self.title)
end



function PANEL:Think()

end

vgui.Register("CraftingMenu", PANEL)