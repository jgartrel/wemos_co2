wifi.setmode(wifi.STATION)
wifi.sta.config(config.station_cfg)
wifi.sta.connect()
print(wifi.sta.getip())
