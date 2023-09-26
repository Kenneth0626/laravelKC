import 'package:http/http.dart' as http;
import 'package:mobile/services/api_host.dart';
import 'package:mobile/services/token/authenticate_service.dart';
import 'package:mobile/services/token/get_token_service.dart';

Future<dynamic> deleteCommentService(int commentID) async {

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

    String deleteCommentApi = '${apiHost()}comments/$commentID/destroy';

    final http.Response response = await http.delete(
      Uri.parse(deleteCommentApi),
      headers: headers,
    );
    
    return response.statusCode;

  }

  catch(error){
    return -1;
  }
}