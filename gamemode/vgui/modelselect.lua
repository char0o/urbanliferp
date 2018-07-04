local PANEL = {}

function PANEL:Init()
	self.ID = 1
	self.scrw = ScrW()
	self.scrh = ScrH()

	
	self.choose = vgui.Create("EButton", self)
	self.choose.Font = "Tahoma40"
	self.choose.Text = "Choose"
	self.choose:SetTextColor(Color(200, 200, 200, 255))
	self.choose:SetColor(Color(100, 100, 100, 100))
	self.choose.DoClick = function()
		net.Start("setskin")
			net.WriteInt(self.ID, 32)
		net.SendToServer()
		self:Remove()
	end

	self.nextbtn = vgui.Create("EButton", self)
	self.nextbtn.Font = "Tahoma40"
	self.nextbtn.Text = "Next"
	self.nextbtn:SetTextColor(Color(200, 200, 200, 255))
	self.nextbtn:SetColor(Color(100, 100, 100, 100))
	self.nextbtn.DoClick = function()
		if self.ID < 9 then
			self.ID = self.ID + 1
			self:InvalidateLayout()
		end
	end	

	self.previousbtn = vgui.Create("EButton", self)
	self.previousbtn.Font = "Tahoma40"
	self.previousbtn.Text = "Previous"
	self.previousbtn:SetTextColor(Color(200, 200, 200, 255))
	self.previousbtn:SetColor(Color(100, 100, 100, 100))
	self.previousbtn.DoClick = function()
		if self.ID > 1 then
			self.ID = self.ID - 1
			self:InvalidateLayout()
		end
	end	

	self.dmodel = vgui.Create("DModelPanel", self)
	self.dmodel:SetMouseInputEnabled(false)

	self.dmodel:SetAnimated(true)
	self.dmodel:SetFOV(80)

end

function PANEL:PerformLayout()

	self:SetSize(self.scrw, self.scrh)
	self:SetPos(0, 0)

	self.choose:SetSize(self.scrw/8, self.scrh/16)
	self.choose:SetPos(self.scrw / 2 - self.scrw / 16, self.scrh - self.scrh / 8)

	self.nextbtn:SetSize(self.scrw/8, self.scrh/16)
	self.nextbtn:SetPos(self.scrw / 2 + self.scrw / 8, self.scrh/2)

	self.previousbtn:SetSize(self.scrw/8, self.scrh/16)
	self.previousbtn:SetPos(self.scrw / 2 - self.scrw / 4, self.scrh / 2)

	self.dmodel:SetSize(self.scrw/2, self.scrh / 1.5)
	self.dmodel:SetPos(self.scrw / 2 - self.scrw / 4, self.scrh / 16)
	self.dmodel:SetModel("models/Humans/Group01/Male_0"..self.ID..".mdl")
end

function PANEL:Paint()
	surface.SetDrawColor(Color(50, 50, 50, 230))
	surface.DrawRect(0, 0, self.scrw, self.scrw)
end

function PANEL:Think()

end

vgui.Register("ModelSelect", PANEL)