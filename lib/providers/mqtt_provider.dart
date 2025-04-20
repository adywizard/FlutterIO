import 'package:factoryio_app/all_imports.dart';

class MqttSecurityContext {
  static Future<SecurityContext> get context async {
    final context = SecurityContext.defaultContext;

    try {
      final prefs = await SharedPreferences.getInstance();

      final String? savedRootPath = prefs.getString('rootCertPath');
      final String? savedDevicePath = prefs.getString('deviceCertPath');
      final String? savedPrivatePath = prefs.getString('privateKeyPath');

      if (savedRootPath == null ||
          savedDevicePath == null ||
          savedPrivatePath == null) {
        throw Exception('Certificate paths not found in preferences');
      }

      final rootCA = File(savedRootPath).readAsBytesSync();
      final deviceCer = File(savedDevicePath).readAsBytesSync();
      final privateCer = File(savedPrivatePath).readAsBytesSync();

      context.setClientAuthoritiesBytes(rootCA.buffer.asInt8List());
      context.useCertificateChainBytes(deviceCer.buffer.asInt8List());
      context.usePrivateKeyBytes(privateCer.buffer.asInt8List());
    } catch (e) {
      log("Error loading certificates: $e");
    }

    return context;
  }
}

class MqttProvider extends AsyncNotifier<List<int>> {
  MqttServerClient? client;
  BuildContext? context;
  double? height;
  Color? color;
  Color? iconColor;
  int numberOfBigBoxes = 0;
  int numberOfSmallBoxes = 0;
  int totalBoxes = 0;

  void setContext(BuildContext context) {
    this.context = context;
    height = MediaQuery.of(context).size.height;
    color = Theme.of(context).colorScheme.primary;
    iconColor = Theme.of(context).colorScheme.onPrimary;
  }

  //
  @override
  Future<List<int>> build() async {
    final prefs = await SharedPreferences.getInstance();
    final connectionPort =
        prefs.getInt('brokerPort') ??
        ref.read(brokerPortProvider).value ??
        defaultPort;
    final address =
        prefs.getString('brokerAddress') ??
        ref.read(brokerAddressProvider).value ??
        defaultBrokerAddress;
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');

    if ((username?.isEmpty ?? true) || username == defaultUsername) {
      username = null;
    }
    if ((password?.isEmpty ?? true) || password == defaultPassword) {
      password = null;
    }
    log("building mqtt client");
    if (client != null &&
        client?.connectionStatus?.state == MqttConnectionState.connected) {
      return [totalBoxes, numberOfBigBoxes, numberOfSmallBoxes];
    }

    client = MqttServerClient.withPort(address, clientId, connectionPort);

    client?.securityContext = await MqttSecurityContext.context;
    connectionPort == 8883 ? client?.secure = true : client?.secure = false;

    client?.keepAlivePeriod = 20;
    client?.setProtocolV311();
    client?.onBadCertificate = _onBadCertificate;
    await connect(client, username, password);
    return [totalBoxes, numberOfBigBoxes, numberOfSmallBoxes];
  }

  Future<void> connect(
    MqttClient? client,
    String? username,
    String? password,
  ) async {
    log("client is not connected, connecting...");
    client?.logging(on: logging);
    log("connect method of mqtt client");
    client?.onConnected = onConnected;
    client?.onDisconnected = onDisconnected;
    client?.onSubscribed = onSubscribed;
    client?.onSubscribeFail = onSubscribeFail;
    client?.onUnsubscribed = onUnsubscribed;
    client?.pongCallback = pong;
    client?.connectTimeoutPeriod = 30;
    client?.autoReconnect = true;
    client?.resubscribeOnAutoReconnect = true;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('MqttClient')
        .startClean()
        .authenticateAs(username, password)
        .withWillQos(MqttQos.atLeastOnce)
        .withWillTopic(Topics.willTopic.name)
        .withWillMessage(Topics.willTopic.description);
    client?.connectionMessage = connMessage;

    try {
      await client?.connect();
    } catch (e) {
      client?.disconnect();
    }

    if (client?.connectionStatus!.state == MqttConnectionState.connected) {
      log('MQTT client connected');
    } else {
      log(
        'ERROR: MQTT client connection failed - disconnecting, state is ${client?.connectionStatus}',
      );
      client?.disconnect();
    }
    client?.updates?.listen(_onData);
  }

  bool _onBadCertificate(Object a) {
    log("cert error");
    if (context != null && (context?.mounted ?? false)) {
      ScaffoldMessenger.of(context!).clearSnackBars();
      final snackBar = TopicMessageSnackBar(
        color: color!,
        iconColor: iconColor!,
        data: "Bad certificate",
        margin: EdgeInsets.only(right: 10, left: 10),
      );
      ScaffoldMessenger.of(context!).showSnackBar(snackBar);
    }
    return true;
  }

  void _showSensorMessage(String message) {
    if (context != null && height != null) {
      ScaffoldMessenger.of(context!).clearSnackBars();
      final snackBar = TopicMessageSnackBar(
        color: color!,
        iconColor: iconColor!,
        data: message,
        margin: EdgeInsets.only(bottom: height! - 150, right: 10, left: 10),
      );
      ScaffoldMessenger.of(context!).showSnackBar(snackBar);
    }
  }

  bool publish(String topic, bool message) {
    if (client?.connectionStatus!.state == MqttConnectionState.connected) {
      final builder = MqttClientPayloadBuilder();
      builder.addBool(val: message);

      client?.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
      log("published message: $message to topic: $topic");
      return true;
    }
    return false;
  }

  void _onData(List<MqttReceivedMessage<MqttMessage?>>? mqtt) async {
    final topic = mqtt?[0].topic;
    log("client received topic: $topic");
    final recMess = mqtt?[0].payload as MqttPublishMessage;
    final data = recMess.payload.message.buffer.asByteData();

    if (topic == TopicsIn.topicBoxTotal.name) {
      numberOfSmallBoxes = data.getUint32(0);
      log("numberOfSmallBoxes: $numberOfSmallBoxes");

      numberOfBigBoxes = data.getUint32(4);
      log("numberOfBigBoxes: $numberOfBigBoxes");
      totalBoxes = numberOfSmallBoxes + numberOfBigBoxes;
      state = AsyncValue.data([
        totalBoxes,
        numberOfBigBoxes,
        numberOfSmallBoxes,
      ]);
      return;
    }

    if (topic == TopicsIn.topicBoxCountBig.name) {
      final boxCount = data.getUint32(0);
      if (boxCount == 0) {
        totalBoxes = 0;
        numberOfSmallBoxes = 0;
      }
      numberOfBigBoxes = boxCount;
      totalBoxes = numberOfBigBoxes + numberOfSmallBoxes;
      state = AsyncValue.data([
        totalBoxes,
        numberOfBigBoxes,
        numberOfSmallBoxes,
      ]);

      return;
    } else if (topic == TopicsIn.topicBoxCountSmall.name) {
      final boxCount = data.getUint32(0);
      if (boxCount == 0) {
        totalBoxes = 0;
        numberOfBigBoxes = 0;
      }
      numberOfSmallBoxes = boxCount;
      totalBoxes = numberOfBigBoxes + numberOfSmallBoxes;
      state = AsyncValue.data([
        totalBoxes,
        numberOfBigBoxes,
        numberOfSmallBoxes,
      ]);
      return;
    }

    final message = data.getUint8(0);
    final sensorState = message == 1 ? "ON" : "OFF";

    if (topic == TopicsIn.topicPlcOnline.name) {
      _showSensorMessage("PLC is online");
      return;
    } else if (topic == TopicsIn.topicAtEntry.name) {
      _showSensorMessage("At Entry sensor triggered $sensorState");
      return;
    } else if (topic == TopicsIn.topicAtLoad.name) {
      _showSensorMessage("At Load sensor triggered $sensorState");
      return;
    } else if (topic == TopicsIn.topicAtUnload.name) {
      _showSensorMessage("At Unload sensor triggered $sensorState");
      return;
    } else if (topic == TopicsIn.topicAtleft.name) {
      _showSensorMessage("At Left sensor triggered $sensorState");
      return;
    } else if (topic == TopicsIn.topicAtRight.name) {
      _showSensorMessage("At Right sensor triggered $sensorState");
      return;
    }
  }

  void disconnect() async {
    log("disconnecting mqtt client");
    client?.disconnect();
    log("mqtt client disconnected");
  }

  void onConnected() {
    log('Connected');
    for (var topic in TopicsIn.values) {
      client?.subscribe(topic.name, MqttQos.atLeastOnce);
    }
    ScaffoldMessenger.of(context!).clearSnackBars();
    final snackBar = TopicMessageSnackBar(
      color: color!,
      iconColor: iconColor!,
      data: "Connected to broker",
      margin: EdgeInsets.only(bottom: 16, right: 16, left: 16),
    );
    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
    publish(Topics.connectedTopic.name, true);
  }

  void onDisconnected() {
    if (context != null && (context?.mounted ?? false)) {
      ScaffoldMessenger.of(context!).clearSnackBars();
      final snackBar = TopicMessageSnackBar(
        color: Theme.of(context!).colorScheme.error,
        iconColor: iconColor!,
        data: "Disconnected from broker",
        margin: EdgeInsets.only(bottom: 16, right: 16, left: 16),
      );
      ScaffoldMessenger.of(context!).showSnackBar(snackBar);
    }
    log('Client callback - Client disconnection');
  }

  void onSubscribed(String topic) {
    log('Subscribed to $topic');
  }

  void onSubscribeFail(String topic) {
    log('Failed to subscribe $topic');
  }

  void onUnsubscribed(String? topic) {
    log('Unsubscribed from $topic');
  }

  void pong() {
    log('Ping response client callback invoked');
  }
}

final mqttProvider = AsyncNotifierProvider<MqttProvider, List<int>>(() {
  return MqttProvider();
});
