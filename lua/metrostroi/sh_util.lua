function Metrostroi.VectorAngle(v,v1,v2)
    local vec1 = (v1-v):GetNormalized()
    local vec2 = (v2-v):GetNormalized()
    return math.deg(math.acos(vec1:Dot(vec2)))
end

function Metrostroi.GetLowVal(...)
    local valID,val
    for k,v in pairs{...} do
        if v and (not val or v < val) then
            valID = k
            val = v
        end
    end
    return valID,val
end

if not math.InRange then
    function math.InRangeXY(x,y,px1,py1,px2,py2)
        return (px1 < x and x < px2) and (py1 < y and y < py2)
    end
    function math.InRangeXYR(x,y,px,py,pw,ph)
        return (px < x and x < px+pw) and (py < y and y < py+ph)
    end
    function math.InRangeXYRC(x,y,px,py,pw,ph)
        local hpw,hph = pw/2,ph/2
        return (px-hpw < x and x < px+hpw) and (py-hph < y and y < py+hph)
    end
end