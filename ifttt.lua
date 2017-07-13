--ifttt.lua

file.open( "iftttKey.lua", "r" )
iftttKey = file.read()
iftttKey = string.gsub(iftttKey, "%s+", "")
file.close()
print("IFTTT Maker Key: "..iftttKey)

file.open( "eventName.lua", "r" )
eventName = file.read()
eventName = string.gsub(eventName, "%s+", "")
file.close()
print("IFTTT Event Name: "..eventName)

file.open( "sensorType.lua", "r" )
sensorType = file.read()
sensorType = string.gsub(sensorType, "%s+", "")
file.close()
print("Sensor Type: "..sensorType)

file.open( "sensorLocOne.lua", "r" )
sensorLocOne = file.read()
sensorLocOne = string.gsub(sensorLocOne, "%s+", "")
file.close()
print("Sensor Location: "..sensorLocOne)

file.open( "sensorLocTwo.lua", "r" )
sensorLocTwo = file.read()
sensorLocTwo = string.gsub(sensorLocTwo, "%s+", "")
file.close()
print("Sensor Location: "..sensorLocTwo)

connected=0
print("YO BOIIII CONNECTED DONE BEEN SET TO FKIN" .. connected .. "YO LMFAOROTFL")
conn = nil
conn=net.createConnection(net.TCP, 0) 
--net.createConnection(type, secure); i.e. Type = TCP,

conn:on("receive", function(conn, payload) 
    --Shutdown!
    gpio.write(4, gpio.LOW)
    tmr.alarm(0, 3000, 1, function()
        delay()
        end)
    end)

conn:on("connection", function(conn, payload) 

print("Sending to IFTTT")
conn:send("POST /trigger/" .. eventName .. "/with/key/" .. iftttKey-- .. "/?value1=" .. sensorType .. "&value2=" .. sensorLocOne .. "&value3=" ..sensorLocTwo
--/?value1=SoundSensor&value2=Kitchen&value3=10:30" 

	  .." HTTP/1.1\r\n" 
      .."Host: maker.ifttt.com\r\n"
      .."Accept: */*\r\n" 
      .."User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n" 
      .."\r\n")
	  print("Alert sent to IFTTT.")

end) 

conn:dns("maker.ifttt.com",function(conn,ip) 
    if (ip and connected==0) then
        print("We can connect to " .. ip)
        print("but bruh yo its " .. connected .. " rn")
        connected=connected+1
        print("wtf is this bullshit bro it should be " .. connected .. ".")
        conn:connect(80,ip)
    else
		delay()
    end
end)

function delay()
  --wifi.sta.disconnect()
  --wifi.sta.config("","")
  dofile("delay.lua")
end
