// To parse this JSON data, do
//
//     final ejerciciosAll = ejerciciosAllFromJson(jsonString);

import 'dart:convert';

List<EjerciciosAll> ejerciciosAllFromJson(String str) => List<EjerciciosAll>.from(json.decode(str).map((x) => EjerciciosAll.fromJson(x)));

String ejerciciosAllToJson(List<EjerciciosAll> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EjerciciosAll {
    EjerciciosAll({
        this.id,
        this.name,
        this.exercises,
    });

    String id;
    String name;
    List<Exercise> exercises;

    factory EjerciciosAll.fromJson(Map<String, dynamic> json) => EjerciciosAll(
        id: json["_id"],
        name: json["name"],
        exercises: List<Exercise>.from(json["exercises"].map((x) => Exercise.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "exercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
    };
}

class Exercise {
    Exercise({
        this.id,
        this.name,
        this.series,
        this.iterations,
        this.restSerie,
        this.restExercise,
        this.iterationsType,
        this.type,
        this.urlImage,
        this.urlGif,
    });

    String id;
    String name;
    String series;
    String iterations;
    String restSerie;
    String restExercise;
    String iterationsType;
    String type;
    String urlImage;
    String urlGif;

    factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json["_id"],
        name: json["name"],
        series: json["series"],
        iterations: json["iterations"],
        restSerie: json["rest_serie"],
        restExercise: json["rest_exercise"],
        iterationsType: json["iterations_type"],
        type: json["type"],
        urlImage: json["url_image"],
        urlGif: json["url_gif"],
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
        "url_image": urlImage,
        "url_gif": urlGif,
    };
}
