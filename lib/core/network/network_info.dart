import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart';

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

  final networkSubject = BehaviorSubject<NetWorkStatus>();

  NetworkInfoImpl(Connectivity connectivity) : _connectivity = connectivity {
    _handleConnect();
  }

  Stream<NetWorkStatus> get networkStream => networkSubject.stream;

  Future<void> _handleConnect() async {
    var connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      _status = NetWorkStatus.noInternet;
    } else {
      _status = NetWorkStatus.successfully;
    }
    networkSubject.add(_status);
  }

  @override
  NetWorkStatus get status => _status;

  @override
  void listenChangeNetwork(ConnectivityResult result) {
    if (result != ConnectivityResult.none) {
      _status = NetWorkStatus.successfully;
    } else {
      _status = NetWorkStatus.noInternet;
    }
    networkSubject.sink.add(_status);
  }
}
