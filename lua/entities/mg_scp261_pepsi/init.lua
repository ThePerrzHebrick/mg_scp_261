AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')

function ENT:Initialize()
    self:SetModel( "models/soda/w_pepsi.mdl" )
    self:PhysicsInit( SOLID_VPHYSICS ) 
    self:SetMoveType( MOVETYPE_VPHYSICS ) 
    self:SetSolid( SOLID_VPHYSICS ) 
    self:SetUseType( SIMPLE_USE )
    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
    end
end

function ENT:Use( ply, caller )
    DarkRP.notify(ply, 0, 4, "Schmeckt nach einer Drachenfrucht, aber dir fällt auf, dass Pepsi das Produkt nie herstellte!")
    ply:EmitSound("scp294/ahh.ogg")
    self:Remove()
end