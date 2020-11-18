import 'package:flutter/material.dart';
import 'package:proyecto_codigo/utils/radial_progress.dart';

class ShowResultEvaluation extends StatefulWidget {
  @override
  _ShowResultEvaluationState createState() => _ShowResultEvaluationState();
}

class _ShowResultEvaluationState extends State<ShowResultEvaluation> {
  String user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Resultados de Evaluacion")),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    "Este es el resultado de tu evaluación integral ",
                    style: TextStyle(
                        fontSize: 20,
                        //color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 150,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new NetworkImage(
                                "https://pbs.twimg.com/profile_images/765266391272390656/zdNk9iJA.jpg")),
                      )),
                  Text("Wendy",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(right: 180),
              child: Text("Resumen de Evaluación",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black)),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "IMC",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "23",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Descripción",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Normal",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(right: 200),
              child: Text("Mis Requerimientos",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black)),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Calorias Diarias",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "200",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(right: 200),
              child: Text("Mis Macronutrientes",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black)),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          /* CustomRadialProgress(porcentaje: porcentajeProte, color: Colors.greenAccent,tipomacro: 'Proteinas',),//proteinas
                        CustomRadialProgress(porcentaje: porcentajeCarbo, color: Colors.greenAccent[200],tipomacro: 'Carbohidratos',),
                        CustomRadialProgress(porcentaje: porcentajeGrasa, color: Colors.greenAccent[100],tipomacro: 'Grasa',),  //carbohidratos */
                          Column(
                            children: [
                              CustomRadialProgress(
                                  porcentaje: 100.0,
                                  cantidad: 20,
                                  color: Colors.white),
                              Text("Proteinas"),
                            ],
                          ),
                          Column(
                            children: [
                              CustomRadialProgress(
                                  porcentaje: 100.0,
                                  cantidad: 20,
                                  color: Colors.white),
                              Text("Carbohidratos"),
                            ],
                          ),
                          Column(
                            children: [
                              CustomRadialProgress(
                                  porcentaje: 100.0,
                                  cantidad: 20,
                                  color: Colors.white),
                              Text("Grasas"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 350,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                padding: EdgeInsets.all(0.0),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "home");
                },
                child: Text("Ver mi Programa Personal"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomRadialProgress extends StatelessWidget {
  final Color color;
  final double porcentaje;
  final double cantidad;

  /* 
  final String tipomacro; */

  const CustomRadialProgress({
    @required this.porcentaje,
    @required this.color,
    this.cantidad,
    /* 
    @required this.tipomacro, */
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Stack(
        children: [
          RadialProgress(
            porcentaje: porcentaje,
            colorPrimario: this.color,
            grosorPrimario: 5,
            grosorSecundario: 5,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
            child: Text('$cantidad' "g"),
          ),
        ],
      ),
      /* Text(tipomacro.toString()) */
    );
  }
}
