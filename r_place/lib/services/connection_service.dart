import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

// class represents a sevice which checks the connection status
class ConnectionService {
  // Controller to control the connection status
  final StreamController<bool> _statusController =
      StreamController<bool>.broadcast();

  ConnectionService() {
    Connectivity().onConnectivityChanged.listen((result) {
      _statusController.add(result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile));
    });
  }

  // Stream which returns the status of the connection
  Stream<bool> get status => _statusController.stream;

  // Method which disposes the controller
  void dispose() {
    _statusController.close();
  }
}
