import 'package:flutter/material.dart';
import 'package:proyecto_codigo/models/ejerciciosAll.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart' as log;
import 'package:proyecto_codigo/utils/httphelper.dart';
import 'package:proyecto_codigo/utils/preferences_user.dart';

class MuestraEjercicioPage extends StatefulWidget {
  MuestraEjercicioPage();

  @override
  _MuestraEjercicioPageState createState() => _MuestraEjercicioPageState();
}

class _MuestraEjercicioPageState extends State<MuestraEjercicioPage> {
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
    final Exercise exercise = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("${exercise.name}"),
      ),
      body: Column(children: [
        (exercise.urlImage).isEmpty
            ? Container(
                child: Expanded(
                    child: Image(image: NetworkImage(exercise.urlImage))),
              )
            : Expanded(
                child: Container(
                    child: Image(image: NetworkImage(exercise.urlGif)))),
        Container(child: Text(exercise.name, style: TextStyle(fontSize: 24))),
        Container(
          width: 300,
          height: 200,
          child: Card(
              child: Text(
                  "Rutina corta e intensa para elevar la frecuencia cardiaca y poner los musculos en marcha",
                  style: TextStyle(fontSize: 18))),
        )
      ]),
    );
  }
}
