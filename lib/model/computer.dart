import 'package:flutter/cupertino.dart';
import 'package:hardware_statistics_flutterapp/device_controller.dart';

class Computer with ChangeNotifier {
  String _name;
  double _cpuUsage, _cpuTemp, _gpuUsage, _gpuTemp, _ramUsage = 0;

  Computer(
      this._name, this._cpuUsage, this._cpuTemp, this._gpuUsage, this._gpuTemp);

  get ramUsage => _ramUsage;

  set ramUsage(value) {
    _ramUsage = value;
    notifyListeners();
  }

  get gpuTemp => _gpuTemp;

  set gpuTemp(value) {
    _gpuTemp = value;
    notifyListeners();
  }

  get gpuUsage => _gpuUsage;

  set gpuUsage(value) {
    _gpuUsage = value;
    notifyListeners();
  }

  get cpuTemp => _cpuTemp;

  set cpuTemp(value) {
    _cpuTemp = value;
    notifyListeners();
  }

  double get cpuUsage => _cpuUsage;

  set cpuUsage(double value) {
    _cpuUsage = value;
    notifyListeners();
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
