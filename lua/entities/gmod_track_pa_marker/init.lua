AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
util.AddNetworkString("metrostroi_auodrive_coils")
function ENT:Initialize()
    self:DrawShadow(false)

    self:SetModel("models/mechanics/roboticslarge/xfoot.mdl")
    self:SetColor(Color(200,50,50,100))
    self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:Think()
end

function ENT:UpdateTrackPos(pos,ang)
    local results = Metrostroi.GetPositionOnTrack(pos or self:GetPos(),ang or self:GetAngles())
    if #results > 0 then
        pos,ang = Metrostroi.GetTrackPosition(results[1].node1.path,results[1].x)
        self:SetPos(pos)
        self:SetAngles(ang:Angle())
        self.TrackPosition = results[1]

        self.TrackPath = self.TrackPosition.node1.path.id
        self.TrackX = self.TrackPosition.x
    else
        self:SetPos(pos)
        self:SetAngles(ang)
    end
end

function ENT:SetTrackPosition(path,x)
    local results = Metrostroi.GetPositionOnTrack(self:GetPos(),self:GetAngles())
    local pos,ang = Metrostroi.GetTrackPosition(path,x)
    if not pos then
        --for k,v in pairs(results[1]) do print(k,v) end
        pos,ang = Metrostroi.GetTrackPosition(results[1].path,results[1].x)
        if not pos then
            ErrorNoHalt(Format("Metrostroi: Can't find PA track position: %s!\n",self:GetPos()))
            return
        else
            ErrorNoHalt(Format("Metrostroi: Can't find PA track position: %s, using standart...\n",self:GetPos()))
        end
        --pos,ang = Metrostroi.GetTrackPosition(path,x)
    end
    self.TrackPosition = results[1]
    if self:GetPos():Distance(pos) > 1 then
        self:SetPos(pos)
        self:SetAngles(ang:Angle())
    end
end