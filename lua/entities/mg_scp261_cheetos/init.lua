AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')

function ENT:Initialize()
    self:SetModel( "models/foodnhouseholditems/chipsccitos.mdl" )
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
    DarkRP.notify(ply, 0, 4, "Schmeckt sehr lecker und sehr käsig !")
    self:Remove()
end
