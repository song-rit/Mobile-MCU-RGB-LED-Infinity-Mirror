-- Flash LED 
return function (mcuPin)
	collectgarbage()
	function led(red,green,blue) 
	    dofile("rgb.lc")(red, green, blue, mcuPin)
	end

	led(0, 0, 0)
	flash = 0

	tmr.alarm(1,250,1,function()
		if flash==0 then 
		    flash=1 
		    led(512,0,0) 
		elseif(flash == 1) then
		    flash=2 
		    led(0,512,0) 
		elseif(flash == 2) then
		    flash=3 
		    led(0,0,512) 
		elseif(flash == 3) then
		    flash=4 
		    led(512,512,0) 
		elseif(flash == 4) then
		    flash=5 
		    led(0,512,512) 
		elseif(flash == 5) then
		    flash=6 
		    led(512,0,512) 
		elseif(flash == 6) then
		    flash=0 
		    led(512,512,512) 
		end 	
	end)
end