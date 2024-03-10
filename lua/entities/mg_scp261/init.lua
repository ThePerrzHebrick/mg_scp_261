AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')

MG_SCP261 = MG_SCP261 || {} -- Reload protection

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
    self.cooldown = CurTime()
end

function ENT:Use(ply, caller)
    if self.cooldown > CurTime() then
        DarkRP.notify(ply, 0, 3, "Der Automat ist gerade in Benutzung!") -- Would spam massively but im too lazy to add a cooldown to the message
        return false
    end

    self.cooldown = CurTime() + 10

    local tbl = MG_SCP261.entityList
    local item = tbl[math.random(1, #tbl)]
    if !item then return false end -- Item invalid
    local ang = self:GetAngles()
    local pos = self:GetPos() + ang:Right() * 9 + ang:Up() * 32 + ang:Forward() * 13

    local object = ents.Create(item[2])
    if object && IsValid(object) then
        self:EmitSound("scp294/dispense2.ogg") -- Emit sound on entity, not player
    end

    timer.Simple(10, function() -- Are 10 seconds neccessary?
        if object && IsValid(object) then -- IMPORTANT: Check if entity is still valid!
            object:SetPos(pos)
            object:Spawn()
        end
    end)
end
