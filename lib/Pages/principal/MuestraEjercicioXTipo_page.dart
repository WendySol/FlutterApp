import 'package:flutter/material.dart';
import 'package:proyecto_codigo/models/ejerciciosAll.dart';
import 'package:proyecto_codigo/models/resEjercicixTipo.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart' as log;
import 'package:proyecto_codigo/utils/httphelper.dart';
import 'package:proyecto_codigo/utils/preferences_user.dart';

class MuestraEjercicioXTipoPage extends StatefulWidget {
  MuestraEjercicioXTipoPage();

  @override
  _MuestraEjercicioXTipoPageState createState() => _MuestraEjercicioXTipoPageState();
}

class _MuestraEjercicioXTipoPageState extends State<MuestraEjercicioXTipoPage> {
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
    final ResEjercicioxTipoModel exerciseType = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("${exerciseType.name}"),
      ),
      body: Column(children: [
        (exerciseType.urlImage).isEmpty
            ? Container(
                child: Expanded(
                    child: Image(image: NetworkImage(exerciseType.urlImage))),
              )
            : Expanded(
                child: Container(
                    child: Image(image: NetworkImage(exerciseType.urlGif)))),
        Container(child: Text(exerciseType.name, style: TextStyle(fontSize: 24))),
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
