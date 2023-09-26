import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/models/Post.dart';
import 'package:mobile/services/api_host.dart';
import 'package:mobile/services/token/authenticate_service.dart';
import 'package:mobile/services/token/get_token_service.dart';

Future<dynamic> getPostsService(int page) async {

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

    String getPostsApi = '${apiHost()}posts?page=$page';

    final http.Response response = await http.get(
      Uri.parse(getPostsApi),
      headers: headers,
    );

    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      final guestStatus = json['data']['guest_id'];
      final jsonMap = json['data']['posts'] as List;
      List<Post> result = jsonMap.map((data) => Post.fromJson(data, guestStatus)).toList(); 
      return result; 
    }
    
    return response.statusCode;

  }

  catch(error){
    return -1;
  }
  
}