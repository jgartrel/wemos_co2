print("Begin: init.lua, use abort=true to bypass startup")

function monitor()
  if abort == true then
    print('monitor aborted')
    return
  end
  if wifi.sta.getip() ~= nil then
    print(wifi.sta.getip())
    if config.wifi.eventmon == true then
      wifi.eventmon.unregister(wifi.eventmon.STA_CONNECTED)
      wifi.eventmon.unregister(wifi.eventmon.STA_DISCONNECTED)
      wifi.eventmon.unregister(wifi.eventmon.STA_AUTHMODE_CHANGE)
      wifi.eventmon.unregister(wifi.eventmon.STA_GOT_IP)
      wifi.eventmon.unregister(wifi.eventmon.STA_DHCP_TIMEOUT)
    end
    dofile("mqtt.lua")
    dofile("readsensor.lua")
    return
  else
    print('monitor aborted')
    return
  end
end

function startup()
  if abort == true then
    print('startup aborted')
    return
  end
  print('in startup')
  dofile("config.lua")
  dofile("wifi.lua")
  tmr.create():alarm(10000, tmr.ALARM_SINGLE,monitor)
end

abort = false
tmr.create():alarm(5000, tmr.ALARM_SINGLE,startup)
