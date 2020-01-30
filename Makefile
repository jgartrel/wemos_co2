#
# Setup all targets to repeatedly run as tasks
#
.PHONEY: all upload help
all: help

#
# Global Variables
#
# NOTE: Avoid using underscores in Global Variables
#
NODE_PORT ?= /dev/ttyUSB0
NODE_BAUD ?= 115200
LUA_FILES=$(wildcard *.lua)

reset:  ## Hard reset the nodemcu
	nodemcu-tool reset --port=$(NODE_PORT) -b $(NODE_BAUD)
	screen $(NODE_PORT) $(NODE_BAUD)

monitor:  ## Connect to nodemcu console
	screen $(NODE_PORT) $(NODE_BAUD)

upload:  ## Upload all files to nodemcu device
	 nodemcu-tool upload --port=$(NODE_PORT) -b $(NODE_BAUD) $(LUA_FILES)

flash:  ## Reflash nodemcu
	 ./esptool/esptool.py --chip esp8266 --port $(NODE_PORT) write_flash -fm dio -ff 20m -fs detect 0x0000 nodemcu-master-12-modules-2020-01-07-01-50-53-float.bin

erase:  ## Erase nodemcu flash
	 ./esptool/esptool.py --chip esp8266 --port $(NODE_PORT) erase_flash

help:  ## Display make target help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
