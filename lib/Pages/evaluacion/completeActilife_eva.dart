import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart';
import 'package:proyecto_codigo/utils/httphelper.dart';
import 'package:proyecto_codigo/utils/preferences_user.dart';

class CompleteActilifePage extends StatefulWidget {
  CompleteActilifePage({Key key}) : super(key: key);

  @override
  _CompleteActilifePageState createState() => _CompleteActilifePageState();
}

class _CompleteActilifePageState extends State<CompleteActilifePage> {
  Profile pro;

  GlobalKey<FormState> keyForm = GlobalKey();

  TextEditingController _controllerEdad = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController _controllerAlt = TextEditingController();
  TextEditingController _controllerweight = TextEditingController();
  TextEditingController _controllerSexo = TextEditingController();
  TextEditingController _controllerphysical_activity = TextEditingController();
  TextEditingController _controllerWaist = TextEditingController();
  TextEditingController _controllerNeck = TextEditingController();

  TextEditingController _controllerNutritional_goal = TextEditingController();

  int dropdownOption = 1;
  int dropdownObjetivoFisico = 1;
  int dropdownActividadFisica;
  int dropdownObjetivoNutricional;
  int dropdownNivelDificultad = 1;
  int dropwDownSexo;
  int dropwDownEdad;
  int dropwDownAltura;
  int dropwDownPeso;

  String idPro;
  String token;
  String activiFisi;
  String sexo;

  bool mostrarCarga = false;

  void transformarActiFi(int value) {
    if (value == 1) {
      activiFisi = "Muy activo";
    }
    if (value == 2) {
      activiFisi = "Activo";
    }
    if (value == 3) {
      activiFisi = "Bajo";
    }
    if (value == 4) {
      activiFisi = "Sedentario";
    }
    setState(() {
      dropdownActividadFisica = value;
      print(activiFisi);
    });
  }

  void transformaSexo(int value) {
    if (value == 1) {
      sexo = "Hombre";
    }
    if (value == 2) {
      sexo = "Mujer";
    }

    setState(() {
      dropwDownSexo = value;
      print(sexo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(children: [
            Container(
              height: 120,
              width: 500,
              alignment: Alignment.center,
              color: Colors.cyan[900],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Container(
                height: 1000,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 310,
                      child: Text(
                        "¿Cúal es su actividad física?",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: _actividadFisica(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: _inputSexo(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: _edad(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: _altura(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: _peso(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: _cintura(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: _cuello(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    _buttonContinuar()
                  ],
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 50, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            // color: Colors.transparent,
                            // elevation: 0,
                            child: Icon(
                              Icons.arrow_back,
                              size: 25,
                              color: Colors.white,
                            ),
                            onTap: () async {
                              Navigator.popAndPushNamed(
                                  context, 'completeGoal');
                              setState(() {
                                print("pru");
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 100),
                            child: Text(
                              "Último paso",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  void recuperarIdUser() async {
    idPro = await Preferencias().getIdUser();
    token = await Preferencias().getUserToken();

    Profile profileRecup = await HttpHelper().consultarUsuario(idPro, token);
    print(profileRecup);
    setState(() {
      pro = profileRecup;
    });
  }

  Widget _actividadFisica() {
    return Container(
      width: 300,
      child: DropdownButton<int>(
          underline: Container(
            height: 1,
            color: Colors.cyan[900],
          ),
          isExpanded: true,
          iconEnabledColor: Colors.cyan[900],
          //valor con el que se muestra el dropdown
          value: dropdownActividadFisica,
          hint: Text("Actividad fisica"),
          items: [
            DropdownMenuItem(child: Text("Muy Activo"), value: 1),
            DropdownMenuItem(child: Text("Activo"), value: 2),
            DropdownMenuItem(child: Text("Bajo"), value: 3),
            DropdownMenuItem(child: Text("Sedentario"), value: 4),
          ],
          onChanged: (value) {
            transformarActiFi(value);
          }),
    );
  }

  Widget _inputSexo() {
    return Container(
      width: 300,
      child: DropdownButton<int>(
          underline: Container(
            height: 1,
            color: Colors.cyan[900],
          ),
          isExpanded: true,
          iconEnabledColor: Colors.cyan[900],
          //valor con el que se muestra el dropdown
          value: dropwDownSexo,
          hint: Text("Sexo"),
          items: [
            DropdownMenuItem(child: Text("Hombre"), value: 1),
            DropdownMenuItem(child: Text("Mujer"), value: 2),
          ],
          onChanged: (value) {
            transformaSexo(value);
          }),
    );
  }

  Widget _edad() {
    return Container(
      width: 300,
      child: TextFormField(
        controller: _controllerEdad,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: "Edad",
        ),
      ),
    );
  }

  Widget _cintura() {
    return Container(
      width: 300,
      child: TextFormField(
        controller: _controllerWaist,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: "Cintura",
        ),
      ),
    );
  }

  Widget _cuello() {
    return Container(
      width: 300,
      child: TextFormField(
        controller: _controllerNeck,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: "Cuello",
        ),
      ),
    );
  }

  Widget _peso() {
    return Container(
      width: 300,
      child: TextFormField(
        controller: _controllerweight,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: "Peso",
        ),
      ),
    );
  }

  Widget _altura() {
    return Container(
      width: 300,
      child: TextFormField(
        controller: _controllerAlt,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: "Altura",
        ),
      ),
    );
  }

  Widget _buttonContinuar() {
    return SizedBox(
      width: 300,
      height: 49,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: EdgeInsets.all(0.0),
        child: Text(
          'Continuar',
          style: TextStyle(fontSize: 19),
        ),
        color: Theme.of(context).accentColor,
        textColor: Colors.white,
        onPressed: () {
          setState(() {
            mostrarCarga = true;
          });
          _enviar();
        },
      ),
    );
  }

  void _enviar() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        'resultadoEvaluacion', (Route<dynamic> route) => false);
      if (keyForm.currentState.validate()) {
        print(idPro);       
        print(double.parse(_controllerAlt.text));
        print(double.parse(_controllerEdad.text));
        print("sexo" +sexo);
        print("activi" + activiFisi);
        print(double.parse(_controllerWaist.text));
        print(double.parse(_controllerNeck.text));
         print(double.parse(_controllerNeck.text));
         //objetivo nutricional
         //objetivo fisico

         print(token);

    // HttpHelper().completarEvaluacion(
    //   idPro,
    //   double.parse(_controllerAlt.text),
    //   double.parse(_controllerEdad.text),
    //   sexo,
    //   activiFisi,
    //   double.parse(_controllerWaist.text),
    //   double.parse(_controllerNeck.text),
    //   int.parse(_controllerEdad.text),
    //   "Aumentar de peso",
    //   token
    // );

    setState(() {
      mostrarCarga = false;
    });

    keyForm.currentState.reset();
  }
  }
}
// String idProfile
// double altura
// double peso
// String sexo
// String actividadF
// double cintura
// double cuello
// int edad
// String objetivoNutri
// String token
