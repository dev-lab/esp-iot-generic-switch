# ESP8266 NodeMCU IoT Generic Switch 1.0.0
A front end NodeMCU HTTP server for operating a back end controller through UART. An example of back end controller is Arduino flashed with [Arduino GenericPin sketch](https://github.com/dev-lab/arduino-generic-pin).

## Features
* HTTP Server with optional security (for 2 users: admin, user)
* WiFi AP/{connect to WiFi network} configurable through Web interface
* User security configurable through Web interface
* In AP mode all the DNS requests are resolved to ESP8266 ip address
* Configurable ports view and configuration through Web interface
* Allows to send raw UART commands through Web interface
* Built-in IDE for editing the software through Web interface

## Usage
1. Flash ESP8266 module with the custom NodeMCU (preferably with limited set of modules without MQTT, crypt, float to have about 70kb of disk space available in flash). The service I used is: [NodeMCU custom builds](http://nodemcu-build.com/). I have selected the following modules for integer version of NodeMCU:
  * node
  * file
  * GPIO
  * WiFi
  * net
  * timer
  * UART 
2. Install the tool for uploading NodeMCU files fast from https://github.com/dev-lab/esp-nodemcu-lua-uploader. Of course you can use other tools for uploading files to NodeMCU, but not that there are many files, so they have to be able to operate in batch mode.
3. Upload the software with [install.bat](install.bat).
4. Restart the ESP8266 module (turn it off and on). After restarting you will see a new Wi-Fi access point with the name: `esp-devlab-setup`. You will be able to connect there with the default password: `We1c0me!`. The default Wi-Fi AP name and password are specified in file: [`connect.lua`](src/connect.lua). 
5. On successfull connection to the `esp-devlab-setup` Access Point you can reach web UI through the browser by typing anything looking like domain name, e.g.: `any.site.com`. You can do that because the software starts a DNS liar server (it responds with ESP8266 IP to any DNS request) in AP mode. The DNS server evolved based on the work published on the following resources:
  * [Re: Tiny DNS server written in Ncat-Lua - anyone interested?](http://seclists.org/nmap-dev/2013/q3/196)
  * https://svn.nmap.org/!svn/bc/31535/nmap-exp/d33tah/lua-exec-examples/ncat/scripts/dns.lua
  * [ESP8266 WiFi Throwies](http://hackaday.com/2015/05/03/esp8266-wifi-throwies/)
  * [Wifi throwie : improved version - faster, smaller, cheaper](http://iotests.blogspot.fr/2015/10/wifi-throwie-improved-version-faster.html)
6. Web UI shall be quite self-explaining, but note that the best way to brick the software is to use IDE without checking twice what you are uploading to the file system. The changes are taken into account immediately. Bricked NodeMCU can be cured only with connecting ESP module to computer and formatting NodeMCU file system and rewriting the software. In some cases you even have to re-flash the NodeMCU (e.g. if you did the mistake and removed the delay in [`init.lua`](src/init.lua).

## [License](LICENSE)
Copyright (c) 2015 Taras Greben
Licensed under the [Apache License](LICENSE).
