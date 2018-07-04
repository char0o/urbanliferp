local PANEL = { }

function PANEL:Init()

	actionmenu = vgui.Create('DMenu', self)
	self.test = false
end

function PANEL:AddOption( string, func, icon )

	actionmenu:AddOption( string, func ):SetIcon(icon)
	return self
end

function PANEL:AddSubMenu( string )
	actionmenu:AddSpacer()
	local smenu = actionmenu:AddSubMenu( string )
	smenu.Title = false
	/*function smenu:AddAdminPlugin( plugin )	
		if not self.Title then
			smenu:AddOption("Plugins")
			smenu:AddSpacer()
			self.Title = true
		end
		local adminmenu = self:AddSubMenu( plugin.Name )

		adminmenu:AddOption("Users")
		adminmenu:AddSpacer()

		for _, u in pairs(player.GetAll()) do

			if plugin.Time then

				local usermenu = adminmenu:AddSubMenu(''..u:Nick())
				usermenu:AddOption("Time")
				usermenu:AddSpacer()
				for _, w in pairs(plugin.Time) do

					if plugin.Reasons then

						local reasonmenu = usermenu:AddSubMenu(''..parseAdminTime(w))
						reasonmenu:AddOption("Reason")
						reasonmenu:AddSpacer()
						for _, v in pairs(plugin.Reasons) do
							reasonmenu:AddOption(""..v ,plugin.Func(u, v, w))
						end
					else
						usermenu:AddOption(""..parseAdminTime(w), plugin.Func(u, w))
					end
				end
			end
			if plugin.Reasons && not plugin.Time then
				for _, v in pairs(plugin.Reasons) do				
					adminmenu:AddOption(''..v, function() plugin.Func(u, v) end)
				end
			end
		end
	end*/
	return smenu
end

function PANEL:PerformLayout()
	if self.test == false then
		actionmenu:SetPos(ScrW() / 2 - 50, ScrH() / 2 - 10)
		self.test = true
	end
	function self:Setpos(x, y)
		self:SetPos(x, y)
	end
end

function PANEL:MakePopup()
	actionmenu:Open()
end

function PANEL:Close()
	actionmenu:Hide()
end
vgui.Register("ActionMenu", PANEL)