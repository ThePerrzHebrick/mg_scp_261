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

local function SendAnswer()
    local ply = net.ReadEntity()
    local ent = net.ReadEntity()
    if !IsValid(ent) then return end
    net.Start("MG_SCP261_AskEntity")
        net.WriteEntity(ent)
        net.WriteEntity(ply)
    net.SendToServer()
end

net.Receive("MG_SCP261_AskEntity", SendAnswer)