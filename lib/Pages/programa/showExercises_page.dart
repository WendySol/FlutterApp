import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart' as log;
import 'package:proyecto_codigo/models/resResEvaProgram_model.dart' as evapro;
import 'package:proyecto_codigo/utils/httphelper.dart';
import 'package:proyecto_codigo/utils/preferences_user.dart';

class ShowExercisesPage extends StatefulWidget {
  evapro.Routine rutina;
  String idRutina;
  String idRuti;

  ShowExercisesPage(this.rutina);

  @override
  _ShowExercisesPageState createState() => _ShowExercisesPageState(this.rutina);
}

class _ShowExercisesPageState extends State<ShowExercisesPage> {
  log.Profile pro;
  String token;
  String idPro;

  @override
  void initState() {
    recuperarIdUser();
    super.initState();
  }

  void recuperarIdUser() async {
    idPro = await Preferencias().getIdUser();
    token = await Preferencias().getUserToken();

    log.Profile profileRecup =
        await HttpHelper().consultarUsuario(idPro, token);
    print(profileRecup);
    setState(() {
      pro = profileRecup;
    });
  }

  evapro.Routine rutina;
  String idRuti;
  String idRutina;
  _ShowExercisesPageState(this.rutina);

  @override
  Widget build(BuildContext context) {
    print(rutina);
    // return Scaffold(
    //   body: CustomScrollView(
    //     slivers: [
    //     SliverAppBar(
    //       title: Text("Qenqo",
    //           style: TextStyle(fontSize: 30, color: Colors.white)),

    //       centerTitle: true,
    //       expandedHeight: 220,

    //       toolbarHeight: 60,

    //       flexibleSpace: FlexibleSpaceBar(
    //         background: Image(
    //           image: AssetImage("assets/banner.jpg"),
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //      // flexibleSpace: _buildEjercicios(rutina: rutina, token: token),
    //     ),
    //     SliverList(
    //         delegate: SliverChildListDelegate([
    //       SizedBox(
    //         height: 25,
    //       ),
    //       SingleChildScrollView(child: _buildEjercicios(rutina: rutina, token: token)),
    //     ]))
    //   ]),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text("${rutina.name}"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
            future: HttpHelper().consultaEjercicios(rutina.id, token),
            builder: (context, snapshot) {
              List<evapro.Exercise> ejercicios = snapshot.data;
              if (snapshot.hasData) {
                return SingleChildScrollView(
                    child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 180),
                          child: Text("Lista de ejercicios",
                              style: TextStyle(fontSize: 20))),
                      SizedBox(
                        height: 25,
                      ),
                      //agregar column ... 
                      Container(    
                        height: 400,  
                        width: 500,                  
                        child: ListView.builder(
                          shrinkWrap: true,
                            itemCount: ejercicios.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: 20, left: 20, bottom: 30),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${ejercicios[index].name}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    //color: Theme.of(context).accentColor,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Tipo: ${ejercicios[index].type.toString().substring(ejercicios[index].type.toString().toString().indexOf('.')).toString().substring(1)}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                          Expanded(
                                              child: Image.network(
                                                  ejercicios[index].urlImage))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()
                  )
              );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _buildEjercicios extends StatelessWidget {
  const _buildEjercicios({
    Key key,
    @required this.rutina,
    @required this.token,
  }) : super(key: key);

  final evapro.Routine rutina;
  final String token;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HttpHelper().consultaEjercicios(rutina.id, token),
      builder: (context, snapshot) {
        List<evapro.Exercise> ejercicios = snapshot.data;
        if (snapshot.hasData) {
          return Container(
            width: 400,
            height: 600,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: ejercicios.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 20, left: 20, bottom: 30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${ejercicios[index].name}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        //color: Theme.of(context).accentColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Tipo: ${ejercicios[index].type.toString().substring(ejercicios[index].type.toString().toString().indexOf('.')).toString().substring(1)}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                              Container(
                                  width: 120,
                                  height: 120,
                                  child:
                                      Image.network(ejercicios[index].urlImage))
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
