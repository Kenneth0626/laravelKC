import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/services/api_host.dart';
import 'package:mobile/services/token/authenticate_service.dart';
import 'package:mobile/services/token/get_token_service.dart';

Future<dynamic> patchCommentService(int postID, String jsonData) async {

  String? token = await getTokenService();

  final Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "X-Requested-With": "XMLHttpRequest",
      "Authorization": 'Bearer $token',
  };

  try{

    int authStatus = await authenticateService(
      doCheckExpire: true,
      token: token,
    );

    if(authStatus == -2){
      return authStatus;
    }

    String patchCommentApi = '${apiHost()}comments/posts/$postID/update';

    final http.Response response = await http.patch(
      Uri.parse(patchCommentApi),
      headers: headers,
      body: jsonData,
    );

    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      return json['data'];
    }
    
    return response.statusCode;

  }

  catch(error){
    return -1;
  }

}