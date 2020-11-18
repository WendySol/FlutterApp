import 'dart:convert';

SolicitudModel solicitudModelFromJson(String str) => SolicitudModel.fromJson(json.decode(str));

String solicitudModelToJson(SolicitudModel data) => json.encode(data.toJson());

class SolicitudModel {
    SolicitudModel({
        this.id,
        this.nombre,
        this.peso,
        this.talla,
        this.fechaNacimiento,
    });

    int id;
    String nombre;
    int peso;
    int talla;
    DateTime fechaNacimiento;

    factory SolicitudModel.fromJson(Map<String, dynamic> json) => SolicitudModel(
        id: json["id"],
        nombre: json["nombre"],
        peso: json["peso"],
        talla: json["talla"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "peso": peso,
        "talla": talla,
        "fecha_nacimiento": "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
    };
}