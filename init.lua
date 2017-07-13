--init.lua

gpio.mode(2, gpio.OUTPUT)
-- Define Mode for General Purpose In Out Pin; Mode 4 == Pin# GPIO2
-- http://esp8266.co.uk/tutorials/introduction-to-the-gpio-api/

gpio.write(2, gpio.LOW)
-- Set esp8266 Pin GPIO2 to write mode, and write "High" to signify high noise level.

cnt = 0
-- Set count variable


print("Starting SimpleIOThings Wifi to Cloud Alert System")
-- Displays startup status

tmr.alarm(1, 1000, 1, function()
-- Create timer to execute function after 1 second (1000 ms)

if wifi.sta.getip() == nil then
    cnt = cnt + 1
	print("(" .. cnt .. ") Waiting for a Wifi Connection...")
-- function that counts each failed attempt to get an IP address from your router.


    if cnt == 10 then
        tmr.stop(1)
        dofile("setwifi.lua")
    end
-- if statement that executes code in "setwifi.lua", which needs to be loaded onto your device along with this file.

else
	tmr.stop(1)
	print("You are connected to Wifi. IP Address:"
	..wifi.sta.getip())
    print("Starting Sensor...")
    tmr.alarm(0, 3000, 0, function()
    print("Listening for Sensor Inputs...")
    dofile("sensor.lua")
    end)
-- else statement that stops the previously setup timer and executes "ifttt.lua" when your device is connected to the internet.

end
end)
