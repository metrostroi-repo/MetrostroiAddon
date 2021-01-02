include("shared.lua")

function ENT:Initialize()
    self.CanDraw = GetConVarNumber("metrostroi_drawsignaldebug")>0
    for k,v in pairs(self.ValidModels) do
        if v==self:GetModel() then
            self.CanDraw = true
            break
        end
    end
    self:DrawShadow(false)
end
function ENT:Draw()
    if not self.CanDraw then return end
    self:DrawModel()
end
cvars.AddChangeCallback("metrostroi_drawsignaldebug", function()
    for k,auto in pairs(ents.FindByClass("gmod_train_autodrive_coil")) do
        if auto.Initialize then auto:Initialize() end
    end
end,"AutodriveCoil")