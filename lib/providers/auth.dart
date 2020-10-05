import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_shop_app/models/http_exception.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(String email, String password, String urlSegment) async {
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBL9iPiTBHklsQ-cxo4Z4jCetw--8jz_g4';

    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          })
      );
      if(json.decode(response.body)['error'] != null) {
        throw HttpException(json.decode(response.body)['error']['message']);
      }
    } catch (error) {
      throw error;
    }

  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
