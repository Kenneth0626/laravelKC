
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> deleteTokenService() async {
  
  const storage = FlutterSecureStorage();

  String? token = await storage.read(key: "Bearer");

  if(token != null){
    await storage.delete(key: "Bearer");
  }

}