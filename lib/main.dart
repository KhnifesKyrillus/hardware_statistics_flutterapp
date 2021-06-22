import 'package:flutter/material.dart';
import 'package:hardware_statistics_flutterapp/add_computer_button.dart';
import 'package:hardware_statistics_flutterapp/device_controller.dart';
import 'package:hardware_statistics_flutterapp/mqtt_controller.dart';
import 'package:provider/provider.dart';

import 'computer_card.dart';
import 'constants.dart';

void main() async {
  MqttController mqttController = new MqttController();
  await mqttController.initializeMqttClient();
  runApp(
    ChangeNotifierProvider(
      create: (_) => controller,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hardware Statistics',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Hardware Statistics'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: Icon(
                    Icons.refresh,
                    size: 26.0,
                  ),
                )),
          ],
        ),
        body: ListView.builder(
            itemBuilder: (context, index) => ComputerCard(
                  c: Provider.of<DeviceController>(context).computers[index],
                ),
            itemCount: Provider.of<DeviceController>(context).computers.length),
        floatingActionButton: AddComputerButton());
  }
}
