import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:hardware_statistics_flutterapp/model/computer.dart';

class DeviceController  with  ChangeNotifier{
  List<Computer> _computers = new List();

  List<Computer> get computers => _computers;

  set computers(List<Computer> value) {
    _computers = value;
    notifyListeners();
  }

  void addComputer(String name) {
    Computer computer =
        computers.firstWhereOrNull((element) => element.name == name);
    if (computer == null) this.computers.add(new Computer(name, 0, 0, 0, 0));
    notifyListeners();
  }
}
