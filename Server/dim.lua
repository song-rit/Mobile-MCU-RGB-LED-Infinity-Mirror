-- Dimmer LED 
return function (mcuPin)
    collectgarbage()
    function led(red,green,blue) 
        dofile("rgb.lc")(red, green, blue, mcuPin)
    end

    i = 0
    dim = 0
    succes = 0
    led(0, 0, 0)
	
    tmr.alarm(0, 80, 1, function() 

        if(dim == 0)then
            pwm.setduty(mcuPin.r, i)
            pwm.setduty(mcuPin.g, i )
            pwm.setduty(mcuPin.b, i)
        elseif(dim == 1) then
            pwm.setduty(mcuPin.r, i)
            pwm.setduty(mcuPin.g, 0 )
            pwm.setduty(mcuPin.b, 0)
        elseif(dim == 2) then
            pwm.setduty(mcuPin.r, 0)
            pwm.setduty(mcuPin.g, i )
            pwm.setduty(mcuPin.b, 0)
         elseif(dim == 3) then
            pwm.setduty(mcuPin.r, 0)
            pwm.setduty(mcuPin.g, 0 )
            pwm.setduty(mcuPin.b, i)
        end

        if(succes == 0) then
            i = i + 25

            if( i >= 600) then
                succes = 1
            end
        else
            i = i - 25;

            if( i <= 25) then
                succes = 0
                i = 0
                led(0, 0, 0)
                dim = dim + 1
                if( dim > 3)then
                    dim = 0
                end
            end
        end      
	end)
end



