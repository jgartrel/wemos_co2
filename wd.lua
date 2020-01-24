global_wd_data = false
global_wd_count = 0

function wd_check()
  if global_wd_data == true then
    global_wd_data = false
  else
    readsensor_disable()
    if global_mqtt_c ~= nil then
      global_mqtt_c:publish(config.mqtt.control_topic,
        "FROM: " .. config.mqtt.client_id .. " wd_reset_uart", 0, 0)
    else
      if wifi.sta.getip() ~= nil then
        mqtt_enable()
      else
        global_wd_count = global_wd_count + 1
        if global_wd_count > config.wd.max_count then
          node.restart()
        end
      end
    end
    readsensor_enable()
  end
end

function wd_enable()
  global_wd_timer = tmr.create():alarm(
    tonumber(config.wd.timeout) * 1000,
    tmr.ALARM_AUTO,
    wd_check)
end

function wd_disable()
  if global_wd_timer ~= nil then
    global_wd_timer:unregister()
  end
end
