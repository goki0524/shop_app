import 'dart:convert'; //json

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../config/env.dart';

class Auth with ChangeNotifier {
  final env = Env();
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup(String email, String password) async {
    final url = env.getSignupUrl;
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    print(json.decode(response.body));
  }

  Future<void> login(String email, String password) async {
    final url = env.getLoginUrl;
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    print(json.decode(response.body));
  }
}
