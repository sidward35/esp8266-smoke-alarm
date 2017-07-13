--sensor.lua
file.open( "sensorThreshold.lua", "r" )
sensorThreshold = file.read()
sensorThreshold = string.gsub(sensorThreshold, "%s+", "")
sensorThreshold = tonumber(sensorThreshold)
file.close()


--Set how many times you'd like the sensor to receive an input before sending an alert.

file.open( "timerThreshold.lua", "r" )
timerThreshold = file.read()
timerThreshold = string.gsub(timerThreshold, "%s+", "")
timerThreshold = tonumber(timerThreshold)*1000
file.close()
--print("Timer Reset: "..timerThreshold)

--The interaction of these two variables above will determine your tolerance for false alarms.
--For example if this device is a panic button and you want to send a message after 3 button presses within 10 seconds, set countThreshold = 3 and TimerResetThreshold = 10000.
--If this device is a Smoke Alarm Sound Sensor, and you want to wait until the alarm has been sounding for ~30 seconds before sending an alert, set countThreshold = 60, TimerResetThreshold = 60000 (60 loud sounds within 60 seconds).
--If this device is a Baby Noise SMS Alert, set countThreshold = 5, TimerResetThreshold = 60000 (5 loud sounds/cries within 60 seconds). Keep in mind you will have to calibrate your microphone sensor to a lower threshold than a Smoke Alarm Sensor.

buttonPin = 2 -- this is ESP-01 pin GPIO4
gpio.mode(buttonPin,gpio.INT,gpio.PULLUP)
count = 0

function resetCounter()
	count = 0
	end

function debounce (func)
    local last = 0
    local delay = 10000

    return function (bounceCheck)
        local now = tmr.now()
			if now - last < delay
			then return
			end
        last = now
        return func(bounceCheck)
    end
end

function onChange()
	if gpio.read(buttonPin) == 0
	then count = count + 1
	
		tmr.alarm(6,timerThreshold,0,function() 
		resetCounter()
		print("Time limit reached. Restarting Counter...")
		end)
		
			if count == sensorThreshold
			then 
				print("(" .. count .. ") sensor inputs counted! Sending Alert!")
				dofile("ifttt.lua")
			else print("(" .. count .. ") sensor inputs counted...")
			end		
    end
end

gpio.trig(buttonPin,"down", debounce(onChange))

