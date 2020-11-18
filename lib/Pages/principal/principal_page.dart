import 'package:flutter/material.dart';
import 'package:proyecto_codigo/models/ejerciciosAll.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart';
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
    super.initState();
  }

  String idPro;

  void recuperarPro() async {
    id = await prefs.getIdUser();
    token = await prefs.getUserToken();

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
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            //return Container(height: 200,color: Colors.red,);
            return _listItem(image[4], "380 kcal");
          }, childCount: 1

                  // _listItem(image[4], "380 kcal"),
                  //Expanded(child: _listItem(image[0], "380 kcal")),

                  ),
        ),
      ],
    );
  }

  Widget scrollAppbar() {
    return SliverAppBar(
      title: Text("Qenqo", style: TextStyle(fontSize: 30, color: Colors.white)),

      centerTitle: true,
      expandedHeight: 220,
      pinned: true,
      //floating: false,
      backgroundColor: Colors.cyan[800],
      toolbarHeight: 60,
      //leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
      flexibleSpace: FlexibleSpaceBar(
        background: Image(
          image: AssetImage("assets/banner.jpg"),
          fit: BoxFit.cover,
          color: Colors.lightBlue[200],
          colorBlendMode: BlendMode.multiply,
        ),
      ),
      // bottom: PreferredSize(
      //   preferredSize: Size.fromHeight(100),
      //   child: Padding(
      //     padding: const EdgeInsets.only(bottom: 24.0, left: 12, right: 12),
      //     child: TextField(
      //       decoration: InputDecoration(
      //           filled: true,
      //           fillColor: Colors.white,
      //           border: OutlineInputBorder(
      //               borderRadius: BorderRadius.circular(30),
      //               borderSide: BorderSide.none),
      //           contentPadding:
      //               EdgeInsets.symmetric(vertical: 0, horizontal: 24),
      //           hintText: "buscar programa de entrenamiento",
      //           prefixIcon: Icon(Icons.search, color: Colors.black)),
      //     ),
      //   ),
      // ),
      // actions: [
      //   IconButton(icon: Icon(Icons.settings), onPressed: () {}),
      // ],
    );
  }

  Widget _itemProgram() {
    return Container(
      height: 180,
      //width: double.infinity,
      margin: EdgeInsets.only(right: 30, left: 30, bottom: 15),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/program2.jpg"),
            //AssetImage("assets/brazos.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "MI PROGRAMA",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 10),
            Text(
              "¿Quieres ejercicios personalizados?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 25),
            SizedBox(
              height: 30,
              width: 160,
              child: RaisedButton(
                elevation: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                padding: EdgeInsets.all(0.0),
                child: Text('¡Vamos!', style: TextStyle(fontSize: 20)),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, "completeEva");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listItem(String img, String subtitle) {
    return FutureBuilder(
        future: helper.obtenerProgramaAll(id, token),
        builder: (BuildContext context,
            AsyncSnapshot<List<EjerciciosAll>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              List<EjerciciosAll> ejercicios = snapshot.data;

              return ListView.builder(
                  itemCount: ejercicios.length + 1,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          SizedBox(height: 10),
                          _itemProgram(),
                          SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "Los mas populares",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              //Icon(Icons.favorite)
                            ],
                          ),
                          SizedBox(height: 10),
                          // lista horizontal
                          _listHorizontal("Pecho", image[0], "250 kcal"),
                          SizedBox(height: 15),
                        ],
                      );
                    }

                    int i = index - 1;
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'detalleEjercicio',
                            arguments: ejercicios[i]);
                      },
                      child: Container(
                        height: 110,
                        width: double.infinity,
                        margin:
                            EdgeInsets.only(right: 20, left: 20, bottom: 30),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/brazos.jpg"),
                              //AssetImage("assets/brazos.jpg"),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black54, BlendMode.darken),
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ejercicios[i].name,
                              style: TextStyle(
                                  color: Colors.white,
                                  //color: Theme.of(context).accentColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(height: 10),
                            Text(
                              subtitle,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Text("No hay informacion");
            }
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
    /* Widget _listItem(String img, String subtitle) {
    return FutureBuilder(
      future: helper.obtenerProgramaAll(id, token),
      builder:
          (BuildContext context, AsyncSnapshot<List<EjerciciosAll>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            List<EjerciciosAll> ejercicios = snapshot.data;

            return ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: ejercicios.length + 1,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, ind) {
                  if (ind == 0) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        _itemProgram(),
                        SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Los mas populares",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            //Icon(Icons.favorite)
                          ],
                        ),
                        SizedBox(height: 10),
                        // lista horizontal
                        _listHorizontal("Pecho", image[0], "250 kcal"),
                        SizedBox(height: 15),
                      ],
                    );
                  }

                  int i = ind - 1;

                  return ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: ejercicios[i].exercises.length + 1,
                      itemBuilder: (context, index2) {
                        if (index2 == 0) {
                          return Text('${ejercicios[i].name}');
                        }

                        int i2 = index2 - 1;
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'routeName',
                                arguments: ejercicios[i]);  
                          },
                          child: Container(
                            height: 110,
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                right: 20, left: 20, bottom: 30),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      ejercicios[i].exercises[i2].urlImage),
                                  //AssetImage("assets/brazos.jpg"),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black54, BlendMode.darken),
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ejercicios[i].exercises[i2].name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      //color: Theme.of(context).accentColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  subtitle,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        );
                      });
                });
          } else {
            return Text("No hay informacion");
          }
        }
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return
              // Center(child: Image(image: AssetImage("assets/vacio.jpg",
              // ),
              // fit: BoxFit.cover,),
              // );
              Center(child: CircularProgressIndicator());
        }
      },
    );
  }

   */
  }

  Widget _listHorizontal(String nombre, String img, String subtitle) {
    return Container(
      height: 110,
      width: double.infinity,
      margin: EdgeInsets.only(right: 20, left: 20, bottom: 30),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(img),
            //AssetImage("assets/brazos.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: image.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 90,
                child: Card(
                  color: Colors.cyan,
                  child: Image(
                    image: AssetImage(img),
                    fit: BoxFit.cover,
                  ),
                ),
              ); //Card(child: Text("data"),);
            },
          )),
    );
  }
}
