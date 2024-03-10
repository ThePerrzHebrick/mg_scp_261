include("shared.lua")

surface.CreateFont("MG_SCP261", {font = "Roboto", size = 100, weight = 600, blursize = 0, scanlines = 0, antialias = true})

function ENT:DrawTranslucent()
    self:Draw()
end

function ENT:Draw()
    MG_DrawEntity3D2D(self, {
        lines = {
            {
                line = "Essensautomat (SCP-261)",
                font = "MG_SCP261",
                offset = -250
            },
	},
        pos_add = self:GetAngles():Right() * -1,
        hovermult = 1,
    })
    self:DrawModel()
end
