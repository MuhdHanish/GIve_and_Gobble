import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:give_gobble/controller/api/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NgoLogin extends ChangeNotifier {
  final emailOResnamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<int> ngologin(context) async {
    final String emailorResname = emailOResnamecontroller.text;
    final String password = passwordcontroller.text;
    try {
      _setIsLoading(true); // Show the loader

      final response = await http.post(
        Uri.parse(Api.ngologin),
        body: {'identifier': emailorResname, 'password': password},
      );
      _setIsLoading(false); // Show the loader
// print(response.body);
      if (response.statusCode == 401) {
        emailOResnamecontroller.clear();
        passwordcontroller.clear();

        notifyListeners();
        return 401;
      } else if (response.statusCode == 403) {
        notifyListeners();
        return 403;
      } else {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString(
            'ngoRefresh', jsonDecode(response.body)['refreshToken']);

        sharedPreferences.setString(
            'ngoAccess', jsonDecode(response.body)['accessToken']);

        notifyListeners();
        return 201;
      }
    } catch (error) {
      print(error);
      notifyListeners();
      return 500;
    }
  }

  Future<bool> ngologout(BuildContext context) async {
    try {
      _setIsLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('isNgoRegistered');
      prefs.remove('isNgoLoggedIn');
      prefs.remove('userId');
      prefs.remove('userRole');
      prefs.remove('accessToken');
      prefs.remove('refreshToken');
      _setIsLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      notifyListeners();
      return false;
    }
    // Navigate to the login page after logout.
    // ignore: use_build_context_synchronously
  }
}
