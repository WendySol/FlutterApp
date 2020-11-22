import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_codigo/Pages/evaluacion/completeActilife_eva.dart';
import 'package:proyecto_codigo/Pages/evaluacion/completeEvaluation.dart';
import 'package:proyecto_codigo/Pages/evaluacion/completeGoals_eva.dart';
import 'package:proyecto_codigo/Pages/evaluacion/listEvaluations.dart';
import 'package:proyecto_codigo/Pages/evaluacion/animationResults.dart';
import 'package:proyecto_codigo/Pages/home_page.dart';
import 'package:proyecto_codigo/Pages/principal/MuestraEjercicioXTipo_page.dart';
import 'package:proyecto_codigo/Pages/principal/detalleEjercicio_page.dart';
import 'package:proyecto_codigo/Pages/principal/muestraEjercicio.dart';

import 'package:proyecto_codigo/Pages/principal/principal_page.dart';
import 'package:proyecto_codigo/Pages/programa/detailsProgramExercise_page.dart';
import 'package:proyecto_codigo/Pages/programa/showRoutines_page.dart';
import 'package:proyecto_codigo/Pages/programa/showExercises_page.dart';
import 'package:proyecto_codigo/Pages/usuario/edit_profile_page.dart';
import 'package:proyecto_codigo/Pages/usuario/profile_page.dart';
import 'package:proyecto_codigo/Pages/login_page.dart';
import 'package:proyecto_codigo/Pages/comunidad/community_page.dart';
import 'package:proyecto_codigo/Pages/register_user_page.dart';
import 'package:proyecto_codigo/models/resEjercicioDetalleModel.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart';
import 'package:proyecto_codigo/models/resResEvaProgram_model.dart';
import 'package:proyecto_codigo/provider/user_provider.dart';
import 'package:proyecto_codigo/utils/drawerMenu/configuracion_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
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
  ResEjercicioDetalleModel ejericio;

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
            primaryColor: Colors.cyan[800],
            accentColor: Colors.orange[500],
            dividerColor: Colors.grey[250]),

        //home: LoginUserPage(),
        // initialRoute: 'login',

        home: AnimatedSplashScreen(
            duration: 5000,
            splash: Stack(children: [
              Container(
                child: WaveWidget(
                  config: CustomConfig(
                    gradients: [
                      [Colors.cyan[900], Colors.cyan[900]],
                      [Colors.cyan[900], Colors.cyan[900]],
                      [Colors.cyan[900], Colors.cyan[900]],
                      [HexColor("#508D99"), HexColor("#508D99")]
                    ],
                    durations: [35000, 19440, 10800, 6000],
                    heightPercentages: [0.14, 0.45, 0.40, 0.30],
                    blur: MaskFilter.blur(BlurStyle.solid, 5),
                    gradientBegin: Alignment.bottomLeft,
                    gradientEnd: Alignment.topRight,
                  ),
                  waveAmplitude: 10,
                  size: Size(
                    double.infinity,
                    double.infinity,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 100,
                  height: 210,
                  child: Image.asset('assets/orig.png')),
              )
            ]),
            nextScreen: (Provider.of<UserProvider>(context).token != null &&
                    Provider.of<UserProvider>(context).token.length > 0)
                ? HomePage(pro)
                : LoginUserPage(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.scale,
            backgroundColor: Colors.cyan[900]),

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
          "muestraEjercicio": (BuildContext context) => MuestraEjercicioPage(),
          "muestraEjercicioXTipo": (BuildContext context) => MuestraEjercicioXTipoPage(),

          //'evaluaciones
          'completeEva': (BuildContext context) => CompleteEvaluation(pro),
          'completeGoal': (BuildContext context) =>
              CompleteGoalEvaluationPage(),
          'completeActivelife': (BuildContext context) =>
              CompleteActilifePage(),
          'listEvaluations': (BuildContext context) => ListEvaluations(),
          'resultadoEvaluacion': (BuildContext context) =>
              AnimationResultsPage(),

          //'Programa
          'programaEjercicios': (BuildContext context) =>
              ShowExercisesPage(rutina),
           'detailsProgramaEjercicios': (BuildContext context) =>
              DetailsProgramPage(),

          //usuario
          "perfil": (BuildContext context) => ProfilePage(pro),
          "editarperfil": (BuildContext context) => EditProfilePage(pro),
          "config": (BuildContext context) => ConfiguracionPage(),
        },
      ),
    );
  }
}
