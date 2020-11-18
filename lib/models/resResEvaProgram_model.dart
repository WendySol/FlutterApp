// To parse this JSON data, do
//
//     final resResEvaProgramModelDart = resResEvaProgramModelDartFromJson(jsonString);

import 'dart:convert';

ResResEvaProgramModelDart resResEvaProgramModelDartFromJson(String str) => ResResEvaProgramModelDart.fromJson(json.decode(str));

String resResEvaProgramModelDartToJson(ResResEvaProgramModelDart data) => json.encode(data.toJson());

class ResResEvaProgramModelDart {
    ResResEvaProgramModelDart({
        this.evaluation,
        this.programSelected,
    });

    Evaluation evaluation;
    ProgramSelected programSelected;

    factory ResResEvaProgramModelDart.fromJson(Map<String, dynamic> json) => ResResEvaProgramModelDart(
        evaluation: Evaluation.fromJson(json["evaluation"]),
        programSelected: ProgramSelected.fromJson(json["program_selected"]),
    );

    Map<String, dynamic> toJson() => {
        "evaluation": evaluation.toJson(),
        "program_selected": programSelected.toJson(),
    };
}

class Evaluation {
    Evaluation({
        this.imcResult,
        this.corporalGrease,
        this.caloriesRecommended,
        this.corporalLeanMass,
        this.corporalGreaseResult,
        this.caloriesProteine,
        this.caloriesGrams,
        this.caloriesCarbohydrates,
        this.carbohydratesGrams,
        this.caloriesGrease,
        this.greaseGrams,
        this.physicalActivity,
        this.coefficientPhysicalActivity,
        this.coefficientPhysicalActivityResult,
    });

    String imcResult;
    double corporalGrease;
    double caloriesRecommended;
    double corporalLeanMass;
    String corporalGreaseResult;
    double caloriesProteine;
    double caloriesGrams;
    double caloriesCarbohydrates;
    double carbohydratesGrams;
    double caloriesGrease;
    double greaseGrams;
    String physicalActivity;
    int coefficientPhysicalActivity;
    String coefficientPhysicalActivityResult;

    factory Evaluation.fromJson(Map<String, dynamic> json) => Evaluation(
        imcResult: json["imc_result"],
        corporalGrease: json["corporal_grease"].toDouble(),
        caloriesRecommended: json["calories_recommended"].toDouble(),
        corporalLeanMass: json["corporal_lean_mass"].toDouble(),
        corporalGreaseResult: json["corporal_grease_result"],
        caloriesProteine: json["calories_proteine"].toDouble(),
        caloriesGrams: json["calories_grams"].toDouble(),
        caloriesCarbohydrates: json["calories_carbohydrates"].toDouble(),
        carbohydratesGrams: json["carbohydrates_grams"].toDouble(),
        caloriesGrease: json["calories_grease"].toDouble(),
        greaseGrams: json["grease_grams"].toDouble(),
        physicalActivity: json["physical_activity"],
        coefficientPhysicalActivity: json["coefficient_physical_activity"],
        coefficientPhysicalActivityResult: json["coefficient_physical_activity_result"],
    );

    Map<String, dynamic> toJson() => {
        "imc_result": imcResult,
        "corporal_grease": corporalGrease,
        "calories_recommended": caloriesRecommended,
        "corporal_lean_mass": corporalLeanMass,
        "corporal_grease_result": corporalGreaseResult,
        "calories_proteine": caloriesProteine,
        "calories_grams": caloriesGrams,
        "calories_carbohydrates": caloriesCarbohydrates,
        "carbohydrates_grams": carbohydratesGrams,
        "calories_grease": caloriesGrease,
        "grease_grams": greaseGrams,
        "physical_activity": physicalActivity,
        "coefficient_physical_activity": coefficientPhysicalActivity,
        "coefficient_physical_activity_result": coefficientPhysicalActivityResult,
    };
}

class ProgramSelected {
    ProgramSelected({
        this.name,
        this.corporalGreaseMin,
        this.corporalGreaseMax,
        this.imcResult,
        this.physicalActivity,
        this.routines,
    });

    String name;
    int corporalGreaseMin;
    int corporalGreaseMax;
    String imcResult;
    List<String> physicalActivity;
    List<Routine> routines;

    factory ProgramSelected.fromJson(Map<String, dynamic> json) => ProgramSelected(
        name: json["name"],
        corporalGreaseMin: json["corporal_grease_min"],
        corporalGreaseMax: json["corporal_grease_max"],
        imcResult: json["imc_result"],
        physicalActivity: List<String>.from(json["physical_activity"].map((x) => x)),
        routines: List<Routine>.from(json["routines"].map((x) => Routine.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "corporal_grease_min": corporalGreaseMin,
        "corporal_grease_max": corporalGreaseMax,
        "imc_result": imcResult,
        "physical_activity": List<dynamic>.from(physicalActivity.map((x) => x)),
        "routines": List<dynamic>.from(routines.map((x) => x.toJson())),
    };
}

class Routine {
    Routine({
        this.id,
        this.name,
        this.exercises,
    });

    String id;
    String name;
    List<Exercise> exercises;

    factory Routine.fromJson(Map<String, dynamic> json) => Routine(
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
    dynamic series;
    dynamic iterations;
    dynamic restSerie;
    dynamic restExercise;
    IterationsType iterationsType;
    Type type;
    String urlImage;
    String urlGif;

    factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json["_id"],
        name: json["name"],
        series: json["series"],
        iterations: json["iterations"],
        restSerie: json["rest_serie"],
        restExercise: json["rest_exercise"],
        iterationsType: iterationsTypeValues.map[json["iterations_type"]],
        type: typeValues.map[json["type"]],
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
        "iterations_type": iterationsTypeValues.reverse[iterationsType],
        "type": typeValues.reverse[type],
        "url_image": urlImage,
        "url_gif": urlGif,
    };
}

enum IterationsType { COUNTER, SECONDS }

final iterationsTypeValues = EnumValues({
    "counter": IterationsType.COUNTER,
    "seconds": IterationsType.SECONDS
});

enum Type { PECHO, HOMBRO, ABDOMINALES }

final typeValues = EnumValues({
    "Abdominales": Type.ABDOMINALES,
    "Hombro": Type.HOMBRO,
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
