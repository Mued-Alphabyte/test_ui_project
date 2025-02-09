import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/UserResponse.dart';
import '../utils/constants.dart';

class UserService {

  static Future<UserResponse> fetchUsers(int page) async {
    final response = await http.get(Uri.parse("$baseUrl?page=$page&per_page=8"));

    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load users");
    }
  }

  // static Future<dynamic> downloadData(String endPoint, Object data) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl$endPoint'),
  //     body: jsonEncode(data),
  //   );
  //
  //   var responseData = jsonDecode(response.body);
  //
  //   if (response.statusCode == 200) {
  //     return responseData;
  //   } else {
  //     throw Exception('Request failed with status: ${response.statusCode}');
  //   }
  //
  // }

}