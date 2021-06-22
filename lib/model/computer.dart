class Computer {
  String _name;
  double _cpuUsage, _cpuTemp, _gpuUsage, _gpuTemp, _ramUsage = 0;

  Computer(
      this._name, this._cpuUsage, this._cpuTemp, this._gpuUsage, this._gpuTemp);

  get ramUsage => _ramUsage;

  set ramUsage(value) {
    _ramUsage = value;
  }

  get gpuTemp => _gpuTemp;

  set gpuTemp(value) {
    _gpuTemp = value;
  }

  get gpuUsage => _gpuUsage;

  set gpuUsage(value) {
    _gpuUsage = value;
  }

  get cpuTemp => _cpuTemp;

  set cpuTemp(value) {
    _cpuTemp = value;
  }

  double get cpuUsage => _cpuUsage;

  set cpuUsage(double value) {
    _cpuUsage = value;
  }

  // ignore: unnecessary_getters_setters
  String get name => _name;
}
