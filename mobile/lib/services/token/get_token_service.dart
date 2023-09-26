import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String?> getTokenService() async {

  const storage = FlutterSecureStorage();

  String? token = await storage.read(key: 'Bearer');

  return token;

}