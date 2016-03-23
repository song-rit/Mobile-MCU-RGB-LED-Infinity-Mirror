-- Begin WiFi configuration
local wifiConfig = {}

-- wifi.STATION         -- station: join a WiFi network
-- wifi.SOFTAP          -- access point: create a WiFi network
-- wifi.wifi.STATIONAP  -- both station and access point
wifiConfig.mode = wifi.SOFTAP  -- both station and access point

wifiConfig.accessPointConfig = {}
wifiConfig.accessPointConfig.ssid = "tns"   -- Name of the SSID you want to create
wifiConfig.accessPointConfig.pwd = "11111111"   -- WiFi password - at least 8 characters
wifiConfig.accessPointConfig.max = 1

wifiConfig.accessPointIpConfig = {}
wifiConfig.accessPointIpConfig.ip = "192.168.4.1"
wifiConfig.accessPointIpConfig.netmask = "255.255.255.0"
wifiConfig.accessPointIpConfig.gateway = "1.1.1.1"

-- Tell the chip to connect to the access point
wifi.setmode(wifiConfig.mode)
print('set (mode='..wifi.getmode()..')')

if (wifiConfig.mode == wifi.SOFTAP) or (wifiConfig.mode == wifi.STATIONAP) then
    print('AP MAC: ',wifi.ap.getmac())
    wifi.ap.setmac("44-D8-84-43-AA-F6") -- Set MAC Address
    wifi.ap.config(wifiConfig.accessPointConfig)
    wifi.ap.setip(wifiConfig.accessPointIpConfig)

end
if (wifiConfig.mode == wifi.STATION) or (wifiConfig.mode == wifi.STATIONAP) then
    print('Client MAC: ',wifi.sta.getmac())   
end

print('chip: ',node.chipid())
print('heap: ',node.heap())

wifiConfig = nil
collectgarbage()

-- End WiFi configuration

-- Compile server code and remove original .lua files.
-- This only happens the first time afer the .lua files are uploaded.

local compileAndRemoveIfNeeded = function(f)
   if file.open(f) then
      file.close()
      print('Compiling:', f)
      node.compile(f)
      file.remove(f)
      collectgarbage()
   end
end

local serverFiles = {'httpserver-sendfile.lua', 'rgb.lua', 'wave-motion.lua', 'flash.lua', 'dim.lua', 'smooth.lua' , 'hextodec.lua', 'httpserver.lua', 'httpserver-header.lua', 'httpserver-error.lua'}
for i, f in ipairs(serverFiles) do compileAndRemoveIfNeeded(f) end

compileAndRemoveIfNeeded = nil
serverFiles = nil
collectgarbage()

-- Set up nodeMCU pin
local mcuPin = {}
mcuPin.r = 6 -- set up pin RGB : red
mcuPin.g = 7 -- set up pin RGB : green
mcuPin.b = 8 -- set up pin RGB : blue
mcuPin.analog = 0 -- set up pin analog for read wave sensor
mcuPin.motion = 1 -- set up pin digital for read motion sensor

pwm.setup(mcuPin.b, 500, 250)
pwm.setup(mcuPin.g, 500, 250)
pwm.setup(mcuPin.r, 500, 250)
pwm.start(mcuPin.r)
pwm.start(mcuPin.g)
pwm.start(mcuPin.b)

-- Connect to the WiFi access point.
-- Once the device is connected, you may start the HTTP server.

-- Uncomment to automatically start the server in port 80
if (not not wifi.sta.getip()) or (not not wifi.ap.getip()) then
    dofile("httpserver.lc")(80, mcuPin)    
end

function led(red,green,blue) 
      dofile("rgb.lc")(red, green, blue, mcuPin)
end

-- Play RGB LED When start NodeMCU

led(1023, 0, 0)
tmr.delay(500000)
led(0, 1023, 0)
tmr.delay(500000)
led(0, 0, 1023)
tmr.delay(500000)

led(0, 1023, 0)
tmr.delay(300000)
led(0, 1023, 0)
tmr.delay(300000)
led(1023, 0, 0)
tmr.delay(300000)
led(1023, 0, 0)
tmr.delay(100000)
led(0, 1023, 0)
tmr.delay(100000)
led(0, 0, 1023)
tmr.delay(100000)

led(1023, 0, 0)
tmr.delay(100000)
led(0, 1023, 0)
tmr.delay(100000)
led(0, 0, 1023)
tmr.delay(100000)

led(1023, 0, 0)
tmr.delay(100000)
led(0, 1023, 0)
tmr.delay(100000)
led(0, 0, 1023)
tmr.delay(100000)

led(1023, 0, 0)
tmr.delay(100000)
led(0, 1023, 0)
tmr.delay(100000)
led(0, 0, 1023)
tmr.delay(100000)


led(1023, 0, 0)
tmr.delay(100000)
led(0, 1023, 0)
tmr.delay(100000)
led(0, 0, 1023)
tmr.delay(100000)

led(1023, 0, 0)
tmr.delay(100000)
led(0, 1023, 0)
tmr.delay(100000)
led(0, 0, 1023)
tmr.delay(100000)

led(0, 0, 0)

-- After Play flash LED will Jump to WAVE mode
dofile("wave-motion.lc")(mcuPin)