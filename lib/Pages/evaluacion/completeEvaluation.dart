import 'package:flutter/material.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart';
import 'package:proyecto_codigo/utils/httphelper.dart';
import 'package:proyecto_codigo/utils/preferences_user.dart';

//import 'package:decimal/decimal.dart';

class CompleteEvaluation extends StatefulWidget {
  Profile pro;
  CompleteEvaluation(this.pro);

  @override
  _CompleteEvaluationState createState() => _CompleteEvaluationState(this.pro);
}

class _CompleteEvaluationState extends State<CompleteEvaluation> {
  Profile pro;
  _CompleteEvaluationState(this.pro);

  GlobalKey<FormState> keyForm = GlobalKey();

  final _controllerPeso = TextEditingController();
  final _controllerTalla = TextEditingController();

  //final d = Decimal;

  //Dropdown opciones:
  int dropdownOption = 1;
  int dropdownObjetivoFisico = 1;
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

  @override
  void initState() {
    recuperarIdUser();
    super.initState();
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

  void recuperarIdUser() async {
    idPro = await Preferencias().getIdUser();
    token = await Preferencias().getUserToken();

    Profile profileRecup = await HttpHelper().consultarUsuario(idPro, token);
    print(profileRecup);
    setState(() {
      pro = profileRecup;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(pro);
    return Scaffold(
      appBar: AppBar(
        title: Text('Evaluación Integral'),
      ),
      body: Stack(children: [
        FutureBuilder(
            future: HttpHelper().consultarUsuario(idPro, token),
            builder: (BuildContext context, AsyncSnapshot<Profile> snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                child: Container(
                  //width: 700,
                  child: Form(
                    key: keyForm,
                    child: Container(
                      //width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: [
                            Text(
                              "Hola ${pro.name},completa la siguiente evaluación para brindarte un programa más personalizado",
                              style: TextStyle(
                                  fontSize: 15,
                                  //color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 15),
                            _peso(),
                            SizedBox(height: 15),
                            _estatura(),
                            SizedBox(height: 15),
                            _genero(),
                            SizedBox(height: 15),
                            _actividadFisica(),
                            SizedBox(height: 15),
                            _edad(),
                            SizedBox(height: 15),
                            _cintura(),
                            SizedBox(height: 15),
                            _cuello(),
                            SizedBox(height: 15),
                            _objetivonutri(),
                            SizedBox(height: 15),
                            _objetivofisico(),
                            SizedBox(height: 15),
                            _buttonRegister()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );            
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ]),
    );
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  int gender = 1;

  Widget _edad() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Edad"),
        Container(
          width: 210,
          child: DropdownButton(
              underline: Container(
                height: 1,
                color: Colors.cyan[900],
              ),
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down),
              value: edad,
              items: [
                DropdownMenuItem(child: Text("18"), value: 1),
                DropdownMenuItem(child: Text("19"), value: 2),
                DropdownMenuItem(child: Text("20"), value: 3),
                DropdownMenuItem(child: Text("21"), value: 4),
                DropdownMenuItem(child: Text("22"), value: 5),
                DropdownMenuItem(child: Text("23"), value: 6),
                DropdownMenuItem(child: Text("24"), value: 7),
                DropdownMenuItem(child: Text("25"), value: 8),
                DropdownMenuItem(child: Text("26"), value: 9),
                DropdownMenuItem(child: Text("27"), value: 10),
                DropdownMenuItem(child: Text("28"), value: 11),
                DropdownMenuItem(child: Text("29"), value: 12),
                DropdownMenuItem(child: Text("30"), value: 13),
              ],
              onChanged: (value) {
                String clave;
                setState(() {
                  edad = value;
                });
              }),
        ),
      ],
    );
  }

  Widget _cintura() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Cintura"),
        Container(
            width: 210,
            child: DropdownButton(
                underline: Container(
                  height: 1,
                  color: Colors.cyan[900],
                ),
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down),
                value: cmCintura,
                items: [
                  DropdownMenuItem(child: Text("60 cm - 67 cm"), value: 1),
                  DropdownMenuItem(child: Text("68 cm - 75 cm"), value: 2),
                  DropdownMenuItem(child: Text("76 cm - 83 cm"), value: 3),
                  DropdownMenuItem(child: Text("84 cm - 91 cm"), value: 4),
                ],
                onChanged: (value) {
                  setState(() {
                    cmCintura = value;
                  });
                })),
      ],
    );
  }

  Widget _cuello() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Cuello"),
        Container(
          width: 210,
          child: Expanded(
            child: DropdownButton(
                underline: Container(
                  height: 1,
                  color: Colors.cyan[900],
                ),
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down),
                value: cmCuello,
                items: [
                  DropdownMenuItem(child: Text("37 cm - 38 cm"), value: 1),
                  DropdownMenuItem(child: Text("39 cm - 40 cm"), value: 2),
                  DropdownMenuItem(child: Text("41 cm - 42 cm"), value: 3),
                  DropdownMenuItem(child: Text("43 cm - 44 cm"), value: 4),
                  DropdownMenuItem(child: Text("45 cm - 46 cm"), value: 5),
                ],
                onChanged: (value) {
                  setState(() {
                    cmCuello = value;
                  });
                }),
          ),
        )
      ],
    );
  }

  Widget _genero() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Género'),
        Container(
          width: 210,
          child: DropdownButton(
              underline: Container(
                height: 1,
                color: Colors.cyan[900],
              ),
              hint: Text("Género"),
              isExpanded: true,
              value: gender,
              items: [
                DropdownMenuItem(child: Text("Hombre"), value: 1),
                DropdownMenuItem(child: Text("Mujer"), value: 2),
              ],
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              }),
        ),
      ],
    );
  }

  Widget _estatura() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Altura"),
        Container(
          width: 210,
          child: DropdownButton(
              underline: Container(
                height: 1,
                color: Colors.cyan[900],
              ),
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down),
              value: altura,
              items: [
                DropdownMenuItem(child: Text("1.60"), value: 1),
                DropdownMenuItem(child: Text("1.61"), value: 2),
                DropdownMenuItem(child: Text("1.62"), value: 3),
                DropdownMenuItem(child: Text("1.63"), value: 4),
                DropdownMenuItem(child: Text("1.64"), value: 5),
                DropdownMenuItem(child: Text("1.65"), value: 6),
                DropdownMenuItem(child: Text("1.66"), value: 7),
                DropdownMenuItem(child: Text("1.67"), value: 8),
                DropdownMenuItem(child: Text("1.68"), value: 9),
                DropdownMenuItem(child: Text("1.69"), value: 10),
                DropdownMenuItem(child: Text("1.70"), value: 11),
                DropdownMenuItem(child: Text("1.71"), value: 12),
                DropdownMenuItem(child: Text("1.72"), value: 13),
                DropdownMenuItem(child: Text("1.73"), value: 14),
                DropdownMenuItem(child: Text("1.74"), value: 15),
                DropdownMenuItem(child: Text("1.75"), value: 16),
                DropdownMenuItem(child: Text("1.76"), value: 17),
                DropdownMenuItem(child: Text("1.77"), value: 18),
                DropdownMenuItem(child: Text("1.78"), value: 19),
                DropdownMenuItem(child: Text("1.79"), value: 20),
                DropdownMenuItem(child: Text("1.80"), value: 21),
                DropdownMenuItem(child: Text("1.81"), value: 22),
                DropdownMenuItem(child: Text("1.82"), value: 23),
              ],
              onChanged: (value) {
                setState(() {
                  altura = value;
                });
              }),
        ),
      ],
    );
  }

  Widget _peso() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Peso"),
        Container(
          width: 210,
          child: DropdownButton(
              underline: Container(
                height: 1,
                color: Colors.cyan[900],
              ),
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down),
              value: peso,
              items: [
                DropdownMenuItem(child: Text("50"), value: 1),
                DropdownMenuItem(child: Text("51"), value: 2),
                DropdownMenuItem(child: Text("52"), value: 3),
                DropdownMenuItem(child: Text("53"), value: 4),
                DropdownMenuItem(child: Text("54"), value: 5),
                DropdownMenuItem(child: Text("55"), value: 6),
                DropdownMenuItem(child: Text("56"), value: 7),
                DropdownMenuItem(child: Text("57"), value: 8),
                DropdownMenuItem(child: Text("58"), value: 9),
                DropdownMenuItem(child: Text("59"), value: 10),
                DropdownMenuItem(child: Text("60"), value: 11),
                DropdownMenuItem(child: Text("61"), value: 12),
                DropdownMenuItem(child: Text("62"), value: 13),
                DropdownMenuItem(child: Text("63"), value: 14),
                DropdownMenuItem(child: Text("64"), value: 15),
                DropdownMenuItem(child: Text("65"), value: 16),
                DropdownMenuItem(child: Text("66"), value: 17),
                DropdownMenuItem(child: Text("67"), value: 18),
                DropdownMenuItem(child: Text("68"), value: 19),
                DropdownMenuItem(child: Text("69"), value: 20),
                DropdownMenuItem(child: Text("70"), value: 21),
                DropdownMenuItem(child: Text("71"), value: 22),
                DropdownMenuItem(child: Text("72"), value: 23),
                DropdownMenuItem(child: Text("73"), value: 24),
                DropdownMenuItem(child: Text("74"), value: 25),
                DropdownMenuItem(child: Text("75"), value: 26),
                DropdownMenuItem(child: Text("76"), value: 27),
                DropdownMenuItem(child: Text("77"), value: 28),
              ],
              onChanged: (value) {
                setState(() {
                  peso = value;
                });
              }),
        ),
      ],
    );
  }

  Widget _objetivonutri() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Objetivo Nutricional'),
        Container(
          width: 210,
          child: DropdownButton<int>(
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
        )
      ],
    );
  }

  Widget _objetivofisico() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Objetivo fisico'),
        Container(
          width: 210,
          child: DropdownButton<int>(
              underline: Container(
                height: 1,
                color: Colors.cyan[900],
              ),
              isExpanded: true,
              //hint: Text("Seleccione una opcion"),
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
                  child: Text("Aumentar masa muscular"),
                  value: 3,
                ),
              ],
              onChanged: (newvalue) {
                setState(() {
                  dropdownObjetivoFisico = newvalue;
                });
              }),
        )
      ],
    );
  }

  Widget _actividadFisica() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Actividad ',
        ),
        Container(
          width: 210,
          child: DropdownButton<int>(
              underline: Container(
                height: 1,
                color: Colors.cyan[900],
              ),
              isExpanded: true,
              //valor con el que se muestra el dropdown
              value: dropdownActividadFisica,
              items: [
                DropdownMenuItem(child: Text("Muy Activo"), value: 1),
                DropdownMenuItem(child: Text("Activo"), value: 2),
                DropdownMenuItem(child: Text("Bajo"), value: 3),
                DropdownMenuItem(child: Text("Sedentario"), value: 4),
              ],
              onChanged: (value) {
                setState(() {
                  dropdownActividadFisica = value;
                });
              }),
        )
      ],
    );
  }

  Widget _buttonRegister() {
    return SizedBox(
      width: 350,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: EdgeInsets.all(0.0),
        child: Text('Registrar'),
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
    if (keyForm.currentState.validate()) {
      // print(idPro);
      // print(token);
      // print("obj nutri" + objNu);
      // print("altura" + altura.toString());
      // print("edad" + edad.toString());
      // print("peso" + peso.toString());
      // print("cintu" + cmCintura.toString());
      // print("cuello" + cmCuello.toString());

      HttpHelper().completarEvaluacion(idPro, 1.60, 50, "Hombre", "Sedentario",
          30, 22, 24, "Aumentar de peso", token);
      setState(() {
        mostrarCarga = false;
      });

      Navigator.pushReplacementNamed(context, 'resultadoEvaluacion');

      keyForm.currentState.reset();
    }
  }
}
