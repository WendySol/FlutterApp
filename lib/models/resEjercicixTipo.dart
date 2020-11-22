// To parse this JSON data, do
//
//     final resEjercicioxTipoModel = resEjercicioxTipoModelFromJson(jsonString);

import 'dart:convert';

List<ResEjercicioxTipoModel> resEjercicioxTipoModelFromJson(String str) => List<ResEjercicioxTipoModel>.from(json.decode(str).map((x) => ResEjercicioxTipoModel.fromJson(x)));

String resEjercicioxTipoModelToJson(List<ResEjercicioxTipoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResEjercicioxTipoModel {
    ResEjercicioxTipoModel({
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

    factory ResEjercicioxTipoModel.fromJson(Map<String, dynamic> json) => ResEjercicioxTipoModel(
        id: json["_id"],
        name: json["name"],
        series: json["series"].toString(),
        iterations: json["iterations"].toString(),
        restSerie: json["rest_serie"].toString(),
        restExercise: json["rest_exercise"].toString(),
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
        "iterations_type":iterationsType,
        "type": type,
        "url_image": urlImage,
        "url_gif": urlGif,
    };
}

enum IterationsType { COUNTER, SECONDS }

final iterationsTypeValues = EnumValues({
    "counter": IterationsType.COUNTER,
    "seconds": IterationsType.SECONDS
});

enum Type { PECHO }

final typeValues = EnumValues({
    "Pecho": Type.PECHO
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}