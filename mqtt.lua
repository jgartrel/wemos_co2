global_mqtt_c = nil

function mqtt_enable()
  if global_mqtt_c ~= nil then
    mqtt_disable()
  end

  -- init mqtt client without logins, keepalive timer 120s
  local m = mqtt.Client(config.mqtt.client_id, tonumber(config.mqtt.keepalive))

  m:on("connect", function(client) print ("connected") end)
  m:on("offline", function(client) print ("offline") end)

  -- on publish message receive event
  m:on("message", function(client, topic, data)
    if data ~= nil then
      local i,j = string.find(data, "TO: " .. config.mqtt.client_id .. " ", 1, true)
      if i == 1 then
        -- The message is destined for this client
        print(string.sub(data, j+1))
      end
    end
  end)

  -- on publish overflow receive event
  m:on("overflow", function(client, topic, data)
    print(topic .. " partial overflowed message: " .. data )
  end)

  -- for TLS: m:connect("192.168.11.118", secure-port, 1)
  m:connect(config.mqtt.server, config.mqtt.port, false, function(client)
    print("connected")
    global_mqtt_c = client
    -- Calling subscribe/publish only makes sense once the connection
    -- was successfully established. You can do that either here in the
    -- 'connect' callback or you need to otherwise make sure the
    -- connection was established (e.g. tracking connection status or in
    -- m:on("connect", function)).

    -- subscribe topic with qos = 0
    client:subscribe(config.mqtt.control_topic, 0,
      function(client) print("subscribe success") end)
    -- publish a message with data = hello, QoS = 0, retain = 0
    client:publish(config.mqtt.control_topic,
      "FROM: " .. config.mqtt.client_id .. " online", 0, 0)
  end,
  function(client, reason)
    print("failed reason: " .. reason)
  end)
end

function mqtt_disable()
  if global_mqtt_c ~= nil then
    global_mqtt_c:close()
    global_mqtt_c = nil
  end
end
