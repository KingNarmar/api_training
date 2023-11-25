import 'package:api_training/repos/dio_helper.dart';
import 'package:api_training/repos/shared_helper.dart';
import 'package:flutter/material.dart';
import 'root/root_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedHelper.init();
  DioHelper.init();
  runApp(const MyApp());
}
