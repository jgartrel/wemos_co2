# CO2 sensor project

This project uses a WeMos D1 Mini connected to a Cozir C02 Sensor.

### Getting started
1.  Start the Vagrant Dev Box:
    ```
    vagrant up
    vagrant ssh
    ```
2.  Connect your WeMos D1 Mini to the USB port

### Building
1.  From within the Vagrant Dev Box `vagrant ssh`:
    ```
    cd /vagrant
    make && sudo make upload && sudo make monitor
    ```

NOTE: use: `ctrl-a \` to quit from screen


### Useful Info

The following links were useful in putting this example project together:
*  [Arduino CLI Hacking](http://www.raspberryvi.org/stories/arduino-cli.html)
*  [Screen Quick Reference](http://aperiodic.net/screen/quick_reference)
*  [Arduino and Linux TTY](https://playground.arduino.cc/Interfacing/LinuxTTY)
*  [USB on a Vagrant Box](https://sonnguyen.ws/connect-usb-from-virtual-machine-using-vagrant-and-virtualbox/)

This project was tested with:
*  Ubuntu 18.04.1 LTS (GNU/Linux 4.15.0-29-generic x86_64)
*  Ubuntu Package: arduino-core, Version: 2:1.0.5+dfsg2-4.1
*  Ubuntu Package: arduino-mk, Version: 1.5.2-1
*  ESP8266 HW: WeMos D1 Mini
*  Vagrant, Version: 2.2.5
*  Virtual Box, Version: 6.0.12
*  Virtual Box Extention Pack, Version: 6.0.12
*  VM Box: geerlingguy/ubuntu1804 Version: 1.0.7
