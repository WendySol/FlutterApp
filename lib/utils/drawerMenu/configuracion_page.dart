import 'package:flutter/material.dart';
import 'package:proyecto_codigo/utils/drawerMenu/barramenu.dart';

class ConfiguracionPage extends StatefulWidget {
  ConfiguracionPage({Key key}) : super(key: key);

  @override
  _ConfiguracionPageState createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
         backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
              builder: (context) => IconButton(
                    icon: new Icon(Icons.menu, color: Colors.black),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  )),
         title: Text("Configuraciones",style: TextStyle(color: Colors.black),),
        ),
       drawer: MenuBarra(context),
       body: Center(
         child: Text("Configuraciones"),
       ),
    );
  }
}