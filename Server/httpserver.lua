return function (port, mcuPin)
  local connectionThread       
  srv=net.createServer(net.TCP, 5) 
  srv:listen(80,function(connection) 

    local function onReceive(connection, payload)
            collectgarbage()   

            local path = string.sub(payload, string.find(payload, "GET /") + 5, string.find(payload, "HTTP/") - 2)           
            local gzip = false            
            
            if path == "index" or  path == "" then path = "index.html" end
            print(path)           

--------------------------FUNCTION LED MODE -------------------------------------

            if string.find(payload, "color/") then              
              dofile("hextodec.lc")(string.sub(path, string.find(path, "color/") + 6), mcuPin)                
            end

            if path == "off" then
              dofile("rgb.lc")(0, 0, 0, mcuPin)                     
            end            

            if path == "dimmer" then
              print("dimmer Active")
              dofile("dim.lc")(mcuPin) 
            else
              tmr.stop(0)         
            end

            if path == "flash" then
              print("flash Active")
              dofile("flash.lc")(mcuPin)  
            else
              tmr.stop(1)         
            end

            if path == "smooth" then
              print("smooth Active")
              dofile("smooth.lc")(mcuPin) 
            else
              tmr.stop(2)         
            end

            if path == "wave" or path == "on" then
              print("wave Active")
              dofile("wave-motion.lc")(mcuPin) 
            else
              tmr.stop(3)         
            end

-------------------------------------------------------------------------------

            if #(path ) > 32 then
                -- nodemcu-firmware cannot handle long filenames.
                fileServeFunction = dofile("httpserver-error.lc")              
            else
                local fileExists = file.open(path, "r")
                file.close()

            if not fileExists then
                -- gzip check
                fileExists = file.open(path .. ".gz", "r")
                file.close()

             if fileExists then
                print("gzip variant exists, serving that one")
                path = path .. ".gz"
                gzip = true
             end
            end

            if not fileExists then                  
              fileServeFunction = dofile("httpserver-error.lc")
            else                 
              args = {file = path, ext = gzip}                 
                fileServeFunction = dofile("httpserver-sendfile.lc")                               
            end
    end           

              connectionThread = coroutine.create(fileServeFunction)
              coroutine.resume(connectionThread, connection, args)            
    end 

    local function onSent(connection, payload)
            collectgarbage()
            if connectionThread then
               local connectionThreadStatus = coroutine.status(connectionThread)
               if connectionThreadStatus == "suspended" then
                  -- Not finished sending file, resume.
                  coroutine.resume(connectionThread)
               elseif connectionThreadStatus == "dead" then
                  -- We're done sending file.
                  connection:close()
                  connectionThread = nil
               end
            end
    end

         connection:on("receive", onReceive)
         connection:on("sent", onSent)        
  end)
   local ip = wifi.sta.getip()
   if not ip then ip = wifi.ap.getip() end
   print("nodemcu-httpserver running at http://" .. ip .. ":" ..  port)
   return srv
end
