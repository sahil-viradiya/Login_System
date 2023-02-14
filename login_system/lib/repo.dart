// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:login_system/utils/utils.dart';

class Repo {
  static Future<dynamic> postData(String email, String password) async {
    var reponce = await Dio().post("http://192.168.1.5:8000/api/login/", data: {
      'email': "john@g.com",
      'password': "12345678",
    });
    return reponce;
  }

  static Future<dynamic> like() async {
    String? token = await getToken();
    var responce = await Dio().get("http://192.168.1.5:8000/api/like/",
        options: Options(headers: {'authorization': token}));
    return responce;
  }
}
