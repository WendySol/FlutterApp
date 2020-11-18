import 'package:flutter/material.dart';

Drawer MenuBarra(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/draw_image.png"),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle),
            title: Text("Home"),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushNamed(context, "home");
            },
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle),
            title: Text("Mis Evaluaciones"),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushNamed(context, "evaluaciones");
            },
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle),
            title: Text("Mi Programa Físico"),
            onTap: () {
             // Navigator.pop(context);
              Navigator.pushNamed(context, "miprograma");
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.supervised_user_circle),
          //   title: Text("Comunidad"),
          //   onTap: () {
          //     Navigator.pushReplacementNamed(
          //                         context, "comusocial");
          //   },
          // ),
          Divider(
            color: Colors.purple,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Configuracion"),
            onTap: () {
              Navigator.pushReplacementNamed(
                                  context, "config");
            },
          )
        ],
      ),
    );
  }