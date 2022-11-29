import 'package:firebase_performance/firebase_performance.dart';

class PerformanceService {
  final FirebasePerformance performance = FirebasePerformance.instance;

  Trace? _trace;

  void _setTrace(String name) => _trace = performance.newTrace(name);

  Trace? get trace => _trace;

  Future<void> startTrace(String name) async {
    _setTrace(name);
    await _trace?.start();
  }

  Future<void> stopTrace() async => await _trace?.stop();

  void setMetric(String name, int value) => _trace?.setMetric(name, value);

  void incrementMetric(String name, int value) =>
      _trace?.incrementMetric(name, value);

  String? getAttribute(String name) => _trace?.getAttribute(name);

  Map<String, String>? getAttributes() => _trace?.getAttributes();

  void setAttribute(String name, String value) {
    if (getAttributes()?.length != 5) {
      _trace?.putAttribute(name, value);
    }
  }

  void removeAttribute(String name) {
    if (getAttribute(name) != null) {
      _trace?.removeAttribute(name);
    }
  }

  HttpMetric setHttpMetric(String url, HttpMethod httpMethod) =>
      performance.newHttpMetric(url, httpMethod);

  Future<void> setAutomaticDataCollection(bool value) async =>
      performance.setPerformanceCollectionEnabled(value);
}
