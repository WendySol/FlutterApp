import 'package:flutter/material.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart';
import 'package:proyecto_codigo/utils/httphelper.dart';
import 'package:proyecto_codigo/utils/preferences_user.dart';

class CompleteGoalEvaluationPage extends StatefulWidget {
  CompleteGoalEvaluationPage({Key key}) : super(key: key);

  @override
  _CompleteGoalEvaluationPageState createState() =>
      _CompleteGoalEvaluationPageState();
}

class _CompleteGoalEvaluationPageState
    extends State<CompleteGoalEvaluationPage> {
  Profile pro;

  GlobalKey<FormState> keyForm = GlobalKey();

  final _controllerPeso = TextEditingController();
  final _controllerTalla = TextEditingController();

  //final d = Decimal;

  //Dropdown opciones:
  int dropdownOption = 1;
  int dropdownObjetivoFisico;
  int dropdownActividadFisica = 1;
  int dropdownNivelDificultad = 1;

  String idPro;
  String token;

  int objNutricional;
  int altura;
  int edad;
  int peso;

  int cmCintura;
  int cmCadera;
  int cmCuello;
  int cmMuneca;
  String objNu;

  bool mostrarCarga = false;

  void recuperarIdUser() async {
    idPro = await Preferencias().getIdUser();
    token = await Preferencias().getUserToken();

    Profile profileRecup = await HttpHelper().consultarUsuario(idPro, token);
    print(profileRecup);
    setState(() {
      pro = profileRecup;
    });
  }

  void transformaObjNut(int value) {
    if (value == 1) {
      objNu = "Bajar de peso";
    }
    if (value == 2) {
      objNu = "Tonificar";
    }
    if (value == 3) {
      objNu = "Aumentar musculacion";
    }
    setState(() {
      objNutricional = value;
      print(objNu);
    });
  }

  void transformaEdad(int value) {
    if (value == 1) {
      objNu = "Bajar de peso";
    }
    if (value == 2) {
      objNu = "Tonificar";
    }
    if (value == 3) {
      objNu = "Aumentar musculacion";
    }
    setState(() {
      objNutricional = value;
      print(objNu);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              height: 1000,
              width: 500,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                          width: 310,
                          child: Text(
                            "Selecciona tus objetivos con todo el poder",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: _objetivonutri(),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: _objetivofisico(),
                  ),
                  SizedBox(
                    height: 150,
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
                        Navigator.pop(context, 'home');
                        setState(() {
                          print("pru");
                        });
                      },
                    ),
                    Text(
                      "Vamos a preparar tu programa",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget _objetivonutri() {
    Product product;
    return Container(
      width: 300,
      child: DropdownButton<int>(
         iconEnabledColor: Colors.cyan[900],
         iconSize: 30,
         icon: Icon(Icons.arrow_drop_down),
        iconDisabledColor: Colors.white,
          hint: Text("Objetivo Nutricional"),
          underline: Container(
            height: 1,
            color: Colors.cyan[900],
          ),
          isExpanded: true,
          //hint: Text("Seleccione una opcion"),
          value: objNutricional,
          items: [
            DropdownMenuItem(child: Text("Bajar de Peso"), value: 1),
            DropdownMenuItem(child: Text("Tonificar"), value: 2),
            DropdownMenuItem(child: Text("Aumentar musculación"), value: 3)
          ],
          onChanged: (newvalue) {
            transformaObjNut(newvalue);
          }),
      // child: ListTile(
      //   title: Row(children: [
      //     Expanded(child: new Text("HOla")),
      //     Checkbox(
      //       value: product.isCheck,
      //         onChanged: (bool value) {
      //           setState(() {
      //             product.isCheck = value;
      //           });
      //         }),
      //   ]),
      // ),
    );
  }

  Widget _objetivofisico() {
    return Container(
      width: 300,
      child: DropdownButton<int>(
          underline: Container(
            height: 1,
            color: Colors.cyan[900],
          ),
          iconEnabledColor: Colors.cyan[900],
         iconSize: 30,
         icon: Icon(Icons.arrow_drop_down),
          isExpanded: true,
          hint: Text("Objetivo Físico"),
          value: dropdownObjetivoFisico,
          items: [
            DropdownMenuItem(
              child: Text("Aumentar Resistencia"),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text("Aumentar Fuerza"),
              value: 2,
            ),
            DropdownMenuItem(
              child: Text("Aumentar Musculación"),
              value: 3,
            ),
          ],
          onChanged: (newvalue) {
            setState(() {
              dropdownObjetivoFisico = newvalue;
            });
          }),
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
    Navigator.pushReplacementNamed(context, 'completeActivelife');

    // if (keyForm.currentState.validate()) {
    //   // print(idPro);
    //   // print(token);
    //   // print("obj nutri" + objNu);
    //   // print("altura" + altura.toString());
    //   // print("edad" + edad.toString());
    //   // print("peso" + peso.toString());
    //   // print("cintu" + cmCintura.toString());
    //   // print("cuello" + cmCuello.toString());

    //   //  HttpHelper().completarEvaluacion(idPro, 1.60, 50, "Hombre", "Sedentario",
    //   //    30, 22, 24, "Aumentar de peso", token);

    //   setState(() {
    //     mostrarCarga = false;
    //   });

    //   keyForm.currentState.reset();
    // }
  }
}

class Product {
  String name;
  bool isCheck = false;
  Product(this.name, this.isCheck);
}
