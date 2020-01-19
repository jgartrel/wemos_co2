print("Begin: init.lua, use abort=true to bypass startup")

function monitor()
  if abort == true then
    print('monitor aborted')
    wd_disable()
    return
  end
  if wifi.sta.getip() ~= nil then
    print(wifi.sta.getip())
    if config.wifi.eventmon == true then
      wifi_eventmon_disable()
    end
    mqtt_enable()
    readsensor_enable()
    return
  else
    print('monitor failed')
    return
  end
end

function startup()
  if abort == true then
    print('startup aborted')
    return
  end
  print('in startup')
  -- Load required modules
  dofile("config.lua")
  dofile("wifi.lua")
  dofile("wd.lua")
  dofile("mqtt.lua")
  dofile("readsensor.lua")
  wifi_enable()
  wd_enable()
  -- Set a timer to wait for wifi to connect
  tmr.create():alarm(10000, tmr.ALARM_SINGLE,monitor)
end

abort = false
tmr.create():alarm(5000, tmr.ALARM_SINGLE,startup)
