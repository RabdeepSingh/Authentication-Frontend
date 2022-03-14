import 'package:authentication/signin.dart';
import 'package:authentication/util/session_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userValue = await UserSecureStorage.getUserdata() ?? "";
  print(userValue);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: true,
    home: userValue.toString() != "" ? Dashboard() : Signin(),
  ));
}


// to run without null safety - flutter run --no-sound-null-safety