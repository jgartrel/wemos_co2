global_wd_data = false

function wd_check()
  if global_wd_data == true then
    global_wd_data = false
  else
    readsensor_disable()
    if global_mqtt_c ~= nil then
      global_mqtt_c:publish(config.mqtt.control_topic,
        config.mqtt.client_id .. ": wd_reset_uart", 0, 0)
    else
      mqtt_enable()
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
