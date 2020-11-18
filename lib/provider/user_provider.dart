import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String token;
  String username;
  String idPro;
  String email;
  String follwrs;

  fetchUserData() async {
    var prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    if (token == null) token = "";
    username = prefs.getString("username");
    idPro = prefs.getString("idPro");
    email = prefs.getString("email");
    follwrs = prefs.getString("follwrs");
    notifyListeners();
  }

  saveUserData(String token) async {
    this.token = token;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    notifyListeners();
  }
  

  // saveUserProfile(String username, String email, String first_name) async {
  //   this.username = username;
  //   this.email = email;
  //   this.first_name = first_name;
  //   this.last_name = last_name;
  //   this.dni = dni;
  //   var prefs = await SharedPreferences.getInstance();
  //   prefs.setString("username", username);
  //   prefs.setString("email", email);
  //   prefs.setString("first_name", first_name);
  //   prefs.setString("last_name", last_name);
  //   prefs.setString("dni", dni);
  //   notifyListeners();
  // }
}
