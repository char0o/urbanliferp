concommand.Add("rp_trade", function(ply, cmd, args)
	local ply = LocalPlayer()
	ply.trademenu = vgui.Create("TradeMenu")
	ply.trademenu:MakePopup()
	print(ply.trademenu)
end)

concommand.Add("rp_crafting", function(ply, cmd, args)
	local craftmenu = vgui.Create("CraftingMenu")
	craftmenu:MakePopup()
end)

concommand.Add("rp_campos", function()
	local frame = vgui.Create("DFrame")
	frame:SetSize(800, 400)
	frame:SetPos(ScrW()/2-400, ScrH()/2-300)
	local campos = vgui.Create("CamPos", frame)
	campos:SetPos(0, 0)
	campos:SetSize(800, 400)
	campos.dbutton.DoClick = function() 
		campos:Remove()
		frame:Close()
	end
	frame:MakePopup()
end)
concommand.Add("rp_camposcar", function()
	local frame = vgui.Create("DFrame")
		frame:SetSize(800, 400)
		frame:SetPos(ScrW()/2-400, ScrH()/2-300)
	local campos = vgui.Create("CamPosCar", frame)
		campos:SetPos(0, 0)
		campos:SetSize(800, 400)
		campos.dbutton.DoClick = function() 
			campos:Remove()
			frame:Close()
		end
	frame:MakePopup()
end)

concommand.Add("rp_getmodel", function(ply) 
	local eye = ply:GetEyeTrace()

	print(eye.Entity:GetModel())
end)

concommand.Add("rp_getrenderview", function(ply)
	local pos = ply:GetPos()
	local ang = ply:GetAngles()
	print("origin = Vector("..math.Round(pos.x)..", "..math.Round(pos.y)..", "..math.Round(pos.z).."),")
	print("angles = Angle("..math.Round(ang.x)..", "..math.Round(ang.y)..", "..math.Round(ang.z).."),")
end)
concommand.Add("rp_getpos", function(ply) 
	local eye = ply:GetEyeTrace()

	print(eye.Entity:GetPos())
end)
concommand.Add("rp_getclass", function(ply) 
	local eye = ply:GetEyeTrace().Entity

	print(eye:GetClass())
end)
concommand.Add("rp_getangles", function(ply) 
	local eye = ply:GetEyeTrace()

	print(eye.Entity:GetAngles())
end)
concommand.Add("rp_getdoor", function(ply) 
	local eye = ply:GetEyeTrace().Entity
	print("{ Pos = Vector("..eye:GetPos().x..", "..eye:GetPos().y..", "..eye:GetPos().z.."), Model = \""..eye:GetModel().."\"}")
end)
concommand.Add("rp_getentpos", function(ply) 
	local eye = ply:GetEyeTrace().Entity
	print("Vector("..math.Round(eye:GetPos().x, 2)..", "..math.Round(eye:GetPos().y, 2)..", "..math.Round(eye:GetPos().z, 2)..")")
	print("Angle("..math.Round(eye:GetAngles().x, 2)..", "..math.Round(eye:GetAngles().y, 2)..", "..math.Round(eye:GetAngles().z, 2)..")")

end)
concommand.Add("rp_getowner", function(ply)
	local eye = ply:GetEyeTrace().Entity 
	print(eye:GetNWEntity("owner"))
end)

concommand.Add("rp_getselfpos", function(ply)
	local pos = ply:GetPos()
	print("Vector("..math.Round(pos.x, 2)..", "..math.Round(pos.y, 2)..", "..math.Round(pos.z, 2)..")")
end)

concommand.Add("rp_getselfang", function(ply) 
	print(ply:GetAngles())
end)

concommand.Add("rp_cardealer", function() 
	local car = vgui.Create("CarDealer")
	car:MakePopup()
end)


local doors = {}

concommand.Add("rp_adddoor", function() 
	local eye = LocalPlayer():GetEyeTrace().Entity
	local pos = eye:GetPos()
	local model = eye:GetModel()
	local format = {Pos = Vector(math.Round(pos.x), math.Round(pos.y), math.Round(pos.z)), Model = model}
	table.insert(doors, format)
	PrintTable(doors)
end)

concommand.Add("rp_cleardoors", function() 
	doors = {}
end)

concommand.Add("rp_createproperty", function() 
	local doorstr = "{"
	for k,v in pairs(doors) do
		doorstr = doorstr..""..v
	end
	print([[
local Property = {}

Property.ID = 0

Property.Name = ""

Property.Price = 0

Property.Doors = {}

]])
print(doorstr)
end)
concommand.Add("rp_choosemodel", function() 
	local model = vgui.Create("ModelSelect")
	model:MakePopup()
end)
local isopen = isopen or false
local fw, ft = 200, 175
local cx, cy, cz
local isw = isw or false
local vehwe = vehwe or nil
local chair = chair or nil
local f = f or nil

concommand.Add("rp_getbench", function()
	if not isopen then
		isopen = true

		if not IsValid(vehwe) then
			vehwe = nil
			isw = false

			if IsValid(chair) then
				chair:Remove()
				chair = nil
			end
		end

		f = vgui.Create("DFrame")
		f:SetSize(fw, ft)
		f:SetPos(ScrW() - fw - 5, ScrH() / 2 - ft / 2)
		f:SetTitle("")

		f.OnClose = function()
			isopen = false
		end

		local won = vgui.Create("DButton", f)
		won:Dock(TOP)
		won:SetText(isw and "Finish working (and close)" or "Work on this vehicle")

		won.DoClick = function()
			if not isw then
				won:SetText("Finish working (and close)")
				vehwe = LocalPlayer():GetEyeTrace().Entity
				isw = true
				chair = ents.CreateClientProp()
				chair:SetModel("models/nova/airboat_seat.mdl")
				chair:SetPos(vehwe:GetPos())
				chair:SetAngles(vehwe:GetAngles())
				chair:SetParent(vehwe)
				chair:SetMaterial("models/debug/debugwhite")
				chair:SetColor(Color(0, 255, 0))
				chair:Spawn()
				cx = 0
				cy = 0
				cz = 0
				local pc = vgui.Create("DButton", f)
				pc:Dock(TOP)
				pc:SetText("Print to console")

				pc.DoClick = function()
					print("Vector(" .. chair:GetLocalPos().x .. ", " .. chair:GetLocalPos().y .. ", " .. chair:GetLocalPos().z .. ")")
				end
			else
				vehwe = nil
				isw = false
				chair:Remove()
				chair = nil
				f:Close()
			end
		end

		local sposx = vgui.Create("DNumSlider", f)
		sposx:SetText("X: ")
		sposx:SetMin(-200)
		sposx:SetMax(200)
		sposx:SetDecimals(2)
		sposx:Dock(TOP)
		sposx:SetValue(cx)

		sposx.OnValueChanged = function(val)
			cx = math.Round(val:GetValue(), 2)
			chair:SetLocalPos(Vector(cx, cy, cz))
		end

		local sposy = vgui.Create("DNumSlider", f)
		sposy:SetText("Y: ")
		sposy:SetMin(-200)
		sposy:SetMax(200)
		sposy:SetDecimals(2)
		sposy:Dock(TOP)
		sposy:SetValue(cy)

		sposy.OnValueChanged = function(val)
			cy = math.Round(val:GetValue(), 2)
			chair:SetLocalPos(Vector(cx, cy, cz))
		end

		local sposz = vgui.Create("DNumSlider", f)
		sposz:SetText("Z: ")
		sposz:SetMin(-200)
		sposz:SetMax(200)
		sposz:SetDecimals(2)
		sposz:Dock(TOP)
		sposz:SetValue(cz)

		sposz.OnValueChanged = function(val)
			cz = math.Round(val:GetValue(), 2)
			chair:SetLocalPos(Vector(cx, cy, cz))
		end

		if isw then
			local pc = vgui.Create("DButton", f)
			pc:Dock(TOP)
			pc:SetText("Print to console")

			pc.DoClick = function()
				print("Vector(" .. math.Round(chair:GetLocalPos().x, 2) .. ", " .. math.Round(chair:GetLocalPos().y, 2) .. ", " .. math.Round(chair:GetLocalPos().z, 2) .. ")")
			end
		end
	end
end)

hook.Add("Think", "chairpositioning-chair-remover", function()
	if not IsValid(vehwe) and IsValid(chair) then
		chair:Remove()
	end

	if not IsValid(vehwe) and IsValid(f) and isw then
		f:Close()
	end
end)
