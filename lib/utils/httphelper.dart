import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_codigo/models/ejerciciosAll.dart' as general;
import 'package:proyecto_codigo/models/resEjercicioDetalleModel.dart';
import 'package:proyecto_codigo/models/resEjercicixTipo.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart' as log;
import 'package:proyecto_codigo/models/resResEvaProgram_model.dart' as evapro;
import 'package:proyecto_codigo/models/resResEvaProgram_model.dart';

import 'package:proyecto_codigo/utils/preferences_user.dart';

class HttpHelper {
  String urlBase = "https://back-mazeout.herokuapp.com";

  Preferencias pref;
  Future tok = Preferencias().getUserToken();

  Future<String> iniciarSesion(String username, String password) async {
    // Map data = {'email': username, 'password': password};
    // var jsonResponse;
    // var response = await http.post("$urlBase/login", body: jsonEncode(data));

    // if (response.statusCode == 200) {
    //   print(json.decode(response.body));
    //   //   if (json.decode(response.body)["message"] != "fail") {
    //   jsonResponse = json.decode(response.body);
    //   Profile useri = Profile.fromJson(jsonDecode(response.body)["profile"]);
    //   print(useri);

    //   return useri;
    //   // }
    //   // else {
    //   //     print(response.body);
    //   // }
    // }
    var response = await http.post("$urlBase/login",
        body: {"email": username, "password": password});

    if (response.statusCode == 200) {
      //print("so" + response.body);
      dynamic token = jsonDecode(response.body);
      return token['token'];
    }
    return "";
  }
  //ANTES DE QUE COMPLETE LA EVALUACION

  Future<log.Profile> consultarPerfil(
      String username, String password, String token) async {
    Map data = {'email': username, 'password': password};
    var jsonResponse;
    var response = await http.post("$urlBase/login",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$token"
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      //print(json.decode(response.body));
      //   if (json.decode(response.body)["message"] != "fail") {
      jsonResponse = json.decode(response.body);
      log.Profile useri =
          log.Profile.fromJson(jsonDecode(response.body)["profile"]);

      //print(useri);
      return useri;
    }
  }

  //CUANDO COMPLETA LA EVALUACION RECIBE PROGRAMA
  Future<List<evapro.Routine>> consultaRutinasdePrograma(
      String idPro, String token) async {
    //Lista rutinas fisicas
    var jsonResponse;
    var response = await http.get(
      "$urlBase/user/$idPro",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "$token"
      },
    );

    if (response != null && response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      List rutinas = jsonDecode(response.body)["program_selected"]["routines"];

      return rutinas.map((e) => evapro.Routine.fromJson(e)).toList();
    } else {
      //do something else
    }

    // if (response.statusCode == 200) {
    //   //print(json.decode(response.body));
    //   //   if (json.decode(response.body)["message"] != "fail") {
    //   jsonResponse = json.decode(response.body);

    //   List rutinas = jsonDecode(response.body)["program_selected"]["routines"];

    //   return rutinas.map((e) => evapro.Routine.fromJson(e)).toList();

    //   //  Routine infoRutin = Routine.fromJson(jsonDecode(response.body)["program_selected"]["routines"]);

    // }
  }

  Future<ResEjercicioDetalleModel> detalleEjercicio(
      String token, String idExercise) async {
    var jsonResponse;
    var response = await http.get(
      "$urlBase/exercisebyid/$idExercise",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "$token"
      },
    );

    if (response.statusCode == 200) {
      //print(json.decode(response.body));
      //   if (json.decode(response.body)["message"] != "fail") {
      jsonResponse = json.decode(response.body);
      ResEjercicioDetalleModel detalleEjercicio =
          ResEjercicioDetalleModel.fromJson(jsonDecode(response.body));

      print(detalleEjercicio);
      return detalleEjercicio;
    }
  }

  Future<List<ResEjercicioxTipoModel>> consultarRutinasxTipo(
      String token,String tipo) async {
    // lista ejercicios de rutina //TODO
    var jsonResponse;
    var response = await http.get(
      "$urlBase/exercisesByType/$tipo",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "$token"
      },
    );

    if (response.statusCode == 200) {
      //print(json.decode(response.body));
      //   if (json.decode(response.body)["message"] != "fail") {
      jsonResponse = json.decode(response.body);

      List ejerc = jsonDecode(response.body);
      //quiero qu absorva por id de rutina
      //print(ejerc);
      // evapro.Exercise infoRutin = evapro.Exercise.fromJson(jsonDecode(response.body)["program_selected"]["routines"]);
      return ejerc.map((e) => ResEjercicioxTipoModel.fromJson(e)).toList();
      
      //  return infoRutin;
    }
  }

  Future<List<evapro.Exercise>> consultaEjercicios(
      String idRuti, String token) async {
    // lista ejercicios de rutina //TODO
    var jsonResponse;
    var response = await http.get(
      "$urlBase/routine/$idRuti",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "$token"
      },
    );

    if (response.statusCode == 200) {
      //print(json.decode(response.body));
      //   if (json.decode(response.body)["message"] != "fail") {
      jsonResponse = json.decode(response.body);

      List ejerc = jsonDecode(response.body)["exercises"];
      //quiero qu absorva por id de rutina

      // evapro.Exercise infoRutin = evapro.Exercise.fromJson(jsonDecode(response.body)["program_selected"]["routines"]);
      return ejerc.map((e) => evapro.Exercise.fromJson(e)).toList();
      //  return infoRutin;
    }
  }

  Future<String> completarEvaluacion(
      String idProfile,
      double altura,
      double peso,
      String sexo,
      String actividadF,
      double cintura,
      double cuello,
      int edad,
      String objetivoNutri,
      String token) async {
    Map data = {
      "id": idProfile,
      "height": altura,
      "weight": peso,
      "sex": sexo,
      "physical_activity": actividadF,
      "waist": cintura,
      "neck": cuello,
      "age": edad,
      "nutritional_goal": objetivoNutri
    };
    var jsonResponse;
    var response = await http.post("$urlBase/askevaluation",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "$token"
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      //print("so" + response.body);
      dynamic regisEva = jsonDecode(response.body);
      return regisEva;
    }
    return "";
  }

  Future<log.Profile> consultarUsuario(String idPro, String token) async {
    var jsonResponse;
    var response = await http.get(
      "$urlBase/user/$idPro",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "$token"
      },
    );

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      log.Profile stProfile = log.Profile.fromJson(jsonDecode(response.body));
      //print(stProfile);
      return stProfile;
    }
  }
  Future<ProgramSelected> consultarProgramSele(String idPro, String token) async {
    var jsonResponse;
    var response = await http.get(
      "$urlBase/user/$idPro",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "$token"
      },
    );

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      
    ProgramSelected stProfile = ProgramSelected.fromJson(jsonDecode(response.body)["program_selected"]);
      //print(stProfile);
      return stProfile;
    }
  }

  Future<evapro.Evaluation> consultaEvaluation(
      String idPro, String token) async {
    var jsonResponse;
    var response = await http.get(
      "$urlBase/user/$idPro",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "$token"
      },
    );

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      evapro.Evaluation stProfile =
          evapro.Evaluation.fromJson(jsonDecode(response.body)["evaluation"]);
      //print(stProfile);
      return stProfile;
    }
  }

  Future<bool> registerUser(String name, String email, String pass) async {
    final response = await http.post('$urlBase/register',
        body: {'name': '$name', 'email': '$email', 'password': '$pass'});

    if (response.statusCode == 200) {
      //print(json.decode(response.body));
      final jsonResponse = json.decode(response.body);
      final res = jsonResponse['active'];

      return res;
    }
  }

  Future<List<general.EjerciciosAll>> obtenerProgramaAll(
      String idPro, String token) async {
    var response = await http.get("$urlBase/allroutines", headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "$token"
    });

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      //Lista vacia
      List ejerciciosAll = List<general.EjerciciosAll>();

      for (var i = 0; i < jsonResponse.length; i++) {
        //instancia del Modelo completo
        general.EjerciciosAll exercisesAll = general.EjerciciosAll();

        List ejercicios = List<general.Exercise>();

        for (var j = 0; j < jsonResponse[i]["exercises"].length; j++) {
          //instancia de la clase Exercise
          general.Exercise exercise = general.Exercise();

          exercise.id = jsonResponse[i]["exercises"][j]['_id'];
          exercise.name = jsonResponse[i]["exercises"][j]['name'];
          exercise.series =
              jsonResponse[i]["exercises"][j]['series'].toString();
          exercise.iterations =
              jsonResponse[i]["exercises"][j]['iterations'].toString();
          exercise.restSerie =
              jsonResponse[i]["exercises"][j]['rest_serie'].toString();
          exercise.restExercise =
              jsonResponse[i]["exercises"][j]['rest_exercise'].toString();
          exercise.iterationsType =
              jsonResponse[i]["exercises"][j]['iterations_type'];
          exercise.type = jsonResponse[i]["exercises"][j]['type'];
          exercise.urlImage = jsonResponse[i]["exercises"][j]['url_image'];
          exercise.urlGif = jsonResponse[i]["exercises"][j]['url_gif'];

          ejercicios.add(exercise);
        }
        //final res = jsonResponse.map((e) => Exercise.fromJson(e)).toList();

        // print(res);

        exercisesAll.id = jsonResponse[i]["_id"];
        exercisesAll.name = jsonResponse[i]["name"];
        exercisesAll.exercises = ejercicios;

        ejerciciosAll.add(exercisesAll);
      }
      //print(ejerciciosAll);
      return ejerciciosAll;
    }
  }
}
