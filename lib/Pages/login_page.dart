import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart';
import 'package:proyecto_codigo/provider/user_provider.dart';
import 'package:proyecto_codigo/utils/httphelper.dart';

import 'package:proyecto_codigo/utils/preferences_user.dart';

class LoginUserPage extends StatefulWidget {
  @override
  _LoginUserPageState createState() => _LoginUserPageState();
}

class _LoginUserPageState extends State<LoginUserPage> {
  String error = "";

  bool _isLoading = false;
  bool logeado;

  bool inAsyncCall = false;
  Profile pro;
  String idPro;

  @override
  void initState() {
    super.initState();
  }

  void iniciarSesion() async {
    setState(() {
      inAsyncCall = true;
    });

    String token = await HttpHelper()
        .iniciarSesion(emailController.text, passwordController.text);

    Profile pro = await HttpHelper()
        .consultarPerfil(emailController.text, passwordController.text, token);

    if (pro != null) {
      print("profile $pro");
      await Preferencias().saveIdUser(pro.id);
    } else {
      print("Error de usuario");
      showInSnackBar("Credenciales incorrectas, vuelva a intentarlo");
    }

    print(token);
    setState(() {
      inAsyncCall = false;
    });

    if (token.length > 0) {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => HomePage(pro),
      //     ));
      Navigator.pushReplacementNamed(context, 'home');
      Provider.of<UserProvider>(context, listen: false).saveUserData(token);

      await Preferencias().saveUserToken(token);
    } else {
      setState(() {
        error = "Credenciales incorrectas";
        print("Error de usuario");
      });
      passwordController.clear();
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //       colors: [Colors.blue, Colors.teal],
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter),
        // ),
        child: _isLoading
            ? Center(
                heightFactor: 20.0,
                widthFactor: 20.0,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ))
            : Stack(
                children: [
                  Image.asset(
                    'assets/fondq.jpeg',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 128,top: 50),
                    width: 150,
                    height: 150,
                    child: Image.asset(
                      'assets/qenq.png',
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(top: 190),
                    child: Card(
                      color: Colors.cyan[900].withOpacity(0.85),
                      elevation: 6.0,
                      margin: EdgeInsets.all(25),
                      child: Container(
                        height: 450,
                        child: ListView(
                          children: <Widget>[
                            headerSection(),
                            textSection(),
                            buttonSection(),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("¿No tienes cuenta? ",
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                  GestureDetector(
                                    child: Text(
                                      " Registrate ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, "registroUsuario");
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: () async {
          iniciarSesion();
        },
        color: Theme.of(context).accentColor,
        child: Text("Ingresa", style: TextStyle(color: Colors.white)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(duration: Duration(seconds: 2), content: new Text(value)));
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: HexColor("#7DB2BC"),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.email, color: Colors.white),
                ),
                hintText: "Usuario",
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 30.0),
          Container(
            decoration: BoxDecoration(
              color: HexColor("#7DB2BC"),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: passwordController,
              cursorColor: Colors.white,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.lock, color: Colors.white),
                ),
                hintText: "Contraseña",
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "¿Olvidaste tu contraseña?",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      child: Center(
        child: Text("Ingresa",
            style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.normal)),
      ),
    );
  }
}
