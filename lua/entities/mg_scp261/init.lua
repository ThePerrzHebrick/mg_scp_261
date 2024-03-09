AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')

MG_SCP261 = {}

MG_SCP261.lastUseTime = {} 
MG_SCP261.entityList = {
    {"Cheetos", "mg_scp261_cheetos", 1},
    {"Coke", "mg_scp261_coke", 2},
    {"Pepsi", "mg_scp261_pepsi", 3}
}

util.AddNetworkString("MG_SCP261_AskEntity")

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

function ENT:Use( ply, caller )
    net.Start("MG_SCP261_AskEntity")
        net.WriteEntity(ply)
        net.WriteEntity(self)
    net.Send(ply)
end

function ENT:Use(ply, caller)
    local curTime = CurTime()
    local cooldownTime = MG_SCP261.lastUseTime[self] or 0
    if curTime - cooldownTime >= 10 then
        MG_SCP261.lastUseTime[self] = curTime
        net.Start("MG_SCP261_AskEntity")
            net.WriteEntity(ply)
            net.WriteEntity(self)
        net.Send(ply)
    else
        DarkRP.notify(ply, 0, 3, "Der Automat ist gerade in Benutzung!")
    end
end

function MG_SCP261.randomEatSpawn()
    local randomInt = math.random(1, #MG_SCP261.entityList)
    local ent = net.ReadEntity()
    local ply = net.ReadEntity()
    local entA = ent:GetAngles()
    local pos = ent:GetPos() + entA:Right() * 9 + entA:Up() * 32 + entA:Forward() * 13
    ply:EmitSound("scp294/dispense2.ogg")
    timer.Simple(10, function()
        local object = ents.Create(MG_SCP261.entityList[randomInt][2])
        object:SetPos(pos)
        object:Spawn()
    end)
end

net.Receive("MG_SCP261_AskEntity", MG_SCP261.randomEatSpawn)
