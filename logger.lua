local copas = require("copas.timer")
local socket = require("socket")
local bluemark_port = 21472

-- socket to listen on for incoming scan results
-- create new UDP socket
local skt, err = socket.udp()
-- set socket options
skt:settimeout(1)
skt:setoption("broadcast", true)
local status
status, err = skt:setsockname('*', bluemark_port)

local sockethandler = function(skt)
  skt = copas.wrap(skt)
  while true do
    local data, fromip, fromport
    data, fromip, fromport = skt:receivefrom(2048)
    if not data then
      print("receive error: ", fromip)
      return
    else
      --print("received data:"..tostring(data))
      -- reformat as CSV and print to STDOUT
      data = {data:match("^>BM%-(%d+%.%d+)%s+(%d+%:%d%d:%d%d)%s+([%x%:]+)%s+RSSI%:+([%-%+%d%.]+)%s+DIST:+([%-%+%d%.]+)")}
      print('"'..table.concat(data,'","')..'"')
    end
  end
end


copas.addserver(skt, sockethandler)

copas.loop()
