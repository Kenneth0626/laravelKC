import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/models/Comment.dart';
import 'package:mobile/services/api_host.dart';
import 'package:mobile/services/token/authenticate_service.dart';
import 'package:mobile/services/token/get_token_service.dart';

Future<dynamic> getCommentsService(int postID, int page) async {

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

    String getCommentsApi = '${apiHost()}posts/comments/$postID?page=$page';

    final http.Response response = await http.get(
      Uri.parse(getCommentsApi),
      headers: headers,
    );

    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      final jsonMap = json['data']['comments'] as List;
      List<Comment> result = jsonMap.map((data) => Comment.fromJson(data)).toList();
      return result;   
    }
    
    return response.statusCode;

  }

  catch(error){
    return -1;
  }

}