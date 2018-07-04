--[[
	Glow around items
--]]
hook.Add("PreDrawHalos", "ItemHalos", function()
	local eye = LocalPlayer():GetEyeTrace().Entity
	if not IsValid(eye) then return end
	if LocalPlayer():GetPos():Distance(eye:GetPos()) < 200 && eye:GetClass() == "ent_item" then
		local todraw = {eye}
		halo.Add(todraw, Color(255, 255 ,255), 2, 2, 8)
	end
end)
--[[
	Owner name on doors
--]]
hook.Add("PostDrawOpaqueRenderables", "camdoor", function()
	for k, v in pairs(ents.FindInSphere(LocalPlayer():GetPos(), 200)) do
		if v:IsDoor() && LocalPlayer():GetPos():Distance(v:GetPos()) < 100 && not v:IsVehicle() then
			if v:GetNWEntity("owner") ~= NULL then
				local ang = v:GetAngles()
				local pos = v:GetPos()
				local offset = ang:Up() + ang:Forward() * -1.2 + ang:Right() * - 20
				local offset2 = ang:Up() + ang:Forward() * 1.2 + ang:Right() * - 20;

				ang:RotateAroundAxis(ang:Forward(), 90)
				ang:RotateAroundAxis(ang:Right(), 90)

				cam.Start3D2D(pos + offset, ang, 0.1)
					draw.SimpleText("Owned by "..v:GetNWEntity("owner"):Nick(), "Arial40", 0, 0, Color(122, 122, 0, 255), 1, 1)
				cam.End3D2D()

				ang:RotateAroundAxis(ang:Forward(), 0)
				ang:RotateAroundAxis(ang:Right(), 180)

				cam.Start3D2D(pos + offset2, ang, 0.1)
					draw.SimpleText("Owned by "..v:GetNWEntity("owner"):Nick(), "Arial40", 0, 0, Color(122, 122, 0, 255), 1, 1)
				cam.End3D2D()
			end
		end
	end
end)
--[[
	HUD elements to hide
--]]
local NotDrawnTbl = {	["CHudHealth"] = true,
						["CHudBattery"] = true,
						["CHudAmmo"] = true,
						["CHudSecondaryAmmo"] = true
					}

hook.Add( "HUDShouldDraw", "hide hud", function( name )
	 if NotDrawnTbl[name] then
		 return false
	 end
	 if name == "CHudCrosshair" && LocalPlayer():GetActiveWeapon().DrawAmmo then
	 	return false
	 end
end )
--[[
	Action menu when you press E on someone
--]]
hook.Add("KeyRelease", "action_menu", function(ply, key)
	local eyet = LocalPlayer():GetEyeTrace()
	if key == IN_USE then
		local actionmenu = vgui.Create("ActionMenu")
		if eyet.Entity:IsPlayer() && IsValid(eyet.Entity) && eyet.StartPos:Distance(eyet.HitPos) < 250 then

			actionmenu:AddOption("Give Money", function() 
				Derma_StringRequest("Give Money",
									"How much money do you want to give?",
									"",
									function(text)
										local int = tonumber(text)
										if isnumber(int) && int >= 0 then
       										local dosh = LocalPlayer():GetNWInt( "money" )
 
       		 								if (dosh - int) >= 0  then
 
  	     										net.Start( "giveothermoney" )
               										net.WriteEntity(eyet.Entity)
                									net.WriteInt(int, 32)
            									net.SendToServer()
        									elseif dosh - int < 0 then
            									GAMEMODE.Notify("Not enough money")	
            								end
    									else
        									GAMEMODE.Notify("Invalid number")
    									end
									end)
				end,"icon16/money_add.png")
			actionmenu:AddOption("Trade", function() 
				GAMEMODE.AskTrade(eyet.Entity)
				end,"icon16/basket.png")
			actionmenu:MakePopup()	
		end

		/*if LocalPlayer():Isadmin() then

			if eyet.Entity:IsWorld() || eyet.StartPos:Distance(eyet.HitPos) > 1000 || eyet.Entity:IsPlayer() && IsValid(eyet.Entity) then
				local adminmenu = actionmenu:AddSubMenu("Admin")	

				for k, v in pairs(ADMIN_PLUGIN) do
					adminmenu:AddAdminPlugin( v )
				end
				actionmenu:MakePopup()
			end
		end*/

	end
end)
--[[
	Handles weapons holstering when the player presses Q
--]]
local nextholster = 0
hook.Add("Think", "HolsterWeapon", function()
	if input.IsKeyDown(KEY_Q) && not GAMEMODE.LoadoutTable[LocalPlayer():GetActiveWeapon():GetClass()] then
		if nextholster < CurTime() then
			net.Start("holsterweapon")
			net.SendToServer()
		nextholster = CurTime() + 3
		end
	end
end)

--[[
	Custom HUD
--]]

local avatar

local ranktbl = { 	["0"] = "RCT",
					["1"] = "JPM",
					["2"] = "PM",
					["3"] = "SPM",
					["4"] = "SGT",
					["5"] = "SSGT",
					["6"] = "LT"
				}

hook.Add( "HUDPaint", "HUDPaint_DrawABox", function()
	if IsValid(LocalPlayer()) then

		surface.SetDrawColor(Color(20, 20, 20, 225))
		surface.DrawRect(5, ScrH()-130, 325, 125)

		surface.SetDrawColor(Color( 0, 0, 0, 225))
		surface.DrawRect(5, ScrH()-109, 325, 5)

		surface.SetDrawColor(Color( 0, 0, 0, 225))
		surface.DrawRect(104, ScrH()-35, 220, 20)

		surface.SetDrawColor(Color( 100, 0, 0, 225))
		surface.DrawRect(104, ScrH()-35, 220*LocalPlayer():Health()/100, 20)

		surface.SetFont("Arial24")
		surface.SetTextColor(Color(155, 155, 155, 255))
		surface.SetTextPos(195, ScrH() - 37)
		surface.DrawText(""..LocalPlayer():Health().."%")

		surface.SetFont("Arial24")
		surface.SetTextColor(Color(155, 155, 155, 255))
		surface.SetTextPos(160 - surface.GetTextSize(LocalPlayer():Nick()) / 2, ScrH() - 131)
		surface.DrawText(""..LocalPlayer():Nick())

		surface.SetFont("Arial24")
		surface.SetTextColor(Color(155, 155, 155, 255))
		surface.SetTextPos(104, ScrH() - 100)
		surface.DrawText("Money:"..comma_value(LocalPlayer():GetNWInt("money")).."$")

		surface.SetFont("Arial24")
		surface.SetTextColor(Color(155, 155, 155, 255))
		surface.SetTextPos(104, ScrH() - 80)
		surface.DrawText("Salary:"..LocalPlayer():GetSalary().."$")

		surface.SetFont("Arial24")
		surface.SetTextColor(Color(155, 155, 155, 255))
		surface.SetTextPos(104, ScrH() - 60)

		if LocalPlayer():IsPolice() then
			surface.DrawText("Job:"..JOB_DB[LocalPlayer():Team()].Name.."("..ranktbl[""..GAMEMODE.PoliceRank]..")")
		else
			surface.DrawText("Job:"..JOB_DB[LocalPlayer():Team()].Name)
		end

		if LocalPlayer():GetActiveWeapon().DrawAmmo then
			surface.SetDrawColor(Color( 0, 0, 0, 225))
			surface.DrawRect(ScrW() - 180, ScrH()-80, 175, 75)

			surface.SetFont("Arial32")
			surface.SetTextColor(Color(155, 155, 155, 255))
			surface.SetTextPos(ScrW()-90 - surface.GetTextSize(LocalPlayer():GetActiveWeapon().PrintName)/2, ScrH() - 75)
			surface.DrawText(""..LocalPlayer():GetActiveWeapon().PrintName)

			surface.SetFont("Arial32")
			surface.SetTextColor(Color(155, 155, 155, 255))
			surface.SetTextPos(ScrW()-130, ScrH() - 40)
			surface.DrawText(""..LocalPlayer():GetActiveWeapon():Clip1())

			surface.SetFont("Arial32")
			surface.SetTextColor(Color(155, 155, 155, 255))
			surface.SetTextPos(ScrW()-95, ScrH() - 40)
			surface.DrawText("/")

			surface.SetFont("Arial32")
			surface.SetTextColor(Color(155, 155, 155, 255))
			surface.SetTextPos(ScrW()-80, ScrH() - 40)
			surface.DrawText(""..LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()))
		end

		if !IsValid(avatar) then
			avatar = vgui.Create("AvatarImage")
			avatar:SetSize(84, 84)
			avatar:SetPos(15, ScrH()-99)
			avatar:SetPlayer(LocalPlayer(), 84)
		end

		if LocalPlayer():GetVehicle() == NULL then return end
		local speed = LocalPlayer().Speedometer or 0
		surface.SetFont("Arial24")
		surface.SetTextColor(Color(155, 155, 155, 255))
		surface.SetTextPos(100, 500)
		surface.DrawText(""..speed)
	end
end )