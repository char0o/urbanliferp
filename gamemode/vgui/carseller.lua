local PANEL = {}

function PANEL:Init()
	self.ID = 1
	self.sizex, self.sizey = ScrW(), ScrH()
	self.carpos = Vector(-800, -1691.044312, -143.968750)

	self.title = vgui.Create("CLabel", self)
	self.title.Font = "Tahoma40"
	self.title:SetColor(Color(30, 30, 30, 240))
	self.title:SetTextColor(Color(225, 225, 225, 225))

	self.money = vgui.Create("CLabel", self)
	self.money.Font = "Verdana24"
	self.money.Text = "Money:"..comma_value(LocalPlayer():GetMoney()).."$"
	self.money:SetColor(Color(30, 30, 30, 240))
	self.money:SetTextColor(Color(225, 225, 225, 225))

	self.price = vgui.Create("CLabel", self)
	self.price.Font = "Verdana24"
	self.price:SetColor(Color(30, 30, 30, 240))
	if VEHICLE_DB[self.ID].Price > LocalPlayer():GetMoney() then
		self.price:SetTextColor(Color(225, 0, 0, 255))
	else
		self.price:SetTextColor(Color(225, 225, 225, 225))
	end

	self.exitbutton = vgui.Create("EButton", self)
	self.exitbutton.Font = "Tahoma40"
	self.exitbutton.Text = "Exit"
	self.exitbutton:SetColor(Color(30, 30, 30, 225))
	self.exitbutton:SetTextColor(Color(225, 225, 225, 225))
	self.exitbutton.DoClick = function() 
		self.model:Remove()
		self:Remove()
	end

	self.leftbutton = vgui.Create("PolyButton", self)
	self.leftbutton:SetColor(Color(30, 30, 30, 240))
	self.leftbutton.DoClick = function()
		if self.ID == 1 then return end
		self.ID = self.ID - 1
		self.model:Remove()
		self:InvalidateLayout()
	end

	self.rightbutton = vgui.Create("PolyButton", self)
	self.rightbutton:SetColor(Color(30, 30, 30, 240))
	self.rightbutton.DoClick = function() 
		if self.ID == #VEHICLE_DB then return end
		self.ID = self.ID + 1
		self.model:Remove()
		self:InvalidateLayout()
	end

	self.choosecolor = vgui.Create("DColorMixer", self)
	self.choosecolor:SetAlphaBar(false)
	self.choosecolor:SetWangs(false)
	self.choosecolor:SetPalette(false)
end

function PANEL:PerformLayout()
	self:SetSize(self.sizex, self.sizey)

	self.title:SetSize(600, 75)
	self.title:SetPos(ScrW()/2-300, 25)
	self.title.Text = VEHICLE_DB[self.ID].Name

	self.money:SetSize(350, 50)
	self.money:SetPos(0, ScrH()-375)

	self.price:SetSize(350, 50)
	self.price:SetPos(ScrW()/2-175, 125)
	self.price.Text = "Price:"..comma_value(VEHICLE_DB[self.ID].Price).."$"

	self.exitbutton:SetSize(400, 100)
	self.exitbutton:SetPos(ScrW()-425, ScrH()-125)
	
	self.leftbutton:SetSize(75, 75)
	self.leftbutton:SetPos(ScrW()/2-385, 25)
	self.leftbutton:SetTriangle(5, 37, 70, 5, 70, 70)

	self.rightbutton:SetSize(75, 75)
	self.rightbutton:SetPos(ScrW()/2+310, 25)
	self.rightbutton:SetTriangle(5, 5, 70, 37, 5, 70)

	self.model = ClientsideModel(VEHICLE_DB[self.ID].Model)
	self.model:SetPos(self.carpos)
	self.model:SetAngles(Angle(0, -90, 0))

	self.choosecolor:SetSize(300, 250)
	self.choosecolor:SetPos(25, ScrH()-275)
end

function PANEL:Paint(w, h)
	local x, y = self:GetPos()
	render.RenderView( {
		origin = self.carpos+Vector(200, 150, 200),
		angles = Angle(35, -130, 0),
		x = x,
		y = y,
		w = w,
		h = h

		})
	surface.SetDrawColor(Color(30, 30, 30, 240))
	surface.DrawRect(0, ScrH()-300, 350, 300)
	surface.DrawRect(350, ScrH()-150, ScrW()-350, 150)

end

function PANEL:Think()
	if not self.model || not IsValid(self.model) then return end
	self.model:SetColor(self.choosecolor:GetColor())
end

vgui.Register("CarSeller", PANEL)