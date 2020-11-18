import 'package:flutter/material.dart';
import 'package:proyecto_codigo/Pages/principal/principal_page.dart';
import 'package:proyecto_codigo/Pages/comunidad/community_page.dart';
import 'package:proyecto_codigo/Pages/programa/showRoutines_page.dart';
import 'package:proyecto_codigo/Pages/usuario/profile_page.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart';
import 'package:proyecto_codigo/utils/httphelper.dart';
import 'package:proyecto_codigo/utils/preferences_user.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  Profile pro;
  HomePage(this.pro);

  @override
  _HomePageState createState() => _HomePageState(this.pro);
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  Profile pro;
  String token;
  String idPro;
  _HomePageState(this.pro);

  List<Widget> listPages = List<Widget>();

  @override
  void initState() {
    recuperarIdUser();
    listPages.add(PrincipalPage(pro));
    listPages.add(CommunityPage());
    listPages.add(ShowRoutinesPage(pro));
    //listPages.add(EvaluationPage(pro));
    listPages.add(ProfilePage(pro));

    super.initState();
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  

  void recuperarIdUser() async {
    idPro = await Preferencias().getIdUser();
    token = await Preferencias().getUserToken();
    
    Profile profileRecup = await HttpHelper().consultarUsuario(idPro, token);
    print(profileRecup);
    setState(() {
      pro=profileRecup;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
  //  print(idPro);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Qenqo App"),
      // ),
      //drawer: _menu()
      body: listPages[_currentIndex],
      bottomNavigationBar: _createBottomNavigationBar(_currentIndex),

      //Center(child: Text("Hola"),),
    );
  }

  Widget _createBottomNavigationBar(_currentIndex) {
    return ClipRRect(
      
      //  borderRadius: BorderRadius.only(
      //   topRight: Radius.circular(40),
      //   topLeft: Radius.circular(40),
      // ),
      child: Container(        
        color: Colors.cyan[900],
        child: BottomNavigationBar(
          selectedItemColor: Colors.orange,
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          showUnselectedLabels: true,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          unselectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(color: Colors.orange),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Principal",
              backgroundColor: Colors.orange,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: "Comunidad",
              backgroundColor: Theme.of(context).primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center_sharp),
              label: "Programa",
              backgroundColor: Theme.of(context).primaryColor,
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.pending_actions),
            //   label: "Evaluacion",
            //   backgroundColor: Theme.of(context).primaryColor,
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Perfil",
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
