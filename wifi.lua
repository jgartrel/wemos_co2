wifi.setmode(wifi.STATION)
station_cfg = {}
station_cfg.ssid="ssid"
station_cfg.pwd="password"
station_cfg.save=true
wifi.sta.config(station_cfg)
wifi.sta.connect()
print(wifi.sta.getip())
