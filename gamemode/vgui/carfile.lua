local PANEL = {}

function PANEL:Init()
	self.ID = self.ID or 0
	self.BColor = Color(155, 155, 155, 200)
	self:SetMouseInputEnabled(true)

	self.dmodel = vgui.Create("DModelPanel", self)
	function self.dmodel:LayoutEntity()
		return
	end
	self.vehiclename = vgui.Create("DLabel", self)
	self.vehiclename:SetTextColor(Color(64, 64, 64, 255))
	self.vehiclename:SetFont("Arial32")
	--self.vehiclename:SetText(""..VEHICLE_DB[self.ID].Name)

	/*self.colorlabel = vgui.Create("DLabel", self)
	self.colorlabel:SetTextColor(Color(64, 64, 64, 255))
	self.colorlabel:SetFont("Arial24")
	self.colorlabel:SetText("Color")*/

	self.speedlabel = vgui.Create("DLabel", self)
	self.speedlabel:SetTextColor(Color(64, 64, 64, 255))
	self.speedlabel:SetFont("Arial24")

	self.seatlabel = vgui.Create("DLabel", self)
	self.seatlabel:SetTextColor(Color(64, 64, 64, 255))
	self.seatlabel:SetFont("Arial24")

	self.pricelabel = vgui.Create("DLabel", self)
	self.pricelabel:SetTextColor(Color(64, 64, 64, 255))
	self.pricelabel:SetFont("Arial24")

	self.buybutton = vgui.Create("EButton", self)
	self.buybutton.Font = "Arial32"
	self.buybutton.Text = "Buy car"

	self.buybutton.DoClick = function() 
			if LocalPlayer():GetNWInt("money") < VEHICLE_DB[self.ID].Price then 
				GAMEMODE.Notify("Not enough money") 
				self:GetParent():GetParent():GetParent():Remove()
				return 
			end
			if GAMEMODE.PlayerHasVehicle(self.ID) then 
				GAMEMODE.Notify("You already have this car in your garage.")
				self:GetParent():GetParent():GetParent():Remove()
				return
			end
			GAMEMODE.PlayerBuyCar(self.ID, self.choosecolor:GetColor())
			self:GetParent():GetParent():GetParent():Remove()
		end

	self.choosecolor = vgui.Create("DColorMixer", self)
	self.choosecolor:SetAlphaBar(false)
	self.choosecolor:SetWangs(false)
	self.choosecolor:SetPalette(false)

end
function PANEL:PerformLayout()
	self.dmodel:SetSize(126, 126)
	self.dmodel:SetPos(0, 24)
	self.dmodel:SetModel(VEHICLE_DB[self.ID].Model)
	self.dmodel:SetLookAt(VEHICLE_DB[self.ID].LookAt)
	self.dmodel:SetCamPos(VEHICLE_DB[self.ID].CamPos)
	self.dmodel:SetFOV(VEHICLE_DB[self.ID].FOV)


	self.vehiclename:SetSize(300, 20)
	self.vehiclename:SetText(""..VEHICLE_DB[self.ID].Name)
	self.vehiclename:SetPos(125-(string.len(self.vehiclename:GetText()) * 2 ), 3)
	/*self.colorlabel:SetSize(75, 20)
	self.colorlabel:SetPos(138, 110)*/

	self.pricelabel:SetText("Price:"..VEHICLE_DB[self.ID].Price.."$")
	self.pricelabel:SetSize(200, 20)
	self.pricelabel:SetPos(200, 35)

	self.speedlabel:SetText("Max Speed:"..VEHICLE_DB[self.ID].MaxSpeed.." MPH")
	self.speedlabel:SetSize(200, 20)
	self.speedlabel:SetPos(175, 60)

	self.seatlabel:SetText("Seats:"..VEHICLE_DB[self.ID].Seats)
	self.seatlabel:SetSize(200, 20)
	self.seatlabel:SetPos(220, 85)

	self.buybutton:SetSize(130, 40)
	self.buybutton:SetPos(270, 110)

	self.choosecolor:SetSize(134, 40)
	self.choosecolor:SetPos(131, 110)
end

function PANEL:Paint()
	surface.SetDrawColor(self.BColor)
	surface.DrawRect(0, 0, 400, 150)
	surface.SetDrawColor(Color(90, 90, 90, 110))
	surface.DrawRect(0, 24, 400, 5)
	surface.SetDrawColor(Color(90, 90, 90, 110))
	surface.DrawRect(126, 29, 5, 121)
	surface.DrawRect(131, 105, 365, 5)
	surface.DrawRect(265, 110, 5, 40)

end

function PANEL:OnMousePressed(key)

end

function PANEL:OnMouseReleased(key)

end

function PANEL:Think()
	if not self.dmodel:GetEntity() then return end
	self.dmodel:SetColor(self.choosecolor:GetColor())
end

vgui.Register("CarFile", PANEL)