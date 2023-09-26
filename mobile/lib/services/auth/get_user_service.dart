import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/services/api_host.dart';
import 'package:mobile/services/token/authenticate_service.dart';
import 'package:mobile/services/token/get_token_service.dart';

Future<dynamic> getUserService() async {
  
  String? token = await getTokenService();

  final Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "X-Requested-With": "XMLHttpRequest",
      "Authorization": 'Bearer $token',
  };

  try {

    int authStatus = await authenticateService(
      doCheckExpire: true,
      token: token,
    );

    if(authStatus == -2){
      return authStatus;
    }

    String authApi = '${apiHost()}user';

    final http.Response response = await http.get(
      Uri.parse(authApi),
      headers: headers,
    );
    
    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      return json['username'];
    }

    return response.statusCode;

  }

  catch (error){
    return -1;
  }

}