print("Begin: init.lua, use abort=true to bypass startup")

function startup()
  if abort == true then
    print('startup aborted')
    return
  end
  print('in startup')
  dofile("config.lua")
  dofile("wifi.lua")
  dofile("mqtt.lua")
  dofile("readsensor.lua")
end

abort = false
tmr.create():alarm(5000, tmr.ALARM_SINGLE,startup)
