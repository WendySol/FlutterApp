// To parse this JSON data, do
//
//     final resEjercicioDetalleModel = resEjercicioDetalleModelFromJson(jsonString);

import 'dart:convert';

ResEjercicioDetalleModel resEjercicioDetalleModelFromJson(String str) => ResEjercicioDetalleModel.fromJson(json.decode(str));

String resEjercicioDetalleModelToJson(ResEjercicioDetalleModel data) => json.encode(data.toJson());

class ResEjercicioDetalleModel {
    ResEjercicioDetalleModel({
        this.id,
        this.name,
        this.series,
        this.iterations,
        this.restSerie,
        this.restExercise,
        this.iterationsType,
        this.type,
        this.urlGif,
        this.urlImage,
    });

    String id;
    String name;
    int series;
    int iterations;
    int restSerie;
    int restExercise;
    String iterationsType;
    String type;
    String urlGif;
    String urlImage;

    factory ResEjercicioDetalleModel.fromJson(Map<String, dynamic> json) => ResEjercicioDetalleModel(
        id: json["_id"],
        name: json["name"],
        series: json["series"],
        iterations: json["iterations"],
        restSerie: json["rest_serie"],
        restExercise: json["rest_exercise"],
        iterationsType: json["iterations_type"],
        type: json["type"],
        urlGif: json["url_gif"],
        urlImage: json["url_image"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "series": series,
        "iterations": iterations,
        "rest_serie": restSerie,
        "rest_exercise": restExercise,
        "iterations_type": iterationsType,
        "type": type,
        "url_gif": urlGif,
        "url_image": urlImage,
    };
}
