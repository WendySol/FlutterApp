import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:proyecto_codigo/models/ejerciciosAll.dart' as exeAll;
import 'package:proyecto_codigo/models/resEjercicixTipo.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart';
import 'package:proyecto_codigo/models/resResEvaProgram_model.dart';
import 'package:proyecto_codigo/utils/httphelper.dart';
import 'package:proyecto_codigo/utils/preferences_user.dart';

class PrincipalPage extends StatefulWidget {
  Profile pro;

  String idPro;
  PrincipalPage(this.pro);
  @override
  _PrincipalPageState createState() => _PrincipalPageState(this.pro);
}

class _PrincipalPageState extends State<PrincipalPage> {
  Profile pro;
  _PrincipalPageState(this.pro);

  final prefs = Preferencias();

  String id;
  String token;
  HttpHelper helper = HttpHelper();

  @override
  void initState() {
    recuperarPro();
    _isSelected(index);
    super.initState();
  }

  String idPro;
  int index = 0;
  int isSelected = -1;
  String tipo = "Piernas";

  _isSelected(int index) {
    //pass the selected index to here and set to 'isSelected'

    setState(() {
      isSelected = index;
      if (index == 0) {
        tipo = "Piernas";
      }
      if (index == 1) {
        tipo = "Abdominales";
      }
      if (index == 2) {
        tipo = "Pecho";
      }
      if (index == 3) {
        tipo = "Hombro";
      }
      if (index == 4) {
        tipo = "Espalda";
      }
      if (index == 5) {
        tipo = "Fullbody";
      }

      tipo = tipo;
      // print(index);
      // print(tipo);
    });
  }

  List<String> listTipos = [
    "Piernas",
    "Abdominales",
    "Pecho",
    "Hombro",
    "Espalda",
    "Full Body"
  ];

  // List<String> listDias = [
  //   "Piernas",
  //   "Abdominales",
  //   "Espalda",
  //   "Triceps",
  //   "Hombros",
  // ];

  void recuperarPro() async {
    id = await prefs.getIdUser();
    token = await prefs.getUserToken();
    print("ide" + id);
    print("token" + token);
    Profile profileRecup = await HttpHelper().consultarUsuario(id, token);

    setState(() {
      idPro = profileRecup.id;
    });
  }

  List<String> image = [
    "assets/brazos.jpg",
    "assets/piernas.jpg",
    "assets/abdomene.jpg",
    "assets/glut.jpg",
    "assets/full.jpeg"
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        scrollAppbar(),
        SliverList(
            delegate: SliverChildListDelegate([
          _builCategorias(),
          _listItem(),
        ])

            //         SliverChildBuilderDelegate((BuildContext context, int index) {
            //   //return Container(height: 200,color: Colors.red,);
            //   return _listItem2();
            // }, childCount: 1),
            ),
      ],
    );
  }

  Widget scrollAppbar() {
    return SliverAppBar(
      // poner logo a la izquierda
      //colocar programa mft dentro del sliver

      expandedHeight: 150,
      pinned: true,
      //floating: false,
      backgroundColor: Colors.cyan[900],
      toolbarHeight: 100,
      elevation: 8,
      leading: Image(
        width: 80,
        image: AssetImage("assets/orig.png"),
      ),
      //IconButton(icon: Icon(Icons.menu), onPressed: () {}),
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            background: Image(
              image: AssetImage("assets/banner.jpg"),
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.multiply,
              color: Colors.cyan[900],
            ),
          ),
          _builEvaluacion()
        ],
      ),
    );
  }

  Widget _builEvaluacion() {
    return FutureBuilder<ProgramSelected>(
      future: HttpHelper().consultarProgramSele(idPro, token),
      builder: (BuildContext context, AsyncSnapshot<ProgramSelected> snapshot) {
        ProgramSelected profito = snapshot.data;
        if (snapshot.hasData) {
          return Center(
            child: Container(
              padding: EdgeInsets.only(top: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Dale con todo a tu ${profito.name}",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Programa ${profito.name}",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 60, left: 80),
              child: Container(
                height: 150,
                //width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      "Programa MFT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 220,
                      child: Text(
                        "¿Quieres un programa y entrenador físico personalizado?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: 120,
                      height: 49,
                      child: SizedBox(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          padding: EdgeInsets.all(0.0),
                          child:
                              Text('¡Vamos!', style: TextStyle(fontSize: 19)),
                          color: Colors.orangeAccent,
                          textColor: Colors.white,
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
      },
    );
  }

  Widget _builCategorias() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 30, top: 30),
          child: Text(
            "¿Qué músculo quieres ejercitar?",
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800),
          ),
        ),
        Container(
          height: 140,
          width: 700,
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: GlowingOverscrollIndicator(
                  color: Colors.white,
                  axisDirection: AxisDirection.down,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,

                    itemCount: listTipos.length, //AGREGAR ICONOS

                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        width: 120,
                        height: 90,
                        child: GestureDetector(
                          onTap: () {
                            _isSelected(i);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation:
                                isSelected != null && isSelected == i ? 2 : 1,
                            color: isSelected != null &&
                                    isSelected ==
                                        i //set condition like this. voila! if isSelected and list index matches it will colored as white else orange.

                                ? Colors.orangeAccent
                                : Colors.cyan[900],
                            child: Center(
                              child: Container(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.healing,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(listTipos[i],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ],
                              )),
                            ),
                          ),
                        ),
                      ); //Card(child: Text("data"),);
                    },
                  ),
                ),
              )),
        ),
      ],
    );
  }

//--------Todos los ejercicios-----------------
  Widget _listItem2() {
    /// list view expandido con todo de largo, los botoncitos e imagenes ejercicios
    return FutureBuilder(
        future: helper.obtenerProgramaAll(id, token),
        builder: (BuildContext context,
            AsyncSnapshot<List<exeAll.EjerciciosAll>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              List<exeAll.EjerciciosAll> ejercicios = snapshot.data;

              return ListView.builder(
                  itemCount: ejercicios.length + 1,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //_itemProgram(),
                          Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Text(
                              "Por músculo",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),

                          // lista horizontal
                          _builCategorias(),

                          _listHorizontal2(),

                          Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Text(
                              "Rutinas Físicas",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      );
                    }

                    int i = index - 1;
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'detalleEjercicio',
                            arguments: ejercicios[i]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 110,
                          width: double.infinity,
                          margin:
                              EdgeInsets.only(right: 20, left: 20, bottom: 30),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(image[index % image.length]),
                                //AssetImage("assets/brazos.jpg"),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.black54, BlendMode.darken),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ejercicios[i].name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      //color: Theme.of(context).accentColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "380 Cal",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Text("No hay informacion");
            }
          }
          if (snapshot.hasError) {
            return Text("No hay informacion");
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _listItem() {
    /// list view expandido con todo de largo, los botoncitos e imagenes ejercicios
    return FutureBuilder(
        future: HttpHelper().consultarRutinasxTipo(token, tipo),
        builder: (BuildContext context,
            AsyncSnapshot<List<ResEjercicioxTipoModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              List<ResEjercicioxTipoModel> ejerciciosTipo = snapshot.data;

              return ListView.builder(
                  itemCount: ejerciciosTipo.length + 1,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _listHorizontal2();
                    }
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          } else if (snapshot.hasError) {
            return //Center(child: Text(snapshot.error.toString()));
                Container(
              width: 550,
              height: 280,
              child: Card(
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                    Text("Por el momento no contamos con estos ejerciciiios "),
                    //Text(snapshot.error),
                    Image(
                      width: 50,
                      image: AssetImage("assets/orig.png"),
                    )
                  ]))),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }

  Widget _listHorizontal2() {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),

          child: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
                color: Colors.white,
            child: FutureBuilder(
          future: HttpHelper().consultarRutinasxTipo(token, tipo),
          builder: (BuildContext context,
              AsyncSnapshot<List<ResEjercicioxTipoModel>> snapshot) {
            if (snapshot.hasData) {
              List<ResEjercicioxTipoModel> ejerciciosTipo = snapshot.data;

              return Container(
                  width: double.infinity,
                  child: Container(
                    height: 280,
                    width: double.infinity,
                    margin: EdgeInsets.only(right: 20, left: 20, bottom: 30),
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ejerciciosTipo.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 330,
                              height: 250,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, 'muestraEjercicioXTipo',
                                      arguments: ejerciciosTipo[index]);
                                },
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 180,
                                        child: FadeInImage.assetNetwork(
                                            placeholder: '/assets/full.jpeg',
                                            image: ejerciciosTipo[index].urlImage),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Text(
                                            ejerciciosTipo[index].name,
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
            }
            if (snapshot.hasError) {
              return //Center(child: Text(snapshot.error.toString()));
                  Container(
                width: 550,
                height: 280,
                child: Card(
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                      Text("Por el momento no contamos con estos ejercicios "),
                      Image(
                        width: 50,
                        image: AssetImage("assets/orig.png"),
                      )
                    ]))),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
    );
  }
}
