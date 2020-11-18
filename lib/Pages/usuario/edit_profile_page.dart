import 'package:flutter/material.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart';


class EditProfilePage extends StatefulWidget {
  Profile profileRecup;
  EditProfilePage(this.profileRecup);

  @override
  _EditProfilePageState createState() =>
      _EditProfilePageState(this.profileRecup);
}

class _EditProfilePageState extends State<EditProfilePage> {
  Profile profileRecup;
  _EditProfilePageState(this.profileRecup);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Perfil"),
      ),
      body: Stack(
        children: [
          Container(color: Colors.blueGrey[400]),

          Column(
            children: [
              Center(
                child: Column(
                  
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Image(
                      image: AssetImage("assets/perfil.jpg"),
                      fit: BoxFit.fitHeight,
                      height: 120,
                      width: 120,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Datos personales",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold,color: Colors.white),),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Nombre",style: TextStyle(color: Colors.white)),
                        Text(profileRecup.name,style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Correo electrónico",style: TextStyle(color: Colors.white)),
                        Text(profileRecup.email,style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Contraseña",style: TextStyle(color: Colors.white)),
                        Text(profileRecup.password,style: TextStyle(color: Colors.white)),
                      ]
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          textColor: Colors.white,
                          color: Theme.of(context).accentColor,
                          child: Text("Cerrar Sesion"),
                          onPressed: () async {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                'login', (Route<dynamic> route) => false);
                          }),
                    )
                  ],
                ),
              ),
            ],
          )
          // infoProfile(context, profileRecup),
          // publisProfile(context),
        ],
      ),
      // Center(
      //   child: Column(
      //     children: [

      //       Text("Editar Perfil aqui"),

      // ),
    );
  }
}
