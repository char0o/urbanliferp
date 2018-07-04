local PANEL = {}
PANEL.Ent = {}

function PANEL:Init()
	self.frame = vgui.Create("DFrame")
	self.daccept = vgui.Create("DButton", self.frame)
	self.ddecline = vgui.Create("DButton", self.frame)
	self.dtext = vgui.Create("DTextEntry", self.frame)

	function self.daccept.DoClick()
    	if isnumber(tonumber(self.dtext:GetValue())) then
        	local int = tonumber(self.dtext:GetValue())
       		local dosh = LocalPlayer():GetNWInt( "money" )
 
       		 if (dosh - int) >= 0 && int >= 0 then
 
  	     		net.Start( "giveothermoney" )
               		net.WriteEntity(self.Ent)
                	net.WriteInt(int, 32)
            	net.SendToServer()
 				self:Remove()
 				self.frame:Close()
        	elseif dosh - int < 0 then
            	GAMEMODE.Notify("Not enough money")	
            	self:Remove()
            	self.frame:Close()
            else
            	print("wtf")
        	end
    	else
 
        	GAMEMODE.Notify("Invalid number")
        	self:Remove()
        	self.frame:Close()
    	end
	end

	self.ddecline.DoClick = function()
			self:Remove()
			self.frame:Close()
		end
end

function PANEL:PerformLayout()
	self.frame:SetSize(300, 200)
	self.frame:SetPos( ScrW()/2 - 150, ScrH() / 2 - 100 )
	self.frame:SetTitle( "Amount of money" )
	self.frame:ShowCloseButton( false )


	self.dtext:SetSize( 200, 75 )
	self.dtext:SetPos( 50, 50 )


	self.daccept:SetSize( 100, 50 )
	self.daccept:SetPos( 50, 130)
	self.daccept:SetText( "Accept" )

	self.ddecline:SetSize(100, 50)
	self.ddecline:SetPos( 150, 130 )
	self.ddecline:SetText( "Decline" )

	self.frame:MakePopup()
end

vgui.Register("CashMenu", PANEL)