-- Show RGB LED by PWM
return function(r, g, b, mcuPin) 	
    pwm.setduty(mcuPin.r, r) 
    pwm.setduty(mcuPin.g, g) 
    pwm.setduty(mcuPin.b, b)     
end