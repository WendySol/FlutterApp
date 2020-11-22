import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart';
import 'package:proyecto_codigo/provider/user_provider.dart';
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
            // color: HexColor("#508D99"),
            color: Colors.cyan[900],
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          // Container(
          //   child: WaveWidget(
          //     config: CustomConfig(
          //       gradients: [
          //         [Colors.cyan[900],Colors.cyan[900]],
          //         [Colors.cyan[900],Colors.cyan[900]],
          //         [Colors.cyan[900], Colors.cyan[900]],
          //         [HexColor("#508D99"),HexColor("#508D99")]
          //       ],
          //       durations: [35000, 19440, 10800, 6000],
          //       heightPercentages: [0.18, 0.45, 0.40, 0.30],
          //       blur: MaskFilter.blur(BlurStyle.solid, 5),
          //       gradientBegin: Alignment.bottomLeft,
          //       gradientEnd: Alignment.topRight,
          //     ),
          //     waveAmplitude: 10,

          //     size: Size(
          //       double.infinity,
          //       double.infinity,
          //     ),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(left: 150, top: 70),
            width: 100,
            height: 100,
            child: Image.asset(
              'assets/orig.png',
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 150),
              child: Container(
                margin: EdgeInsets.only(top: 10),
                //padding: const EdgeInsets.only(top:30.0),
                child: Form(
                  key: keyForm,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40.0),
                        // padding: EdgeInsets.symmetric(
                        //     horizontal: 70.0, vertical: 30.0),
                        child: Text("¡ Regístrate con todo el poder !",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      _nombreUsuario(
                        context,
                      ),
                      SizedBox(height: 20),
                      _emailUsuario(context),
                      SizedBox(height: 20),
                      _passwordUsuario(context),
                      SizedBox(height: 20),

                      //Repetir contraseña
                      _passwordRepeat(context),
                      SizedBox(height: 40),

                      //-----------Boton------------
                      SizedBox(
                        width: 350,
                        height: 48,
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
                          child: Text('Registrar',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19)),
                          color: HexColor("#F29E38"),
                          textColor: Colors.white,

                          //color: Theme.of(context),
                          //textColor: Colors.grey.shade800,
                        ),
                      ),
                      SizedBox(
                        height: 40,
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

        // await Preferencias().saveIdUser(pro.id);
        // _scaffoldKey.currentState
        //     .showSnackBar(SnackBar(content: Text('Registro exitoso')));
        if (pro != null) {
          print("profile $pro");
          await  Preferencias().saveUserToken(token);
          await Preferencias().saveIdUser(pro.id);

          Navigator.pushReplacementNamed(context, 'home');
        } else {
          print("Error de carga");
          showInSnackBar("Error de carga, vuelva intentar");
        }
        print('Processing Data');
        showInSnackBar("Usuario Registrado");
        
      } 
      else {
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
        color: HexColor("#336E7A"),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
          controller: _controllerPassword,
          cursorColor: Colors.white,
          obscureText: true,
          style: TextStyle(color: Colors.white),
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
        color: HexColor("#336E7A"),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
          controller: _controllerPasswordRepeat,
          cursorColor: Colors.white,
          obscureText: true,
          style: TextStyle(color: Colors.white),
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
        color: HexColor("#336E7A"),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
          controller: _controllerEmail,
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
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
        color: HexColor("#336E7A"),
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
            child: Icon(Icons.person, color: Colors.white),
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
