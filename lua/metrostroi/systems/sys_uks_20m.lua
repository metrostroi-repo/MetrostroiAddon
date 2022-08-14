--------------------------------------------------------------------------------
-- UKS system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("UKS_20M")

function TRAIN_SYSTEM:Initialize(parameters)
    self.UKSLamp = 0
    self.UKSTriggered = 0
    self.UKSEmerTriggered = 0
    self.UKSEmerTriggeredX = false
    self.UKSEmerTriggeredT = false
    self.UKSEmerTriggeredV = false
    self.UKSEmerTriggeredReal = false
    self.Train:LoadSystem("UKSDisconnect","Relay","Switch", {bass = true,normally_closed = true})
end

function TRAIN_SYSTEM:Outputs()
    return { "UKSLamp", "UKSTriggered", "UKSEmerTriggered" }
end

function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    local KV = Train.KV
    if Train.Panel.V1*(KV["10a-8"] or KV["10-14B"])*Train.UAVA.Value*Train.UKSDisconnect.Value > 0 then
        local speed = Train.ALSCoil.Speed*Train.ALSCoil.SpeedSign
        local KVX = KV["33-10AK"] or KV["10AK-7A"]
        local KVTr = KV["U2-6"]
        if speed <= -1 or KV["U2-4"] == 1 then
            self.UKSEmerTriggered = 1
            self.UKSTriggered = 1
            self.UKSLamp = 1        
        elseif speed > 18 then
            self.UKSLamp = 1
            self.UKSTriggered = 1
            if speed > 20 and self.UKSEmerTriggered ~= 1 then
                self.UKSEmerTriggered = 1
                self.UKSEmerTriggeredReal = true
                self.UKSEmerTriggeredX = KVX > 0
                self.UKSEmerTriggeredT = KVTr > 0
                self.UKSEmerTriggeredV = false
            end
        elseif speed <= 1 then
            if self.UKSEmerTriggered > 0 and KVX > 0 then
                if not self.Starting then self.Starting = CurTime() end
            elseif KVX == 0 and self.UKSEmerTriggered == 0 then
                self.Starting = nil
            end
            if self.Starting then
                if CurTime()-self.Starting > 5 then self.UKSEmerTriggered = 1 self.UKSTriggered = 1 end 
            end            
            if self.UKSTriggered > 0 then
                self.UKSTriggered = KVX
                self.UKSEmerTriggered = KVX
            else            
                self.UKSEmerTriggered = 1-KVX
                self.UKSEmerTriggeredReal = false
            end
            self.UKSLamp = self.UKSEmerTriggered
        elseif speed <= 18 and self.UKSEmerTriggered > 0 and self.UKSEmerTriggeredReal and not self.UKSEmerTriggeredX then
            self.UKSLamp = 0
            if KVTr+KVX == 0 then self.UKSEmerTriggeredV = true end
            if self.UKSEmerTriggeredV then
                if self.UKSEmerTriggeredT then
                    self.UKSEmerTriggered = 1-KVTr
                else
                    self.UKSEmerTriggered = 1-KVX
                end
                self.UKSEmerTriggeredReal = self.UKSEmerTriggered > 0
                self.UKSTriggered = self.UKSEmerTriggered
            end
        elseif speed <= 16 and self.UKSTriggered > 0 and self.UKSEmerTriggered == 0 then
            self.UKSTriggered = KVX
            self.UKSEmerTriggered = KVX
            self.UKSLamp = KVX
        else
            if self.Starting then
                if CurTime()-self.Starting > 5 then self.UKSEmerTriggered = 1 self.UKSTriggered = 1 self.Starting = nil elseif speed > 3 then self.Starting = nil end 
            end
        end
    else
        self.UKSTriggered = 0
        self.UKSEmerTriggered = 0
        self.UKSLamp = 0
    end
end
