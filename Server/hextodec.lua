return function (color, mcuPin)  
    collectgarbage()
    --print(color)
    
    local hextable = "0123456789ABCDEF"
    -- Function Change Hex Number to Dec Number
    function hextodex(rgb)         
	    bit1 = string.find(hextable, string.sub(rgb,1, 1)) - 1
	    bit0 = string.find(hextable, string.sub(rgb,2, 2)) - 1   
	   return ((bit1 * 16 )+ bit0)  
	   end
       
      r = string.sub(color,1, 2)
      g = string.sub(color,3, 4)
      b = string.sub(color,5, 6)	

      r = hextodex(r) * 3
      g = hextodex(g) * 3
      b = hextodex(b) * 3

      print(r..",".. g..",".. b)     
      dofile("rgb.lc")(r, g, b, mcuPin)
end
