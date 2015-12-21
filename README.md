# ESP8266 NodeMCU IoT Generic Switch 1.0.0
A front-end NodeMCU HTTP server for operating a back-end controller through UART. An example of back-end controller is Arduino flashed with [Arduino GenericPin sketch](https://github.com/dev-lab/arduino-generic-pin).

## Features
* HTTP Server with optional authentication for 2 users: _admin_, _user_;
* WiFi configurable through Web interface (both connecting to existing Wi-Fi network and creating a new Wi-Fi Access Point with the option to disable AP on successfull connectin to Wi-Fi network);
* User authentication configurable through Web interface;
* In AP mode all the DNS requests are resolved to ESP8266 IP address;
* Configurable through Web interface Ports View;
* Allows to send raw UART commands through Web interface;
* Built-in IDE for editing the software through Web interface.

### Web UI Animations:

#### Overwiew:
[![Web UI overview animation](https://github.com/dev-lab/blob/blob/master/iot-power-strip/generic-switch-web-ui-overview-pic.png)](https://github.com/dev-lab/blob/blob/master/iot-power-strip/generic-switch-web-ui-overview.gif)

#### Overwiew with port configuration:
[![Web UI overview with port config animation](https://github.com/dev-lab/blob/blob/master/iot-power-strip/generic-switch-web-ui-overview-with-config-port-pic.png)](https://github.com/dev-lab/blob/blob/master/iot-power-strip/generic-switch-web-ui-overview-with-config-port.gif)

#### Wi-Fi access point configuration:
[![Web UI overview with port config animation](https://github.com/dev-lab/blob/blob/master/iot-power-strip/generic-switch-web-ui-config-wifi-ap-pic.png)](https://github.com/dev-lab/blob/blob/master/iot-power-strip/generic-switch-web-ui-config-wifi-ap.gif)

#### Wi-Fi access point configuration:
[![Web UI overview with port config animation](https://github.com/dev-lab/blob/blob/master/iot-power-strip/generic-switch-web-ui-config-admin-auth-pic.png)](https://github.com/dev-lab/blob/blob/master/iot-power-strip/generic-switch-web-ui-config-admin-auth.gif)

## Usage
1. Flash ESP8266 module with the custom NodeMCU (preferably with limited set of modules without MQTT, crypt, float, to have about 70kb of disk space available in flash). The service I used is: [NodeMCU custom builds](http://nodemcu-build.com/). I have selected the following modules for integer version of NodeMCU:
  * node
  * file
  * GPIO
  * WiFi
  * net
  * timer
  * UART
  
  [![Flashing ESP8266 with custom NodeMCU](https://github.com/dev-lab/blob/blob/master/iot-power-strip/flash-nodemcu-pic.png)](https://github.com/dev-lab/blob/blob/master/iot-power-strip/flash-nodemcu.gif) 
2. Install the tool for uploading NodeMCU files from https://github.com/dev-lab/esp-nodemcu-lua-uploader. Of course you can use other tools for uploading files to NodeMCU, but not that there are many files, so they have to be able to operate in batch mode.
3. Upload the software with [install.bat](install.bat):
  [![Uploading IoT Generic Switch software into ESP8266]((https://github.com/dev-lab/blob/blob/master/iot-power-strip/upload-soft-pic.png))](https://github.com/dev-lab/blob/blob/master/iot-power-strip/upload-soft.gif)
4. Restart the ESP8266 module (turn it off and on). After restarting you will see a new Wi-Fi access point with the name: `esp-devlab-setup`. You will be able to connect there with the default password: `We1c0me!`. The default Wi-Fi AP name and password are specified in file: [`connect.lua`](src/connect.lua). 
5. On successfull connection to the `esp-devlab-setup` Access Point you can reach web UI through the browser by typing anything looking like domain name, e.g.: `any.site.com`. You can do that because the software starts a DNS liar server (it responds with ESP8266 IP to any DNS request) in AP mode. The DNS server evolved based on the work published on the following resources:
  * [Re: Tiny DNS server written in Ncat-Lua - anyone interested?](http://seclists.org/nmap-dev/2013/q3/196)
  * https://svn.nmap.org/!svn/bc/31535/nmap-exp/d33tah/lua-exec-examples/ncat/scripts/dns.lua
  * [ESP8266 WiFi Throwies](http://hackaday.com/2015/05/03/esp8266-wifi-throwies/)
  * [Wifi throwie : improved version - faster, smaller, cheaper](http://iotests.blogspot.fr/2015/10/wifi-throwie-improved-version-faster.html)
6. Web UI shall be quite self-explaining, but note that the best way to brick the software is to use IDE without checking twice what you are uploading to the file system. The changes are taken into account immediately. Bricked NodeMCU can be cured only with connecting ESP module to computer and formatting NodeMCU file system and rewriting the software. In some cases you even have to re-flash the NodeMCU (e.g. if you did the mistake and removed the delay in [`init.lua`](src/init.lua).

## The Use Case:
[IoT Power Strip](http://www.thingiverse.com/thing:1211810)

## [License](LICENSE)
Copyright (c) 2015 Taras Greben
Licensed under the [Apache License](LICENSE).
