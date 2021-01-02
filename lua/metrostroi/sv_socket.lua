require("bromsock")

if server then server:Close() end
server = BromSock()
server:SetOption(0xFFFF, 0x0008, 1)
server:SetOption(0x6, 0x0001 , 1)

if (not server:Listen(1337)) then
    print("[BS:S] Failed to listen!")
else
    print("[BS:S] Server listening...")
end
server:SetCallbackConnect(function(sockObj, succ, ip, port )
    print(sockObj, succ, ip, port )
end)
local opened = {}
concommand.Add("test_command_send",function(_,_,args)
    local sock = opened[tonumber(args[1])]
    if not sock then return end
    local packet = BromPacket()
    packet:WriteStringRaw(args[2])
    sock:Send(packet,true)
end)
concommand.Add("test_command_sendtest",function(_,_,args)
    local sock = opened[tonumber(args[1])]
    if not sock then return end
    local packet = BromPacket()
    packet:WriteByte(0x00)
    packet:WriteUInt(1234)
    packet:WriteStringNT("test")
    sock:Send(packet,true)
end)
server:SetCallbackAccept(function(serversock, clientsock)
    print("[BS:S] Accepted:", serversock, clientsock,clientsock:GetPort())
    opened[clientsock:GetPort()] = clientsock
    clientsock:SetCallbackReceive(function(sock, packet)
        print("[BS:S] Received:", sock, packet)

        local typ = packet:ReadByte()
        print("[BS:S] Type:", typ)
        if typ == 0x01 then
            local trains = {}
            for k,ent in pairs(ents.GetAll()) do
                if ent.Base == "gmod_subway_base" and not ent.NoTrain then
                    table.insert(trains,ent)
                end
            end

            local packet = BromPacket()
            packet:WriteByte(0x00)
            packet:WriteUInt(#trains)
            sock:Send(packet,true)
            for k,v in ipairs(trains) do
                print("Send train",v:GetClass())
                local packet = BromPacket()
                packet:WriteByte(0x01)
                packet:WriteUInt(#trains)
                packet:WriteUInt(v:EntIndex())
                packet:WriteStringNT(v:GetClass())
                sock:Send(packet,true)
            end
        end
    end)

    clientsock:SetCallbackDisconnect(function(sock)
        print("[BS:S] Disconnected:", sock)
        opened[clientsock:GetPort()] = nil
    end)

    clientsock:SetTimeout(1000)

    clientsock:Receive()

    -- Who's next in line?
    serversock:Accept()
end)
server:Accept()
