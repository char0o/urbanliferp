local PANEL = {}

function PANEL:Init()
	self.scrw = ScrW()
	self.scrh = ScrH()
	--self:MakePopup()
	self.title = vgui.Create("DLabel", self)
	self.title:SetFont("Verdana40")
	self.title:SetText("Trade")
	self.title:SetTextColor(Color(40, 40, 40, 255))
	self.title:SetContentAlignment(4)

	self.mymodel = vgui.Create("DModelPanel", self)
	self.mymodel:SetAnimated(false)
	function self.mymodel:LayoutEntity()
		return
	end
	self.hismodel = vgui.Create("DModelPanel", self)
	function self.hismodel:LayoutEntity()
		return
	end

	self.myname = vgui.Create("DLabel", self)
	self.myname:SetFont("Arial24")
	self.myname:SetTextColor(Color(155, 155, 155, 255))
	self.myname:SetText("You")
	self.myname:SetContentAlignment(5)

	self.hisname = vgui.Create("DLabel", self)
	self.hisname:SetFont("Arial24")
	self.hisname:SetTextColor(Color(155, 155, 155, 255))
	self.hisname:SetText("")
	self.hisname:SetContentAlignment(5)

	self.mymoney = vgui.Create("RoundedButton", self)
	self.mymoney.Font = "Arial24"
	self.mymoney.Text = "Money:0$"
	self.mymoney:SetColor(Color(40, 40, 40, 255))
	self.mymoney.TextColor = Color(155, 155, 155, 255)
	self.mymoney.DoClick = function()
		Derma_StringRequest("Amount of money",
							"How much money do you want to put in the trade?",
							"",
							function(text)
								local int = tonumber(text)
								if isnumber(int) && int >=0 then
									local dosh = LocalPlayer():GetNWInt("money")
									if (dosh - int) >= 0 then
										GAMEMODE.AddTradeMoney(int)
										self.mymoney.Text = "Money:"..text.."$"
										self.money = int
									else
										GAMEMODE.Notify("Not enough money")
									end
								else
									GAMEMODE.Notify("Invalid number")
								end
							end)
	end

	self.hismoney = vgui.Create("RoundedButton", self)
	self.hismoney.Font = "Arial24"
	self.hismoney.Text = "Money:0$"
	self.hismoney:SetColor(Color(40, 40, 40, 255))
	self.hismoney.TextColor = Color(155, 155, 155, 255)
	self.hismoney.NotClickable = true

	self.acceptbtn = vgui.Create("RoundedButton", self)
	self.acceptbtn.Font = "Arial32"
	self.acceptbtn.Text = "Accept"
	self.acceptbtn:SetColor(Color(40, 40, 40, 255))
	self.acceptbtn.TextColor = Color(155, 155, 155, 255)
	self.acceptbtn.DoClick = function()
		self:PendingAccept()
	end

	self.cancelbtn = vgui.Create("RoundedButton", self)
	self.cancelbtn.Font = "Arial32"
	self.cancelbtn.Text = "Cancel"
	self.cancelbtn:SetColor(Color(40, 40, 40, 255))
	self.cancelbtn.TextColor = Color(155, 155, 155, 255)
	self.cancelbtn.DoClick = function()
	GAMEMODE.CancelTrade()
		self:Remove()
	end

	self.invdb = { }
	for i=0,3 do
		for j=0,7 do
			local u = i*8+j+1
			
			self.inventory = vgui.Create("TradeButton", self)
				self.inventory.ID = GAMEMODE.PlayerInventory[u].ID
				self.inventory.Quantity = GAMEMODE.PlayerInventory[u].Quantity
				self.inventory.Num = u
				self.inventory:SetSize(64, 64)
				self.inventory:SetPos(j*75+105, i*70+400)
				self.inventory.functions = 1
			self.invdb[u] = self.inventory
		end
	end

	self.myitemdb = { }
	for i=0,3 do
		for j=0,2 do
			local u = i*3+j+1
			self.mybuttons = vgui.Create("TradeButton", self)
				self.mybuttons.ID = 0
				self.mybuttons.Quantity = 0
				self.mybuttons.Num = u
				self.mybuttons:SetSize(64, 64)
				self.mybuttons:SetPos(j*75+105, i*70+100)
				self.mybuttons.functions = 2
			self.myitemdb[u] = self.mybuttons
		end
	end
	self.hisitemdb = { }
	for i=0,3 do
		for j=0,2 do
			local u = i*3+j+1
			
			self.otherbutton = vgui.Create("TradeButton", self)
				self.otherbutton.ID = 0
				self.otherbutton.Quantity = 0
				self.otherbutton.Num = u
				self.otherbutton:SetSize(64, 64)
				self.otherbutton:SetPos(j*75+475, i*70+100)
				self.otherbutton.NotClickable = true
			self.hisitemdb[u] = self.otherbutton
		end
	end
end

function PANEL:PerformLayout()
	self:SetSize(800, 800)
	self.sx, self.sy = self:GetSize()

	self:SetPos(ScrW()/2 - self.sx/2, ScrH()/2-self.sy/2)

	self.title:SetSize(200, 32)
	self.title:SetPos(325, 0)

	self.mymodel:SetSize(100, 100)
	self.mymodel:SetPos(340, 130)
	self.mymodel:SetModel(LocalPlayer():GetModel())
	self.mymodel:SetFOV(15)
	self.mymodel:SetLookAt(Vector(0, 0, 65))
	self.mymodel:SetCamPos(Vector(50, 0, 70))

	self.hismodel:SetSize(100, 100)
	self.hismodel:SetPos(355, 275)
	self.hismodel:SetFOV(15)
	self.hismodel:SetLookAt(Vector(0, 0, 65))
	self.hismodel:SetCamPos(Vector(50, 0, 70))

	self.myname:SetSize(150, 30)
	self.myname:SetPos(320, 95)

	self.hisname:SetSize(150, 30)
	self.hisname:SetPos(333, 240)

	self.mymoney:SetSize(225, 40)
	self.mymoney:SetPos(100, 45)

	self.hismoney:SetSize(225, 40)
	self.hismoney:SetPos(470, 45)

	self.acceptbtn:SetSize(225, 40)
	self.acceptbtn:SetPos(100, 690)

	self.cancelbtn:SetSize(225, 40)
	self.cancelbtn:SetPos(474, 690)
	if string.len(self.hisname:GetText()) > 10 then
		self.myname:SetFont("Arial16")
	end

end

function PANEL:Paint()

	surface.SetDrawColor(Color(80, 80, 80, 225))
	surface.DrawRect(0, 0, self.sx, self.sy)
	surface.SetDrawColor(Color(40, 40, 40, 255))
	surface.DrawRect(0, 32, 800, 5)
	surface.SetDrawColor(Color(70, 70, 40, 255))


	draw.RoundedBox(8, 100, 395, 599, 284, Color(40, 40, 40, 255))

	draw.RoundedBox(8, 100, 95, 225, 285, Color(40, 40, 40, 255))
	draw.RoundedBox(8, 310, 95, 150, 140, Color(40, 40, 40, 255))

	draw.RoundedBox(8, 470, 95, 225, 285, Color(40, 40, 40, 255))
	draw.RoundedBox(8, 335, 240, 150, 140, Color(40, 40, 40, 255))

	
end

function PANEL:PendingAccept()
	self.acceptbtn:SetColor(Color(0, 225, 0, 255))
	self.acceptbtn.TextColor = Color(60, 60, 60, 255)
	self.acceptbtn.NotClickable = true
	self.myname:SetTextColor(Color(0, 225, 0, 255))
	self.Accept = true
	GAMEMODE.AcceptTrade()
end

function PANEL:TradeHasChanged()
	self.acceptbtn:SetColor(Color(40, 40, 40, 255))
	self.acceptbtn.TextColor = Color(155, 155, 155, 255)
	self.myname:SetTextColor(Color(155, 155, 155, 255))
	self.hisname:SetTextColor(Color(155, 155, 155, 255))
	self.acceptbtn.NotClickable = false
	self.Accept = false
end

function PANEL:AddToTrade(id, quantity)
	if self.Accept then
		self:TradeHasChanged()
	end
	for i=1,12 do
		if self.myitemdb[i].ID == id then --If there's already this item in our item list
			self.myitemdb[i]:InvalidateLayout()
			for u=1,32 do
				if self.invdb[u].ID == id then 
					if self.invdb[u].Quantity <= quantity then --If there's less than the quantity we want to remove
						self.myitemdb[i].Quantity = self.myitemdb[i].Quantity + self.invdb[u].Quantity
						GAMEMODE.AddToTrade(id, self.invdb[u].Quantity)
						self.invdb[u]:ClearSlot()
						return
					else --If there's enough quantity
						self.myitemdb[i].Quantity = self.myitemdb[i].Quantity + quantity
						self.invdb[u].Quantity = self.invdb[u].Quantity - quantity
						GAMEMODE.AddToTrade(id, quantity)
						return
					end
					return
				end
			end
			return
		end

		if self.myitemdb[i].ID == 0 then --If there's not already this item in the item list
			self.myitemdb[i].ID = id
			self.myitemdb[i]:InvalidateLayout()
			for u=1,32 do
				if self.invdb[u].ID == id then --If there's less than the quantity we want to remove
					if self.invdb[u].Quantity <= quantity then
						self.myitemdb[i].Quantity = self.myitemdb[i].Quantity + self.invdb[u].Quantity
						GAMEMODE.AddToTrade(id, self.invdb[u].Quantity)
						self.invdb[u]:ClearSlot()				
						return
					else --If there's enough quantity
						self.myitemdb[i].Quantity = self.myitemdb[i].Quantity + quantity
						self.invdb[u].Quantity = self.invdb[u].Quantity - quantity
						GAMEMODE.AddToTrade(id, quantity)
						return
					end
				end
			end
		end
	end
end

function PANEL:RemoveFromTrade(id, quantity)
	if self.Accept then
		self:TradeHasChanged()
	end
	for i=1,12 do
		if self.myitemdb[i].ID == id then
			for u=1,32 do 
				if self.invdb[u].ID == id then
					self.invdb[u]:InvalidateLayout()
					if self.myitemdb[i].Quantity <= quantity then
						self.invdb[u].Quantity = self.invdb[u].Quantity + self.myitemdb[i].Quantity
						GAMEMODE.RemoveFromTrade(id, self.myitemdb[i].Quantity)
						self.myitemdb[i]:ClearSlot()
						break
					else
						self.invdb[u].Quantity = self.invdb[u].Quantity + quantity
						self.myitemdb[i].Quantity = self.myitemdb[i].Quantity - quantity
						GAMEMODE.RemoveFromTrade(id, quantity)
						break
					end
					break
				end

				if self.invdb[u].ID == 0 then
					self.invdb[u].ID = id
					self.invdb[u]:InvalidateLayout()
					if self.myitemdb[i].Quantity <= quantity then
						self.invdb[u].Quantity = self.invdb[u].Quantity + self.myitemdb[i].Quantity
						GAMEMODE.RemoveFromTrade(id, self.myitemdb[i].Quantity)
						self.myitemdb[i]:ClearSlot()
						break
					else
						self.invdb[u].Quantity = self.invdb[u].Quantity + quantity
						self.myitemdb[i].Quantity = self.myitemdb[i].Quantity - quantity
						GAMEMODE.RemoveFromTrade(id, quantity)
						break
					end
					break
				end
			end
			break
		end
	end
end

function PANEL:AddToOtherTrade(id, quantity)
	for i=1,12 do
		if self.hisitemdb[i].ID == id then
			self.hisitemdb[i].Quantity = self.hisitemdb[i].Quantity + quantity
			self.hisitemdb[i]:InvalidateLayout()
			return
		end

		if self.hisitemdb[i].ID == 0 then
			self.hisitemdb[i].ID = id
			self.hisitemdb[i].Quantity = quantity
			self.hisitemdb[i]:InvalidateLayout()
			return
		end
	end
end

function PANEL:RemoveFromOtherTrade(id, quantity)
	for i=1,12 do
		if self.hisitemdb[i].ID == id then
			if self.hisitemdb[i].Quantity <= quantity then
				self.hisitemdb[i]:ClearSlot()
				self.hisitemdb[i]:InvalidateLayout()
			else
				self.hisitemdb[i].Quantity = self.hisitemdb[i].Quantity - quantity
				self.hisitemdb[i]:InvalidateLayout()
				return
			end
		end
	end
end

function PANEL:Think()

end

vgui.Register("TradeMenu", PANEL)