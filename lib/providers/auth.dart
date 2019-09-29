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

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

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
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      // 値が変更したことをProviderに伝える
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    final url = env.signupUrl;
    return _authenticate(url, email, password);
  }

  Future<void> login(String email, String password) async {
    final url = env.loginUrl;
    return _authenticate(url, email, password);
  }
}
