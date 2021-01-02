util.AddNetworkString("metrostroi_language_sync")

Metrostroi.LanguageCache = {}
function Metrostroi.SendLanguages(ply)
  if true then return end
  -- Add all clientside files
  local files = file.Find("lua/metrostroi_data/languages/*","GAME")
  local langs = {}
  for i,filename in ipairs(files) do
      local bytes = (#filename+4)+4+(1+1)+(1+1)+4
      local data = util.Compress(file.Read("metrostroi_data/languages/"..filename,"LUA"))
      local count = math.floor(#data/(65533-bytes))
      if count > 32 then
        ErrorNoHalt("Default language file metrostroi_data/languages/"..filename.." is too big (max ~2mb compressed)")
      elseif count > 0 then
        local bytescount = (65533-bytes)
        for c=0,count do
          local write = data:sub(c*bytescount,(i+1)*bytescount-1)
          table.insert(Metrostroi.LanguageCache,{
            CurTime(),    --ID
            #files,i,     --Count/CurrFile
            count,c,      --Count/CurrPacket
            #write,write, --Count/Data
            ply           --Player
          })
        end
      else
        table.insert(Metrostroi.LanguageCache,{
          CurTime(),  --ID
          #files,i,   --Count/CurrFile
          0,0,        --Count/CurrPacket
          #data,data, --Count/Data
          ply         --Player
        })
      end
  end
end
timer.Create("metrostroi_language_sender",0.5,0,function()
  if #Metrostroi.LanguageCache > 0 then
    local tbl = table.remove(Metrostroi.LanguageCache,1)
    if tbl and (not tbl[8] or IsValid(tbl[8])) then
      print(Format("Send [%s] %01d/%01d %01d/%01d %d",tbl[1],tbl[3],tbl[2],tbl[5],tbl[4],tbl[6]))
      net.Start("metrostroi_language_sync")
        net.WriteFloat(tbl[1]) -- ID of packet
        net.WriteUInt(tbl[2],8) -- Count of files
        net.WriteUInt(tbl[3],8) -- Current file
        net.WriteUInt(tbl[4],8) -- Count of packets
        net.WriteUInt(tbl[5],8) -- Current packet
        net.WriteUInt(tbl[6],32) --Count of datasize
        net.WriteData(tbl[7],tbl[6]) --Data
      if IsValid(tbl[8]) then net.Send(tbl[8]) else net.Broadcast() end
    end
  end
end)

net.Receive("metrostroi_language_sync",function(_,ply) Metrostroi.SendLanguages(ply) end)
--Metrostroi.LanguageCache = {}
--Metrostroi.SendLanguages()

concommand.Add("metrostroi_language_reload",Metrostroi.SendLanguages)
