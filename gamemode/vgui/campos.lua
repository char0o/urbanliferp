local PANEL = {}

function PANEL:Init()
	self.x, self.y = self:GetPos()

	self.dmodel = vgui.Create("DModelPanel", self)

	self.dlistview = vgui.Create("DListView", self)
	self.dlistview:AddColumn("ID")
	self.dlistview:AddColumn("Name")
	self.dlistview:AddColumn("Ref")
	self.dlistview:AddColumn("Model")
	self.dlistview:SetSortable(false)
	self.dlistview.OnRowSelected = function(row)
		reset = true
	end
	for k,v in pairs(ITEM_DB) do
		self.dlistview:AddLine(""..ITEM_DB[k].ID, ""..ITEM_DB[k].Name, ""..ITEM_DB[k].Ref, ""..ITEM_DB[k].Model)
	end

	self.dsliderlookatx = vgui.Create("DNumSlider", self)
	self.dsliderlookaty = vgui.Create("DNumSlider", self)
	self.dsliderlookatz = vgui.Create("DNumSlider", self)

	/*self.dlabellookatx = vgui.Create("DLabel", self)
	self.dlabellookaty = vgui.Create("DLabel", self)
	self.dlabellookatz = vgui.Create("DLabel", self)

	self.dlabelcamposx = vgui.Create("DLabel", self)
	self.dlabelcamposy = vgui.Create("DLabel", self)
	self.dlabelcamposz = vgui.Create("DLabel", self)*/

	self.dslidercamposx = vgui.Create("DNumSlider", self)
	self.dslidercamposy = vgui.Create("DNumSlider", self)
	self.dslidercamposz = vgui.Create("DNumSlider", self)

	self.dsliderfov = vgui.Create("DNumSlider", self)

	self.dbutton = vgui.Create("DButton", self)
	self.dbutton.DoClick = function() end

	self.dbuttonprint = vgui.Create("DButton", self)
	self.dbuttonprint.DoClick = function() 



		print("ITEM.Lookat = Vector("..lookatx..", "..lookaty..", "..lookatz..")")
		print("ITEM.Campos = Vector("..camposx..", "..camposy..", "..camposz..")")
		print("ITEM.FOV = "..fov) 
	end
	reset = false
	defaultcoord = 0

	camposx = 0
	camposy = 0
	camposz = 0
	lookatx = 0
	lookaty = 0
	lookatz = 0
	fov = 0
	campos = 0
	model = 0


	function self.dmodel:LayoutEntity(ent)
		return
	end

	self.dsliderlookatx:SetMinMax(-100, 100)
	self.dsliderlookaty:SetMinMax(-100, 100)
	self.dsliderlookatz:SetMinMax(-100, 100)

	self.dslidercamposx:SetMinMax(-150, 150)
	self.dslidercamposy:SetMinMax(-150, 150)
	self.dslidercamposz:SetMinMax(-150, 150)

	self.dsliderfov:SetMinMax(-100, 100)

	self.dsliderlookatx:SetDecimals(0)
	self.dsliderlookaty:SetDecimals(0)
	self.dsliderlookatz:SetDecimals(0)

	self.dslidercamposx:SetDecimals(0)
	self.dslidercamposy:SetDecimals(0)
	self.dslidercamposz:SetDecimals(0)

	self.dsliderfov:SetDecimals(0)

	self.dslidercamposx:SetValue(50)
	self.dslidercamposy:SetValue(50)
	self.dslidercamposz:SetValue(50)
	self.dsliderfov:SetValue(30)

end
function PANEL:PerformLayout()
	self.dsliderlookatx:SetSize(400, 20)
	self.dsliderlookatx:SetPos(-100, 200)

	self.dsliderlookaty:SetSize(400, 20)
	self.dsliderlookaty:SetPos(-100, 240)

	self.dsliderlookatz:SetSize(400, 20)
	self.dsliderlookatz:SetPos(-100, 280)

	self.dslidercamposx:SetSize(400, 20)
	self.dslidercamposx:SetPos(300, 200)

	self.dslidercamposy:SetSize(400, 20)
	self.dslidercamposy:SetPos(300, 240)

	self.dslidercamposz:SetSize(400, 20)
	self.dslidercamposz:SetPos(300, 280)


	self.dsliderfov:SetSize(400, 20)
	self.dsliderfov:SetPos(100, 320)

	self.dmodel:SetSize(64, 64)
	self.dmodel:SetPos(100, 70)

	self.dbutton:SetSize(64, 32)
	self.dbutton:SetPos(450, 350)
	self.dbutton:SetText("Exit")

	self.dbuttonprint:SetSize(64, 32)
	self.dbuttonprint:SetPos(200, 350)
	self.dbuttonprint:SetText("Print")

	self.dlistview:SetSize(500, 100)
	self.dlistview:SetPos(250, 50)


end
/*function PANEL:MakePopup()
	self.dframe:MakePopup()
end*/
function PANEL:Paint()
	surface.SetDrawColor(64,64,64, 255)
	surface.DrawRect(100, 70, 64, 64)
end


function PANEL:Think()
	if reset then
		self.dsliderfov:SetValue(30)
		self.dsliderlookatx:SetValue(0)
		self.dsliderlookaty:SetValue(0)
		self.dsliderlookatz:SetValue(0)

		self.dslidercamposx:SetValue(50)
		self.dslidercamposy:SetValue(50)
		self.dslidercamposz:SetValue(50)
		reset = false
	end
	model = self.dlistview:GetSelectedLine()
	campos = self.dmodel:GetCamPos()
	lookatx, lookaty, lookatz = math.Round(self.dsliderlookatx:GetValue()), math.Round(self.dsliderlookaty:GetValue()), math.Round(self.dsliderlookatz:GetValue())
	camposx, camposy, camposz = math.Round(self.dslidercamposx:GetValue()), math.Round(self.dslidercamposy:GetValue()), math.Round(self.dslidercamposz:GetValue())
	fov = math.Round(self.dsliderfov:GetValue())
	if not model then return end
	self.dmodel:SetModel(ITEM_DB[model].Model)
	self.dmodel:SetLookAt(Vector(lookatx, lookaty, lookatz))
	self.dmodel:SetCamPos(Vector(camposx, camposy, camposz))
	self.dmodel:SetFOV(fov)
end
vgui.Register("CamPos", PANEL)