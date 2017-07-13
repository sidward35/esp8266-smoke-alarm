# esp8266-smoke-alarm
If a smoke alarm goes off, the microphone will detect it, sending a signal to the ESP8266, which will send a signal to the Maker Channel on IFTTT to send an SMS that the smoke alarm went off.

## Installation

**0** Plug jumper wires into the “GND”, “3V3”, and “D2” pins on the right side of the ESP8266 NodeMCU V3 board, making sure that on the microphone, “GND” connects to “GND”, “+” connects to “3V3”, and “D0” connects to “D2.”

**1** Use the [32-bit ESP8266 Flasher](https://github.com/nodemcu/nodemcu-flasher/tree/master/Win32/Release) or the [64-bit ESP8266 Flasher](https://github.com/nodemcu/nodemcu-flasher/tree/master/Win64/Release) (depending on your hardware) to flash the [NodeMCU Firmware for ESP8266 Development Board](https://github.com/nodemcu/nodemcu-firmware).

**2** Download all the .lua files in this repo, and change the key in [iftttKey.lua](https://github.com/sidward35/esp8266-smoke-alarm/blob/master/iftttKey.lua) to your own IFTTT Maker Channel key.

**3** Use the [LuaLoader](https://github.com/GeoNomad/LuaLoader) to load all the .lua files in this repo, as well as set the network connection to your local router.
