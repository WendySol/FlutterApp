import 'package:flutter/material.dart';
import 'package:proyecto_codigo/models/ejerciciosAll.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart' as log;
import 'package:proyecto_codigo/utils/httphelper.dart';
import 'package:proyecto_codigo/utils/preferences_user.dart';

class DetalleEjercicioPage extends StatefulWidget {
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
        body: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: exercises.exercises.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: (){

                  Navigator.pushNamed(context, 'muestraEjercicio',
                            arguments: exercises.exercises[i]);
                },
                child: Container(
                  height: 110,
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          exercises.exercises[i].urlImage,
                        ), // AssetImage("assets/brazos.jpg"),
                        //AssetImage("assets/brazos.jpg"),
                        fit: BoxFit.cover,
                        colorFilter:
                            ColorFilter.mode(Colors.black54, BlendMode.darken),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercises.exercises[i].name,
                        style: TextStyle(
                            color: Colors.white,
                            //color: Theme.of(context).accentColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: 10),
                      Text(
                        exercises.exercises[i].type,
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

              // return ListView.builder(
              //   itemCount: ejercicios[index].exercises.length,
              //   itemBuilder: (BuildContext context, int index2) {
              //     return Text("${ejercicios[index].exercises[index2].name}",
              //         style: TextStyle(
              //             color: Colors.black,
              //             fontSize: 24,
              //             fontWeight: FontWeight.w800));
              //   },
              // );
            }));
  }
}


