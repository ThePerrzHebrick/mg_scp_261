include("shared.lua")

surface.CreateFont("MG_SCP261_CokeZero", {font = "Roboto", size = 60, weight = 400, blursize = 0, scanlines = 0, antialias = true})

function ENT:DrawTranslucent()
    self:Draw()
end

function ENT:Draw()
    MG_DrawEntity3D2D(self, {
        lines = {
            {
                line = "Coke Zero (SCP-261)",
                font = "MG_SCP261_CokeZero",
                offset = -150
            },
	},
        pos_add = self:GetAngles():Right() * 2,
        hovermult = 1,
    })
    self:DrawModel()
end
