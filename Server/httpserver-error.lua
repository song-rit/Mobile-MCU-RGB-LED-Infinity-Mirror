return function (connection, args)
	  collectgarbage()
      connection:send("connection: close\r\n\r\n") 
end
