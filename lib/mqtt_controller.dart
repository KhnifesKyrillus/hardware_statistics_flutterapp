import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttController {
  final client =
      MqttServerClient('broker.mqttdashboard.com', 'FwUwjvc0Rn');

  Future<int> initializeMqttClient() async {
    client.port = 8000;
    client.logging(on: true);
    client.keepAlivePeriod = 5;
    client.autoReconnect = true;
    client.resubscribeOnAutoReconnect = false;
    client.onAutoReconnect = onAutoReconnect;
    client.onAutoReconnected = onAutoReconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;

    /* final connMess = MqttConnectMessage()
      .withClientIdentifier('Mqtt_MyClientUniqueId')
      .withWillTopic('willtopic') // If you set this you must set a will message
      .withWillMessage('My Will message')
      .startClean() // Non persistent session for testing
      .withWillQos(MqttQos.atLeastOnce);
  print('EXAMPLE::Mosquitto client connecting....');
  client.connectionMessage = connMess;*/

    try {
      await client.connect();
    } on Exception catch (e) {
      print('client exception - $e');
      client.disconnect();
    }

    /// Check we are connected
    if (client.connectionStatus.state == MqttConnectionState.connected) {
      print('Client connected');
    } else {
      print(
          'Client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      exit(-1);
    }

    print('EXAMPLE::Subscribing to the test/lol topic');
    const topic = 'maxl/1';
    client.subscribe(topic, MqttQos.atMostOnce);

    /// The client has a change notifier object(see the Observable class) which we then listen to to get
    /// notifications of published updates to each subscribed topic.
    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print(
          'Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });

    /// If needed you can listen for published messages that have completed the publishing
    /// handshake which is Qos dependant. Any message received on this stream has completed its
    /// publishing handshake with the broker.
    client.published.listen((MqttPublishMessage message) {
      print(
          'Published notification:: topic is ${message.variableHeader.topicName}, with Qos ${message.header.qos}');
    });
    return 0;
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('Subscription confirmed for topic $topic');
  }

  /// The pre auto re connect callback
  void onAutoReconnect() {
    print(
        'onAutoReconnect client callback - Client auto reconnection sequence will start');
  }

  /// The post auto re connect callback
  void onAutoReconnected() {
    print(
        'onAutoReconnected client callback - Client auto reconnection sequence has completed');
  }

  /// The successful connect callback
  void onConnected() {
    print('onConnected client callback - Client connection was successful');
  }

  /// Pong callback
  void pong() {
    print(
        'Ping response client callback invoked - you may want to disconnect your broker here');
  }
}
