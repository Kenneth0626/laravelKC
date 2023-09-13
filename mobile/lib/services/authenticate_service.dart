
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<dynamic> authenticateService() async {

  const  String authApi = 'http://192.168.0.26:8000/api/user';

  const storage = FlutterSecureStorage();

  String? token = await storage.read(key: 'Bearer');

  final Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "X-Requested-With": "XMLHttpRequest",
      "Authorization": 'Bearer $token',
  };

  try {

    final http.Response response = await http.get(
      Uri.parse(authApi),
      headers: headers,
    );

    if(response.statusCode == 401){
      return 401;
    }

    final msg = jsonDecode(response.body);

    return msg?['username'];

  }

  catch (error){
    return -1;
  }

}