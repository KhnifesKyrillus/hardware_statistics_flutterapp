import 'dart:io';

import 'package:collection/collection.dart';
import 'package:hardware_statistics_flutterapp/model/computer.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'constants.dart';

class MqttController {
  final client = MqttServerClient('90.146.155.103', 'mqtt_2134qw');

  Future<int> initializeMqttClient() async {
    client.port = 1883;
    client.logging(on: false);
    client.keepAlivePeriod = 5;
    client.autoReconnect = true;
    client.resubscribeOnAutoReconnect = false;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
    client.useWebSocket = false;

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

    const topic = 'device/#';
    client.subscribe(topic, MqttQos.atMostOnce);

    /// The client has a change notifier object(see the Observable class) which we then listen to to get
    /// notifications of published updates to each subscribed topic.
    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      String deviceName = c[0].topic.split("/")[1];

      List<Computer> computers = controller.computers;
      Computer computer =
          computers.firstWhereOrNull((element) => element.name == deviceName);
      if (computer != null) {
        int index = c[0].topic.indexOf(deviceName);
        String topic = c[0].topic.substring(index + deviceName.length + 1);
        switch (topic) {
          case "ram":
            computer.ramUsage = double.parse(pt) * 100;
            controller.computers = controller.computers;
            break;
          case "cpu/temp":
            computer.cpuTemp = double.parse(pt);
            controller.computers = controller.computers;
            break;
          case "cpu/load":
            computer.cpuUsage = double.parse(pt) * 100;
            controller.computers = controller.computers;
            break;
          case "gpu/temp":
            computer.gpuTemp = double.parse(pt);
            controller.computers = controller.computers;
            break;
          case "gpu/load":
            computer.gpuUsage = double.parse(pt) * 100;
            controller.computers = controller.computers;
            break;
        }
        print(
            '<$deviceName> Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
        print('');
      }
    });
    return 0;
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('Subscription confirmed for topic $topic');
  }

  /// The successful connect callback
  void onConnected() {
    print('onConnected client callback - Client connection was successful');
  }
}
