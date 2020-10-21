import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future<dynamic> getRequest(String url, [Map header]) {
    return http.get(url, headers: header).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        return "Something Went Wrong";
      }
    });
  }
}
