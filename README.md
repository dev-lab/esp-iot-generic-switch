# ESP8266 NodeMCU IoT Generic Switch 1.0.0
A front-end NodeMCU HTTP server for operating a back-end controller through UART. An example of back-end controller is an Arduino board flashed with [**Arduino GenericPin sketch**](https://github.com/dev-lab/arduino-generic-pin).

The software allows both to set-up and to control ESP8266 device through Web Interface.

## Features
* Operate ports of a secondary controller (connected via UART to ESP8266) through Web Interface;
* HTTP Server with optional authentication for 2 users: `admin` and `user` (configurable through Web interface);
* Wi-Fi configurable through Web interface (both connecting to existing Wi-Fi network and creating a new Wi-Fi Access Point (AP) with the option of disabling AP on successfull connectin to Wi-Fi network);
* In AP mode all the DNS queries are resolved to ESP8266 IP address;
* Configurable through the Web interface **Ports View**;
* Allows to send raw UART commands through Web interface;
* Built-in IDE for editing the software through Web interface.

### Web UI Animations:

#### UI overview:
[![Web UI overview (animation)](https://github.com/dev-lab/blob/blob/master/iot-power-strip/generic-switch-web-ui-overview-pic.png)](https://github.com/dev-lab/blob/blob/master/iot-power-strip/generic-switch-web-ui-overview.gif)

#### UI overview with port configuration:
[![Web UI overview with port config (animation)](https://github.com/dev-lab/blob/blob/master/iot-power-strip/generic-switch-web-ui-overview-with-config-port-pic.png)](https://github.com/dev-lab/blob/blob/master/iot-power-strip/generic-switch-web-ui-overview-with-config-port.gif)

#### Setup Wi-Fi access point:
[![Setup Wi-Fi access point (animation)](https://github.com/dev-lab/blob/blob/master/iot-power-strip/generic-switch-web-ui-config-wifi-ap-pic.png)](https://github.com/dev-lab/blob/blob/master/iot-power-strip/generic-switch-web-ui-config-wifi-ap.gif)

#### Setup `admin` authentication:
[![Setup admin authentication (animation)](https://github.com/dev-lab/blob/blob/master/iot-power-strip/generic-switch-web-ui-config-admin-auth-pic.png)](https://github.com/dev-lab/blob/blob/master/iot-power-strip/generic-switch-web-ui-config-admin-auth.gif)

## Usage
1. Flash the ESP8266 module using [NodeMCU Flasher](https://github.com/nodemcu/nodemcu-flasher) with customized NodeMCU firmware (preferably integer **dev** version with the limited set of modules, i.e. without `MQTT`, `crypt`, etc., to have about 70kb of disk space available in ESP EEPROM). The service that greatly simplifies the creation of custom firmware is: [NodeMCU custom builds](http://nodemcu-build.com/). I have selected the following modules for **dev** version of NodeMCU:
  * `node`;
  * `file`;
  * `GPIO`;
  * `WiFi`;
  * `net`;
  * `PWM`;
  * `timer`;
  * `UART`;
  * `cJSON`.

[![Flashing ESP8266 with custom NodeMCU](https://github.com/dev-lab/blob/blob/master/iot-power-strip/flash-nodemcu-pic.png)](https://github.com/dev-lab/blob/blob/master/iot-power-strip/flash-nodemcu.gif) 
  
2. Install the tool for uploading NodeMCU files from https://github.com/dev-lab/esp-nodemcu-lua-uploader. Of course you can use other tools for uploading files to NodeMCU, but note that the project consists of many files, so the tool have to be able to operate in batch mode.
3. Upload the software with [install.bat](install.bat):

  [![Uploading IoT Generic Switch software into ESP8266](https://github.com/dev-lab/blob/blob/master/iot-power-strip/upload-soft-pic.png)](https://github.com/dev-lab/blob/blob/master/iot-power-strip/upload-soft.gif)
  
4. Restart the ESP8266 module (turn it off and turn back on). After restarting you will see a new Wi-Fi access point with the name: `esp-devlab-setup`. You will be able to connect to the module with the default password: `We1c0me!`. The default Wi-Fi AP name and password are specified in file: [`connect.lua`](src/connect.lua). 
5. On successfull connection to the `esp-devlab-setup` Access Point you will be able to reach the Web UI through the browser by typing anything looking like domain name as an URL, e.g.: `any.site.my`. You can do that because the software starts a DNS liar server (it responds with the ESP8266 IP to any DNS request) in AP mode. The DNS server evolved based on the work published on the following resources:
  * [Re: Tiny DNS server written in Ncat-Lua - anyone interested?](http://seclists.org/nmap-dev/2013/q3/196)
  * https://svn.nmap.org/!svn/bc/31535/nmap-exp/d33tah/lua-exec-examples/ncat/scripts/dns.lua
  * [ESP8266 WiFi Throwies](http://hackaday.com/2015/05/03/esp8266-wifi-throwies/)
  * [Wifi throwie : improved version - faster, smaller, cheaper](http://iotests.blogspot.fr/2015/10/wifi-throwie-improved-version-faster.html)
6. Web UI shall be quite self-explaining to use. You only have to remember that the best way to brick the software is to use Web IDE without checking twice what you are uploading to the file system. The changes are taken into account immediately. A bricked NodeMCU can be cured only with connecting of ESP module to computer through UART, formatting of NodeMCU file system, and rewriting the Lua software. In some cases you even have to re-flash the NodeMCU (e.g. if you did the mistake and removed the delay in [`init.lua`](src/init.lua).

## The Use Case:
[IoT Power Strip](http://www.thingiverse.com/thing:1211810)

## [License](LICENSE)
Copyright (c) 2015 Taras Greben 

Licensed under the [Apache License](LICENSE).
