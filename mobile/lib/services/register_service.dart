import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<dynamic> registerService(String jsonData) async {

  const  String registerApi = 'http://192.168.0.26:8000/api/register';

  final Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "X-Requested-With": "XMLHttpRequest",
  };

  try {

    final http.Response response = await http.post(
      Uri.parse(registerApi),
      headers: headers,
      body: jsonData,
    );

    if (response.statusCode == 200) {
      const storage = FlutterSecureStorage();
      final data = jsonDecode(response.body);
      await storage.write(
        key: 'Bearer', 
        value: data['data']['token'],
      );
      return 200; 
    }
    else{
      final msg = jsonDecode(response.body);
      return msg['errors'];
    }

  }

  catch (error){
    return -1;
  }

}
