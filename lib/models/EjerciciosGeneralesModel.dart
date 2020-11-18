// To parse this JSON data, do
//
//     final ejerciciosGenerales = ejerciciosGeneralesFromJson(jsonString);

// import 'dart:convert';

// EjerciciosGenerales ejerciciosGeneralesFromJson(String str) => EjerciciosGenerales.fromJson(json.decode(str));

// String ejerciciosGeneralesToJson(EjerciciosGenerales data) => json.encode(data.toJson());

// class EjerciciosGenerales {
//     EjerciciosGenerales({
//         this.allExercises,
//     });

//     List<AllExercise> allExercises;

//     factory EjerciciosGenerales.fromJson(Map<String, dynamic> json) => EjerciciosGenerales(
//         allExercises: List<AllExercise>.from(json["all_exercises"].map((x) => AllExercise.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "all_exercises": List<dynamic>.from(allExercises.map((x) => x.toJson())),
//     };
// }

// class AllExercise {
//     AllExercise({
//         this.type,
//        // this.exercises,
//     });

//     Type type;
//     //List<Exercise> exercises;

//     factory AllExercise.fromJson(Map<String, dynamic> json) => AllExercise(
//         type: typeValues.map[json["type"]],
//        // exercises: List<Exercise>.from(json["exercises"].map((x) => Exercise.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "type": typeValues.reverse[type],
//         "exercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
//     };
// }

// class Exercise {
//     Exercise({
//         this.id,
//         this.name,
//         this.series,
//         this.iterations,
//         this.restSerie,
//         this.restExercise,
//         this.iterationsType,
//         this.type,
//         this.urlImage,
//         this.urlGif,
//     });

//     String id;
//     String name;
//     int series;
//     int iterations;
//     int restSerie;
//     int restExercise;
//     IterationsType iterationsType;
//     Type type;
//     String urlImage;
//     String urlGif;

//     factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
//         id: json["_id"],
//         name: json["name"],
//         series: json["series"],
//         iterations: json["iterations"],
//         restSerie: json["rest_serie"],
//         restExercise: json["rest_exercise"],
//         iterationsType: iterationsTypeValues.map[json["iterations_type"]],
//         type: typeValues.map[json["type"]],
//         urlImage: json["url_image"],
//         urlGif: json["url_gif"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         "series": series,
//         "iterations": iterations,
//         "rest_serie": restSerie,
//         "rest_exercise": restExercise,
//         "iterations_type": iterationsTypeValues.reverse[iterationsType],
//         "type": typeValues.reverse[type],
//         "url_image": urlImage,
//         "url_gif": urlGif,
//     };
// }

// enum IterationsType { COUNTER, SECONDS }

// final iterationsTypeValues = EnumValues({
//     "counter": IterationsType.COUNTER,
//     "seconds": IterationsType.SECONDS
// });

// enum Type { ESPALDA, PECHO, PIERNAS }

// final typeValues = EnumValues({
//     "Espalda": Type.ESPALDA,
//     "Pecho": Type.PECHO,
//     "Piernas": Type.PIERNAS
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         if (reverseMap == null) {
//             reverseMap = map.map((k, v) => new MapEntry(v, k));
//         }
//         return reverseMap;
//     }
// }
