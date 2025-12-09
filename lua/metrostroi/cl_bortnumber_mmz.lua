--------------------------------------------------------------------------------
-- Callbacks for new bortnumber models
--------------------------------------------------------------------------------
local bortnumber_mdl = "models/metrostroi_train/81-714_mmz/bortnumber_%d.mdl"

function Metrostroi.BortNumberMMZCallback(train, cent, id, i, pos, align)
    align = align or TEXT_ALIGN_LEFT
    
    local x = train[id.."PosX"..i] or 0
    local w = train[id.."Width"]
    local inv = train[id.."Inv"]
    
    local offset = 0
    if align == TEXT_ALIGN_LEFT then
        offset = (inv and 0 or w)
    elseif align == TEXT_ALIGN_CENTER then
        offset = w/2
    elseif align == TEXT_ALIGN_RIGHT then
        offset = (inv and w or 0)
    end

    cent:SetPos(train:LocalToWorld(pos + Vector(x-offset,0,0)))
end

function Metrostroi.BortNumberMMZCallbackModel(train, id, i, minc, inv)
    local wagNum = train.WagonNumber or 0
    local count = math.max(minc, math.ceil(math.log10(wagNum+1)))

    if not train[id] then
        train[id] = true

        local w = 0
        local prevOne = false
        for n=0,count do
            local n2 = inv and (count-n-1) or n
            local nNum = math.floor(wagNum%(10^(n2+1))/10^n2)

            if (nNum == 1) and prevOne then     -- Two and more ones
                w = w+2.6
            elseif (nNum == 1) or prevOne then  -- First one
                w = w+4.8
            else                                -- Not one
                w = w+6.6
            end
            prevOne = (nNum == 1)

            train[id.."PosX"..n2] = w
        end
        train[id.."Width"] = w
        train[id.."Inv"] = inv
    end

    local iNum = math.floor(wagNum%(10^(i+1))/10^i)
    return Format(bortnumber_mdl, iNum)
end