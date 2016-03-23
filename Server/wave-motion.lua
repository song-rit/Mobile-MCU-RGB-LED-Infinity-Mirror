-- Wave and Motion
return function(mcuPin)
  collectgarbage()
  function led(red,green,blue) 
      dofile("rgb.lc")(red, green, blue, mcuPin)
  end

 countMotion = 0

 tmr.alarm(3, 65, 1, function() 

    motion = gpio.read(mcuPin.motion)
    -- if motion active wave dont active
    if(motion == 1) then
      countMotion = countMotion + 1
      mode = math.random(3)    
      
      if(mode == 1 and countMotion >= 25) then
        led(1023, 0, 0)
        countMotion = 0
        print("red")   
      elseif(mode == 2 and countMotion >= 25) then
        led(0, 1023, 0)
        countMotion = 0
        print("green") 
      elseif(mode == 3 and countMotion >= 25) then
        led(0, 0, 1023)
        countMotion = 0
        print("blue") 
      end

    else
      countMotion = 0      
      analog = adc.read(mcuPin.analog)
      if(analog > 525)then
        led(1023,0 , 0)
      elseif(analog > 515) then
        led(0, 0, 1023)
      elseif(analog > 505) then
       led(0,1023 , 0)
      elseif(analog <  300) then
        led(1023, 1023, 1023)
      else
       led(0, 0, 0)
      end  
    end
 end)    
end