uart.setup(0,9600,8,0,1,0)

topic = "sensors"
measurement = "environ"
location = "PSB-2fl"
hostname = wifi.sta.gethostname()
tag_set = string.format("location=%s,sensor=%s", location, hostname)
parse_field = {
  ["H"] = function (v) return "humidity", tonumber(v) / 100 end,
  ["T"] = function (v) return "temperature", tonumber(v) / 100 end,
  ["Z"] = function (v) return "co2", tonumber(v) end,
}
fields = {}

uart.on("data","\r", function(data)
  if global_c~=nil then
    global_c:publish(topic, data, 0, 0, function(client) print("sent") end)
    fields = {}
    string.gsub(data, "(%a)%s(%d+)", function (k,v)
      if parse_field[k] then
        table.insert(fields,string.format("%s=%s",parse_field[k](v)))
      end
    end)
    field_set = table.concat(fields,",")
    if field_set ~= "" then
      global_c:publish(topic, string.format("%s,%s %s", measurement, tag_set, field_set), 0, 0)
    end
  else
    uart.on("data")
  end
end, 0)
