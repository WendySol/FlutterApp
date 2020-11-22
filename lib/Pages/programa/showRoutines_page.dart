import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:proyecto_codigo/Pages/programa/showExercises_page.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart';
import 'package:proyecto_codigo/models/resResEvaProgram_model.dart';
import 'package:proyecto_codigo/utils/httphelper.dart';
import 'package:proyecto_codigo/utils/preferences_user.dart';

class ShowRoutinesPage extends StatefulWidget {
  Profile pro;
  // ResRecoveryProfile profileRecup;
  String idPro;
  ShowRoutinesPage(this.pro);

  @override
  _ShowRoutinesPageState createState() => _ShowRoutinesPageState(this.pro);
}

class _ShowRoutinesPageState extends State<ShowRoutinesPage> {
  Profile pro;
  _ShowRoutinesPageState(this.pro);

  List<String> image = [
    "assets/brazos.jpg",
    "assets/piernas.jpg",
    "assets/abdomene.jpg",
    "assets/glut.jpg",
    "assets/full.jpeg"
  ];

  List<String> listDias = [
    "Lunes",
    "Martes",
    "Miercoles",
    "Jueves",
    "Viernes",
    "Sabado",
    "Domingo"
  ];
  List<String> listfechas = ["12", "13", "14", "15", "16", "17", "18"];

  List<String> listImage = [
    "assets/brazos.jpg",
    "assets/piernas.jpg",
    "assets/abdomene.jpg",
    "assets/glut.jpg",
    "assets/full.jpeg"
  ];

  int isSelected =
      -1; // changed bool to int and set value to -1 on first time if you don't select anything otherwise set 0 to set first one as selected.

  _isSelected(int index) {
    //pass the selected index to here and set to 'isSelected'
    setState(() {
      isSelected = index;
    });
  }

  @override
  void initState() {
    recuperarPro();
    super.initState();
  }

  String idPro;
  String token;
  bool esNull = false;

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      // body: CustomScrollView(
      //   slivers: [
      //     _appBar(),
      //    // _listHorizontal("Pecho", image[0], "250 kcal")    ,
      //     //_gridRoutines(),
      //   ],
      // ),

      body: Container(
        child: Stack(
          children: [
            Container(
              height: 250,
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                        width: 310,
                        child: Text(
                          "Hoy te toca realizar esta rutina física",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    // Container(
                    //   child: _listDias(),
                    // ),
                    _buildRutinas(idPro: idPro, token: token),
                  ],
                ),
              ),
            ),
            
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    "Mi Programa",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _listDias() {
    return Container(
      height: 140,
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listDias.length,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                width: 85,
                height: 90,
                child: GestureDetector(
                  onTap: () {
                    _isSelected(i);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: isSelected != null && isSelected == i ? 5 : 1,
                    color: isSelected != null &&
                            isSelected ==
                                i //set condition like this. voila! if isSelected and list index matches it will colored as white else orange.
                        ? Colors.orangeAccent
                        : Colors.cyan[900],
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          listDias[i].substring(0, 3),
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                            child: Text(listfechas[i],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)))
                      ],
                    ),
                  ),
                ),
              ); //Card(child: Text("data"),);
            },
          )),
    );
  }

  Widget _gridRoutines() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //espacio  horizontal entre las grillas
        crossAxisSpacing: 0,
        //espacio vertical entre las grillas
        mainAxisSpacing: 0,
        //tamaño horizontal de las grillas
        maxCrossAxisExtent: 300,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "programaEjercicios");
              },
              child: Card(
                //margin: EdgeInsets.only(top: 10,left: 10, right: 10),

                color: Theme.of(context).dividerColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        listDias[index],
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                          child: Image(
                        image: AssetImage(listImage[index % listImage.length]),
                        fit: BoxFit.cover,
                      )),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        childCount: listDias.length,
      ),
    );
  }

  Widget _appBar() {
    return SliverAppBar(
        title: Text("Mi Programa",
            style: TextStyle(fontSize: 30, color: Colors.white)),
        centerTitle: true,
        expandedHeight: 200,
        pinned: true,
        backgroundColor: Colors.cyan[800],
        toolbarHeight: 60,
        //leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/program1.jpg"),
                    fit: BoxFit.cover)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Container(
                decoration:
                    BoxDecoration(color: Colors.black.withOpacity(0.25)),
              ),
            ),
          ),
        ));
  }
}

class _buildRutinas extends StatelessWidget {
  const _buildRutinas({
    Key key,
    @required this.idPro,
    @required this.token,
  }) : super(key: key);

  final String idPro;
  final String token;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder(
            future: HttpHelper().consultaRutinasdePrograma(idPro, token),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Routine> listRouti = snapshot.data;

                return Container(
                    width: double.infinity,
                    child: Container(
                      height: 80,
                      width: double.infinity,
                      margin: EdgeInsets.only(right: 20, left: 20, bottom: 30),
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listRouti.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: 200,
                                height: 150,
                                child: GestureDetector(
                                  onTap: () {
                                     Navigator.pushNamed(context, 'detailsProgramaEjercicios',
                                       arguments: listRouti[index]);
                                  },
                                  child: Card(
                                    child: Column(
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      children: [
                                        // Container(
                                        //   width: 200,
                                        //   height: 180,
                                        //   child: FadeInImage.assetNetwork(
                                        //       placeholder: '/assets/full.jpeg',
                                        //       image: listRouti[index].name),
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Text(
                                              listRouti[index].name,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ); //Card(child: Text("data"),);
                            },
                          )),
                    ));
                // return GridView.builder(
                //   itemCount: listRouti.length,
                //   gridDelegate:
                //       SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 1,
                //   ),
                //   itemBuilder: (context, index) {
                //     return GestureDetector(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) =>
                //                   ShowExercisesPage(listRouti[index]),
                //             ));
                //       },
                //       child: Card(
                //         //color: Colors.grey[350],
                //         // child: Container(
                //         //   decoration: BoxDecoration(
                //         //     image: DecorationImage(
                //         //       image: AssetImage(listImage[
                //         //           index % listImage.length]),
                //         //       fit: BoxFit.cover,
                //         //     ),
                //         //   ),
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Column(
                //             mainAxisAlignment:
                //                 MainAxisAlignment.start,
                //             crossAxisAlignment:
                //                 CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 "${listRouti[index].name}",
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                     color: Colors.black,

                //                     //color: Theme.of(context).accentColor,
                //                     fontSize: 15,
                //                     fontWeight: FontWeight.w800),
                //               ),
                //               // Image(
                //               // //  image:   AssetImage(),
                //               // ),
                //               SizedBox(height: 10),

                //               // Text(
                //               //   listRouti[index].id,
                //               //   style: TextStyle(
                //               //       color: Colors.black,
                //               //       fontSize: 15,
                //               //       fontWeight: FontWeight.w400),
                //               // ),
                //               SizedBox(height: 10),
                //             ],
                //           ),
                //         ),
                //         //),
                //       ),
                //     );
                //   },
                // );
              }
              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(30),
                  child: Card(
                    child: Container(
                      height: 180,
                      //width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            "Parece que aún no completas tu evaluación",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Completa tu evaluación para que tengas un programa poderoso",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 25),
                          Container(
                            width: 250,
                            height: 49,
                            child: SizedBox(
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Text('¡Vamos!',
                                    style: TextStyle(fontSize: 19)),
                                color: Colors.orangeAccent,
                                textColor: Colors.black,
                                onPressed: () {
                                  Navigator.pushNamed(context, "completeGoal");
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
