include("shared.lua")

surface.CreateFont("MG_SCP261_Cheetos", {font = "Roboto", size = 40, weight = 600, blursize = 0, scanlines = 0, antialias = true})

function ENT:DrawTranslucent()
    self:Draw()
end

function ENT:Draw()
    MG_DrawEntity3D2D(self, {
        lines = {
            {
                line = "Cheetos (SCP-261)",
                font = "MG_SCP261_Cheetos",
                offset = -40
            },
		},
        pos_add = self:GetAngles():Right() * -1,
        hovermult = 1,
    })
    self:DrawModel()
end