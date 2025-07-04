import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pickit/core/models/connection_state.dart';

class ConnectionObserver {
  ConnectionObserver._();

  static void observeConnection(
    Function(ConnectionState) onConnectionStateChanged,
  ) {
    checkConnectivity(onConnectionStateChanged);
    Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        onConnectionStateChanged(ConnectionState.connected);
      } else {
        onConnectionStateChanged(ConnectionState.disconnected);
      }
    });
  }

  static void checkConnectivity(
    Function(ConnectionState) onConnectionStateChanged,
  ) async {
    final List<ConnectivityResult> result =
        await (Connectivity().checkConnectivity());
    if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        onConnectionStateChanged(ConnectionState.connected);
      } else {
        onConnectionStateChanged(ConnectionState.disconnected);
      }
  }
}
