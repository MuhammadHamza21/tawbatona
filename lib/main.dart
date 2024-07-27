import 'package:flutter/material.dart';
import 'package:tawbatona/core/services/service_locator.dart';
import 'package:tawbatona/tawbatona_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.init();
  runApp(const MyApp());
}
