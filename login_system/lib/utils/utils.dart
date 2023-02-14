// ignore_for_file: avoid_print

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<void> storeToken(String token) async {
  await storage.write(key: 'token', value: token);
}

Future<String?> getToken() async {
  String? token = await storage.read(key: "token");
  print(token);
  return token;
}

Future<void> deletToken() async {
   await storage.delete(key: "token");

}

