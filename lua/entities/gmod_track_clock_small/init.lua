AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:KeyValue(key, value)
  self.VMF = self.VMF or {}
  self.VMF[key] = value
end

function ENT:Initialize()
  self:EntIndex()
  self.VMF = self.VMF or {}
  self.Type = (tonumber(self.VMF.Type) or tonumber(self.VMF.type) or 2)
  self.NoAutoSearch = (tonumber(self.VMF.NoAutoSearch) or 0)
  self.NoInterval   = (tonumber(self.VMF.NoInterval) or 0)
  self:SetNW2Int("Type",self.Type)
  if self.Type == 2 then
    self:SetModel("models/metrostroi/mus_clock/ind_small_base_spb.mdl")
  else
    self:SetModel("models/metrostroi/mus_clock/ind_small_base.mdl")
  end
end

function ENT:PostInitalize()
  if self.NoInterval == 1 then return end
  self.Signal = nil
  if self.NoAutoSearch == 0 then
    local mind, sig
    for _,v in pairs(ents.FindInSphere(self:GetPos(),1512)) do
      if v:GetClass() == "gmod_track_signal" and not v.ARSOnly and (not sig or v:GetPos():Distance(self:GetPos()) < mind) and (self:GetAngles()-v:GetAngles()):Forward().x > 0 then
        --err = self:WorldToLocal(v:GetPos()).y < 0
        --print(self:WorldToLocal(v:GetPos()).x)
        sig = v
        mind = v:GetPos():Distance(self:GetPos())
        delta_z = math.abs(self:GetPos().z-v:GetPos().z)
      end
    end
    if sig then
      self.Signal = sig
      --print(self,"linked to",sig.Name,mind,self:WorldToLocal(sig:GetPos()).x)
    end
  end
end

function ENT:Think()
  if self.NoInterval == 1 then return end

  self.SensingTrain = false
  if self.NoAutoSearch == 0 then
    if IsValid(self.Signal) then
      if self.Signal.OccupiedBy and self.Signal.OccupiedBy ~= self.Signal then
        self.SensingTrain = true
      end
    else
      -- Check if train passes the sign
      for ray=0,6 do
        local trace = {
          start = self:GetPos() - self:GetRight()*16 + self:GetForward()*50*(ray-3) + Vector(0,0,64),
          endpos = self:GetPos() - self:GetRight()*16 + self:GetForward()*50*(ray-3) - Vector(0,0,256),
          --mask = -1,
          --filter = { },
          ignoreworld = true,
        }

        --debugoverlay.Cross(trace.start,10,1,Color(0,0,255))
        --debugoverlay.Line(trace.start,trace.endpos,1,Color(0,0,255))

        local result = util.TraceLine(trace)
        if result.Hit and (not result.HitWorld) then
          --debugoverlay.Sphere(result.HitPos,5,1,Color(0,0,255),true)
          if result.Entity and (not result.Entity:IsPlayer()) then
            self.SensingTrain = true
          end
        end
      end
    end
  end
  -- If only sensing train for the first time, reset
  self.SensingTime = self.SensingTime or (Metrostroi.GetSyncTime())
  if self.SensingTrain and (not self.IntervalReset) then
		self:SetIntervalResetTime(Metrostroi.GetSyncTime()-GetGlobalFloat("MetrostroiTY")+Metrostroi.GetTimedT())
    self.SensingTime = Metrostroi.GetSyncTime()
    self.IntervalReset = true
  end

  -- If not sensing anything for more than 3 seconds, expect something again
  if (not self.SensingTrain) and (Metrostroi.GetSyncTime() - self.SensingTime > 7.0) then
    self.IntervalReset = false
  end
  self:NextThink(CurTime() + (self.NoAutoSearch ~= 0 and 2 or not IsValid(self.Signal) and 1 or 0.5))
  return true
end
function ENT:AcceptInput( input, activator, called, data )
  if self.NoInterval == 1 then return end
  if input == "Reset" then
    if not self.IntervalReset then
      self:SetIntervalResetTime(Metrostroi.GetSyncTime()-GetGlobalFloat("MetrostroiTY")+Metrostroi.GetTimedT())
      self.SensingTime = Metrostroi.GetSyncTime()
      self.IntervalReset = true
    end
  end
end
