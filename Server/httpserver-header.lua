return function (connection, code, gzip)

   local function getHTTPStatusString(code)
      local codez = {[200]="OK", [400]="Bad Request", [404]="Not Found",}
      local myResult = codez[code]
      -- enforce returning valid http codes all the way throughout?
      if myResult then return myResult else return "Not Implemented" end
   end

   connection:send("HTTP/1.0 " .. code .. " " .. getHTTPStatusString(code) .. "\r\nServer: nodemcu-httpserver\r\n")
   if gzip == true then
       connection:send("Content-Encoding: gzip\r\n")
   end
   connection:send("Connection: close\r\n\r\n")
end

