global_wd_data = false

function wd_check()
  if global_wd_data == true then
    global_wd_data = false
  else
    readsensor_disable()
    if global_c ~= nil then
      global_c:publish("/topic", "wd_reset_uart", 0, 0)
    else
      dofile("mqtt.lua")
    end
    dofile("readsensor.lua")
  end
end

function wd_enable()
  global_wd_timer = tmr.create():alarm(60000, tmr.ALARM_AUTO,wd_check)
end

function wd_disable()
  if global_wd_timer ~= nil then
    global_wd_timer:unregister()
  end
end
