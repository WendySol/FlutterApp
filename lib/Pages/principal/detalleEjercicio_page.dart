import 'package:flutter/material.dart';
import 'package:proyecto_codigo/models/ejerciciosAll.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart' as log;
import 'package:proyecto_codigo/models/ejerciciosAll.dart' as general;
import 'package:proyecto_codigo/utils/httphelper.dart';
import 'package:proyecto_codigo/utils/preferences_user.dart';

class DetalleEjercicioPage extends StatefulWidget {
  // evapro.Routine rutina;
  // String idRutina;
  // String idRuti;

  DetalleEjercicioPage();

  @override
  _DetalleEjercicioPageState createState() => _DetalleEjercicioPageState();
}

class _DetalleEjercicioPageState extends State<DetalleEjercicioPage> {
  log.Profile pro;
  String token;
  String idPro;
  String id;

  @override
  void initState() {
    recuperarIdUser();
    super.initState();
  }

  void recuperarIdUser() async {
    id = await Preferencias().getIdUser();
    token = await Preferencias().getUserToken();

    log.Profile profileRecup =
        await HttpHelper().consultarUsuario(idPro, token);
    print(profileRecup);
    setState(() {
      idPro = profileRecup.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final EjerciciosAll exercises = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("${exercises.name}"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
            future: HttpHelper().obtenerProgramaAll(id, token),
            builder: (context, snapshot) {
              List<EjerciciosAll> ejercicios = snapshot.data;
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: ejercicios.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListView.builder(
                        itemCount: ejercicios[index].exercises.length,
                        itemBuilder: (BuildContext context, int index2) {
                          return Text("${ejercicios[index].exercises[index2].name}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800));
                        },
                      );
                    });
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
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

// class _buildEjercicios extends StatelessWidget {
//   const _buildEjercicios({
//     Key key,
//     //@required this.rutina,
//     @required this.token,
//   }) : super(key: key);

//   //final evapro.Routine rutina;
//   final String token;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: HttpHelper().obtenerProgramaAll(ejerciciosAll.id, token),
//       builder: (context, snapshot) {
//         List<general.Exercise> ejercicios = snapshot.data;
//         if (snapshot.hasData) {
//           return Container(
//             width: 400,
//             height: 600,
//             child: ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 itemCount: ejercicios.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     margin: EdgeInsets.only(right: 20, left: 20, bottom: 30),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Padding(
//                       padding: EdgeInsets.all(10.0),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "${ejercicios[index].name}",
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         //color: Theme.of(context).accentColor,
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w800),
//                                   ),
//                                   SizedBox(height: 10),
//                                   Text(
//                                     "Tipo: ${ejercicios[index].type.toString().substring(ejercicios[index].type.toString().toString().indexOf('.')).toString().substring(1)}",
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w400),
//                                   ),
//                                   SizedBox(height: 10),
//                                 ],
//                               ),
//                               Container(
//                                   width: 120,
//                                   height: 120,
//                                   child:
//                                       Image.network(ejercicios[index].urlImage))
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//           );
//         } else if (snapshot.hasError) {
//           return Text(snapshot.error.toString());
//         } else {
//           return Center(
//             child: CircularProgressIndicator()
//           );
//         }
//       },
//     );
//   }
