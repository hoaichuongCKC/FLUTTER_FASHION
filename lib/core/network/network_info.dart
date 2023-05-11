import 'dart:developer';
import 'package:flutter_fashion/app/presentation/login/export.dart';

enum NetWorkStatus {
  successfully,
  noInternet,
}

abstract class NetworkInfo {
  NetWorkStatus get status;

  void listenChangeNetwork(ConnectivityResult result);
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  NetWorkStatus _status = NetWorkStatus.successfully;

  NetworkInfoImpl(Connectivity connectivity) : _connectivity = connectivity {
    _handleConnect();
  }

  Future<void> _handleConnect() async {
    var connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      _status = NetWorkStatus.noInternet;
    } else {
      _status = NetWorkStatus.successfully;
    }
  }

  @override
  NetWorkStatus get status => _status;

  @override
  void listenChangeNetwork(ConnectivityResult result) {
    log("$result", name: "Connectivity");
    if (result != ConnectivityResult.none) {
      _status = NetWorkStatus.successfully;
    } else {
      _status = NetWorkStatus.noInternet;
      AppSnackbarMessenger.showMessage(content: "No Internet!!!");
    }
  }
}
