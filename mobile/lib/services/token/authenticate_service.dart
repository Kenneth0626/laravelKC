import 'package:http/http.dart' as http;
import 'package:mobile/services/api_host.dart';
import 'package:mobile/services/token/delete_token_service.dart';
import 'package:mobile/services/token/get_token_service.dart';

Future<int> authenticateService({bool doCheckExpire = false, String? token}) async {
  
  String authApi = '${apiHost()}user';

  token ??= await getTokenService();

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

    if(doCheckExpire && token != null && response.statusCode == 401){
      await deleteTokenService();
      return -2;
    }

    if(token == null){
      return -2;
    }

    return response.statusCode;

  }

  catch (error){
    return -1;
  }

}