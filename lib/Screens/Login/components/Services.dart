import 'dart:convert';
import 'package:dapur_malaysia/User.dart';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file

class Services {
  // static const ROOT = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyC93qNHEHxotzDUhesxY-dDwX2tD8kwTAM'; //put database URL here
  static const _GET_USER = 'GET_USER';

// ignore: non_constant_identifier_names
  static Future<List<User>> getUser(String email, String password) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_USER;
      map['email'] = email;
      map['password'] = password;
      final response = await http.post(Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyC93qNHEHxotzDUhesxY-dDwX2tD8kwTAM'), body: map);
      if (200 == response.statusCode) {
        print('getCF Response: ${response.body}');
        List<User> userData = parseResponse(response.body);
        return userData;
      } else {
        return List<User>();
      }
    } catch (e) {
      print('hello');
      return List<User>();
    }
  }

  static List<User> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }
}
