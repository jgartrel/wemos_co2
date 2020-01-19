function wifi_eventmon_enable()
  wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, function(T)
    print("\n\tSTA - CONNECTED" .. "\n\tSSID: " .. T.SSID .. "\n\tBSSID: " ..
    T.BSSID .. "\n\tChannel: " .. T.channel)
  end)

  wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, function(T)
    print("\n\tSTA - DISCONNECTED" .. "\n\tSSID: " .. T.SSID .. "\n\tBSSID: " ..
    T.BSSID .. "\n\treason: " .. T.reason)
  end)

  wifi.eventmon.register(wifi.eventmon.STA_AUTHMODE_CHANGE, function(T)
    print("\n\tSTA - AUTHMODE CHANGE" .. "\n\told_auth_mode: " ..
    T.old_auth_mode .. "\n\tnew_auth_mode: " .. T.new_auth_mode)
  end)

  wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function(T)
    print("\n\tSTA - GOT IP" .. "\n\tStation IP: " .. T.IP ..
    "\n\tSubnet mask: " ..  T.netmask .. "\n\tGateway IP: " .. T.gateway)
  end)

  wifi.eventmon.register(wifi.eventmon.STA_DHCP_TIMEOUT, function()
    print("\n\tSTA - DHCP TIMEOUT")
  end)
end

function wifi_eventmon_disable()
  wifi.eventmon.unregister(wifi.eventmon.STA_CONNECTED)
  wifi.eventmon.unregister(wifi.eventmon.STA_DISCONNECTED)
  wifi.eventmon.unregister(wifi.eventmon.STA_AUTHMODE_CHANGE)
  wifi.eventmon.unregister(wifi.eventmon.STA_GOT_IP)
  wifi.eventmon.unregister(wifi.eventmon.STA_DHCP_TIMEOUT)
end

function wifi_enable()
  wifi.setmode(wifi.STATION)
  wifi.sta.config(config.wifi.station_cfg)

  if config.wifi.eventmon == true then
    wifi_eventmon_enable()
  end

  wifi.sta.connect()
  wifi.sta.autoconnect(1)
end

function wifi_disable()
  wifi.sta.autoconnect(0)
  wifi.sta.disconnect()
  wifi_eventmon_disable()
  wifi.setmode(wifi.NULLMODE)
end
