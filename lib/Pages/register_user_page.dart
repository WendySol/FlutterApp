import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart';
import 'package:proyecto_codigo/utils/preferences_user.dart';
import 'package:proyecto_codigo/utils/validator.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../utils/httphelper.dart';

class RegistroUsuario extends StatefulWidget {
  @override
  _RegistroUsuarioState createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //key para acceder al validator del Form
  final keyForm = GlobalKey<FormState>();
  //acceder a la clase validator
  Validator validated = Validator();

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerPasswordRepeat = TextEditingController();
  HttpHelper helper = HttpHelper();

  bool mostrarCarga = false;

  @override
  void dispose() {
    _controllerName?.clear();
    _controllerEmail?.clear();
    _controllerPassword?.clear();
    _controllerPasswordRepeat.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            color: HexColor("#508D99"),
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Container(            
            child: WaveWidget(
              config: CustomConfig(
                gradients: [
                  [Colors.cyan[900],Colors.cyan[900]],
                  [Colors.cyan[900],Colors.cyan[900]],
                  [Colors.cyan[900], Colors.cyan[900]],
                  [HexColor("#508D99"),HexColor("#508D99")]
                ],
                durations: [35000, 19440, 10800, 6000],
                heightPercentages: [0.18, 0.45, 0.40, 0.30],
                blur: MaskFilter.blur(BlurStyle.solid, 5),
                gradientBegin: Alignment.bottomLeft,
                gradientEnd: Alignment.topRight,
              ),              
              waveAmplitude: 10,   
                  
              size: Size(
                double.infinity,
                double.infinity,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 128, top: 20),
            width: 150,
            height: 150,
            child: Image.asset(
              'assets/qenq.png',
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 150),
              child: Container(
                margin: EdgeInsets.only(top: 30),
                //padding: const EdgeInsets.only(top:30.0),
                child: Form(
                  key: keyForm,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50.0),
                        // padding: EdgeInsets.symmetric(
                        //     horizontal: 70.0, vertical: 30.0),
                        child: Text("Regístrate",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _nombreUsuario(
                        context,
                      ),
                      SizedBox(height: 10),
                      _emailUsuario(context),
                      SizedBox(height: 10),
                      _passwordUsuario(context),
                      SizedBox(height: 10),

                      //Repetir contraseña
                      _passwordRepeat(context),
                      SizedBox(height: 20),

                      //-----------Boton------------
                      SizedBox(
                        width: 350,
                        child: RaisedButton(
                          onPressed: () async {
                            setState(() {
                              mostrarCarga = true;
                            });
                            await _submit(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Text('Registrar'),
                          color: Theme.of(context).accentColor,
                          textColor: Colors.white,

                          //color: Theme.of(context),
                          //textColor: Colors.grey.shade800,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("¿Ya tienes cuenta? ",
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            GestureDetector(
                              child: Text(
                                " Ingresa ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, "login");
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          (mostrarCarga == false)
              ? Container()
              : Center(
                  child: CircularProgressIndicator(),
                )
        ],
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(duration: Duration(seconds: 2), content: new Text(value)));
  }

  Future _submit(BuildContext context) async {
    if (keyForm.currentState.validate()) {
      final res = await helper.registerUser(_controllerName.text,
          _controllerEmail.text, _controllerPassword.text);

      if (res == true) {
        String token = await HttpHelper()
            .iniciarSesion(_controllerEmail.text, _controllerPassword.text);

        Profile pro = await HttpHelper().consultarPerfil(
            _controllerEmail.text, _controllerPassword.text, token);
        //print("profile $pro");

        await Preferencias().saveIdUser(pro.id);
        // _scaffoldKey.currentState
        //     .showSnackBar(SnackBar(content: Text('Registro exitoso')));

        print('Processing Data');
        showInSnackBar("Usuario Registrado");
        Navigator.pushReplacementNamed(context, 'home');
      } else {
        print("Usuario no registrado");
        showInSnackBar("Credenciales incorrectas, vuelva a intentarlo");
      }
    }
    setState(() {
      mostrarCarga = false;
    });
  }

  Widget _passwordUsuario(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HexColor("#7DB2BC"),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
          controller: _controllerPassword,
          cursorColor: Colors.black,
          obscureText: true,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            fillColor: Theme.of(context).primaryColor,
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
          validator: (value) {
            //validated.validatePassword(value);
            if (value.isEmpty) {
              return 'El campo password no debe estar vacio';
            }
          }),
    );
  }

  Widget _passwordRepeat(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HexColor("#7DB2BC"),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
          controller: _controllerPasswordRepeat,
          cursorColor: Colors.black,
          obscureText: true,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            fillColor: Theme.of(context).primaryColor,
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.lock, color: Colors.white),
            ),
            hintText: "Repetir contraseña",
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            hintStyle: TextStyle(color: Colors.white),
          ),
          validator: (value) {
            //validated.validatePassword(value);
            if (value.isEmpty) {
              return 'El campo password no debe estar vacio';
            } else if (value != _controllerPassword.text) {
              return "Las contraseñas no coinciden";
            }
          }),
    );
  }

  Widget _emailUsuario(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HexColor("#7DB2BC"),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
          controller: _controllerEmail,
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            fillColor: Theme.of(context).primaryColor,
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.email, color: Colors.white),
            ),
            hintText: "Email",
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            hintStyle: TextStyle(color: Colors.white),
          ),
          validator: (value) {
            //validated.validateEmail(value);

            String pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regExp = RegExp(pattern);
            if (value.isEmpty) {
              return "El correo es necesario";
            } else if (!regExp.hasMatch(value)) {
              return "Ingrese un correo válido";
            } else {
              return null;
            }
          }),
    );
  }

  Widget _nombreUsuario(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HexColor("#7DB2BC"),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: _controllerName,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          fillColor: Theme.of(context).primaryColor,
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.people, color: Colors.white),
          ),
          hintText: "Nombre",
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          border:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          hintStyle: TextStyle(color: Colors.white),
        ),

        // validator: (value) {
        //   //validated.validateName(value);
        //   String pattern = r'(^[a-zA-Z ]*$)';
        //   RegExp regExp = RegExp(pattern);
        //   if (value.isEmpty) {
        //     return "El nombre es necesario";
        //   } else if (!regExp.hasMatch(value)) {
        //     return "El nombre debe de ser a-z y A-Z";
        //   }
        //   return null;
        // },
      ),
    );
  }
}
