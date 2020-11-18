import 'package:flutter/material.dart';
import 'package:proyecto_codigo/Pages/evaluacion/shoResultEvaluation.dart';
import 'package:proyecto_codigo/Pages/usuario/edit_profile_page.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart';
import 'package:proyecto_codigo/models/resResEvaProgram_model.dart';
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
    print(idPro);
    return new FutureBuilder<Profile>(
        future: HttpHelper().consultarUsuario(idPro, token),
        builder: (BuildContext context, AsyncSnapshot<Profile> snapshot) {
          if (snapshot.hasData) {
          Profile profileRecup = snapshot.data;
           // Evaluation evaRecup = snapshot.data;
            return Scaffold(
              body: Stack(
                children: [
                 // Container(color: Colors.blueGrey[400]),
                  infoProfile(context, profileRecup),
                  publisProfile(context),
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget infoProfile(BuildContext context, Profile profileRecup) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(50),
        bottomRight: Radius.circular(50),
      ),
      child: Container(
        height: 280,
        width: 500,
        color: Colors.cyan[900],
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.cyan[900],
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditProfilePage(profileRecup)),
                          );
                        },
                        child: Icon(Icons.edit, color: Colors.white))
                  ],
                ),
                SizedBox(height: 25),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image(
                                image: AssetImage("assets/perfil.jpg"),
                                fit: BoxFit.fitHeight,
                                height: 90,
                                width: 90,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "${profileRecup.name}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
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
                                  SizedBox(width: 20),
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
                                ],
                              ),
                              SizedBox(height: 30),
                              Container(
                                  height: 40.0,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  margin: EdgeInsets.only(top: 15.0),
                                  child: RaisedButton(
                                    onPressed: () {},
                                    color: Colors.orange,
                                    child: Text("Seguir",
                                        style: TextStyle(color: Colors.white)),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ))
                            ],
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
    return Container(
      
      child: FutureBuilder<Profile>(
          future: HttpHelper().consultarUsuario(idPro, token), //aqui se consultara al usuario y traera su info, esperar Renato//TODO
          builder: (BuildContext context, AsyncSnapshot<Profile> snapshot) {
            if (snapshot.hasData) {
              Profile profileRecup = snapshot.data;
              
              return Padding(
                padding: const EdgeInsets.only(left:30,top:300),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 180),
                      child: Text("Resumen de Evaluación",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.black)),
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
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      width: 320,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "IMC",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "23",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Descripción",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Normal",
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
                      padding: EdgeInsets.only(right: 200),
                      child: Text("Mis Requerimientos",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.black)),
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
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      width: 320,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Calorias Diarias",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "200",
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
                      padding: EdgeInsets.only(right: 200),
                      child: Text("Mis Macronutrientes",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.black)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 320,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ]),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    /* CustomRadialProgress(porcentaje: porcentajeProte, color: Colors.greenAccent,tipomacro: 'Proteinas',),//proteinas
                            CustomRadialProgress(porcentaje: porcentajeCarbo, color: Colors.greenAccent[200],tipomacro: 'Carbohidratos',),
                            CustomRadialProgress(porcentaje: porcentajeGrasa, color: Colors.greenAccent[100],tipomacro: 'Grasa',),  //carbohidratos */
                                    Column(
                                      children: [
                                        CustomRadialProgress(
                                            porcentaje: 100.0,
                                            cantidad: 20,
                                            color: Colors.white),
                                        Text("Proteinas"),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        CustomRadialProgress(
                                            porcentaje: 100.0,
                                            cantidad: 20,
                                            color: Colors.white),
                                        Text("Carbohidratos"),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        CustomRadialProgress(
                                            porcentaje: 100.0,
                                            cantidad: 20,
                                            color: Colors.white),
                                        Text("Grasas"),
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
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
