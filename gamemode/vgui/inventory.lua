local PANEL = {}

function PANEL:Init()
	self.scrw = ScrW()
	self.scrh = ScrH()
	self.Opened = CurTime()
	--self:MakePopup()
	self.title = vgui.Create("DLabel", self)
	self.title:SetFont("Verdana40")
	self.title:SetText("Inventory")
	self.title:SetTextColor(Color(40, 40, 40, 255))
	self.title:SetContentAlignment(4)

	self.portrait = vgui.Create("ItemPortrait", self)
	self.desc = vgui.Create("ItemDesc", self)
	local inv = {}
		for i=0,3 do
			for j=0,7 do
				local u = i*8+j+1
			
				local itembutton = vgui.Create("ItemButton", self)
					itembutton.ID = GAMEMODE.PlayerInventory[u].ID
					itembutton.Quantity = GAMEMODE.PlayerInventory[u].Quantity
					itembutton.Num = u
					itembutton:SetSize(64, 64)
					itembutton:SetPos(j*75+105, i*70+300)
			end
		end

	self:Receiver("ItemButton", function(receiver, pnls, dropped, index, x, y) 
		print("OK")
		end)


	self.exitbutton = vgui.Create("EButton", self)
	self.exitbutton.Font = "Tahoma40"
	self.exitbutton.Text = "X"
	self.exitbutton:SetColor(Color(80, 80, 80, 50))
	self.exitbutton.DoClick = function() 
		self:Remove()
	end
end

function PANEL:PerformLayout()
	self:SetSize(800, 600)
	self.sx, self.sy = self:GetSize()

	self:SetPos(ScrW()/2 - self.sx/2, ScrH()/2-self.sy/2)

	self.exitbutton:SetSize(32, 32)
	self.exitbutton:SetPos(self.sx-32, 0)

	self.title:SetSize(200, 32)
	self.title:SetPos(325, 0)

	self.portrait:SetSize(200, 200)
	self.portrait:SetPos(105, 60)

	self.desc:SetSize(370, 200)
	self.desc:SetPos(330, 60)
end

function PANEL:Paint()


	--surface.DrawRect(75, 285, 650, 300)


	surface.SetDrawColor(Color(80, 80, 80, 225))
	surface.DrawRect(0, 0, 800, 600)
	surface.SetDrawColor(Color(40, 40, 40, 255))
	surface.DrawRect(0, 32, 800, 5)
	surface.SetDrawColor(Color(20, 20, 20, 225))

	draw.RoundedBox(8, 100, 295, 599, 284, Color(40, 40, 40, 255))
	draw.RoundedBox(8, 105, 300, 589, 274, Color(40, 40, 40, 255))

	draw.RoundedBox(8, 100, 55, 210, 210, Color(40, 40, 40, 255))

	draw.RoundedBox(8, 325, 55, 380, 210, Color(40, 40, 40, 255))
	/*surface.DrawRect(100, 295, 599, 5)
	surface.DrawRect(100, 300, 5, 274)
	surface.DrawRect(100, 574, 599, 5)
	surface.DrawRect(694, 300, 5, 274)*/
end

function PANEL:Think()
	if input.IsKeyDown(KEY_F2) && self.Opened + 0.5 < CurTime() then
		self:Remove()
	end
end

vgui.Register("Inventory", PANEL)