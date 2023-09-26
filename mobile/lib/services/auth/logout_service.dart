import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/services/api_host.dart';

Future<int> logoutService() async {

  String logoutApi = '${apiHost()}logout';

  const storage = FlutterSecureStorage();

  String? token = await storage.read(key: 'Bearer');

  final Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "X-Requested-With": "XMLHttpRequest",
      "Authorization": 'Bearer $token',
  };

  try {

    final http.Response response = await http.post(
      Uri.parse(logoutApi),
      headers: headers,
    );

    if(response.statusCode == 200){
      await storage.delete(key: "Bearer");
      return 200;
    }

    return response.statusCode;

  }

  catch (error){
    return -1;
  }

}
