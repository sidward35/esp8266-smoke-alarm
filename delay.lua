--delay.lua
file.open( "alertDelay.lua", "r" )
alertDelay = file.read()
--alertDelay = string.gsub(alertDelay, "%s+", "")
alertDelay=5
alertDelay = tonumber(alertDelay)*60*1000
file.close()
print("alertDelay: "..(alertDelay/(60*1000)).." minutes.")

print("Waiting "..(alertDelay/(60*1000)).." minutes before sending another message.")

tmr.delay(alertDelay)

function restart ()
node.restart()
end

tmr.alarm(0,alertDelay,0,restart)