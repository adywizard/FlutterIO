# factoryio_app

A Flutter application designed to interface with Factory I/O simulation software using mqtt protocol. This app enables remote monitoring and control of virtual factory environment (Sorting by height Advanced scene), providing real-time data visualization and process management capabilities.

It's a small example of how to integrate mobile development with Operational Technology

This project is composed of three parts:

1) Multiplatform App made with flutter (version 3.29.3 used)

2) PLC program made with Tia Portal Profesional v19

3) FactoryIO Scene Sorting by height Advanced (FactoryIO version 2.5.4 used)

The Flutter app is a MQTT Client that allows you set either secure or non secure communication with the broker, at the moment websocket is not implemented. 

You can find on link below how to set up certificatesa for secure communication with the broker hosted on AWS in Tia Portal:

https://www.youtube.com/watch?v=yOqHG6bxKAY

Give the guy thumbs up!

The app can also be used on non secure port (1883) either localy or over internet, it's up to you how you want to implement your broker.

for local communication you can use Mosquitto broke which is open surce project, download link: https://mosquitto.org/

Guide for setting it up: https://www.youtube.com/watch?v=2S_kZo_ElxY

Give a credit to that guy!
