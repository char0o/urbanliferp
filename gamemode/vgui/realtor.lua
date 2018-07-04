local PANEL = {}

function PANEL:Init()

end

function PANEL:PerformLayout()
	self:SetSize(ScrW(), ScrH())
end

function PANEL:Paint(w, h)
	local x, y = self:GetPos()
	render.RenderView( {
		origin = Vector(-9176, -9852, 426),
		angles = Angle(5, -178, 0),
		x = x,
		y = y,
		w = w,
		h = h

		})
end

function PANEL:Think()
	if input.IsKeyDown(KEY_F2) then
		self:Remove()
	end
end

vgui.Register("Realtor", PANEL)