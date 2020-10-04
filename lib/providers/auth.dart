import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String idToken;
  String refreshToken;
  String expiresIn;
  String localId;

  Future<void> signup(String email, String password) async {
    const url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCwh2EuuqF952sAqqHnCpbWb46Iu83eIJI";
    final response = await http.post(url,
        body: json.encode(
            {"email": email, "password": password, "returnSecureToken": true}));
    print(json.decode(response.body));
  }
}
