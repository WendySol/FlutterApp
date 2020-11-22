import 'package:flutter/material.dart';
import 'package:proyecto_codigo/utils/radial_progress.dart';

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
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Text('$cantidad',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          ),
        ],
      ),
      /* Text(tipomacro.toString()) */
    );
  }
}