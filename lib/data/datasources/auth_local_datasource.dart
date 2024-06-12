import 'dart:convert';

import 'package:possapp/data/models/response/auth_response_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthLocalDataSource {

  Future<void> saveAuthData(AuthResponseModel authResponseModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_data', authResponseModel.toRawJson());
  }

// Ini buat logout
  Future<void> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_data');
  }

  // ini buat dapetin data orang yang login (token, email, pw)
  Future<AuthResponseModel> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_data');
    if ( authData != null) {
      return AuthResponseModel.fromJson(json.decode(authData));
    } else {
      throw Exception("Auth Data not found");
    }
  }

  // ini buat cek data nya ada atau gak
  Future<bool> isAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_data');
    return authData != null;
  }
}


//isinya buat nyimpan data ke lokal