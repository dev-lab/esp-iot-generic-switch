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
1. Flash ESP8266 module with the latest NodeMCU (preferably with limited set of modules without MQTT, crypt, float).
2. Install https://github.com/dev-lab/esp-nodemcu-lua-uploader.
3. Upload the software with [install.bat](install.bat).

## [License](LICENSE)
Copyright (c) 2015 Taras Greben
Licensed under the [Apache License](LICENSE).
