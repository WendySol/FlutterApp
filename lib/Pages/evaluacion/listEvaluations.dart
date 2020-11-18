import 'package:flutter/material.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart';

class ListEvaluations extends StatefulWidget {
  Profile pro;
  ListEvaluations();

  @override
  _ListEvaluationsState createState() => _ListEvaluationsState();
}

class _ListEvaluationsState extends State<ListEvaluations> {

  Profile pro;
  _ListEvaluationsState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Evaluaciones"),
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Ver lista de evaluaciones",
            style: TextStyle(fontSize: 30),
          ),
          Text(
              "Evaluacion... agregar lista de cards, mostrando boton con completar evaluacion, "),
          SizedBox(
            height: 20,
          ),
          Row(
            
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "miprograma");
                },
                child: Text("Ir a mi Programa"),
              ),
              SizedBox(width: 20),
              // RaisedButton(
              //   onPressed: () {
              //     Navigator.pushNamed(context, "home");
              //   },
              //   child: Text("home"),
              // )
            ],
          ),
        ],
      )),
    );
  }
}
