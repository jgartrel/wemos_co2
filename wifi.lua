wifi.setmode(wifi.STATION)
wifi.sta.config(config.station_cfg)
wifi.sta.connect()
tmr.delay(1000000)

function wait_ip()
    print("Waiting for IP")

    local max=15
    while(wifi.sta.getip() == nil)
    do
        max=max-1
        tmr.delay(1000000)
        print(string.format('WiFi attempt %d', max))
        if max==0 then
        return
        end
    end

    print("Waited for IP")
    print(wifi.sta.getip())
end

wait_ip()
