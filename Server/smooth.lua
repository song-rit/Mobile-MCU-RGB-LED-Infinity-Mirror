-- SMOOTH RGB LED 
return function (mcuPin)
    collectgarbage()
    function led(red,green,blue) 
        dofile("rgb.lc")(red, green, blue, mcuPin)
    end

    i = 0
    smooth = 0
    led(0, 0, 0)
    tmr.alarm(2, 80, 1, function() 

         if(smooth == 0)then
            pwm.setduty(mcuPin.r, i)
            pwm.setduty(mcuPin.g, i )
            pwm.setduty(mcuPin.b, i)
        elseif(smooth == 1) then
            pwm.setduty(mcuPin.r, i)
            pwm.setduty(mcuPin.g, 0 )
            pwm.setduty(mcuPin.b, 0)
        elseif(smooth == 2) then
            pwm.setduty(mcuPin.r, 0)
            pwm.setduty(mcuPin.g, i )
            pwm.setduty(mcuPin.b, 0)
         elseif(smooth == 3) then
            pwm.setduty(mcuPin.r, 0)
            pwm.setduty(mcuPin.g, 0 )
            pwm.setduty(mcuPin.b, i)
        end

        if(i <= 600) then
            i = i + 25            
        else
                i = 0
                led(0, 0, 0)
                smooth = smooth + 1
                if( smooth > 3)then
                    smooth = 0
                end
        end      
    end)
end




