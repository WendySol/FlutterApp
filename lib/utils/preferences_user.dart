import 'package:shared_preferences/shared_preferences.dart';

class Preferencias{

  Future saveUserToken(String token) async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    return await preferences.setString("TOKEN", token);
  }

  Future getUserToken() async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    return preferences.getString("TOKEN");
  }


  Future saveIdUser(String isUser) async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    return await preferences.setString("IDUSER", isUser);
  }

  Future<String> getIdUser() async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    print(preferences);
    return preferences.getString("IDUSER");
  }
  Future saveUserName(String userName) async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    return await preferences.setString("USERNAME", userName);
  }
  Future saveEmail(String email) async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    return await preferences.setString("EMAIL", email);
  }
  Future saveLogInState(bool isLogedIn) async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    print(isLogedIn);
    await preferences.setBool("LOGEDIN", isLogedIn);
   
  }
  Future<String> getUserName() async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    return  preferences.getString("USERNAME");
  }
  Future<String> getEmail() async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    return preferences.getString("EMAIL");
  }
  Future<bool> getLogInState() async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    return  preferences.getBool("LOGEDIN");
  }
}