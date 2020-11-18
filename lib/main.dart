import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_codigo/Pages/evaluacion/completeEvaluation.dart';
import 'package:proyecto_codigo/Pages/evaluacion/listEvaluations.dart';
import 'package:proyecto_codigo/Pages/evaluacion/shoResultEvaluation.dart';
import 'package:proyecto_codigo/Pages/home_page.dart';
import 'package:proyecto_codigo/Pages/principal/detalleEjercicio_page.dart';

import 'package:proyecto_codigo/Pages/principal/principal_page.dart';
import 'package:proyecto_codigo/Pages/programa/showRoutines_page.dart';
import 'package:proyecto_codigo/Pages/programa/showExercises_page.dart';
import 'package:proyecto_codigo/Pages/usuario/edit_profile_page.dart';
import 'package:proyecto_codigo/Pages/usuario/profile_page.dart';
import 'package:proyecto_codigo/Pages/login_page.dart';
import 'package:proyecto_codigo/Pages/comunidad/community_page.dart';
import 'package:proyecto_codigo/Pages/register_user_page.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart';
import 'package:proyecto_codigo/models/resResEvaProgram_model.dart';
import 'package:proyecto_codigo/provider/user_provider.dart';
import 'package:proyecto_codigo/utils/drawerMenu/configuracion_page.dart';


void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool logeado = false;
  Profile pro;

  Routine rutina;
  String idRutina;
  String idPro;
  // ResRecoveryProfile profileRecup;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    if (Provider.of<UserProvider>(context, listen: false).token == null)
      Provider.of<UserProvider>(context, listen: false).fetchUserData();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',

         theme: ThemeData(
          primaryColor: Colors.cyan[800], accentColor: Colors.orange[500], dividerColor: Colors.grey[250]),

        //home: LoginUserPage(),
        // initialRoute: 'login',
        home: (Provider.of<UserProvider>(context).token != null &&
                Provider.of<UserProvider>(context).token.length > 0)
            ? HomePage(pro)
            : LoginUserPage(),
        routes: {
          "login": (BuildContext context) => LoginUserPage(),
          "registroUsuario": (BuildContext context) => RegistroUsuario(),

          //nabvar
          "home": (BuildContext context) => HomePage(pro),
          'principal': (BuildContext context) => PrincipalPage(pro),
          "comusocial": (BuildContext context) => CommunityPage(),
          'mostrarRutinas': (BuildContext context) => ShowRoutinesPage(pro),

          //Principal
          "detalleEjercicio": (BuildContext context) => DetalleEjercicioPage(),


          //'evaluaciones
          'completeEva':(BuildContext context)=> CompleteEvaluation(pro),
          'listEvaluations':(BuildContext context)=> ListEvaluations(),
          'resultadoEvaluacion':(BuildContext context)=> ShowResultEvaluation(),

           //'Programa
          'programaEjercicios':(BuildContext context)=> ShowExercisesPage(rutina),

          //usuario
          "perfil": (BuildContext context) => ProfilePage(pro),
          "editarperfil": (BuildContext context) => EditProfilePage(pro),
          "config": (BuildContext context) => ConfiguracionPage(),

          
          
        },
      ),
    );
  }
}
