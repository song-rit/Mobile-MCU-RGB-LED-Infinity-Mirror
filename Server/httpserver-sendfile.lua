-- Function Send Data 
return function (connection, args)
   dofile("httpserver-header.lc")(connection, 200, args.ext)

   local continue = true
   local bytesSent = 0
   while continue do
      collectgarbage()
      
      file.open(args.file)
      file.seek("set", bytesSent)
      local chunk = file.read(512)          
      file.close()
      if chunk == nil then
         continue = false
        print(coroutine.running().."END")
      else
         print(coroutine.running())
         coroutine.yield()
         connection:send(chunk)
         bytesSent = bytesSent + #chunk
         chunk = nil

      end
   end
end
