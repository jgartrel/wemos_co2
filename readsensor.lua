
function readsensor_enable()
  uart.setup(0,9600,8,0,1,0)
  local topic = config.readsensor.topic
  local measurement = config.readsensor.measurement
  local location = config.readsensor.location
  local hostname = config.readsensor.hostname
  local tag_set = string.format("location=%s,sensor=%s", location, hostname)
  local parse_field = {
    ["H"] = function (v) return "humidity", tonumber(v) / 100 end,
    ["T"] = function (v) return "temperature", tonumber(v) / 100 end,
    ["Z"] = function (v) return "co2", tonumber(v) end,
  }
  uart.on("data","\r", function(data)
    if global_mqtt_c~=nil then
      local fields = {}
      string.gsub(data, "(%a)%s(%d+)", function (k,v)
        if parse_field[k] then
          table.insert(fields,string.format("%s=%s",parse_field[k](v)))
        end
      end)
      local field_set = table.concat(fields,",")
      if field_set ~= "" then
        global_wd_data = true
        global_mqtt_c:publish(topic, string.format("%s,%s %s", measurement, tag_set, field_set), 0, 0)
      end
    else
      uart.on("data")
    end
  end, 0)
end

function readsensor_disable()
  uart.on("data")
end
