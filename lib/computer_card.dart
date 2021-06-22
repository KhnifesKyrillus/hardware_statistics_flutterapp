import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/computer.dart';

class ComputerCard extends StatelessWidget {
  const ComputerCard({Key key, this.c}) : super(key: key);
  final Computer c ;
  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.all(18),
        shadowColor: Colors.green,
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.green],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                c.name.toUpperCase(),
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "CPU Usage:\t\t ${c.cpuUsage.toStringAsFixed(2)}%\n" +
                    "CPU Temp:\t\t ${c.cpuTemp.toStringAsFixed(2)}°C\n\n" +
                    "GPU Usage:\t\t ${c.gpuUsage.toStringAsFixed(2)}%\n" +
                    "GPU Temp:\t\t ${c.gpuTemp.toStringAsFixed(2)}°C\n\n" +
                    "RAM Usage:\t\t ${c.ramUsage.toStringAsFixed(2)}%\n",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );

}
