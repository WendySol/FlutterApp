import 'package:flutter/material.dart';

import 'package:proyecto_codigo/Pages/usuario/edit_profile_page.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart';
import 'package:proyecto_codigo/models/resResEvaProgram_model.dart';

import 'package:proyecto_codigo/utils/customRdial.dart';
import 'package:proyecto_codigo/utils/httphelper.dart';
import 'package:proyecto_codigo/utils/preferences_user.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  Profile pro;
  // ResRecoveryProfile profileRecup;
  String idPro;

  ProfilePage(this.pro);

  @override
  _ProfilePageState createState() => _ProfilePageState(this.pro);
}

class _ProfilePageState extends State<ProfilePage> {
  Profile pro;

  String idPro;
  String token;
  bool esNull = false;

  _ProfilePageState(this.pro);

  @override
  void initState() {
    recuperarPro();
    super.initState();
  }

  void recuperarPro() async {
    String id = await Preferencias().getIdUser();
    token = await Preferencias().getUserToken();

    Profile profileRecup = await HttpHelper().consultarUsuario(id, token);
    print(profileRecup.followers);

    if (profileRecup.followers == null) {
      esNull = true;
    }

    setState(() {
      idPro = profileRecup.id;
      esNull = esNull;
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(idPro);
    return new FutureBuilder<Profile>(
        future: HttpHelper().consultarUsuario(idPro, token),
        builder: (BuildContext context, AsyncSnapshot<Profile> snapshot) {
          if (snapshot.hasData) {
            Profile profileRecup = snapshot.data;
            // Evaluation evaRecup = snapshot.data;
            return Scaffold(
              body: Stack(
                children: [
                   Container(
                    height: 225,
                    width: 500,
                    alignment: Alignment.center,
                    color: Colors.cyan[900],
                  ),
                  publisProfile(context),
                  infoProfile(context, profileRecup),
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }

  Widget infoProfile(BuildContext context, Profile profileRecup) {
    return ClipRRect(
      child: Container(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Icon(Icons.edit, color: Colors.white),
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditProfilePage(profileRecup)),
                        );
                      },
                    ),
                    SizedBox(width: 25),
                  ],
                ),
                SizedBox(height: 15),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 40, left: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "${profileRecup.name}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ClipOval(
                                child: Image(
                                  image: AssetImage("assets/sinperfil.png"),
                                  fit: BoxFit.fitHeight,
                                  height: 128,
                                  width: 128,
                                ),
                              ),
                              
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "${profileRecup.followers}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Seguidores",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 25),
                                Column(
                                  children: [
                                    Text(
                                      "${profileRecup.followers}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Siguiendo",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30),

                                // Container(
                                //   width: 120,
                                //     height: 49,
                                //     padding:
                                //         EdgeInsets.symmetric(horizontal: 15.0),
                                //     margin: EdgeInsets.only(top: 15.0),
                                //     child: RaisedButton(
                                //       onPressed: () {},
                                //       color: Colors.orange,
                                //       child: Text("Seguir",
                                //           style: TextStyle(color: Colors.white,fontSize: 15)),
                                //       shape: RoundedRectangleBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(10.0)),
                                //     ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget publisProfile(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
            color: Colors.white,
          ),
          child: Column(
            children: [
            FutureBuilder<Evaluation>(
                future: HttpHelper().consultaEvaluation(idPro, token),
                builder:
                    (BuildContext context, AsyncSnapshot<Evaluation> snapshot) {
                  if (snapshot.hasData) {
                    Evaluation evaRecup = snapshot.data;
                    print(evaRecup);
                    return Container(
                      padding: EdgeInsets.only(top: 50),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              
                              child: Text("Resumen de Evaluación",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 19)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 0.5,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ]),
                              width: 320,
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "IMC",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "${evaRecup.imcResult}",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Objetivo",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "${evaRecup.physicalObjective}",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Grasa Corporal",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "${evaRecup.corporalGrease.toString().substring(1, 3)} %",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Masa Magra",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "${evaRecup.corporalLeanMass.toString().substring(1, 3)} %",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Text("Mis Requerimientos",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 19)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 0.5,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ]),
                              width: 320,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Calorias Diarias",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "${evaRecup.caloriesRecommended.round()}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Text("Mis Macronutrientes",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 19)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 320,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 0.5,
                                            blurRadius: 5,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ]),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Column(
                                              children: [
                                                CustomRadialProgress(
                                                    porcentaje: 100.0,
                                                    cantidad: 20,
                                                    color: Colors.white),
                                                Text("Proteinas"),
                                                Text("(Gramos)"),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                CustomRadialProgress(
                                                    porcentaje: 100.0,
                                                    cantidad: evaRecup
                                                        .carbohydratesGrams
                                                        .round()
                                                        .toDouble(),
                                                    color: Colors.white),
                                                Text("Carbohidratos"),
                                                Text("(Gramos)"),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                CustomRadialProgress(
                                                    porcentaje: 100.0,
                                                    cantidad: evaRecup.greaseGrams
                                                        .round()
                                                        .toDouble(),
                                                    color: Colors.white),
                                                Text("Grasas"),
                                                Text("(Gramos)"),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Padding(
                  padding: const EdgeInsets.only(top:120),
                  child: Card(
                    child: Container(
                      height: 180,
                      //width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            "Ups! Parece que aún no completas tu evaluación",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 200,
                            child: Text(
                              "Para visualizar tus resultados debes completar tu evaluación",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: 25),
                          Container(
                            width: 250,
                            height: 49,
                            child: Icon(Icons.adb)
                          ),
                        ],
                      ),
                    ),
                  ),
                );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(top: 470),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                }),
          ]),
        ),
      ),
    );
  }
}
