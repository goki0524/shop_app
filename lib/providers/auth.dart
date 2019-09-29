import 'dart:convert'; //json

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../config/env.dart';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  final env = Env();
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(String url, String email, String password) async {
    try {
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
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    final url = env.getSignupUrl;
    return _authenticate(url, email, password);
  }

  Future<void> login(String email, String password) async {
    final url = env.getLoginUrl;
    return _authenticate(url, email, password);
  }
}
