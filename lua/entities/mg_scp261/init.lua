AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')

MG_SCP261 = {}

MG_SCP261.entityList = {
    {"Cheetos", "mg_scp261_cheetos", 1},
    {"Coke", "mg_scp261_coke", 2},
    {"Pepsi", "mg_scp261_pepsi", 3}
}

function ENT:Initialize()
    self:SetModel( "models/vinrax/scp294/scp294_lg.mdl" )
    self:PhysicsInit( SOLID_VPHYSICS ) 
    self:SetMoveType( MOVETYPE_VPHYSICS ) 
    self:SetSolid( SOLID_VPHYSICS ) 
    self:SetUseType( SIMPLE_USE )
    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
    end
end

function ENT:Use(ply, caller)
    if (self.Cooldown == false) then
        local randomInt = math.random(1, #MG_SCP261.entityList)
        local ent = self
        local entA = ent:GetAngles()
        local pos = ent:GetPos() + entA:Right() * 9 + entA:Up() * 32 + entA:Forward() * 13
        local object = ents.Create(MG_SCP261.entityList[randomInt][2])
        ply:EmitSound("scp294/dispense2.ogg")
        self.Cooldown = true;
        timer.Simple(10, function()
            object:SetPos(pos)
            object:Spawn()
            self.Cooldown = false;
        end)
    else
        DarkRP.notify(ply, 0, 3, "Der Automat ist gerade in Benutzung!")
    end
end
