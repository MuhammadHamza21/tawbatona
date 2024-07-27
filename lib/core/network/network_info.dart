// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class BaseNetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfo extends BaseNetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;
  NetworkInfo({
    required this.internetConnectionChecker,
  });
  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
