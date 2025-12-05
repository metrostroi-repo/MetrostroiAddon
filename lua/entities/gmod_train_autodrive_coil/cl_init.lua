include("shared.lua")

local C_SignalDebug = GetConVar("metrostroi_drawsignaldebug")

function ENT:Initialize()
    self:SetNoDraw(false)
    self:DrawShadow(false)
    self.CanDraw = C_SignalDebug:GetBool()

    for k,v in pairs(self.ValidModels) do
        if v==self:GetModel() then
            self.CanDraw = true
            break
        end
    end
end

function ENT:Draw(flags)
    if not self.CanDraw then
        self:SetNoDraw(true)
        return
    end

    self:DrawModel(flags)
end

cvars.AddChangeCallback("metrostroi_drawsignaldebug", function()
    for _,ent in pairs(ents.FindByClass("gmod_train_autodrive_coil")) do
        ent:Initialize()
    end
end)